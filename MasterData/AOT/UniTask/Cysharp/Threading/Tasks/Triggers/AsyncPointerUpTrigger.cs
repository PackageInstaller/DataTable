using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncPointerUpTrigger : AsyncTriggerBase<PointerEventData>, IPointerUpHandler, IEventSystemHandler
{
	void IPointerUpHandler.OnPointerUp(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnPointerUpHandler GetOnPointerUpAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnPointerUpHandler GetOnPointerUpAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnPointerUpAsync()
	{
		return ((IAsyncOnPointerUpHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnPointerUpAsync();
	}

	public UniTask<PointerEventData> OnPointerUpAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnPointerUpHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnPointerUpAsync();
	}
}
