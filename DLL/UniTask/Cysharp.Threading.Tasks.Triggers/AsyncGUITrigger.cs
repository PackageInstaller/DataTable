using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncGUITrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnGUI()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnGUIHandler GetOnGUIAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnGUIHandler GetOnGUIAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnGUIAsync()
	{
		return ((IAsyncOnGUIHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnGUIAsync();
	}

	public UniTask OnGUIAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnGUIHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnGUIAsync();
	}
}
