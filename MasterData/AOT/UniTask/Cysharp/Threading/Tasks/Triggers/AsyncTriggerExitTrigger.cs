using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncTriggerExitTrigger : AsyncTriggerBase<Collider>
{
	private void OnTriggerExit(Collider other)
	{
		RaiseEvent(other);
	}

	public IAsyncOnTriggerExitHandler GetOnTriggerExitAsyncHandler()
	{
		return new AsyncTriggerHandler<Collider>(this, callOnce: false);
	}

	public IAsyncOnTriggerExitHandler GetOnTriggerExitAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collider>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collider> OnTriggerExitAsync()
	{
		return ((IAsyncOnTriggerExitHandler)new AsyncTriggerHandler<Collider>(this, callOnce: true)).OnTriggerExitAsync();
	}

	public UniTask<Collider> OnTriggerExitAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnTriggerExitHandler)new AsyncTriggerHandler<Collider>(this, cancellationToken, callOnce: true)).OnTriggerExitAsync();
	}
}
