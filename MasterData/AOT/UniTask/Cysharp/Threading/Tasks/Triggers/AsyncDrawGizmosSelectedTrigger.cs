using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncDrawGizmosSelectedTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnDrawGizmosSelected()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnDrawGizmosSelectedHandler GetOnDrawGizmosSelectedAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnDrawGizmosSelectedHandler GetOnDrawGizmosSelectedAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnDrawGizmosSelectedAsync()
	{
		return ((IAsyncOnDrawGizmosSelectedHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnDrawGizmosSelectedAsync();
	}

	public UniTask OnDrawGizmosSelectedAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnDrawGizmosSelectedHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnDrawGizmosSelectedAsync();
	}
}
