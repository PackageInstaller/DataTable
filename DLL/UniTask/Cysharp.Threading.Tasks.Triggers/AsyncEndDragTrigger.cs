using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncEndDragTrigger : AsyncTriggerBase<PointerEventData>, IEndDragHandler, IEventSystemHandler
{
	void IEndDragHandler.OnEndDrag(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnEndDragHandler GetOnEndDragAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnEndDragHandler GetOnEndDragAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnEndDragAsync()
	{
		return ((IAsyncOnEndDragHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnEndDragAsync();
	}

	public UniTask<PointerEventData> OnEndDragAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnEndDragHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnEndDragAsync();
	}
}
