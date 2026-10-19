namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.ExponentialFunction")]
[UnitCategory("Community\\Math\\Functions")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.ExponentialFunction")]
[UnitTitle("Exponential")]
[UnitOrder(3)]
public class ExponentialFunction : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[PortLabel("Minimum")]
	[DoNotSerialize]
	public ValueInput minimum { get; private set; }

	[DoNotSerialize]
	[PortLabel("Exponent")]
	public ValueInput exponent { get; private set; }

	[PortLabel("Scale")]
	[DoNotSerialize]
	public ValueInput scale { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	protected float defaultMinimum => 0f;

	[DoNotSerialize]
	protected float defaultExponent => 1f;

	[DoNotSerialize]
	protected float defaultScale => 1f;

	protected override void Definition()
	{
		input = ValueInput("input", 0f);
		minimum = ValueInput("minimum", defaultMinimum);
		exponent = ValueInput("exponent", defaultExponent);
		scale = ValueInput("scale", defaultScale);
		output = ValueOutput("output", Operation);
		Requirement(input, output);
		Requirement(minimum, output);
		Requirement(exponent, output);
		Requirement(scale, output);
	}

	private float Operation(Flow flow)
	{
		return MathLibrary.ExponentialFunction(flow.GetValue<float>(input), flow.GetValue<float>(minimum), flow.GetValue<float>(exponent), flow.GetValue<float>(scale));
	}
}
