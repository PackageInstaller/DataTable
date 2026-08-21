using Ase;
using Ase.ECS;
using UnityEngine;

public class EntitySelfDegMoveComponent : BaseComponent
{
	private Vector3 _direct;

	private bool _isUniformSpeedMode;

	private float _lastTime;

	private float _elapsedTime;

	private float _uniformSpeed;

	private float _startSpeed;

	private float _acceleration;

	private bool _isSkillMoveCancel;

	private float _moveTime;

	private float _checkDistance;

	private float _checkRadius;

	private bool _isStopMove = true;

	private bool _isFrozenMovementCommand;

	private bool _frozenState;

	private bool _lockDirect;

	private Vector3 _lastEntityPosition;

	private KinematicMoveComponent _kinematicMoveComponent;

	private Vector2 _stopAngle = new Vector2(-180f, 180f);

	public bool IsStopMove => _isStopMove;

	public void InitData(bool lockDirect, bool isUniformSpeedMode, float moveTime, float distance, float startSpeed, bool isFrozenMovementCommand, bool isSkillMoveCancel, float checkDistance, float checkRadius)
	{
		_lockDirect = lockDirect;
		_isFrozenMovementCommand = isFrozenMovementCommand;
		_startSpeed = startSpeed;
		_isSkillMoveCancel = isSkillMoveCancel;
		_checkDistance = checkDistance;
		_checkRadius = checkRadius;
		_moveTime = moveTime;
		_isUniformSpeedMode = isUniformSpeedMode;
		if (isUniformSpeedMode)
		{
			_uniformSpeed = distance / moveTime;
		}
		else
		{
			_acceleration = 2f * (distance / Mathf.Pow(moveTime, 2f) - startSpeed / moveTime);
		}
		if (lockDirect)
		{
			_direct = (mBaseEntity.transform.rotation * Vector3.forward).normalized;
		}
		_lastTime = 0f;
		_isStopMove = false;
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_kinematicMoveComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
	}

	public override void OnEntityFrozen(bool isFrozen, bool isFrozenLogic = true)
	{
		base.OnEntityFrozen(isFrozen, isFrozenLogic);
		if (isFrozenLogic)
		{
			_frozenState = isFrozen;
		}
	}

	private Vector3 GetCheckDir()
	{
		if (_lastTime != 0f)
		{
			return Vector3.Normalize(base.transform.position - _lastEntityPosition);
		}
		return base.transform.rotation * Vector3.forward;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (_frozenState && _isFrozenMovementCommand)
		{
			if (mBaseEntity.FrozenSpeed == 0f)
			{
				return;
			}
			deltaTime *= mBaseEntity.FrozenSpeed;
		}
		if (_isStopMove)
		{
			return;
		}
		_elapsedTime += deltaTime;
		if (_elapsedTime >= _moveTime)
		{
			StopMove();
		}
		_lastEntityPosition = base.transform.position;
		Vector3 checkDir = GetCheckDir();
		if (_isUniformSpeedMode)
		{
			Vector3 position = mBaseEntity.transform.position + (_lockDirect ? (_direct * (_uniformSpeed * (_elapsedTime - _lastTime))) : ((Quaternion.Euler(mBaseEntity.transform.rotation.eulerAngles) * Vector3.forward).normalized * (_uniformSpeed * (_elapsedTime - _lastTime))));
			_kinematicMoveComponent.SetPosition(position, "EntityMovementAction.isUniformSpeedMode = true");
		}
		else
		{
			Vector3 position2 = mBaseEntity.transform.position + (_lockDirect ? (_direct * (_startSpeed * _elapsedTime + 0.5f * _acceleration * _elapsedTime * _elapsedTime - (_startSpeed * _lastTime + 0.5f * _acceleration * _lastTime * _lastTime))) : ((Quaternion.Euler(mBaseEntity.transform.rotation.eulerAngles) * Vector3.forward).normalized * (_startSpeed * _elapsedTime + 0.5f * _acceleration * _elapsedTime * _elapsedTime - (_startSpeed * _lastTime + 0.5f * _acceleration * _lastTime * _lastTime))));
			_kinematicMoveComponent.SetPosition(position2, "EntityMovementAction = false");
		}
		if (_isSkillMoveCancel && _kinematicMoveComponent != null && _kinematicMoveComponent.CheckMovementCollision(_checkDistance, checkDir, out var raycastHit, _checkRadius))
		{
			Vector3 vector = ((RaycastHit)(ref raycastHit)).transform.position - mBaseEntity.transform.position;
			vector.y = 0f;
			float num = Vector3.SignedAngle(vector, mBaseEntity.transform.rotation * Vector3.forward, Vector3.up);
			if (num > _stopAngle.x && num < _stopAngle.y)
			{
				_kinematicMoveComponent.SetPosition(mBaseEntity.transform.position, "碰撞矫正");
				_kinematicMoveComponent.SetRotation(mBaseEntity.transform.rotation, "碰撞矫正");
				StopMove();
			}
		}
		_lastTime = _elapsedTime;
	}

	private void StopMove()
	{
		_elapsedTime = 0f;
		_isStopMove = true;
		_lastTime = 0f;
	}
}
