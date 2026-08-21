using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncPointerEnterTrigger : AsyncTriggerBase<PointerEventData>, IPointerEnterHandler, IEventSystemHandler
{
	void IPointerEnterHandler.OnPointerEnter(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnPointerEnterHandler GetOnPointerEnterAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnPointerEnterHandler GetOnPointerEnterAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnPointerEnterAsync()
	{
		return ((IAsyncOnPointerEnterHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnPointerEnterAsync();
	}

	public UniTask<PointerEventData> OnPointerEnterAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnPointerEnterHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnPointerEnterAsync();
	}
}
