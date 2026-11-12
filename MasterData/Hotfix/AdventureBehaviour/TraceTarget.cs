using System;
using System.Collections;
using TrueSync;

namespace AdventureBehaviour;

public class TraceTarget
{
	protected AdventureActor _actor;

	protected LogicEntity _target;

	protected Action _finishCallback;

	protected Action<bool, bool, bool, bool> _cancelCallback;

	protected Action _updateCb;

	protected CoroutineNode _trackingCoroutine;

	protected FP _trackingDuration;

	protected FP _cancelDistance;

	protected FP _cancelTime;

	private bool tracing;

	public bool Tracing => tracing;

	public void BeginTrace(AdventureActor actor, LogicEntity target, FP stopDistance, FP cancelDistance, FP cancelTime, Action finishCallback, Action<bool, bool, bool, bool> cancelCallback, NavAgentTypeNames.NavigationUpdateQualityLevel navigationUpdateQualityLevel = NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate, AdventureActor.MovementMode movmentMode = AdventureActor.MovementMode.Run, Action leaveCallBack = null, Action updateCb = null)
	{
		_actor = actor;
		_target = target;
		_cancelDistance = cancelDistance;
		_cancelTime = cancelTime;
		_finishCallback = finishCallback;
		_cancelCallback = cancelCallback;
		_updateCb = updateCb;
		_trackingDuration = 0;
		tracing = true;
		if (target == null || !target.isActiveAndEnabled)
		{
			CancelTrace(isDie: true);
			return;
		}
		FP fP = FP.Zero;
		DeterministicCollider logicComponent = target.GetLogicComponent<DeterministicCollider>();
		if (logicComponent != null)
		{
			fP = logicComponent.Radius;
		}
		FP fP2 = actor.dtCollider.Radius + fP;
		if (stopDistance < fP2)
		{
			stopDistance = fP2;
		}
		if (actor.TrackMove(target, stopDistance, enableNavigation: true, navigationUpdateQualityLevel, movmentMode, TraceComplete, leaveCallBack))
		{
			if (_trackingCoroutine == null)
			{
				_trackingCoroutine = _actor.StartLogicCoroutine(Tracking());
			}
		}
		else
		{
			CancelTrace();
		}
	}

	protected IEnumerator Tracking()
	{
		while (true)
		{
			FP logicDeltaTime = _actor.LogicDeltaTime;
			_trackingDuration += logicDeltaTime;
			_updateCb?.Invoke();
			if (_target == null || !_target.isActiveAndEnabled)
			{
				CancelTrace(isDie: true);
				yield break;
			}
			if (_cancelDistance >= 0f && TSVector2.Distance(_actor.tsTransform.Position, _target.tsTransform.Position) >= _cancelDistance)
			{
				CancelTrace(isDie: false, isInterrupt: false, isTimeout: false, isDistanceOut: true);
				yield break;
			}
			if (_cancelTime >= 0f && _trackingDuration >= _cancelTime)
			{
				break;
			}
			yield return null;
		}
		CancelTrace(isDie: false, isInterrupt: false, isTimeout: true);
	}

	protected void TraceComplete()
	{
		if (_trackingCoroutine != null)
		{
			_actor.StopLogicCoroutine(_trackingCoroutine);
			_trackingCoroutine = null;
		}
		if (tracing)
		{
			tracing = false;
			_finishCallback?.Invoke();
		}
	}

	public void CancelTrace(bool isDie = false, bool isInterrupt = false, bool isTimeout = false, bool isDistanceOut = false)
	{
		if (_trackingCoroutine != null)
		{
			_actor?.StopLogicCoroutine(_trackingCoroutine);
			_trackingCoroutine = null;
		}
		if (_actor != null && _actor.movementState == ActorState.Move)
		{
			_actor.StandBy();
		}
		if (tracing)
		{
			tracing = false;
			_cancelCallback?.Invoke(isDie, isInterrupt, isTimeout, isDistanceOut);
		}
	}

	public void Clear()
	{
		CancelTrace();
		_actor = null;
		_target = null;
		_finishCallback = null;
		_cancelCallback = null;
	}
}
