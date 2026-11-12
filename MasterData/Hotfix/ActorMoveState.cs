using System;
using TrueSync;
using UnityEngine;

public class ActorMoveState : ActorStateBase<ActorMovementFSM>
{
	public enum MoveMode
	{
		MoveByDirection,
		MoveToTarget
	}

	protected MoveMode _moveMode;

	protected TSVector2 _direction;

	protected TSVector2 _targetPosition;

	protected FP _targetPositionY;

	protected LogicEntity _trackTarget;

	protected FP _stopDistance;

	protected bool _enableNavigation;

	protected NavAgentTypeNames.NavigationUpdateQualityLevel _navigationUpdateQualityLevel;

	protected FP _navigationUpdateIntervalTime;

	protected Action _onComplete;

	protected Action _onLeave;

	protected FP _navigationUpdateTimer;

	protected TSVector2 _forwardDirection;

	private bool _completed;

	private bool _isTrackTarget;

	public override int GetStateID()
	{
		return 8;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		OnReset(onComplete, onLeave);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		_moveMode = _fsm.moveMode;
		_direction = _fsm.direction;
		_targetPosition = _fsm.targetPosition;
		_targetPositionY = _fsm.targetPositionY;
		_trackTarget = _fsm.trackTarget;
		_stopDistance = _fsm.stopDistance;
		_enableNavigation = _fsm.enableNavigation;
		_navigationUpdateQualityLevel = _fsm.navigationUpdateQualityLevel;
		_onComplete = onComplete;
		_onLeave = onLeave;
		_completed = false;
		if (!_fsm.stopDisIgnoreRadius && _stopDistance < _actor.dtCollider.Radius)
		{
			_stopDistance = _actor.dtCollider.Radius;
		}
		_isTrackTarget = false;
		if (_trackTarget != null)
		{
			_targetPosition = _trackTarget.tsTransform.Position;
			_targetPositionY = _trackTarget.tsTransform.PositionY;
			_isTrackTarget = true;
		}
		if (_moveMode == MoveMode.MoveToTarget && _enableNavigation)
		{
			_actor.movAgent.slowdownTime = 0.05f;
			ConfigNavigationAgentFromQualityLevel();
			_actor.movAgent.StartNavigation(new TSVector(_targetPosition.x, _targetPositionY, _targetPosition.y));
			_navigationUpdateTimer = 0f;
		}
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		ResetNavigationAgentConfigure();
		_actor.movAgent.StopMovement();
		_trackTarget = null;
		_onLeave?.Invoke();
	}

	public override void OnUpdate()
	{
		switch (_moveMode)
		{
		case MoveMode.MoveByDirection:
			if (_trackTarget != null && _trackTarget.isActiveAndEnabled)
			{
				_targetPosition = _trackTarget.tsTransform.Position;
				_direction = (_targetPosition - _actor.tsTransform.Position).normalized;
			}
			_actor.velocityDirection = _direction;
			_actor.velocitySpeed = _actor.movAgent.maxSpeed;
			_actor.movAgent.ForwardMovement(new TSVector(_actor.velocityDirection.x, 0f, _actor.velocityDirection.y));
			break;
		case MoveMode.MoveToTarget:
			if (_isTrackTarget && _actor is MonsterAdventureActor)
			{
				_trackTarget = _actor.monsterTarget;
			}
			if (_trackTarget != null && _trackTarget.isActiveAndEnabled)
			{
				_targetPosition = _trackTarget.tsTransform.Position;
			}
			if (TSVector2.Distance(_targetPosition, _actor.tsTransform.Position) <= _stopDistance)
			{
				if (!_fsm.stayWhenReachTarget)
				{
					_fsm.SwitchState(7);
				}
				if (!_completed)
				{
					_completed = true;
					_onComplete?.Invoke();
				}
				break;
			}
			_actor.velocityDirection = (_targetPosition - _actor.tsTransform.Position).normalized;
			_actor.velocitySpeed = _actor.movAgent.maxSpeed;
			if (_enableNavigation)
			{
				FP logicDeltaTime = _actor.LogicDeltaTime;
				_navigationUpdateTimer += logicDeltaTime;
				if (_navigationUpdateTimer >= _navigationUpdateIntervalTime || !_actor.movAgent.hasPath)
				{
					_navigationUpdateTimer = 0f;
					_actor.movAgent.StartNavigation(new TSVector(_targetPosition.x, 0f, _targetPosition.y));
				}
			}
			else
			{
				_actor.movAgent.ForwardMovement(new TSVector(_actor.velocityDirection.x, 0f, _actor.velocityDirection.y));
			}
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
	}

	protected void ConfigNavigationAgentFromQualityLevel()
	{
		AdventureModuleConfigureData config = AdventureModuleController.Config;
		_actor.ScaleMovementAcceleration(config.Actor_DefaultNavigationAccelerationScaleFactor);
		_actor.ScaleMovementRotationSpeed(config.Actor_DefaultNavigationRotationSpeedScaleFactor);
		switch (_navigationUpdateQualityLevel)
		{
		case NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate:
			_navigationUpdateIntervalTime = config.Actor_NavigationMinUpdateIntervalTime * 8f;
			_actor.movAgent.slowWhenNotFacingTarget = false;
			_actor.movAgent.funnelSimplification = false;
			break;
		case NavAgentTypeNames.NavigationUpdateQualityLevel.MedQualityNavigationUpdate:
			_navigationUpdateIntervalTime = config.Actor_NavigationMinUpdateIntervalTime * 4f;
			_actor.movAgent.slowWhenNotFacingTarget = true;
			_actor.movAgent.funnelSimplification = false;
			break;
		case NavAgentTypeNames.NavigationUpdateQualityLevel.GoodQualityNavigationUpdate:
			_navigationUpdateIntervalTime = config.Actor_NavigationMinUpdateIntervalTime * 2f;
			_actor.movAgent.slowWhenNotFacingTarget = true;
			_actor.movAgent.funnelSimplification = false;
			break;
		case NavAgentTypeNames.NavigationUpdateQualityLevel.HighQualityNavigationUpdate:
			_navigationUpdateIntervalTime = config.Actor_NavigationMinUpdateIntervalTime;
			_actor.movAgent.slowWhenNotFacingTarget = true;
			_actor.movAgent.funnelSimplification = true;
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
	}

	protected void ResetNavigationAgentConfigure()
	{
		_actor.ScaleMovementAcceleration(FP.One);
		_actor.ScaleMovementRotationSpeed(FP.One);
		_actor.movAgent.slowdownTime = 0.5f;
		_actor.movAgent.slowWhenNotFacingTarget = false;
		_actor.movAgent.funnelSimplification = false;
	}
}
