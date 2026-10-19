using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncRenderObjectTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnRenderObject()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnRenderObjectHandler GetOnRenderObjectAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnRenderObjectHandler GetOnRenderObjectAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnRenderObjectAsync()
	{
		return ((IAsyncOnRenderObjectHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnRenderObjectAsync();
	}

	public UniTask OnRenderObjectAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnRenderObjectHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnRenderObjectAsync();
	}
}
