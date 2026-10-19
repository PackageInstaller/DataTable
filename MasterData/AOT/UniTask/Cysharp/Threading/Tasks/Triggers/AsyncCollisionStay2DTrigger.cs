using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncCollisionStay2DTrigger : AsyncTriggerBase<Collision2D>
{
	private void OnCollisionStay2D(Collision2D coll)
	{
		RaiseEvent(coll);
	}

	public IAsyncOnCollisionStay2DHandler GetOnCollisionStay2DAsyncHandler()
	{
		return new AsyncTriggerHandler<Collision2D>(this, callOnce: false);
	}

	public IAsyncOnCollisionStay2DHandler GetOnCollisionStay2DAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collision2D>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collision2D> OnCollisionStay2DAsync()
	{
		return ((IAsyncOnCollisionStay2DHandler)new AsyncTriggerHandler<Collision2D>(this, callOnce: true)).OnCollisionStay2DAsync();
	}

	public UniTask<Collision2D> OnCollisionStay2DAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnCollisionStay2DHandler)new AsyncTriggerHandler<Collision2D>(this, cancellationToken, callOnce: true)).OnCollisionStay2DAsync();
	}
}
