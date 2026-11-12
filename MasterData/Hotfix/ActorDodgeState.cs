using System;
using TrueSync;
using UnityEngine;

public class ActorDodgeState : ActorStateBase<ActorMovementFSM>
{
	protected TSVector2 _direction;

	protected FP _distance;

	protected FP _duration;

	protected FP _speed;

	protected Action _onComplete;

	protected Action _onLeave;

	protected FP _elapsedTime;

	public override int GetStateID()
	{
		return 11;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		OnReset(onComplete, onLeave);
		if (_actor.canPerfectDodge && !_actor.forbiddenPerfectDodge)
		{
			_actor.EnterPerfectDodge();
			_actor.canPerfectDodge = false;
		}
		else if (_actor is PlayerAdventureActor && !_actor.forbiddenPerfectDodge)
		{
			_actor.canPerfectDodge = true;
		}
		_actor.EnableSuperArmor();
		_actor.EnableDodge();
		_actor.PauseMovementBlock();
		ActorSearchTarget logicComponent = _actor.GetLogicComponent<ActorSearchTarget>();
		logicComponent.EnableVisionLogic(enable: false);
		logicComponent.EnableHearingLogic(enable: false);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		_direction = _fsm.direction;
		_distance = _fsm.distance;
		_duration = _fsm.duration;
		_onComplete = onComplete;
		_onLeave = onLeave;
		if (_fsm.dashCanRotate)
		{
			_actor.tsTransform.Forward = _direction;
		}
		if (_duration != 0f)
		{
			_speed = _distance / _duration;
		}
		if (_actor.crossObstacleMode)
		{
			_speed = 0;
		}
		_elapsedTime = 0f;
		_actor.SyncMovementLocation();
		_actor.PlayDodgeAnim();
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		_actor.DisableSuperArmor();
		_actor.DisableDodge();
		_actor.canPerfectDodge = false;
		_actor.ResumeMovementBlock();
		_actor.SyncMovementLocation();
		_actor.StopDodgeAnim();
		ActorSearchTarget logicComponent = _actor.GetLogicComponent<ActorSearchTarget>();
		logicComponent.EnableVisionLogic();
		logicComponent.EnableHearingLogic();
		if (_actor is PlayerAdventureActor)
		{
			_actor.attackTarget = logicComponent.GetLockingConfrontActor(useInputDirection: true);
		}
		if (_actor.actorInfo.fastSpeedMode)
		{
			SceneSingleton<AdventurePlayerController>.Instance?.ClearSwitchTargetLs(swichOff: true);
		}
		_onLeave?.Invoke();
	}

	public override void OnUpdate()
	{
		FP logicDeltaTime = _actor.LogicDeltaTime;
		_elapsedTime += logicDeltaTime;
		if (_elapsedTime > AdventureModuleController.Config.PrefectDodge_TimeAfterDodgeBegin)
		{
			_actor.canPerfectDodge = false;
		}
		_actor.velocitySpeed = _speed;
		_actor.velocityDirection = _direction;
		FP fP = TSMath.Clamp01(_elapsedTime / _duration);
		if (fP < 1f)
		{
			_actor.UpdateDodgeAnim((float)fP);
			return;
		}
		_actor.UpdateDodgeAnim(1f);
		_fsm.SwitchState(7);
		_onComplete?.Invoke();
	}
}
