using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncSubmitTrigger : AsyncTriggerBase<BaseEventData>, ISubmitHandler, IEventSystemHandler
{
	void ISubmitHandler.OnSubmit(BaseEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnSubmitHandler GetOnSubmitAsyncHandler()
	{
		return new AsyncTriggerHandler<BaseEventData>(this, callOnce: false);
	}

	public IAsyncOnSubmitHandler GetOnSubmitAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<BaseEventData> OnSubmitAsync()
	{
		return ((IAsyncOnSubmitHandler)new AsyncTriggerHandler<BaseEventData>(this, callOnce: true)).OnSubmitAsync();
	}

	public UniTask<BaseEventData> OnSubmitAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnSubmitHandler)new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: true)).OnSubmitAsync();
	}
}
