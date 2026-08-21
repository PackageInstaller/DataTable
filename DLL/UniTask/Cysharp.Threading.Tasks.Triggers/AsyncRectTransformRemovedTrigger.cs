using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncRectTransformRemovedTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnRectTransformRemoved()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnRectTransformRemovedHandler GetOnRectTransformRemovedAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnRectTransformRemovedHandler GetOnRectTransformRemovedAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnRectTransformRemovedAsync()
	{
		return ((IAsyncOnRectTransformRemovedHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnRectTransformRemovedAsync();
	}

	public UniTask OnRectTransformRemovedAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnRectTransformRemovedHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnRectTransformRemovedAsync();
	}
}
