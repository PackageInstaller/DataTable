using UnityEngine;

namespace Unity.VisualScripting.Community;

[UnitOrder(9)]
[UnitTitle("Sigmoid")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.SigmoidFunction")]
[UnitCategory("Community\\Math\\Functions")]
[RenamedFrom("Bolt.Addons.Community.Math.Custom_Units.Math.Functions.SigmoidFunction")]
public class SigmoidFunction : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	[PortLabel("MinimumValue")]
	public ValueInput minimum { get; private set; }

	[PortLabel("InflectionPoint")]
	[DoNotSerialize]
	public ValueInput inflectionPoint { get; private set; }

	[DoNotSerialize]
	[PortLabel("Scale")]
	public ValueInput scale { get; private set; }

	[DoNotSerialize]
	[PortLabel("DecayFactor")]
	public ValueInput decayFactor { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	protected float defaultMinimum => 0f;

	[DoNotSerialize]
	protected float defaultDecayFactor => 1f;

	[DoNotSerialize]
	protected float defaultScale => 1f;

	[DoNotSerialize]
	protected float defaultInflectionPoint => 0.5f;

	protected override void Definition()
	{
		input = ValueInput("input", 0f);
		minimum = ValueInput("minimum", defaultMinimum);
		inflectionPoint = ValueInput("inflectionPoint", defaultInflectionPoint);
		decayFactor = ValueInput("decayFactor", defaultDecayFactor);
		scale = ValueInput("scale", defaultScale);
		output = ValueOutput("output", (Flow flow) => Operation(flow));
		Requirement(input, output);
		Requirement(minimum, output);
		Requirement(inflectionPoint, output);
		Requirement(decayFactor, output);
		Requirement(scale, output);
	}

	private float Operation(Flow flow)
	{
		float value = Mathf.Clamp01(flow.GetValue<float>(input));
		float num = Mathf.Clamp01(flow.GetValue<float>(inflectionPoint));
		return MathLibrary.DecayingSigmoid(value, num, flow.GetValue<float>(minimum), flow.GetValue<float>(decayFactor), flow.GetValue<float>(scale));
	}
}
