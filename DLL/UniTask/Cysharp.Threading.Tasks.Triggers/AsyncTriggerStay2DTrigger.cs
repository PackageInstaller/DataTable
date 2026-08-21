using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncTriggerStay2DTrigger : AsyncTriggerBase<Collider2D>
{
	private void OnTriggerStay2D(Collider2D other)
	{
		RaiseEvent(other);
	}

	public IAsyncOnTriggerStay2DHandler GetOnTriggerStay2DAsyncHandler()
	{
		return new AsyncTriggerHandler<Collider2D>(this, callOnce: false);
	}

	public IAsyncOnTriggerStay2DHandler GetOnTriggerStay2DAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collider2D>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collider2D> OnTriggerStay2DAsync()
	{
		return ((IAsyncOnTriggerStay2DHandler)new AsyncTriggerHandler<Collider2D>(this, callOnce: true)).OnTriggerStay2DAsync();
	}

	public UniTask<Collider2D> OnTriggerStay2DAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnTriggerStay2DHandler)new AsyncTriggerHandler<Collider2D>(this, cancellationToken, callOnce: true)).OnTriggerStay2DAsync();
	}
}
