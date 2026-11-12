using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_跟随")]
[RequireComponent(typeof(AreaEffectEntity))]
[DisallowMultipleComponent]
public class AreaEffect_FollowComponent : AreaEffect_Component
{
	public enum FollowTargetType
	{
		Owner,
		Target,
		MainPlayerActor,
		SpecifiedTarget
	}

	public FP followTime = -1;

	public bool finishAfterFollowTime;

	public FollowTargetType targetType;

	public bool lockMainActorTarget;

	public FP searchTargetRadius = 15;

	public bool canSwitchTarget = true;

	public bool syncTargetRotation;

	public bool isSlowMove;

	public FP followSpeed = 1f;

	public FP followAcceleratedSpeed = 0f;

	public FP borderVelocitySpeed = 1f;

	public bool changeDirection = true;

	public bool shakeWhenReachingTarget;

	public FP shakeInterval = 0.5f;

	public bool syncPositionY = true;

	public bool positionYWithGround;

	public bool followInEarlyWarning;

	private FP _followTime;

	private TSVector2 _velocityDirection;

	private FP _velocitySpeed;

	private LogicEntity _followTarget;

	private CoroutineNode _shakeMoveNode;

	protected override bool ShowCheckTag => false;

	private bool CanFollow
	{
		get
		{
			if (!(followTime <= 0))
			{
				if (followTime > 0)
				{
					return _followTime > 0;
				}
				return false;
			}
			return true;
		}
	}

	private TSVector2 Velocity => _velocityDirection * _velocitySpeed;

	public LogicEntity FollowTarget
	{
		get
		{
			return _followTarget;
		}
		set
		{
			if (!(_followTarget == value))
			{
				_followTarget = value;
			}
		}
	}

	protected override void OnSetup()
	{
		base.OnSetup();
		_followTime = followTime;
		_velocityDirection = _context.tsTransform.Forward;
		_velocitySpeed = followSpeed;
		UpdateFollowTarget(setup: true);
		_context.EnableSmooth();
	}

	protected override void OnEarlyWarningUpdate(FP logicDeltaTime)
	{
		if (followInEarlyWarning)
		{
			FollowLogic(logicDeltaTime);
		}
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		FollowLogic(logicDeltaTime);
	}

	private void FollowLogic(FP logicDeltaTime)
	{
		if (CanFollow)
		{
			LogicEntity followTarget = FollowTarget;
			UpdateFollowTarget();
			if (FollowTarget == null)
			{
				ForceStopShakeMove();
			}
			else
			{
				bool flag = FollowTarget != followTarget;
				if (isSlowMove)
				{
					if (flag)
					{
						ForceStopShakeMove();
					}
					if (!shakeWhenReachingTarget || _shakeMoveNode == null)
					{
						_velocityDirection = (FollowTarget.tsTransform.Position - _context.tsTransform.Position).normalized;
						if (changeDirection)
						{
							_context.tsTransform.Forward = _velocityDirection;
						}
						if (followAcceleratedSpeed != 0f)
						{
							_velocitySpeed += followAcceleratedSpeed * logicDeltaTime;
							if ((followAcceleratedSpeed > 0f && _velocitySpeed > borderVelocitySpeed) || (followAcceleratedSpeed < 0f && _velocitySpeed < borderVelocitySpeed))
							{
								_velocitySpeed = borderVelocitySpeed;
							}
						}
						if (TSVector2.Distance(_context.tsTransform.Position, FollowTarget.tsTransform.Position) > _velocitySpeed * logicDeltaTime)
						{
							_context.tsTransform.Position += Velocity * logicDeltaTime;
						}
						else if (shakeWhenReachingTarget && FollowTarget is AdventureActor { movementState: ActorState.StandBy } adventureActor)
						{
							_shakeMoveNode = _context.StartLogicCoroutine(ShakeMove(adventureActor));
						}
						else
						{
							_context.tsTransform.Position = FollowTarget.tsTransform.Position;
						}
					}
				}
				else
				{
					_context.tsTransform.Position = FollowTarget.tsTransform.Position;
					if (syncTargetRotation)
					{
						_context.tsTransform.Rotation = FollowTarget.tsTransform.Rotation;
					}
				}
				if (syncPositionY)
				{
					_context.SyncPositionY(FollowTarget.tsTransform.PositionY, positionYWithGround);
				}
			}
			if (followTime > 0 && _followTime > 0)
			{
				_followTime -= logicDeltaTime;
				if (_followTime <= 0 && finishAfterFollowTime)
				{
					FinishAreaEffect = true;
				}
			}
		}
		else
		{
			ForceStopShakeMove();
		}
	}

	private IEnumerator ShakeMove(AdventureActor target)
	{
		FP time = shakeInterval;
		FP shakeTime = 0;
		long targetId = target.Id;
		while (!target.IsDead() && target.Id == targetId && target.movementState == ActorState.StandBy)
		{
			_context.tsTransform.Position += Velocity * _context.LogicDeltaTime;
			shakeTime += _context.LogicDeltaTime;
			if (shakeTime < time)
			{
				yield return null;
				continue;
			}
			time = shakeInterval * 2;
			shakeTime = 0;
			_velocityDirection = -_velocityDirection;
			if (changeDirection)
			{
				_context.tsTransform.Forward = _velocityDirection;
			}
		}
		_shakeMoveNode = null;
	}

	private void ForceStopShakeMove()
	{
		if (_shakeMoveNode != null)
		{
			_context.StopLogicCoroutine(_shakeMoveNode);
			_shakeMoveNode = null;
		}
	}

	private void UpdateFollowTarget(bool setup = false)
	{
		switch (targetType)
		{
		case FollowTargetType.Owner:
			FollowTarget = _owner;
			break;
		case FollowTargetType.Target:
		{
			LogicEntity logicEntity;
			if (lockMainActorTarget)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
				if (playerAdventureActor != null)
				{
					logicEntity = playerAdventureActor.attackTarget;
					if (logicEntity == null)
					{
						logicEntity = ((FollowTarget != null) ? FollowTarget : ILRuntimeAPI.GetTargetNearByRange(playerAdventureActor, searchTargetRadius));
					}
				}
				else
				{
					logicEntity = null;
				}
			}
			else
			{
				AdventureActor owner = _owner;
				LogicEntity logicEntity2;
				if (owner is PlayerAdventureActor)
				{
					logicEntity2 = _owner.attackTarget;
				}
				else
				{
					logicEntity2 = ((!(owner is MonsterAdventureActor)) ? null : _owner.monsterTarget);
				}
				logicEntity = logicEntity2;
				if (logicEntity == null)
				{
					logicEntity = ((FollowTarget != null) ? FollowTarget : ILRuntimeAPI.GetTargetNearByRange(_owner, searchTargetRadius));
				}
			}
			if (FollowTarget != logicEntity && !setup && !canSwitchTarget)
			{
				logicEntity = null;
			}
			FollowTarget = logicEntity;
			break;
		}
		case FollowTargetType.MainPlayerActor:
			FollowTarget = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			break;
		}
		if (FollowTarget is AdventureActor entity && entity.IsDead())
		{
			FollowTarget = null;
		}
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		ForceStopShakeMove();
		_context?.DisableSmooth();
		FollowTarget = null;
	}
}
