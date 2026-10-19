namespace Unity.VisualScripting.Community;

[UnitTitle("Sigmoid Function Of Range")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.SigmoidFunctionOfRange")]
[RenamedFrom("Bolt.Addons.Community.Math.Custom_Units.Math.Functions.SigmoidFunctionOfRange")]
[UnitCategory("Community\\Math\\Functions")]
[UnitOrder(10)]
public class SigmoidFunctionOfRange : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[PortLabel("MinimumValue")]
	[DoNotSerialize]
	public ValueInput minimum { get; private set; }

	[DoNotSerialize]
	[PortLabel("MinimumRange")]
	public ValueInput minimumRange { get; private set; }

	[PortLabel("MaximumRange")]
	[DoNotSerialize]
	public ValueInput maximumRange { get; private set; }

	[PortLabel("InflectionPoint")]
	[DoNotSerialize]
	public ValueInput inflectionPoint { get; private set; }

	[PortLabel("Scale")]
	[DoNotSerialize]
	public ValueInput scale { get; private set; }

	[PortLabel("DecayFactor")]
	[DoNotSerialize]
	public ValueInput decayFactor { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	protected float defaultMinimumRange => 0f;

	[DoNotSerialize]
	protected float defaultMaximumRange => 100f;

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
		minimumRange = ValueInput("minimumRange", defaultMinimumRange);
		maximumRange = ValueInput("maximumRange", defaultMaximumRange);
		inflectionPoint = ValueInput("inflectionPoint", defaultInflectionPoint);
		decayFactor = ValueInput("decayFactor", defaultDecayFactor);
		scale = ValueInput("scale", defaultScale);
		output = ValueOutput("output", (Flow x) => Operation(x));
		Requirement(minimumRange, output);
		Requirement(maximumRange, output);
		Requirement(input, output);
		Requirement(minimum, output);
		Requirement(inflectionPoint, output);
		Requirement(decayFactor, output);
		Requirement(scale, output);
	}

	private float Operation(Flow flow)
	{
		float value = MathLibrary.ReverseLinearFunction(flow.GetValue<float>(input), flow.GetValue<float>(minimumRange), flow.GetValue<float>(maximumRange));
		float num = MathLibrary.ReverseLinearFunction(flow.GetValue<float>(inflectionPoint), flow.GetValue<float>(minimumRange), flow.GetValue<float>(maximumRange));
		return MathLibrary.DecayingSigmoid(value, num, flow.GetValue<float>(minimum), flow.GetValue<float>(decayFactor), flow.GetValue<float>(scale));
	}
}
