using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncParticleTriggerTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnParticleTrigger()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnParticleTriggerHandler GetOnParticleTriggerAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnParticleTriggerHandler GetOnParticleTriggerAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnParticleTriggerAsync()
	{
		return ((IAsyncOnParticleTriggerHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnParticleTriggerAsync();
	}

	public UniTask OnParticleTriggerAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnParticleTriggerHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnParticleTriggerAsync();
	}
}
