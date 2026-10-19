namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.DecayFunction")]
[UnitTitle("Decay")]
[UnitOrder(7)]
[UnitCategory("Community\\Math\\Functions")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.DecayFunction")]
public class DecayFunction : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[PortLabel("Minimum")]
	[DoNotSerialize]
	public ValueInput minimum { get; private set; }

	[DoNotSerialize]
	[PortLabel("DecayFactor")]
	public ValueInput decayFactor { get; private set; }

	[PortLabel("Scale")]
	[DoNotSerialize]
	public ValueInput scale { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	protected float defaultMinimum => 0f;

	[DoNotSerialize]
	protected float defaultDecayFactor => 1f;

	[DoNotSerialize]
	protected float defaultScale => 1f;

	protected override void Definition()
	{
		input = ValueInput("input", 0f);
		minimum = ValueInput("minimum", defaultMinimum);
		decayFactor = ValueInput("decayFactor", defaultDecayFactor);
		scale = ValueInput("scale", defaultScale);
		output = ValueOutput("output", Operation);
		Requirement(input, output);
		Requirement(minimum, output);
		Requirement(decayFactor, output);
		Requirement(scale, output);
	}

	private float Operation(Flow flow)
	{
		return MathLibrary.DecayFunction(flow.GetValue<float>(input), flow.GetValue<float>(minimum), flow.GetValue<float>(decayFactor), flow.GetValue<float>(scale));
	}
}
