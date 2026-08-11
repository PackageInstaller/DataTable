using System;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class LinearMoveTrajectoryData : MovementTrajectoryData
{
	protected Vector3 _moveDirect;

	protected float _velocity;

	protected Vector3 _initialVelocity;

	protected Vector3 _acceleration;

	protected bool isAccelerate;

	protected float _accelerateTime;

	protected Vector3 _startPos;

	protected Vector3 _endAccelerateVel;

	protected Vector3 _curVel;

	protected Vector3 _targetPoint;

	protected float _moveTime;

	protected float oriVel;

	protected float oriAcc;

	protected float curVel;

	protected MovementTrajectoryTypeEnum _trajectoryTypeEnum;

	protected Vector3 _lastFramePosition;

	public override MovementTrajectoryTypeEnum TrajectoryTypeEnum => _trajectoryTypeEnum;

	public override Vector3 TargetPoint => _targetPoint;

	public override float MoveTime => _moveTime;

	public override Vector3 Tangent => _curVel.normalized;

	public override Vector3 LastFramePosition => _lastFramePosition;

	public static LinearMoveTrajectoryData Create(Vector3 offsetPoint, float time, Vector3 startPos, Quaternion startQuaternion)
	{
		LinearMoveTrajectoryData linearMoveTrajectoryData = ReferencePool.Acquire<LinearMoveTrajectoryData>();
		linearMoveTrajectoryData._moveDirect = startQuaternion * offsetPoint.normalized;
		linearMoveTrajectoryData._moveTime = time;
		linearMoveTrajectoryData._velocity = offsetPoint.magnitude / linearMoveTrajectoryData._moveTime;
		linearMoveTrajectoryData._targetPoint = startPos + startQuaternion * offsetPoint;
		linearMoveTrajectoryData.isAccelerate = false;
		linearMoveTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.LinearMoveToPoint;
		linearMoveTrajectoryData._lastFramePosition = startPos;
		return linearMoveTrajectoryData;
	}

	public static LinearMoveTrajectoryData Create(Vector3 offsetDir, float velocity, float time, Vector3 startPos, Quaternion startQuaternion)
	{
		LinearMoveTrajectoryData linearMoveTrajectoryData = ReferencePool.Acquire<LinearMoveTrajectoryData>();
		linearMoveTrajectoryData._moveDirect = startQuaternion * offsetDir.normalized;
		linearMoveTrajectoryData._velocity = velocity;
		linearMoveTrajectoryData._moveTime = time;
		linearMoveTrajectoryData._targetPoint = startPos + linearMoveTrajectoryData._velocity * time * linearMoveTrajectoryData._moveDirect;
		linearMoveTrajectoryData.isAccelerate = false;
		linearMoveTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.LinearMoveByDirect;
		linearMoveTrajectoryData._lastFramePosition = startPos;
		return linearMoveTrajectoryData;
	}

	public static LinearMoveTrajectoryData Create(Vector3 startPos, Quaternion rotation, float oriVel, float oriAcc, float accelerateTime, float time)
	{
		LinearMoveTrajectoryData linearMoveTrajectoryData = ReferencePool.Acquire<LinearMoveTrajectoryData>();
		linearMoveTrajectoryData.oriVel = ((oriVel <= 0f) ? 0f : oriVel);
		linearMoveTrajectoryData.oriAcc = oriAcc;
		linearMoveTrajectoryData._initialVelocity = rotation * new Vector3(0f, 0f, linearMoveTrajectoryData.oriVel);
		linearMoveTrajectoryData._acceleration = rotation * new Vector3(0f, 0f, linearMoveTrajectoryData.oriAcc);
		linearMoveTrajectoryData._accelerateTime = accelerateTime;
		linearMoveTrajectoryData._moveTime = time;
		linearMoveTrajectoryData._startPos = startPos;
		linearMoveTrajectoryData._targetPoint = linearMoveTrajectoryData._startPos + linearMoveTrajectoryData._initialVelocity * linearMoveTrajectoryData._moveTime + 0.5f * linearMoveTrajectoryData._moveTime * linearMoveTrajectoryData._moveTime * linearMoveTrajectoryData._acceleration;
		linearMoveTrajectoryData._curVel = linearMoveTrajectoryData._initialVelocity;
		linearMoveTrajectoryData.isAccelerate = true;
		linearMoveTrajectoryData.curVel = oriVel;
		linearMoveTrajectoryData._endAccelerateVel = ((oriVel + oriAcc * accelerateTime <= 0f) ? Vector3.zero : (rotation * new Vector3(0f, 0f, oriVel + oriAcc * accelerateTime)));
		linearMoveTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.LinearMove;
		linearMoveTrajectoryData._lastFramePosition = startPos;
		return linearMoveTrajectoryData;
	}

	public static LinearMoveTrajectoryData Create(LinearMoveTrajectoryData oriMoveTrajectoryData)
	{
		LinearMoveTrajectoryData linearMoveTrajectoryData = ReferencePool.Acquire<LinearMoveTrajectoryData>();
		linearMoveTrajectoryData._acceleration = oriMoveTrajectoryData._acceleration;
		linearMoveTrajectoryData._velocity = oriMoveTrajectoryData._velocity;
		linearMoveTrajectoryData._accelerateTime = oriMoveTrajectoryData._accelerateTime;
		linearMoveTrajectoryData._curVel = oriMoveTrajectoryData._curVel;
		linearMoveTrajectoryData._initialVelocity = oriMoveTrajectoryData._initialVelocity;
		linearMoveTrajectoryData._moveDirect = oriMoveTrajectoryData._moveDirect;
		linearMoveTrajectoryData._startPos = oriMoveTrajectoryData._startPos;
		linearMoveTrajectoryData._targetPoint = oriMoveTrajectoryData._targetPoint;
		linearMoveTrajectoryData.isAccelerate = oriMoveTrajectoryData.isAccelerate;
		linearMoveTrajectoryData._endAccelerateVel = oriMoveTrajectoryData._endAccelerateVel;
		linearMoveTrajectoryData._moveTime = oriMoveTrajectoryData._moveTime;
		linearMoveTrajectoryData._trajectoryTypeEnum = oriMoveTrajectoryData.TrajectoryTypeEnum;
		linearMoveTrajectoryData._lastFramePosition = oriMoveTrajectoryData._lastFramePosition;
		return linearMoveTrajectoryData;
	}

	public override MovementTrajectoryData CopySelf()
	{
		LinearMoveTrajectoryData linearMoveTrajectoryData = ReferencePool.Acquire<LinearMoveTrajectoryData>();
		linearMoveTrajectoryData._acceleration = _acceleration;
		linearMoveTrajectoryData._velocity = _velocity;
		linearMoveTrajectoryData._accelerateTime = _accelerateTime;
		linearMoveTrajectoryData._curVel = _curVel;
		linearMoveTrajectoryData._initialVelocity = _initialVelocity;
		linearMoveTrajectoryData._moveDirect = _moveDirect;
		linearMoveTrajectoryData._startPos = _startPos;
		linearMoveTrajectoryData._targetPoint = _targetPoint;
		linearMoveTrajectoryData.isAccelerate = isAccelerate;
		linearMoveTrajectoryData._endAccelerateVel = _endAccelerateVel;
		linearMoveTrajectoryData._moveTime = _moveTime;
		linearMoveTrajectoryData._trajectoryTypeEnum = TrajectoryTypeEnum;
		linearMoveTrajectoryData._lastFramePosition = _lastFramePosition;
		return linearMoveTrajectoryData;
	}

	public void OverrideCurVel(float velocity, float angle, bool isAbsolutely, float timer, Vector3 curPos)
	{
		if (!(timer > _moveTime))
		{
			velocity = ((velocity <= 0f) ? 0f : velocity);
			curVel = velocity;
			Vector3 vector = new Vector3(velocity * Mathf.Sin(angle * (MathF.PI / 180f)), 0f, velocity * Mathf.Cos(angle * (MathF.PI / 180f)));
			_acceleration = new Vector3(oriAcc * Mathf.Sin(angle * (MathF.PI / 180f)), 0f, oriAcc * Mathf.Cos(angle * (MathF.PI / 180f)));
			if (!isAbsolutely)
			{
				Vector3 eulerAngles = Quaternion.LookRotation(_curVel).eulerAngles;
				eulerAngles.y += angle;
				vector = Quaternion.Euler(eulerAngles) * new Vector3(0f, 0f, velocity);
				_acceleration = Quaternion.Euler(eulerAngles) * new Vector3(0f, 0f, oriAcc);
			}
			_endAccelerateVel = vector;
			Vector3 vector2 = (_moveTime - timer) * _endAccelerateVel;
			if (timer < _accelerateTime)
			{
				_endAccelerateVel = ((curVel + oriAcc * (_accelerateTime - timer) <= 0f) ? Vector3.zero : (vector + (_accelerateTime - timer) * _acceleration));
				vector2 = curPos + _endAccelerateVel * (_moveTime - timer) + 0.5f * (_moveTime - timer) * (_moveTime - timer) * _acceleration;
			}
			_targetPoint = curPos + vector2;
			_curVel = vector;
		}
	}

	public Vector3 GetLinearMovePoint(Vector3 lastPos, float deltaTime)
	{
		return lastPos + _velocity * deltaTime * _moveDirect;
	}

	public Vector3 GetAccelerateMovePoint(Vector3 lastPos, float deltaTime)
	{
		if (oriAcc < 0f)
		{
			if (curVel + oriAcc * deltaTime <= _endAccelerateVel.z)
			{
				curVel = _endAccelerateVel.z;
				_curVel = _endAccelerateVel;
			}
			else
			{
				curVel += oriAcc * deltaTime;
				_curVel += _acceleration * deltaTime;
			}
		}
		else
		{
			curVel += oriAcc * deltaTime;
			_curVel = Vector3.ClampMagnitude(_curVel + _acceleration * deltaTime, _endAccelerateVel.magnitude);
		}
		_lastFramePosition = lastPos;
		lastPos += _curVel * deltaTime + deltaTime * deltaTime * 0.5f * _acceleration;
		return lastPos;
	}

	public override Vector3 GetNextPoint(Vector3 lastPos, float deltaTime)
	{
		if (isAccelerate)
		{
			return GetAccelerateMovePoint(lastPos, deltaTime);
		}
		_lastFramePosition = lastPos;
		return lastPos + _velocity * deltaTime * _moveDirect;
	}

	public override void Dispose()
	{
		ReferencePool.Release(this);
	}
}
