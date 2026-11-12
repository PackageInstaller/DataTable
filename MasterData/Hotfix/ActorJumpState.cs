using System;
using TrueSync;
using UnityEngine;

public class ActorJumpState : ActorStateBase<ActorMovementFSM>
{
	protected TSVector2 _targetPosition;

	protected FP _speed;

	protected FP _duration;

	protected Action _onComplete;

	protected Action _onLevel;

	protected FP _distance;

	protected FP _startPositionY;

	protected FP _targetPositionY;

	protected FP _elapsedTime;

	public override int GetStateID()
	{
		return 9;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		_targetPosition = _fsm.targetPosition;
		_speed = _fsm.speed;
		_duration = _fsm.duration;
		if (_speed <= 0 && _duration <= 0)
		{
			_speed = 1;
		}
		_onComplete = onComplete;
		_distance = TSVector2.Distance(_targetPosition, _actor.tsTransform.Position);
		if (_speed > 0)
		{
			_duration = _distance / _speed;
		}
		else
		{
			_speed = _distance / _duration;
		}
		_startPositionY = _actor.tsTransform.PositionY;
		_elapsedTime = 0f;
		_targetPositionY = CommonHelper.GetGroundHeightByActorMoveType(_actor, _targetPosition, _startPositionY);
		_actor.velocityDirection = (_targetPosition - _actor.tsTransform.Position).normalized;
		_actor.SyncMovementLocation();
		_actor.EnableIgnoreDeterministicCollision();
		_actor.PauseMovementAgent();
		_actor.PlayJumpAnim();
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		_actor.tsTransform.PositionY = _targetPositionY;
		_actor.velocitySpeed = 0f;
		_actor.tsTransform.Position = _targetPosition;
		_actor.SyncMovementLocation();
		_actor.ResumeMovementAgent();
		_actor.DisableIgnoreDeterministicCollision();
		_actor.StopJumpAnim();
		_onLevel?.Invoke();
	}

	public override void OnUpdate()
	{
		FP logicDeltaTime = _actor.LogicDeltaTime;
		_elapsedTime += logicDeltaTime;
		_actor.velocitySpeed = _speed;
		if (_duration < AdventureModuleController.Config.Combat_MinJumpDuration)
		{
			_duration = AdventureModuleController.Config.Combat_MinJumpDuration;
			_speed = _distance / _duration;
			_actor.velocitySpeed = _speed;
		}
		FP fP = TSMath.Clamp01(_elapsedTime / _duration);
		if (fP < 1f)
		{
			if (!_fsm.forbiddenHeight)
			{
				FP fP2 = TSMath.Clamp(_distance * 0.5f, AdventureModuleController.Config.Combat_MinJumpHeight, AdventureModuleController.Config.Combat_MaxJumpHeight);
				FP fP3 = _startPositionY;
				if (_targetPositionY > fP3)
				{
					fP3 = _targetPositionY;
				}
				fP2 += fP3;
				if (fP < 0.5f)
				{
					FP t = fP * 2f;
					_actor.tsTransform.PositionY = TSFloatEase.Easing(TSFloatEase.EaseType.EaseOutSine, _startPositionY, fP2, t);
				}
				else
				{
					FP t2 = (fP - 0.5f) * 2f;
					_actor.tsTransform.PositionY = TSFloatEase.Easing(TSFloatEase.EaseType.EaseInSine, fP2, _targetPositionY, t2);
				}
			}
			_actor.UpdateJumpAnim((float)fP);
		}
		else
		{
			_fsm.SwitchState(7);
			_onComplete?.Invoke();
		}
	}
}
