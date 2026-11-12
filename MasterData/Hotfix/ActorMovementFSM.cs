using System;
using TrueSync;
using UnityEngine;

public class ActorMovementFSM(GameObject actor) : ActorFSM(actor)
{
	internal bool dashCanRotate;

	public ActorMoveState.MoveMode moveMode;

	internal TSVector2 direction;

	internal TSVector2 targetPosition;

	internal FP targetPositionY;

	internal LogicEntity trackTarget;

	internal FP stopDistance;

	internal bool stopDisIgnoreRadius;

	internal bool enableNavigation;

	internal NavAgentTypeNames.NavigationUpdateQualityLevel navigationUpdateQualityLevel;

	internal FP distance;

	internal FP speed;

	internal FP duration;

	internal bool forbiddenHeight;

	internal Action changeDir;

	internal readonly bool[] triggerStopS = new bool[3];

	internal FP minStopTime;

	internal bool playAnim;

	internal bool _checkStop;

	protected TSVector2 _accumulatedMovementDelta;

	protected FP _oldAngle;

	protected FP _newAngle;

	public bool forceMove;

	internal bool stayWhenReachTarget;

	private TSVector2 rootMotionDir;

	private bool enableRootMotionDir;

	public bool runtimeIgonreRootMotion;

	public bool rootMotionRotateOnlyChangeForward;

	private static readonly float SmoothTime = 0.08f;

	private float _currentDampVelocity;

	private float _currentForwardX;

	private float _currentForwardY;

	private float _currentVelocityDirX;

	private float _currentVelocityDirY;

	public override void OnUpdate()
	{
		base.OnUpdate();
		FP logicDeltaTime = _actor.LogicDeltaTime;
		DeterministicMovementAgent movAgent = _actor.movAgent;
		FP fP = FP.Abs(_actor.velocitySpeed);
		FP forwardRotationSpeed = movAgent.rotationSpeed;
		bool applyRootMotion = _actor._attackFSM.applyRootMotion;
		bool applyRootMotionRotate = _actor._attackFSM.applyRootMotionRotate;
		bool flag = !(_actor is PlayerAdventureActor) || _actor.actorSkillManage == null || !_actor.actorSkillManage.CheckIsMovable() || _actor.disableMove || !SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput();
		if (flag & applyRootMotionRotate)
		{
			TSVector2 tSVector = TSVector2.Rotate((_actor.velocityDirection != TSVector2.zero) ? _actor.velocityDirection : movAgent.Forward2D, _actor._attackFSM.deltaRootMotionRotateAngle);
			movAgent.RotationTowards(new TSVector(tSVector.x, 0f, tSVector.y), FP.MaxValue);
			forwardRotationSpeed = FP.MaxValue;
		}
		if (movAgent.enabled && movAgent.canMove)
		{
			if ((_actor.movementState == ActorState.Dash || _actor.movementState == ActorState.Dodge) && fP > FP.Epsilon)
			{
				TSVector2 movementDelta = _actor.velocity * logicDeltaTime;
				Move(movementDelta);
				if (_actor.velocityDirection != TSVector2.zero && dashCanRotate)
				{
					movAgent.RotationTowards(new TSVector(_actor.velocityDirection.x, 0f, _actor.velocityDirection.y), FP.MaxValue);
					forwardRotationSpeed = FP.MaxValue;
				}
			}
			if (flag & applyRootMotion)
			{
				TSVector2 tSVector2 = movAgent.TransformLocalPointToWorldSpace(_actor._attackFSM.deltaRootMotionTranslate) - movAgent.Position2D;
				if (enableRootMotionDir)
				{
					tSVector2 = rootMotionDir.normalized * tSVector2.magnitude;
				}
				if (runtimeIgonreRootMotion)
				{
					tSVector2 = TSVector2.zero;
				}
				Move(tSVector2);
				if (_actor.crossObstacleMode)
				{
					tSVector2 *= _actor.crossObstacleModeSpeedMultiply;
					_actor.tsTransform.Position += tSVector2;
				}
			}
			if (_actor.externalForce != TSVector2.zero)
			{
				_actor.haveExternalForce = true;
				TSVector2 movementDelta2 = _actor.externalForce * logicDeltaTime;
				Move(movementDelta2);
				if (_actor.velocityDirection != TSVector2.zero)
				{
					movAgent.RotationTowards(new TSVector(_actor.velocityDirection.x, 0f, _actor.velocityDirection.y), FP.MaxValue);
					forwardRotationSpeed = FP.MaxValue;
				}
				_actor.externalForce = TSVector2.zero;
			}
			movAgent.UpdateMovement(logicDeltaTime);
			if (!_actor.isBondage)
			{
				_actor.velocityDirection = movAgent.movementVelocity.normalized;
				_actor.velocitySpeed = movAgent.movementVelocity.magnitude;
			}
			if (!_actor.crossObstacleMode)
			{
				TSVector position = movAgent.position;
				if (!_actor.isAirBorne)
				{
					_actor.tsTransform.PositionY = position.y;
				}
				_actor.tsTransform.Position = new TSVector2(position.x, position.z);
			}
		}
		else if (_actor.movementState == ActorState.Jump && fP > FP.Epsilon)
		{
			TSVector2 tSVector3 = _actor.velocity * logicDeltaTime;
			_actor.tsTransform.Position += tSVector3;
		}
		if (movAgent.enabled && !_actor.disableRotate)
		{
			UpdateForwardDirection(forwardRotationSpeed);
		}
		UpdateAnimation(applyRootMotion, applyRootMotionRotate);
		_accumulatedMovementDelta = TSVector2.zero;
	}

	protected virtual void Move(TSVector2 movementDelta)
	{
		if (!_actor.crossObstacleMode)
		{
			TSVector2 tSVector = _actor.tsTransform.Position + _accumulatedMovementDelta;
			if ((movementDelta.LengthSquared() > 1f || !_actor.QueryPositionWalkable(tSVector + movementDelta)) && _actor.LinecastNavmeshGraph(tSVector, tSVector + movementDelta, out var linecastHitPoint, offset: true, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY))
			{
				movementDelta = linecastHitPoint - tSVector;
			}
			_accumulatedMovementDelta += movementDelta;
			_actor.movAgent.Move(new TSVector(movementDelta.x, 0f, movementDelta.y));
		}
	}

	protected void UpdateForwardDirection(FP forwardRotationSpeed)
	{
		if (_actor.movementState == ActorState.Dash && !dashCanRotate)
		{
			return;
		}
		if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			if (_actor.aimLockedTarget == null)
			{
				return;
			}
			if (_actor.aimAngleLimit > 0)
			{
				if (_actor.LogicDeltaTime == FP.Zero)
				{
					return;
				}
				_oldAngle = _actor.tsTransform.Forward.GetAngle();
				_newAngle = (_actor.aimLockedTarget.tsTransform.Position - _actor.tsTransform.Position).GetAngle();
				_oldAngle = GetAngel(_oldAngle);
				_newAngle = GetAngel(_newAngle);
				FP fP = _newAngle - _oldAngle;
				if (fP == 0)
				{
					return;
				}
				if (fP > _actor.aimAngleLimit || fP < -_actor.aimAngleLimit)
				{
					if (fP > 0)
					{
						if (fP < 180)
						{
							_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, _actor.aimAngleLimit);
						}
						else
						{
							_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, -_actor.aimAngleLimit);
						}
					}
					else if (fP >= -180)
					{
						_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, -_actor.aimAngleLimit);
					}
					else
					{
						_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, _actor.aimAngleLimit);
					}
				}
				else
				{
					_actor.tsTransform.Forward = (_actor.aimLockedTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
				}
			}
			else
			{
				_actor.tsTransform.Forward = (_actor.aimLockedTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			return;
		}
		if (_actor.aimMode == AdventureActor.AimMode.LockDirection)
		{
			if (!(_actor.aimAngleLimit > 0))
			{
				return;
			}
			_oldAngle = _actor.tsTransform.Forward.GetAngle();
			_newAngle = _actor.targetDir.GetAngle();
			_oldAngle = GetAngel(_oldAngle);
			_newAngle = GetAngel(_newAngle);
			FP fP2 = _newAngle - _oldAngle;
			if (fP2 == 0)
			{
				return;
			}
			if (fP2 > _actor.aimAngleLimit || fP2 < -_actor.aimAngleLimit)
			{
				if (fP2 > 0)
				{
					if (fP2 < 180)
					{
						_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, _actor.aimAngleLimit);
					}
					else
					{
						_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, -_actor.aimAngleLimit);
					}
				}
				else if (fP2 >= -180)
				{
					_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, -_actor.aimAngleLimit);
				}
				else
				{
					_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, _actor.aimAngleLimit);
				}
			}
			else
			{
				_actor.tsTransform.Forward = _actor.targetDir;
			}
			return;
		}
		if (_actor.enableChangeCurrentAttackTarget)
		{
			_actor.enableChangeCurrentAttackTarget = false;
			if (_actor.aimLockedTarget != null)
			{
				_actor.tsTransform.Forward = (_actor.aimLockedTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
				_actor.SyncMovementLocation();
				return;
			}
		}
		if (_actor.forceChangeDirection != TSVector2.zero)
		{
			return;
		}
		if (_actor.isBondage && _actor.velocityDirection != TSVector2.zero)
		{
			_actor.tsTransform.Forward = _actor.velocityDirection;
			return;
		}
		TSVector2 forward = _actor.tsTransform.Forward;
		TSVector2 forward2D = _actor.movAgent.Forward2D;
		FP one = FP.One;
		TSQuaternion tSQuaternion = TSQuaternion.LookRotation(new TSVector(forward.x, 0f, forward.y), TSVector.up);
		TSQuaternion to = TSQuaternion.LookRotation(new TSVector(forward2D.x, 0f, forward2D.y), TSVector.up);
		TSVector eulerAngles = TSQuaternion.RotateTowards(tSQuaternion, to, forwardRotationSpeed * one * _actor.LogicDeltaTime).eulerAngles;
		if (eulerAngles.x >= 0f)
		{
			_actor.tsTransform.Rotation = -eulerAngles.y;
		}
		else
		{
			_actor.tsTransform.Rotation = eulerAngles.y + 180f;
		}
	}

	public void EnableRootMotionForceDir(TSVector2 forceDir)
	{
		_actor.movementFSM.enableRootMotionDir = true;
		_actor.movementFSM.rootMotionDir = forceDir;
	}

	public void DisableRootMotionForceDir()
	{
		_actor.movementFSM.rootMotionDir = TSVector2.zero;
		_actor.movementFSM.enableRootMotionDir = false;
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

	public virtual void UpdateAnimation(bool applyRootMotion, bool applyRootMotionRotate)
	{
		if (_actor.animatorController == null)
		{
			return;
		}
		if (_actor.actorInfo.runAnimationSpd <= 0 || _actor.actorInfo.walkAnimationSpd <= 0)
		{
			_actor.actorInfo.runAnimationSpd = 5;
			_actor.actorInfo.walkAnimationSpd = 3;
		}
		if (applyRootMotionRotate)
		{
			_actor.rootBoneRotationLocked = true;
		}
		else
		{
			_actor.rootBoneRotationLocked = false;
		}
		if (_actor.aimMode != AdventureActor.AimMode.Forward)
		{
			_actor.animatorController.SetBool(AdventureActor.AnimationParameterNames.IsAiming, value: true);
			if (_actor.comboGroup != null && _actor.curAimCombo != null)
			{
				if (_actor.aimWithStartAnim && _actor.comboGroup.aimStartAnimClip != null)
				{
					if (_actor.animatorController.baseOverrideWithMaskPlayable.playingAnimationClip != _actor.comboGroup.aimStartAnimClip.animationClip && _actor.animatorController.baseOverrideWithMaskPlayable.playingAnimationClip != _actor.curAimCombo.animationClip)
					{
						_actor.animatorController.PlayActionAnimation(_actor.comboGroup.aimStartAnimClip.animationClip, HybirdAnimatorController.ActionAnimationType.BaseOverrideWithMask, (float)_actor.comboGroup.aimStartAnimClip.transitionIn, (float)_actor.comboGroup.aimStartAnimClip.transitionOut, (float)_actor.comboGroup.aimStartAnimClip.playSpeed, 1, pauseOnEnd: false, () =>
						{
							AdventureActorAimStartAnimPlayEndEvent aEvent2 = AdventureActorAimStartAnimPlayEndEvent.Generate();
							ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent2);
							_actor.animatorController.PlayActionAnimation(_actor.curAimCombo.animationClip, HybirdAnimatorController.ActionAnimationType.BaseOverrideWithMask, (float)_actor.curAimCombo.transitionIn, (float)_actor.curAimCombo.transitionOut, (float)_actor.curAimCombo.playSpeed, -1);
						});
					}
				}
				else if (_actor.animatorController.baseOverrideWithMaskPlayable.playingAnimationClip != _actor.curAimCombo.animationClip)
				{
					_actor.animatorController.PlayActionAnimation(_actor.curAimCombo.animationClip, HybirdAnimatorController.ActionAnimationType.BaseOverrideWithMask, (float)_actor.curAimCombo.transitionIn, (float)_actor.curAimCombo.transitionOut, (float)_actor.curAimCombo.playSpeed, -1);
				}
			}
		}
		else
		{
			_actor.animatorController.SetBool(AdventureActor.AnimationParameterNames.IsAiming, value: false);
			if (_actor.comboGroup != null)
			{
				if (_actor.curAimCombo != null && _actor.animatorController.baseOverrideWithMaskPlayable.playingAnimationClip == _actor.curAimCombo.animationClip)
				{
					_actor.animatorController.StopActionAnimation(HybirdAnimatorController.ActionAnimationType.BaseOverrideWithMask, (float)_actor.curAimCombo.transitionOut);
				}
				else if (_actor.comboGroup.aimStartAnimClip != null && _actor.animatorController.baseOverrideWithMaskPlayable.playingAnimationClip == _actor.comboGroup.aimStartAnimClip.animationClip)
				{
					_actor.animatorController.StopActionAnimation(HybirdAnimatorController.ActionAnimationType.BaseOverrideWithMask, (float)_actor.comboGroup.aimStartAnimClip.transitionOut);
					AdventureActorAimStartAnimInterruptedEvent aEvent = AdventureActorAimStartAnimInterruptedEvent.Generate();
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
				}
			}
		}
		bool flag = false;
		float num = 0f;
		if (_actor.isRotating || _actor.isRotate)
		{
			num = (_actor.isRotateCloseTarget ? 0f : 0.5f);
		}
		else if (GetCurStateID() == 7)
		{
			num = 0f;
		}
		else
		{
			switch (_actor.movementMode)
			{
			case AdventureActor.MovementMode.Run:
				num = ((_actor.actorInfo.runSpeed > _actor.actorInfo.transSpdScale * _actor.actorInfo.originRunSpeed) ? 1f : 0.5f);
				if (_actor.actorInfo.fastSpeedMode)
				{
					num = 2f;
				}
				break;
			case AdventureActor.MovementMode.Walk:
				num = ((_actor.actorInfo.walkSpeed > _actor.actorInfo.transSpdScale * _actor.actorInfo.originRunSpeed) ? 1f : 0.5f);
				break;
			default:
				throw new ArgumentOutOfRangeException();
			case AdventureActor.MovementMode.None:
				break;
			}
			flag = true;
		}
		_actor.animatorController.SetFloat(AdventureActor.AnimationParameterNames.MoveSpeedHash, num);
		if (flag)
		{
			FP fP = _actor.movAgent.maxSpeed / _actor.actorInfo.walkAnimationSpd;
			if (num > 0.5f)
			{
				fP = _actor.movAgent.maxSpeed / _actor.actorInfo.runAnimationSpd;
			}
			fP /= _actor.actorScaleInfo.modelScale;
			_actor.animatorController.SetFloat(AdventureActor.AnimationParameterNames.MoveSpeedMultiplierHash, (float)fP);
		}
		if (_actor.aimMode != AdventureActor.AimMode.Forward || _actor.attackState == ActorState.AttackReload)
		{
			TSVector2 forward = _actor.tsTransform.Forward;
			TSVector2 velocityDirection = _actor.velocityDirection;
			if (forward != TSVector2.zero && velocityDirection != TSVector2.zero)
			{
				Vector3 forward2;
				Vector3 vector;
				if (_actor is MonsterAdventureActor || (_actor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorInfo.moveDirChangeSmoothTime > 0))
				{
					float smoothTime = SmoothTime;
					if (_actor is PlayerAdventureActor playerAdventureActor2)
					{
						smoothTime = (float)playerAdventureActor2.actorInfo.moveDirChangeSmoothTime;
					}
					_currentForwardX = Mathf.SmoothDamp(_currentForwardX, (float)forward.x, ref _currentDampVelocity, smoothTime);
					_currentForwardY = Mathf.SmoothDamp(_currentForwardY, (float)forward.y, ref _currentDampVelocity, smoothTime);
					forward2 = new Vector3(_currentForwardX, 0f, _currentForwardY);
					_currentVelocityDirX = Mathf.SmoothDamp(_currentVelocityDirX, (float)velocityDirection.x, ref _currentDampVelocity, smoothTime);
					_currentVelocityDirY = Mathf.SmoothDamp(_currentVelocityDirY, (float)velocityDirection.y, ref _currentDampVelocity, smoothTime);
					vector = new Vector3(_currentVelocityDirX, 0f, _currentVelocityDirY);
				}
				else
				{
					forward2 = new Vector3((float)forward.x, 0f, (float)forward.y);
					vector = new Vector3((float)velocityDirection.x, 0f, (float)velocityDirection.y);
				}
				Vector3 vector2 = Quaternion.Inverse(Quaternion.LookRotation(forward2, Vector3.up)) * vector;
				float z = vector2.z;
				float x = vector2.x;
				_actor.animatorController.SetFloat(AdventureActor.AnimationParameterNames.MoveDirectionForward, z);
				_actor.animatorController.SetFloat(AdventureActor.AnimationParameterNames.MoveDirectionSide, x);
			}
			else
			{
				_currentForwardX = 0f;
				_currentForwardY = 0f;
				_currentVelocityDirX = 0f;
				_currentVelocityDirY = 0f;
			}
		}
		else
		{
			_currentForwardX = 0f;
			_currentForwardY = 0f;
			_currentVelocityDirX = 0f;
			_currentVelocityDirY = 0f;
			_actor.animatorController.SetFloat(AdventureActor.AnimationParameterNames.MoveDirectionForward, num);
			_actor.animatorController.SetFloat(AdventureActor.AnimationParameterNames.MoveDirectionSide, 0f);
		}
	}
}
