using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncDeselectTrigger : AsyncTriggerBase<BaseEventData>, IDeselectHandler, IEventSystemHandler
{
	void IDeselectHandler.OnDeselect(BaseEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnDeselectHandler GetOnDeselectAsyncHandler()
	{
		return new AsyncTriggerHandler<BaseEventData>(this, callOnce: false);
	}

	public IAsyncOnDeselectHandler GetOnDeselectAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<BaseEventData> OnDeselectAsync()
	{
		return ((IAsyncOnDeselectHandler)new AsyncTriggerHandler<BaseEventData>(this, callOnce: true)).OnDeselectAsync();
	}

	public UniTask<BaseEventData> OnDeselectAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnDeselectHandler)new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: true)).OnDeselectAsync();
	}
}
