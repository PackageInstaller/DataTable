namespace Unity.VisualScripting.Community;

[UnitOrder(0)]
[UnitTitle("Linear")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.LinearFunction")]
[RenamedFrom("Bolt.Addons.Community.Custom_Units.Math.Functions.LinearFunction")]
[UnitCategory("Community\\Math\\Functions")]
public class LinearFunction : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[PortLabel("Minimum")]
	[DoNotSerialize]
	public ValueInput minimum { get; private set; }

	[PortLabel("Maximum")]
	[DoNotSerialize]
	public ValueInput maximum { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
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
		return MathLibrary.LinearFunction(flow.GetValue<float>(minimum), flow.GetValue<float>(maximum), flow.GetValue<float>(input));
	}
}
