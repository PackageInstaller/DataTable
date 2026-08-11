using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncWillRenderObjectTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnWillRenderObject()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnWillRenderObjectHandler GetOnWillRenderObjectAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnWillRenderObjectHandler GetOnWillRenderObjectAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnWillRenderObjectAsync()
	{
		return ((IAsyncOnWillRenderObjectHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnWillRenderObjectAsync();
	}

	public UniTask OnWillRenderObjectAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnWillRenderObjectHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnWillRenderObjectAsync();
	}
}
