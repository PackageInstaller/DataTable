using System;
using TrueSync;
using UnityEngine;

public class ActorDashState : ActorStateBase<ActorMovementFSM>
{
	protected TSVector2 _direction;

	protected FP _distance;

	protected FP _speed;

	protected FP _duration;

	protected Action _onComplete;

	protected Action _onLevel;

	protected FP _elapsedTime;

	protected bool checkStop;

	protected FP _startTime;

	protected FP _minStopTime;

	protected bool _playAnim;

	public override int GetStateID()
	{
		return 10;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		OnReset(onComplete, onLeave);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		_direction = _fsm.direction;
		_distance = _fsm.distance;
		_speed = _fsm.speed;
		_onComplete = onComplete;
		_onLevel = onLeave;
		checkStop = _fsm._checkStop;
		_startTime = _actor.LogicTime;
		_minStopTime = _fsm.minStopTime;
		_playAnim = _fsm.playAnim;
		if (_distance <= 0f)
		{
			_duration = 0f;
		}
		else
		{
			_duration = _distance / _speed;
		}
		_elapsedTime = 0f;
		_actor.SyncMovementLocation();
		if (_playAnim)
		{
			_actor.PlayDashAnim();
		}
		_actor.GetLogicComponent<LogicVariable>()?.ToggleLogicTag("hitPlayer", value: false);
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		_actor.SyncMovementLocation();
		if (_playAnim)
		{
			_actor.StopDashAnim();
		}
		_onLevel?.Invoke();
	}

	public void Fix_Add_Speed(FP speed)
	{
		_speed += speed;
		_speed = ((_speed < 0) ? ((FP)0) : _speed);
	}

	public override void OnUpdate()
	{
		FP logicDeltaTime = _actor.LogicDeltaTime;
		_elapsedTime += logicDeltaTime;
		if (_fsm.changeDir != null)
		{
			_fsm.changeDir();
			_fsm.direction = _fsm.direction.normalized;
		}
		_direction = _fsm.direction;
		_actor.velocitySpeed = _speed;
		_actor.velocityDirection = _direction;
		FP fP = TSMath.Clamp01(_elapsedTime / _duration);
		if (fP < 1f)
		{
			if (_playAnim)
			{
				_actor.UpdateDashAnim((float)fP);
			}
			if (checkStop)
			{
				FP fP2 = _actor.dtCollider.Radius + 0.1f;
				TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * fP2;
				if (!_actor.QueryPositionWalkable(position))
				{
					Finish(0);
				}
			}
		}
		else
		{
			if (_playAnim)
			{
				_actor.UpdateDashAnim(1f);
			}
			Finish(0);
		}
	}

	protected void Finish(int finishType)
	{
		_fsm.SwitchState(7);
		_actor.GetLogicComponent<LogicVariable>()?.SetLogicTagValue("finishType", finishType);
		_onComplete?.Invoke();
	}

	public override void OnDeterministicCollisionStay(DeterministicCollider other)
	{
		if (!(_actor.LogicTime - _startTime > _minStopTime))
		{
			return;
		}
		switch (other.layer)
		{
		case 8:
			if (!CantStopDash(other.Entity))
			{
				bool flag = _actor.IsConfrontWith(other.Entity);
				if (_fsm.triggerStopS[1] & flag)
				{
					Finish(1);
				}
				else if (_fsm.triggerStopS[2] && !flag)
				{
					Finish(2);
				}
			}
			break;
		case 12:
			if (_fsm.triggerStopS[0])
			{
				Finish(3);
			}
			break;
		}
	}

	protected virtual bool CantStopDash(LogicEntity target)
	{
		if (target == null)
		{
			return false;
		}
		if (target is AdventureActor adventureActor)
		{
			_actor.GetLogicComponent<LogicVariable>()?.ToggleLogicTag("hitPlayer", value: true);
			if (!adventureActor.movementBlockPaused)
			{
				return adventureActor.movementAvoidancePaused;
			}
			return true;
		}
		return false;
	}
}
