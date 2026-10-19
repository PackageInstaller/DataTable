namespace Unity.VisualScripting.Community;

[UnitOrder(2)]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.LinearFunctionOfRange")]
[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.LinearFunctionOfRange")]
[UnitCategory("Community\\Math\\Functions")]
[UnitTitle("Linear Function of Range")]
public class LinearFunctionOfRange : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[PortLabel("MinInputRange")]
	[DoNotSerialize]
	public ValueInput minInputRange { get; private set; }

	[PortLabel("MaxInputRange")]
	[DoNotSerialize]
	public ValueInput maxInputRange { get; private set; }

	[DoNotSerialize]
	[PortLabel("Minimum")]
	public ValueInput minimum { get; private set; }

	[PortLabel("Maximum")]
	[DoNotSerialize]
	public ValueInput maximum { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	protected float defaultMinRange => 0f;

	[DoNotSerialize]
	protected float defaultMaxRange => 1f;

	[DoNotSerialize]
	protected float defaultMinimum => 0f;

	[DoNotSerialize]
	protected float defaultMaximum => 1f;

	protected override void Definition()
	{
		input = ValueInput("input", 0f);
		minInputRange = ValueInput("minInputRange", defaultMinRange);
		maxInputRange = ValueInput("maxInputRange", defaultMaxRange);
		minimum = ValueInput("minimum", defaultMinimum);
		maximum = ValueInput("maximum", defaultMaximum);
		output = ValueOutput("output", Operation);
		Requirement(input, output);
		Requirement(minInputRange, output);
		Requirement(maxInputRange, output);
		Requirement(minimum, output);
		Requirement(maximum, output);
	}

	private float Operation(Flow flow)
	{
		return MathLibrary.LinearFunctionOfRange(flow.GetValue<float>(input), flow.GetValue<float>(minInputRange), flow.GetValue<float>(maxInputRange), flow.GetValue<float>(minimum), flow.GetValue<float>(maximum));
	}
}
