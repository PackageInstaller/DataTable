using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncUpdateSelectedTrigger : AsyncTriggerBase<BaseEventData>, IUpdateSelectedHandler, IEventSystemHandler
{
	void IUpdateSelectedHandler.OnUpdateSelected(BaseEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnUpdateSelectedHandler GetOnUpdateSelectedAsyncHandler()
	{
		return new AsyncTriggerHandler<BaseEventData>(this, callOnce: false);
	}

	public IAsyncOnUpdateSelectedHandler GetOnUpdateSelectedAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<BaseEventData> OnUpdateSelectedAsync()
	{
		return ((IAsyncOnUpdateSelectedHandler)new AsyncTriggerHandler<BaseEventData>(this, callOnce: true)).OnUpdateSelectedAsync();
	}

	public UniTask<BaseEventData> OnUpdateSelectedAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnUpdateSelectedHandler)new AsyncTriggerHandler<BaseEventData>(this, cancellationToken, callOnce: true)).OnUpdateSelectedAsync();
	}
}
