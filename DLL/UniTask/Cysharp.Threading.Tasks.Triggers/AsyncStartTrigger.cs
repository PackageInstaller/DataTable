using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncStartTrigger : AsyncTriggerBase<AsyncUnit>
{
	private bool called;

	private void Start()
	{
		called = true;
		RaiseEvent(AsyncUnit.Default);
	}

	public UniTask StartAsync()
	{
		if (called)
		{
			return UniTask.CompletedTask;
		}
		return ((IAsyncOneShotTrigger)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OneShotAsync();
	}
}
