using Ase;
using Ase.ECS;
using UnityEngine;

public class EntityFixedAngelMoveComponent : BaseComponent
{
	private Vector3 _direct;

	private bool _isUniformSpeedMode;

	private float _lastTime;

	private float _elapsedTime;

	private float _uniformSpeed;

	private float _startSpeed;

	private float _acceleration;

	private float _moveTime;

	private bool _isStopMove = true;

	private bool _isFrozenMovementCommand;

	private bool _frozenState;

	public bool IsStopMove => _isStopMove;

	public void InitData(float moveDir, bool isUniformSpeedMode, float moveTime, float distance, float startSpeed, bool isFrozenMovementCommand)
	{
		_isUniformSpeedMode = isUniformSpeedMode;
		_moveTime = moveTime;
		_startSpeed = startSpeed;
		if (_isUniformSpeedMode)
		{
			_uniformSpeed = distance / moveTime;
		}
		else
		{
			_acceleration = 2f * (distance / Mathf.Pow(moveTime, 2f) - startSpeed / moveTime);
		}
		_direct = (Quaternion.Euler(new Vector3(0f, moveDir, 0f)) * Vector3.forward).normalized;
		_lastTime = 0f;
		_isStopMove = false;
		_isFrozenMovementCommand = isFrozenMovementCommand;
	}

	public override void OnEntityFrozen(bool isFrozen, bool isFrozenLogic = true)
	{
		base.OnEntityFrozen(isFrozen, isFrozenLogic);
		if (isFrozenLogic)
		{
			_frozenState = isFrozen;
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (_frozenState && _isFrozenMovementCommand)
		{
			if (mBaseEntity.FrozenSpeed == 0f)
			{
				return;
			}
			deltaTime *= mBaseEntity.FrozenSpeed;
		}
		if (!_isStopMove)
		{
			_elapsedTime += deltaTime;
			if (_elapsedTime >= _moveTime)
			{
				StopMove();
			}
			if (_isUniformSpeedMode)
			{
				Vector3 position = mBaseEntity.transform.position + _direct * (_uniformSpeed * deltaTime);
				mBaseEntity.GetComponent<KinematicMoveComponent>().SetPosition(position, "EntityMovementAction.isUniformSpeedMode = true");
			}
			else
			{
				Vector3 position2 = mBaseEntity.transform.position + _direct * (_startSpeed * _elapsedTime + 0.5f * _acceleration * _elapsedTime * _elapsedTime - (_startSpeed * _lastTime + 0.5f * _acceleration * _lastTime * _lastTime));
				mBaseEntity.GetComponent<KinematicMoveComponent>().SetPosition(position2, "EntityMovementAction = false");
			}
			_lastTime = _elapsedTime;
		}
	}

	private void StopMove()
	{
		_elapsedTime = 0f;
		_isStopMove = true;
		_lastTime = 0f;
	}
}
