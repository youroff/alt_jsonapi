require "spec_helper"

describe JsonapiSerializer::Utils do
  before(:all) {
    @probe = Class.new.extend(JsonapiSerializer::Utils)
  }

  it "normalize_includes" do
    normalized = @probe.normalize_includes([:some, other: [:oh, omg: :lol]])
    expect(normalized).to include(some: {}, other: {oh: {}, omg: {lol: {}}})

    expect(@probe.normalize_includes(:some)).to include(some: {})
  end

  it "normalize_fields" do
    normalized = @probe.normalize_fields({model: ["some", "field"], "oh_what" => [:more, :fields]})
    expect(normalized).to include(model: [:some, :field], oh_what: [:more, :fields])

    expect(@probe.normalize_includes(:some)).to include(some: {})
  end

  it "apply_splat" do
    expect(@probe.apply_splat(2) { |i| i * 2 }).to eq 4
    expect(@probe.apply_splat([1, 3]) { |i| i * 2 }).to eq [2, 6]
  end

  it "key_intersect" do
    expect(@probe.key_intersect(nil, [1, 2, 3])).to eq [1, 2, 3]
    expect(@probe.key_intersect([2], [1, 2, 3])).to eq [2]
  end
end
