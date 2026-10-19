namespace Unity.VisualScripting.Community;

[UnitOrder(6)]
[UnitTitle("Logarithmic Function of Range")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.LogarithmicFunctionOfRange")]
[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.LogarithmicFunctionOfRange")]
[UnitCategory("Community\\Math\\Functions")]
public class LogarithmicFunctionOfRange : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	[PortLabel("MinimumRange")]
	public ValueInput minimumRange { get; private set; }

	[DoNotSerialize]
	[PortLabel("MaximumRange")]
	public ValueInput maximumRange { get; private set; }

	[DoNotSerialize]
	[PortLabel("MinimumValue")]
	public ValueInput minimumValue { get; private set; }

	[DoNotSerialize]
	[PortLabel("Exponent")]
	public ValueInput exponent { get; private set; }

	[DoNotSerialize]
	[PortLabel("Scale")]
	public ValueInput scale { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	protected float defaultMinimumRange => 0f;

	[DoNotSerialize]
	protected float defaultMaximumRange => 100f;

	[DoNotSerialize]
	protected float defaultMinimum => 0f;

	[DoNotSerialize]
	protected float defaultExponent => 1f;

	[DoNotSerialize]
	protected float defaultScale => 1f;

	protected override void Definition()
	{
		input = ValueInput("input", 0f);
		minimumRange = ValueInput("minimumRange", defaultMinimumRange);
		maximumRange = ValueInput("maximumRange", defaultMaximumRange);
		minimumValue = ValueInput("minimumValue", defaultMinimum);
		exponent = ValueInput("exponent", defaultExponent);
		scale = ValueInput("scale", defaultScale);
		output = ValueOutput("output", (Flow flow) => Operation(flow));
		Requirement(minimumRange, output);
		Requirement(maximumRange, output);
		Requirement(input, output);
		Requirement(minimumValue, output);
		Requirement(exponent, output);
		Requirement(scale, output);
	}

	private float Operation(Flow flow)
	{
		return MathLibrary.LogarithmicFunctionOfRange(flow.GetValue<float>(input), flow.GetValue<float>(minimumRange), flow.GetValue<float>(maximumRange), flow.GetValue<float>(maximumRange), flow.GetValue<float>(exponent), flow.GetValue<float>(scale));
	}
}
