using System.Collections;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using Unity.VisualScripting;

namespace ACT.BluePrint;

public class WaitAllUniTask : WaitUnit
{
	[DoNotSerialize]
	public ValueInput uniTask;

	protected override void Definition()
	{
		base.Definition();
		uniTask = ValueInput<List<UniTask>>("uniTask");
	}

	protected override IEnumerator Await(Flow flow)
	{
		List<UniTask> value = flow.GetValue<List<UniTask>>(uniTask);
		yield return UniTask.WhenAll(value).ToCoroutine();
		yield return exit;
	}
}
