namespace Unity.VisualScripting.Community;

[UnitTitle("Reverse Linear")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.ReverseLinearFunction")]
[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.ReverseLinearFunction")]
[UnitCategory("Community\\Math\\Functions")]
[UnitOrder(1)]
public class ReverseLinearFunction : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	[PortLabel("Minimum")]
	public ValueInput minimum { get; private set; }

	[DoNotSerialize]
	[PortLabel("Maximum")]
	public ValueInput maximum { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	[DoNotSerialize]
	protected float defaultMinimum => 0f;

	[DoNotSerialize]
	protected float defaultMaximum => 1f;

	protected override void Definition()
	{
		input = ValueInput("input", 0f);
		minimum = ValueInput("minimum", defaultMinimum);
		maximum = ValueInput("maximum", defaultMaximum);
		output = ValueOutput("output", Operation);
		Requirement(input, output);
		Requirement(minimum, output);
		Requirement(maximum, output);
	}

	private float Operation(Flow flow)
	{
		return MathLibrary.ReverseLinearFunction(flow.GetValue<float>(minimum), flow.GetValue<float>(maximum), flow.GetValue<float>(input));
	}
}
