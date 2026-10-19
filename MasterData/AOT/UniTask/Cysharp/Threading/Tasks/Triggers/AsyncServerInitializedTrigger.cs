using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncServerInitializedTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnServerInitialized()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnServerInitializedHandler GetOnServerInitializedAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnServerInitializedHandler GetOnServerInitializedAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnServerInitializedAsync()
	{
		return ((IAsyncOnServerInitializedHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnServerInitializedAsync();
	}

	public UniTask OnServerInitializedAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnServerInitializedHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnServerInitializedAsync();
	}
}
