namespace Unity.VisualScripting.Community;

[UnitOrder(4)]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.ExponentialFunctionOfRange")]
[UnitCategory("Community\\Math\\Functions")]
[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.ExponentialFunctionOfRange")]
[UnitTitle("Exponential Function of Range")]
public class ExponentialFunctionOfRange : Unit
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

	[PortLabel("Exponent")]
	[DoNotSerialize]
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
		output = ValueOutput("output", Operation);
		Requirement(minimumRange, output);
		Requirement(maximumRange, output);
		Requirement(input, output);
		Requirement(minimumValue, output);
		Requirement(exponent, output);
		Requirement(scale, output);
	}

	private float Operation(Flow flow)
	{
		return MathLibrary.ExponentialFunctionOfRange(flow.GetValue<float>(input), flow.GetValue<float>(minimumRange), flow.GetValue<float>(maximumRange), flow.GetValue<float>(maximumRange), flow.GetValue<float>(exponent), flow.GetValue<float>(scale));
	}
}
