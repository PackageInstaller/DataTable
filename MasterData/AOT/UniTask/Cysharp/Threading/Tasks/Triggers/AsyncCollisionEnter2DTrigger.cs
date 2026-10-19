using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncCollisionEnter2DTrigger : AsyncTriggerBase<Collision2D>
{
	private void OnCollisionEnter2D(Collision2D coll)
	{
		RaiseEvent(coll);
	}

	public IAsyncOnCollisionEnter2DHandler GetOnCollisionEnter2DAsyncHandler()
	{
		return new AsyncTriggerHandler<Collision2D>(this, callOnce: false);
	}

	public IAsyncOnCollisionEnter2DHandler GetOnCollisionEnter2DAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collision2D>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collision2D> OnCollisionEnter2DAsync()
	{
		return ((IAsyncOnCollisionEnter2DHandler)new AsyncTriggerHandler<Collision2D>(this, callOnce: true)).OnCollisionEnter2DAsync();
	}

	public UniTask<Collision2D> OnCollisionEnter2DAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnCollisionEnter2DHandler)new AsyncTriggerHandler<Collision2D>(this, cancellationToken, callOnce: true)).OnCollisionEnter2DAsync();
	}
}
