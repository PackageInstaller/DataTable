using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncCollisionExitTrigger : AsyncTriggerBase<Collision>
{
	private void OnCollisionExit(Collision coll)
	{
		RaiseEvent(coll);
	}

	public IAsyncOnCollisionExitHandler GetOnCollisionExitAsyncHandler()
	{
		return new AsyncTriggerHandler<Collision>(this, callOnce: false);
	}

	public IAsyncOnCollisionExitHandler GetOnCollisionExitAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collision>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collision> OnCollisionExitAsync()
	{
		return ((IAsyncOnCollisionExitHandler)new AsyncTriggerHandler<Collision>(this, callOnce: true)).OnCollisionExitAsync();
	}

	public UniTask<Collision> OnCollisionExitAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnCollisionExitHandler)new AsyncTriggerHandler<Collision>(this, cancellationToken, callOnce: true)).OnCollisionExitAsync();
	}
}
