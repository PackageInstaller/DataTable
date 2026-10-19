using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Documenting.SomeValue")]
[UnitCategory("Community\\Documentation")]
public class SomeValue : Unit
{
	[Inspectable]
	public bool IsInteger;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		if (IsInteger)
		{
			output = ValueOutput("output", (Flow flow) => Random.Range(0, 1));
		}
		else
		{
			output = ValueOutput("output", (Flow flow) => Random.Range(0f, 1f));
		}
	}
}
