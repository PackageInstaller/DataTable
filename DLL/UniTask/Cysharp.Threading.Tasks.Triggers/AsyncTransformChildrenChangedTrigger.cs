using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncTransformChildrenChangedTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnTransformChildrenChanged()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnTransformChildrenChangedHandler GetOnTransformChildrenChangedAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnTransformChildrenChangedHandler GetOnTransformChildrenChangedAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnTransformChildrenChangedAsync()
	{
		return ((IAsyncOnTransformChildrenChangedHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnTransformChildrenChangedAsync();
	}

	public UniTask OnTransformChildrenChangedAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnTransformChildrenChangedHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnTransformChildrenChangedAsync();
	}
}
