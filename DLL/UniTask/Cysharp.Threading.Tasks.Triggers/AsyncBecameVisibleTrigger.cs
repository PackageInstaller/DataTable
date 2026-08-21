using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncBecameVisibleTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnBecameVisible()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnBecameVisibleHandler GetOnBecameVisibleAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnBecameVisibleHandler GetOnBecameVisibleAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnBecameVisibleAsync()
	{
		return ((IAsyncOnBecameVisibleHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnBecameVisibleAsync();
	}

	public UniTask OnBecameVisibleAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnBecameVisibleHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnBecameVisibleAsync();
	}
}
