using System;
using TrueSync;

namespace AdventureBehaviour;

public class Dash
{
	protected AdventureActor _actor;

	protected Action _finishCallback;

	protected Action _finishByActorCallback;

	protected Action _finishByObstacleCallback;

	protected FP _angleLimit;

	public TSVector2 _direction;

	protected bool _isAngle;

	protected FP _oldAngle;

	protected FP _newAngle;

	private bool useInputDir;

	public void BeginDash(AdventureActor actor, TSVector2 direction, FP speed, FP distance, FP angleLimit, Action finishCallback = null, Action finishByActorCallback = null, Action finishByObstacleCallback = null, bool comboWithAttack = false, bool isAngle = false, bool notChangeForward = false, bool triggerObstacleStop = true, bool triggerEnemyStop = true, bool triggerFriendStop = true, bool checkStop = false, FP minDashTime = default(FP), bool playAnim = true, Action leaveCallBack = null)
	{
		_actor = actor;
		_finishCallback = finishCallback;
		_finishByActorCallback = finishByActorCallback;
		_finishByObstacleCallback = finishByObstacleCallback;
		_angleLimit = angleLimit;
		_direction = direction;
		_isAngle = isAngle;
		useInputDir = false;
		if (speed <= 0f || distance <= 0f)
		{
			OnComplete();
		}
		else if (!actor.Dash(direction, distance, speed, OnComplete, comboWithAttack, !notChangeForward, ChangeDirection, triggerObstacleStop, triggerEnemyStop, triggerFriendStop, checkStop, minDashTime, playAnim, leaveCallBack))
		{
			OnComplete();
		}
	}

	public void BeginDashActorForward(AdventureActor actor, FP speed, FP distance, FP angleLimit, Action finishCallback = null, Action finishByActorCallback = null, Action finishByObstacleCallback = null, bool comboWithAttack = false, bool isAngle = false, bool notChangeForward = false, bool triggerObstacleStop = true, bool triggerEnemyStop = true, bool triggerFriendStop = true, FP minDashTime = default(FP))
	{
		_actor = actor;
		_finishCallback = finishCallback;
		_finishByActorCallback = finishByActorCallback;
		_finishByObstacleCallback = finishByObstacleCallback;
		_angleLimit = angleLimit;
		_isAngle = isAngle;
		if (speed <= 0f || distance <= 0f)
		{
			OnComplete();
		}
		else if (!actor.Dash(actor.tsTransform.Forward, distance, speed, OnComplete, comboWithAttack, !notChangeForward, ChangeDirectionByActorFoward, triggerObstacleStop, triggerEnemyStop, triggerFriendStop, checkStop: false, minDashTime))
		{
			OnComplete();
		}
	}

	public void ChangeDashSpeed(FP speed)
	{
		if (!(_actor == null) && _actor.movementState == ActorState.Dash)
		{
			(_actor._movementFSM.GetCurState() as ActorDashState).Fix_Add_Speed(speed);
		}
	}

	protected FP GetAngel(FP angle)
	{
		if (angle > 360 || angle < -360)
		{
			angle %= (FP)360;
		}
		if (angle < 0)
		{
			angle = 360 + angle;
		}
		if (angle % 1 > 0.9f)
		{
			return FP.Ceiling(angle);
		}
		if (angle % 1 < 0.1f)
		{
			return FP.Floor(angle);
		}
		return angle;
	}

	public void SetInputDirection()
	{
		useInputDir = true;
	}

	protected void ChangeDirection()
	{
		if (_angleLimit <= 0 || _actor == null || !_isAngle)
		{
			return;
		}
		if (useInputDir)
		{
			if (!SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
			{
				return;
			}
			_direction = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		}
		_oldAngle = _actor._movementFSM.direction.GetAngle();
		_newAngle = _direction.GetAngle();
		_oldAngle = GetAngel(_oldAngle);
		_newAngle = GetAngel(_newAngle);
		FP fP = _newAngle - _oldAngle;
		if (fP == 0)
		{
			return;
		}
		if (fP > _angleLimit || fP < -_angleLimit)
		{
			if (fP > 0)
			{
				if (fP < 180)
				{
					_actor._movementFSM.direction = TSVector2.Rotate(_actor._movementFSM.direction, _angleLimit);
				}
				else
				{
					_actor._movementFSM.direction = TSVector2.Rotate(_actor._movementFSM.direction, -_angleLimit);
				}
			}
			else if (fP >= -180)
			{
				_actor._movementFSM.direction = TSVector2.Rotate(_actor._movementFSM.direction, -_angleLimit);
			}
			else
			{
				_actor._movementFSM.direction = TSVector2.Rotate(_actor._movementFSM.direction, _angleLimit);
			}
		}
		else
		{
			_actor._movementFSM.direction = _direction;
		}
	}

	protected void ChangeDirectionByActorFoward()
	{
		if (_angleLimit <= 0 || !_isAngle)
		{
			return;
		}
		_oldAngle = _actor._movementFSM.direction.GetAngle();
		_oldAngle = (_oldAngle + 360f) % 360f;
		_newAngle = _actor.tsTransform.Forward.GetAngle();
		_newAngle = (_newAngle + 360f) % 360f;
		FP fP = _newAngle - _oldAngle;
		FP fP2 = ((fP > 0f) ? fP : (-fP));
		if (fP2 > 180f)
		{
			fP = ((fP > 0f) ? (-(360f - fP2)) : (360f - fP2));
		}
		if (!(FP.Abs(fP) < FP.Epsilon))
		{
			if (FP.Abs(fP) >= _angleLimit)
			{
				FP degrees = TSMath.Clamp(fP, -_angleLimit, _angleLimit);
				_actor._movementFSM.direction = TSVector2.Rotate(_actor._movementFSM.direction, degrees);
			}
			else
			{
				_actor._movementFSM.direction = _actor.tsTransform.Forward;
			}
		}
	}

	protected void OnComplete()
	{
		LogicVariable logicVariable = _actor?.GetLogicComponent<LogicVariable>();
		if (logicVariable == null)
		{
			_finishCallback?.Invoke();
			return;
		}
		FP logicTagValue = logicVariable.GetLogicTagValue("finishType");
		if (logicTagValue == 0)
		{
			_finishCallback?.Invoke();
		}
		else if (logicTagValue == 1 || logicTagValue == 2)
		{
			_finishByActorCallback?.Invoke();
		}
		else if (logicTagValue == 3)
		{
			_finishByObstacleCallback?.Invoke();
		}
	}

	public void Interrupte()
	{
		if (_actor != null && _actor.movementState == ActorState.Dash)
		{
			_actor.StandBy();
		}
	}

	public void Clear()
	{
		_actor = null;
		_finishCallback = null;
		_finishByActorCallback = null;
		_finishByObstacleCallback = null;
	}
}
