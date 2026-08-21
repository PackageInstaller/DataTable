using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncCancelTrigger : AsyncTriggerBase<BaseEventData>, ICancelHandler, IEventSystemHandler
{
	void ICancelHandler.OnCancel(BaseEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnCancelHandler GetOnCancelAsyncHandler()
	{
		return new AsyncTriggerHandler<BaseEventData>(this, callOnce: false);
	}

	public IAsyncOnCancelHandler GetOnCancelAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<BaseEventData> OnCancelAsync()
	{
		return ((IAsyncOnCancelHandler)new AsyncTriggerHandler<BaseEventData>(this, callOnce: true)).OnCancelAsync();
	}

	public UniTask<BaseEventData> OnCancelAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnCancelHandler)new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: true)).OnCancelAsync();
	}
}
