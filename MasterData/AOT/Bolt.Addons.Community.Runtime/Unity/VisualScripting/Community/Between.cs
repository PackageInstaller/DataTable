namespace Unity.VisualScripting.Community;

[UnitCategory("Community\\Logic")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.Between")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Between")]
[TypeIcon(typeof(And))]
public class Between : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	public ValueInput min { get; private set; }

	[DoNotSerialize]
	public ValueInput max { get; private set; }

	[DoNotSerialize]
	public ValueOutput within { get; private set; }

	protected override void Definition()
	{
		input = ValueInput<float>("input");
		min = ValueInput("min", 0f);
		max = ValueInput("max", 0f);
		within = ValueOutput("within", (Flow flow) => GetWithin(flow));
		Requirement(input, within);
		Requirement(min, within);
		Requirement(max, within);
	}

	private bool GetWithin(Flow flow)
	{
		float value = flow.GetValue<float>(input);
		if (value >= flow.GetValue<float>(min))
		{
			return value <= flow.GetValue<float>(max);
		}
		return false;
	}
}
