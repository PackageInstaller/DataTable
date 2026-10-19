using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncPointerExitTrigger : AsyncTriggerBase<PointerEventData>, IPointerExitHandler, IEventSystemHandler
{
	void IPointerExitHandler.OnPointerExit(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnPointerExitHandler GetOnPointerExitAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnPointerExitHandler GetOnPointerExitAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnPointerExitAsync()
	{
		return ((IAsyncOnPointerExitHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnPointerExitAsync();
	}

	public UniTask<PointerEventData> OnPointerExitAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnPointerExitHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnPointerExitAsync();
	}
}
