using System.Collections;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Wait Until")]
[UnitOrder(2)]
[UnitShortTitle("Wait Until")]
public class WaitUntilUnit : WaitUnit
{
	[DoNotSerialize]
	public ValueInput condition { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		condition = ValueInput<bool>("condition");
		Requirement(condition, enter);
	}

	protected override IEnumerator Await(Flow flow)
	{
		yield return new WaitUntil(() => flow.GetValue<bool>(condition));
		yield return exit;
	}
}
