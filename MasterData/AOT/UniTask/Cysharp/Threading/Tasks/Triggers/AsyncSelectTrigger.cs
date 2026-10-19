using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncSelectTrigger : AsyncTriggerBase<BaseEventData>, ISelectHandler, IEventSystemHandler
{
	void ISelectHandler.OnSelect(BaseEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnSelectHandler GetOnSelectAsyncHandler()
	{
		return new AsyncTriggerHandler<BaseEventData>(this, callOnce: false);
	}

	public IAsyncOnSelectHandler GetOnSelectAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<BaseEventData> OnSelectAsync()
	{
		return ((IAsyncOnSelectHandler)new AsyncTriggerHandler<BaseEventData>(this, callOnce: true)).OnSelectAsync();
	}

	public UniTask<BaseEventData> OnSelectAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnSelectHandler)new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: true)).OnSelectAsync();
	}
}
