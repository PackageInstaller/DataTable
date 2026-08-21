using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class MoveComponent : BaseComponent
{
	private float _lerpMoveSpeed;

	private float _lerpSpeed;

	private bool _openLerpRotate;

	private AnimatorComponent _animatorComponent;

	private Vector3 _currentVelocity = Vector3.zero;

	private KinematicMoveComponent _moveComponent;

	private bool _moveEnable = true;

	private bool _rotateEnable = true;

	private bool animEnable = true;

	private bool isMoving;

	private MoveType moveType;

	private StateComponent stateComponent;

	private AbnormalStateComponent abnormalStateComponent;

	private Vector3 _playerCustomMoveDir;

	private bool _isOpenCustomMoveDir;

	private bool nextFrameMoveMin;

	private Vector3 position = Vector3.zero;

	private int _lastMoveState = -1;

	public bool MoveEnable
	{
		get
		{
			if (_moveEnable && stateComponent.GetMoveEnable())
			{
				return abnormalStateComponent.IsCanMove;
			}
			return false;
		}
	}

	public bool RotateEnable
	{
		get
		{
			if (_rotateEnable && stateComponent.GetRotateEnable())
			{
				return abnormalStateComponent.IsCanRotate;
			}
			return false;
		}
	}

	public override void OnStart(object data = null)
	{
		_animatorComponent = mBaseEntity.GetComponent<AnimatorComponent>();
		_moveComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
		stateComponent = mBaseEntity.GetComponent<StateComponent>();
		abnormalStateComponent = mBaseEntity.GetComponent<AbnormalStateComponent>();
	}

	public void ChangeMovementEnable(bool canMove, bool canRotate)
	{
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"ChangeMoveEnable ： {canMove}  ChangeRotateEnable  : {canRotate}", mBaseEntity);
		}
		_moveEnable = canMove;
		_rotateEnable = canRotate;
	}

	public void ChangePlayerMoveDir(Vector2 moveDir, bool openChangeDir)
	{
		_playerCustomMoveDir = new Vector3(moveDir.x, 0f, moveDir.y);
		_isOpenCustomMoveDir = openChangeDir;
	}

	private Vector3 GetEntityMoveDir()
	{
		if (_isOpenCustomMoveDir)
		{
			return _playerCustomMoveDir;
		}
		return base.transform.rotation * Vector3.forward;
	}

	public void SetAnimEnable(bool enable)
	{
		animEnable = enable;
	}

	public void ExecuteCommand(Vector2 inputUV)
	{
		_currentVelocity.x = inputUV.x;
		_currentVelocity.y = 0f;
		_currentVelocity.z = inputUV.y;
	}

	private void CheckMoveState()
	{
		if (MoveEnable && HaveMoveInput())
		{
			if (!isMoving)
			{
				isMoving = true;
				ObserverMoveStateParams observerMoveStateParams = ReferencePool.Acquire<ObserverMoveStateParams>();
				observerMoveStateParams.Init(mBaseEntity, isMoving);
				mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.MoveState, observerMoveStateParams);
				ReferencePool.Release(observerMoveStateParams);
			}
		}
		else if (isMoving)
		{
			isMoving = false;
			ObserverMoveStateParams observerMoveStateParams2 = ReferencePool.Acquire<ObserverMoveStateParams>();
			observerMoveStateParams2.Init(mBaseEntity, isMoving);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.MoveState, observerMoveStateParams2);
			ReferencePool.Release(observerMoveStateParams2);
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		if (animEnable)
		{
			SetAnimatorParam(MoveEnable);
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (mBaseEntity is MonsterEntity || (mBaseEntity is HeroEntity heroEntity && (heroEntity.IsAi || heroEntity.InFreedomBattleMode())))
		{
			return;
		}
		if (HaveMoveInput())
		{
			if (RotateEnable)
			{
				UpdateRotation(deltaTime, out var nextRotation);
				FinalizeRotate(nextRotation);
			}
			nextFrameMoveMin = false;
			if (MoveEnable)
			{
				UpdateVelocity(deltaTime, out var nextPosition);
				FinalizeMove(nextPosition);
			}
		}
		CheckMoveState();
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"MoveEnable   {MoveEnable}：", mBaseEntity);
		}
	}

	private void UpdateVelocity(float deltaTime, out Vector3 nextPosition)
	{
		if (MoveEnable && _currentVelocity != Vector3.zero)
		{
			Vector3 vector = GetEntityMoveDir() * mBaseEntity.GetProperty("Speed") * deltaTime;
			nextPosition = base.transform.position + vector;
		}
		else
		{
			nextPosition = base.transform.position;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId(string.Format("MoveComponent transform.position {0} moveValue {1} UpdateVelocity 1：{2} {3} {4} {5}", base.transform.position, GetEntityMoveDir(), nextPosition * 1000f, _currentVelocity, mBaseEntity.GetProperty("Speed"), deltaTime), base.Entity);
		}
	}

	private void UpdateRotation(float deltaTime, out Quaternion nextRotation)
	{
		if (_currentVelocity.x * _currentVelocity.x + _currentVelocity.z * _currentVelocity.z > 0.0001f)
		{
			if (_openLerpRotate)
			{
				Quaternion b = Quaternion.LookRotation(_currentVelocity, Vector3.up);
				nextRotation = Quaternion.Slerp(mBaseEntity.transform.rotation, b, _lerpSpeed * deltaTime);
			}
			else
			{
				nextRotation = Quaternion.LookRotation(_currentVelocity, Vector3.up);
			}
		}
		else
		{
			nextRotation = base.transform.rotation;
		}
	}

	public void UpdateRotation(Vector3 velocity)
	{
		if (velocity.magnitude > 0.01f)
		{
			base.transform.rotation = Quaternion.LookRotation(velocity.normalized, Vector3.up);
		}
	}

	private void FinalizeMove(Vector3 nextPosition)
	{
		nextFrameMoveMin = Utility.Math.Round((nextPosition - base.transform.position).magnitude) > 0.01f;
		_moveComponent.SetPosition(nextPosition, "MoveComponent");
		position = nextPosition;
	}

	private void FinalizeRotate(Quaternion nextRotation)
	{
		_moveComponent.SetRotation(nextRotation, "移动组件 MoveComponent");
	}

	public override void OnPause()
	{
		_currentVelocity = Vector3.zero;
		SetAnimatorParam(isOpenMove: false);
	}

	public bool HaveMoveInput()
	{
		return _currentVelocity != Vector3.zero;
	}

	public void OpenLerpRotate(bool openLerpRotate, float lerpSpeed)
	{
		_openLerpRotate = openLerpRotate;
		_lerpSpeed = lerpSpeed;
	}

	private void SetAnimatorParam(bool isOpenMove)
	{
		if (isOpenMove && _currentVelocity != Vector3.zero)
		{
			if (_lastMoveState != 1)
			{
				_animatorComponent.SetBool(AnimationParameters.Moving, value: true);
				_lastMoveState = 1;
			}
			float property = mBaseEntity.GetProperty("Speed");
			if (property != _lerpMoveSpeed)
			{
				float num = mBaseEntity?.EntityGameSpeed ?? 1f;
				_lerpMoveSpeed = TSUtil.MoveSpeedLerp(_lerpMoveSpeed, property, 0.2f * num);
				_animatorComponent.SetFloat(AnimationParameters.MoveSpeed, _lerpMoveSpeed);
			}
		}
		else
		{
			if (_lastMoveState != 0)
			{
				_animatorComponent.SetBool(AnimationParameters.Moving, value: false);
				_lastMoveState = 0;
			}
			if (_lerpMoveSpeed != 0f)
			{
				float num2 = mBaseEntity?.EntityGameSpeed ?? 1f;
				_lerpMoveSpeed = TSUtil.MoveSpeedLerp(_lerpMoveSpeed, 0f, 0.2f * num2);
				_animatorComponent.SetFloat(AnimationParameters.MoveSpeed, _lerpMoveSpeed);
			}
		}
	}
}
