using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncDrawGizmosTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnDrawGizmos()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnDrawGizmosHandler GetOnDrawGizmosAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnDrawGizmosHandler GetOnDrawGizmosAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnDrawGizmosAsync()
	{
		return ((IAsyncOnDrawGizmosHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnDrawGizmosAsync();
	}

	public UniTask OnDrawGizmosAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnDrawGizmosHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnDrawGizmosAsync();
	}
}
