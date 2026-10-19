using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.Polarity")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.Polarity")]
[UnitCategory("Community\\Logic")]
[TypeIcon(typeof(Comparison))]
public class Polarity : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	public ValueOutput positive { get; private set; }

	[DoNotSerialize]
	public ValueOutput negative { get; private set; }

	[DoNotSerialize]
	public ValueOutput zero { get; private set; }

	protected override void Definition()
	{
		input = ValueInput<float>("input");
		positive = ValueOutput("positive", (Flow flow) => flow.GetValue<float>(input) > 0f);
		negative = ValueOutput("negative", (Flow flow) => flow.GetValue<float>(input) < 0f);
		zero = ValueOutput("zero", (Flow flow) => Mathf.Approximately(flow.GetValue<float>(input), 0f));
		Requirement(input, positive);
		Requirement(input, negative);
		Requirement(input, zero);
	}
}
