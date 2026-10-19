using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncScrollTrigger : AsyncTriggerBase<PointerEventData>, IScrollHandler, IEventSystemHandler
{
	void IScrollHandler.OnScroll(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnScrollHandler GetOnScrollAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnScrollHandler GetOnScrollAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnScrollAsync()
	{
		return ((IAsyncOnScrollHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnScrollAsync();
	}

	public UniTask<PointerEventData> OnScrollAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnScrollHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnScrollAsync();
	}
}
