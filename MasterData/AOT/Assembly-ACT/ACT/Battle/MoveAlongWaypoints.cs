using System.Collections.Generic;
using ACT.MultiPlayer;
using Bamboo.ECS;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/移动")]
[TaskDescription("沿巡逻点路点顺序移动，到达最后一个点后 Success")]
public class MoveAlongWaypoints : Action
{
	public float arriveThreshold = 0.1f;

	public float waitTime = 0.5f;

	private Entity _entity;

	private CompNav _compNav;

	private CompAI _compAI;

	private int _currentIndex;

	private bool _started;

	private float _realWaitTime;

	private bool _needWait;

	public override void OnStart()
	{
		_entity = Owner.ToEntity();
		_compNav = _entity.GetCompNav();
		_compAI = _entity.GetCompAI();
		_currentIndex = 0;
		_started = false;
		_needWait = false;
		_realWaitTime = waitTime;
		if (_compAI?.patrolPoints != null && _compAI.patrolPoints.Count != 0)
		{
			_started = true;
			_compNav.destination = _compAI.patrolPoints[_currentIndex];
			_compNav.isStopped = false;
		}
	}

	public override void OnEnd()
	{
		if (_entity.IsValid)
		{
			_compNav.isStopped = true;
			StopMove(_entity.GetCompInput());
		}
	}

	public override TaskStatus OnUpdate()
	{
		CompInput compInput = _entity.GetCompInput();
		if (!_started)
		{
			return TaskStatus.Failure;
		}
		if (IsAtLastPoint())
		{
			_compNav.isStopped = true;
			StopMove(compInput);
			return TaskStatus.Success;
		}
		if (_needWait)
		{
			_realWaitTime -= Time.deltaTime;
			if (_realWaitTime > 0f)
			{
				StopMove(compInput);
				return TaskStatus.Running;
			}
			_needWait = false;
		}
		Vector3 physicsPosition = _entity.GetCompTransform().physicsPosition;
		Vector3 destination = _compNav.destination;
		Vector3 dis = destination - physicsPosition;
		if (HasArrived(physicsPosition, destination, dis))
		{
			return AdvanceToNextPoint(compInput);
		}
		if (!TryFaceDestination(dis.x))
		{
			return TaskStatus.Running;
		}
		ApplyMoveInput(compInput, dis);
		return TaskStatus.Running;
	}

	private bool IsAtLastPoint()
	{
		List<Vector3> patrolPoints = _compAI.patrolPoints;
		Vector3 vector = patrolPoints[patrolPoints.Count - 1];
		Vector3 physicsPosition = _entity.GetCompTransform().physicsPosition;
		return HasArrived(physicsPosition, vector, vector - physicsPosition);
	}

	private bool HasArrived(Vector3 current, Vector3 destination, Vector3 dis)
	{
		if (_compNav != null && _compNav.isAir)
		{
			return _compNav.CheckArrived(current, destination);
		}
		return Mathf.Abs(dis.x) < arriveThreshold;
	}

	private bool TryFaceDestination(float deltaX)
	{
		bool flag = deltaX < 0f;
		FaceDir faceDir = ((!flag) ? FaceDir.Right : FaceDir.Left);
		if (_entity.GetFaceDir() == faceDir)
		{
			ClearTurn();
			return true;
		}
		if (_entity.GetConfig().animationSchema == AnimationSchema.LockRotation)
		{
			_entity.SetBool("turn", value: true);
			_entity.SetBool("turn_to_left", flag);
			_entity.SetBool("turn_to_right", !flag);
			return false;
		}
		_entity.SetFaceLeft(flag);
		ClearTurn();
		return true;
	}

	private void ClearTurn()
	{
		_entity.SetBool("turn", value: false);
		_entity.SetBool("turn_to_left", value: false);
		_entity.SetBool("turn_to_right", value: false);
	}

	private void ApplyMoveInput(CompInput compInput, Vector3 dis)
	{
		if (_compNav != null && _compNav.isAir)
		{
			Vector2 dir = new Vector2(dis.x, dis.y);
			if (Mathf.Abs(dir.x) < 0.001f && Mathf.Abs(dir.y) > 0.001f)
			{
				dir.x = (_entity.IsFaceLeft() ? (-0.01f) : 0.01f);
			}
			compInput.dir = dir;
		}
		else
		{
			compInput.inputDir = ((dis.x < 0f) ? EInputDir.Left : EInputDir.Right);
		}
		_entity.SetBool("Move", value: true);
		_entity.SetBool("FlyMove", value: true);
	}

	private void StopMove(CompInput compInput)
	{
		if (compInput != null)
		{
			compInput.inputDir = EInputDir.None;
		}
		_entity.SetBool("Move", value: false);
		_entity.SetBool("FlyMove", value: false);
	}

	private TaskStatus AdvanceToNextPoint(CompInput compInput)
	{
		StopMove(compInput);
		if (_currentIndex >= _compAI.patrolPoints.Count - 1)
		{
			_compNav.isStopped = true;
			return TaskStatus.Success;
		}
		_currentIndex++;
		_compNav.destination = _compAI.patrolPoints[_currentIndex];
		_compNav.isStopped = false;
		_realWaitTime = waitTime;
		_needWait = true;
		if (_realWaitTime <= 0f)
		{
			ApplyMoveInput(compInput, _compNav.destination - _entity.GetCompTransform().physicsPosition);
		}
		return TaskStatus.Running;
	}
}
