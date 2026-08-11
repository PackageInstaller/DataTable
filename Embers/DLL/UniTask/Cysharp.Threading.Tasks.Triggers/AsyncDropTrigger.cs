using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncDropTrigger : AsyncTriggerBase<PointerEventData>, IDropHandler, IEventSystemHandler
{
	void IDropHandler.OnDrop(PointerEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnDropHandler GetOnDropAsyncHandler()
	{
		return new AsyncTriggerHandler<PointerEventData>(this, callOnce: false);
	}

	public IAsyncOnDropHandler GetOnDropAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<PointerEventData> OnDropAsync()
	{
		return ((IAsyncOnDropHandler)new AsyncTriggerHandler<PointerEventData>(this, callOnce: true)).OnDropAsync();
	}

	public UniTask<PointerEventData> OnDropAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnDropHandler)new AsyncTriggerHandler<PointerEventData>(this, cancellationToken, callOnce: true)).OnDropAsync();
	}
}
