using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncDragTrigger : AsyncTriggerBase<PointerEventData>, IDragHandler, IEventSystemHandler
{
	void IDragHandler.OnDrag(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnDragHandler GetOnDragAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnDragHandler GetOnDragAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnDragAsync()
	{
		return ((IAsyncOnDragHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnDragAsync();
	}

	public UniTask<PointerEventData> OnDragAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnDragHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnDragAsync();
	}
}
