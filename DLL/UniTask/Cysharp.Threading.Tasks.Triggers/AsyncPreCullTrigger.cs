using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncPreCullTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnPreCull()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnPreCullHandler GetOnPreCullAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnPreCullHandler GetOnPreCullAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnPreCullAsync()
	{
		return ((IAsyncOnPreCullHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnPreCullAsync();
	}

	public UniTask OnPreCullAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnPreCullHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnPreCullAsync();
	}
}
