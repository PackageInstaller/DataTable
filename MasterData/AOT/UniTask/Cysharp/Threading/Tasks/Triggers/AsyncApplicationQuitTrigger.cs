using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncApplicationQuitTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnApplicationQuit()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnApplicationQuitHandler GetOnApplicationQuitAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnApplicationQuitHandler GetOnApplicationQuitAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnApplicationQuitAsync()
	{
		return ((IAsyncOnApplicationQuitHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnApplicationQuitAsync();
	}

	public UniTask OnApplicationQuitAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnApplicationQuitHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnApplicationQuitAsync();
	}
}
