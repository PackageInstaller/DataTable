using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncAwakeTrigger : AsyncTriggerBase<AsyncUnit>
{
	public UniTask AwakeAsync()
	{
		if (calledAwake)
		{
			return UniTask.CompletedTask;
		}
		return ((IAsyncOneShotTrigger)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OneShotAsync();
	}
}
