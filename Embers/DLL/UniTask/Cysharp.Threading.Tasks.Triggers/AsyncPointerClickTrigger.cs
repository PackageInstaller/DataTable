using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncPointerClickTrigger : AsyncTriggerBase<PointerEventData>, IPointerClickHandler, IEventSystemHandler
{
	void IPointerClickHandler.OnPointerClick(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnPointerClickHandler GetOnPointerClickAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnPointerClickHandler GetOnPointerClickAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnPointerClickAsync()
	{
		return ((IAsyncOnPointerClickHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnPointerClickAsync();
	}

	public UniTask<PointerEventData> OnPointerClickAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnPointerClickHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnPointerClickAsync();
	}
}
