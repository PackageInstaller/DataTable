namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.LogarithmicFunction")]
[UnitTitle("Logarithmic")]
[UnitOrder(5)]
[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.LogarithmicFunction")]
[UnitCategory("Community\\Math\\Functions")]
public class LogarithmicFunction : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[PortLabel("Minimum")]
	[DoNotSerialize]
	public ValueInput minimum { get; private set; }

	[PortLabel("Exponent")]
	[DoNotSerialize]
	public ValueInput exponent { get; private set; }

	[DoNotSerialize]
	[PortLabel("Scale")]
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
		return MathLibrary.LogarithmicFunction(flow.GetValue<float>(input), flow.GetValue<float>(minimum), flow.GetValue<float>(exponent), flow.GetValue<float>(scale));
	}
}
