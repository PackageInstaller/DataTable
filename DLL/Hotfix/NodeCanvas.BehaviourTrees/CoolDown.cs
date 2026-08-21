using System.Collections;
using GameFramework.Runtime;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("CoolDown", 0)]
[Category("Decorators")]
[Description("倒计时结束后将会运行.")]
[Icon("Filter", false, "")]
public class CoolDown : BTDecorator
{
	[Name("冷却时间", 0)]
	public BBParameter<float> coolDownTime = 5f;

	private float currentTime;

	private AsyncResult asyncResult;

	public override void OnGraphStoped()
	{
		currentTime = 0f;
		asyncResult?.Cancel();
	}

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.decoratedConnection == null)
		{
			return Status.Optional;
		}
		asyncResult = new AsyncResult();
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult r)
		{
			if (r.Exception == null && !r.IsCancelled)
			{
				base.status = base.decoratedConnection.Execute(agent, blackboard);
				asyncResult = null;
			}
		});
		StartCoroutine(Cooldown(asyncResult));
		return base.status;
	}

	protected IEnumerator Cooldown(IPromise promise)
	{
		for (currentTime = coolDownTime.value; currentTime > 0f; currentTime -= 0.01f)
		{
			yield return new WaitForSeconds(0.01f);
		}
		promise.SetResult();
	}
}
