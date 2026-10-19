using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncCollisionEnterTrigger : AsyncTriggerBase<Collision>
{
	private void OnCollisionEnter(Collision coll)
	{
		RaiseEvent(coll);
	}

	public IAsyncOnCollisionEnterHandler GetOnCollisionEnterAsyncHandler()
	{
		return new AsyncTriggerHandler<Collision>(this, callOnce: false);
	}

	public IAsyncOnCollisionEnterHandler GetOnCollisionEnterAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collision>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collision> OnCollisionEnterAsync()
	{
		return ((IAsyncOnCollisionEnterHandler)new AsyncTriggerHandler<Collision>(this, callOnce: true)).OnCollisionEnterAsync();
	}

	public UniTask<Collision> OnCollisionEnterAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnCollisionEnterHandler)new AsyncTriggerHandler<Collision>(this, cancellationToken, callOnce: true)).OnCollisionEnterAsync();
	}
}
