using UnityEngine;

namespace Ase.ECS;

public class NormalMoveComponent : BaseComponent
{
	private Vector3 _dir;

	private bool _isMoveStop;

	private float _moveSpeed;

	private float _moveTime;

	private bool _isFrozenMovementCommand;

	private bool _frozenState;

	private KinematicMoveComponent _kinematicMoveComponent;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_kinematicMoveComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
	}

	public override void OnDispose()
	{
		_kinematicMoveComponent = null;
		base.OnDispose();
	}

	public override void OnEntityFrozen(bool isFrozen, bool isFrozenLogic = true)
	{
		base.OnEntityFrozen(isFrozen, isFrozenLogic);
		if (isFrozenLogic)
		{
			_frozenState = isFrozen;
		}
	}

	public void SetMoveParam(float moveTime, float moveDistance, float deg, bool isFrozenMovementCommand)
	{
		if (moveTime == 0f)
		{
			Vector3 position = TSUtil.MoveForward2D(mBaseEntity.transform.position, deg, moveDistance);
			_kinematicMoveComponent.SetPosition(position, "NormalMoveComponent.瞬移");
			return;
		}
		_moveTime = moveTime;
		_moveSpeed = moveDistance / _moveTime;
		_dir = TSUtil.MoveForward2D(mBaseEntity.transform.position, deg, moveDistance) - mBaseEntity.transform.position;
		_dir.Normalize();
		_isMoveStop = false;
		_isFrozenMovementCommand = isFrozenMovementCommand;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (_frozenState && _isFrozenMovementCommand)
		{
			if (mBaseEntity.FrozenSpeed == 0f)
			{
				_kinematicMoveComponent.ImmediatelyMove(base.transform.position);
				return;
			}
			deltaTime *= mBaseEntity.FrozenSpeed;
		}
		if (!_isMoveStop)
		{
			_moveTime = Mathf.Clamp(_moveTime - deltaTime, 0f, _moveTime);
			if (_moveTime <= 0f)
			{
				_isMoveStop = true;
				return;
			}
			Vector3 position = _dir * _moveSpeed * deltaTime + mBaseEntity.transform.position;
			_kinematicMoveComponent.SetPosition(position, "NormalMoveComponent.插值");
		}
	}
}
