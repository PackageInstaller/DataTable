using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncFixedUpdateTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void FixedUpdate()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncFixedUpdateHandler GetFixedUpdateAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncFixedUpdateHandler GetFixedUpdateAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask FixedUpdateAsync()
	{
		return ((IAsyncFixedUpdateHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).FixedUpdateAsync();
	}

	public UniTask FixedUpdateAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncFixedUpdateHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).FixedUpdateAsync();
	}
}
