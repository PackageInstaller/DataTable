using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncResetTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void Reset()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncResetHandler GetResetAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncResetHandler GetResetAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask ResetAsync()
	{
		return ((IAsyncResetHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).ResetAsync();
	}

	public UniTask ResetAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncResetHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).ResetAsync();
	}
}
