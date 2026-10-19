using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncBeginDragTrigger : AsyncTriggerBase<PointerEventData>, IBeginDragHandler, IEventSystemHandler
{
	void IBeginDragHandler.OnBeginDrag(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnBeginDragHandler GetOnBeginDragAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnBeginDragHandler GetOnBeginDragAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnBeginDragAsync()
	{
		return ((IAsyncOnBeginDragHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnBeginDragAsync();
	}

	public UniTask<PointerEventData> OnBeginDragAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnBeginDragHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnBeginDragAsync();
	}
}
