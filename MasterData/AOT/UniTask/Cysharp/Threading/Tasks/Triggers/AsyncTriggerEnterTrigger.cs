using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncTriggerEnterTrigger : AsyncTriggerBase<Collider>
{
	private void OnTriggerEnter(Collider other)
	{
		RaiseEvent(other);
	}

	public IAsyncOnTriggerEnterHandler GetOnTriggerEnterAsyncHandler()
	{
		return new AsyncTriggerHandler<Collider>(this, callOnce: false);
	}

	public IAsyncOnTriggerEnterHandler GetOnTriggerEnterAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collider>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collider> OnTriggerEnterAsync()
	{
		return ((IAsyncOnTriggerEnterHandler)new AsyncTriggerHandler<Collider>(this, callOnce: true)).OnTriggerEnterAsync();
	}

	public UniTask<Collider> OnTriggerEnterAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnTriggerEnterHandler)new AsyncTriggerHandler<Collider>(this, cancellationToken, callOnce: true)).OnTriggerEnterAsync();
	}
}
