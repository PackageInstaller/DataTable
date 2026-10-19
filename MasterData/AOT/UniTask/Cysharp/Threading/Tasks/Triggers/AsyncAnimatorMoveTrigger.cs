using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncAnimatorMoveTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnAnimatorMove()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnAnimatorMoveHandler GetOnAnimatorMoveAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnAnimatorMoveHandler GetOnAnimatorMoveAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnAnimatorMoveAsync()
	{
		return ((IAsyncOnAnimatorMoveHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnAnimatorMoveAsync();
	}

	public UniTask OnAnimatorMoveAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnAnimatorMoveHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnAnimatorMoveAsync();
	}
}
