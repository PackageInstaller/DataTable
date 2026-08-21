using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncCollisionExit2DTrigger : AsyncTriggerBase<Collision2D>
{
	private void OnCollisionExit2D(Collision2D coll)
	{
		RaiseEvent(coll);
	}

	public IAsyncOnCollisionExit2DHandler GetOnCollisionExit2DAsyncHandler()
	{
		return new AsyncTriggerHandler<Collision2D>(this, callOnce: false);
	}

	public IAsyncOnCollisionExit2DHandler GetOnCollisionExit2DAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collision2D>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collision2D> OnCollisionExit2DAsync()
	{
		return ((IAsyncOnCollisionExit2DHandler)new AsyncTriggerHandler<Collision2D>(this, callOnce: true)).OnCollisionExit2DAsync();
	}

	public UniTask<Collision2D> OnCollisionExit2DAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnCollisionExit2DHandler)new AsyncTriggerHandler<Collision2D>(this, cancellationToken, callOnce: true)).OnCollisionExit2DAsync();
	}
}
