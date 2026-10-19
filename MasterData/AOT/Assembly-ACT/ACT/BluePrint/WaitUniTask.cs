using System.Collections;
using Cysharp.Threading.Tasks;
using Unity.VisualScripting;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public class WaitUniTask : WaitUnit
{
	[DoNotSerialize]
	public ValueInput uniTask;

	protected override void Definition()
	{
		base.Definition();
		uniTask = ValueInput<UniTask>("uniTask");
	}

	protected override IEnumerator Await(Flow flow)
	{
		UniTask value = flow.GetValue<UniTask>(uniTask);
		yield return value.ToCoroutine();
		yield return exit;
	}
}
