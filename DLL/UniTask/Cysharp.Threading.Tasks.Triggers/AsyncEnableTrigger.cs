using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncEnableTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnEnable()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnEnableHandler GetOnEnableAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnEnableHandler GetOnEnableAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnEnableAsync()
	{
		return ((IAsyncOnEnableHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnEnableAsync();
	}

	public UniTask OnEnableAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnEnableHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnEnableAsync();
	}
}
