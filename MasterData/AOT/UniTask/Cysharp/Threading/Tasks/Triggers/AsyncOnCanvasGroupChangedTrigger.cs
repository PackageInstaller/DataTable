using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncOnCanvasGroupChangedTrigger : AsyncTriggerBase<AsyncUnit>
{
	private void OnCanvasGroupChanged()
	{
		RaiseEvent(AsyncUnit.Default);
	}

	public IAsyncOnCanvasGroupChangedHandler GetOnCanvasGroupChangedAsyncHandler()
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, callOnce: false);
	}

	public IAsyncOnCanvasGroupChangedHandler GetOnCanvasGroupChangedAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: false);
	}

	public UniTask OnCanvasGroupChangedAsync()
	{
		return ((IAsyncOnCanvasGroupChangedHandler)new AsyncTriggerHandler<AsyncUnit>(this, callOnce: true)).OnCanvasGroupChangedAsync();
	}

	public UniTask OnCanvasGroupChangedAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnCanvasGroupChangedHandler)new AsyncTriggerHandler<AsyncUnit>(this, cancellationToken, callOnce: true)).OnCanvasGroupChangedAsync();
	}
}
