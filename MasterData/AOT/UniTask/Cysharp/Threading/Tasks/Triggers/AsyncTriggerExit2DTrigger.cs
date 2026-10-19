using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncTriggerExit2DTrigger : AsyncTriggerBase<Collider2D>
{
	private void OnTriggerExit2D(Collider2D other)
	{
		RaiseEvent(other);
	}

	public IAsyncOnTriggerExit2DHandler GetOnTriggerExit2DAsyncHandler()
	{
		return new AsyncTriggerHandler<Collider2D>(this, callOnce: false);
	}

	public IAsyncOnTriggerExit2DHandler GetOnTriggerExit2DAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<Collider2D>(this, cancellationToken, callOnce: false);
	}

	public UniTask<Collider2D> OnTriggerExit2DAsync()
	{
		return ((IAsyncOnTriggerExit2DHandler)new AsyncTriggerHandler<Collider2D>(this, callOnce: true)).OnTriggerExit2DAsync();
	}

	public UniTask<Collider2D> OnTriggerExit2DAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnTriggerExit2DHandler)new AsyncTriggerHandler<Collider2D>(this, cancellationToken, callOnce: true)).OnTriggerExit2DAsync();
	}
}
