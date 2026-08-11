using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Cysharp.Threading.Tasks.Triggers;

[DisallowMultipleComponent]
public sealed class AsyncMoveTrigger : AsyncTriggerBase<AxisEventData>, IMoveHandler, IEventSystemHandler
{
	void IMoveHandler.OnMove(AxisEventData eventData)
	{
		RaiseEvent(eventData);
	}

	public IAsyncOnMoveHandler GetOnMoveAsyncHandler()
	{
		return new AsyncTriggerHandler<AxisEventData>(this, callOnce: false);
	}

	public IAsyncOnMoveHandler GetOnMoveAsyncHandler(CancellationToken cancellationToken)
	{
		return new AsyncTriggerHandler<AxisEventData>(this, cancellationToken, callOnce: false);
	}

	public UniTask<AxisEventData> OnMoveAsync()
	{
		return ((IAsyncOnMoveHandler)new AsyncTriggerHandler<AxisEventData>(this, callOnce: true)).OnMoveAsync();
	}

	public UniTask<AxisEventData> OnMoveAsync(CancellationToken cancellationToken)
	{
		return ((IAsyncOnMoveHandler)new AsyncTriggerHandler<AxisEventData>(this, cancellationToken, callOnce: true)).OnMoveAsync();
	}
}
