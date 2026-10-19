using System.Collections;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Wait While")]
[UnitShortTitle("Wait While")]
[UnitOrder(3)]
public class WaitWhileUnit : WaitUnit
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
		yield return new WaitWhile(() => flow.GetValue<bool>(condition));
		yield return exit;
	}
}
