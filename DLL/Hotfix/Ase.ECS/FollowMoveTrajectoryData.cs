using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class FollowMoveTrajectoryData : MovementTrajectoryData
{
	private bool _isFollowMove;

	private bool _isFollowRotate;

	private Vector3 _oriPos;

	private float _speed;

	private float _radius;

	private bool _isClockwise;

	private float _angle;

	private float _angularSpeed;

	private float _lerpSpeed;

	private BaseEntity _followEntity;

	private Vector3 _followPoint;

	private Vector3 _followLocalOffset;

	private Vector3 _followWorldOffset;

	private Quaternion _quaternionOffset;

	private Quaternion _oriQuaternionOffset;

	private float _radiusAc;

	private float _endRadius;

	private float _speedAc;

	private float _endSpeed;

	private Vector3 _targetPoint;

	private float _moveTime;

	private Vector3 _tangent;

	private MovementTrajectoryTypeEnum _trajectoryTypeEnum;

	private Vector3 _lastFramePosition;

	public override MovementTrajectoryTypeEnum TrajectoryTypeEnum => _trajectoryTypeEnum;

	public override Vector3 TargetPoint => _targetPoint;

	public override float MoveTime => _moveTime;

	public override Vector3 LastFramePosition => _lastFramePosition;

	public override Vector3 Tangent => _tangent;

	public static FollowMoveTrajectoryData Create(Vector3 moveOffset, Vector3 yEulerOffset, float moveTime, BaseEntity targetEntity)
	{
		FollowMoveTrajectoryData followMoveTrajectoryData = ReferencePool.Acquire<FollowMoveTrajectoryData>();
		followMoveTrajectoryData._isFollowMove = true;
		followMoveTrajectoryData._isFollowRotate = false;
		followMoveTrajectoryData._followLocalOffset = moveOffset;
		followMoveTrajectoryData._oriQuaternionOffset = Quaternion.Euler(yEulerOffset);
		followMoveTrajectoryData._moveTime = moveTime;
		followMoveTrajectoryData._followEntity = targetEntity;
		followMoveTrajectoryData._oriPos = followMoveTrajectoryData._followEntity.transform.position + TSUtil.TransformPoint(Vector3.zero, followMoveTrajectoryData._followEntity.transform.eulerAngles, followMoveTrajectoryData._followEntity.transform.localScale, followMoveTrajectoryData._followLocalOffset);
		followMoveTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.FollowMove;
		followMoveTrajectoryData._lastFramePosition = followMoveTrajectoryData._oriPos;
		followMoveTrajectoryData._lerpSpeed = 1f;
		return followMoveTrajectoryData;
	}

	public static FollowMoveTrajectoryData Create(Vector3 oriPos, float speed, float radius, Vector3 relativeStartPosition, bool isClockwise, float moveTime, Vector3 followPoint = default(Vector3), BaseEntity targetEntity = null, float radiusAcTime = 0f, float endRadius = 0f, float speedAcTime = 0f, float endSpeed = 0f)
	{
		FollowMoveTrajectoryData followMoveTrajectoryData = ReferencePool.Acquire<FollowMoveTrajectoryData>();
		followMoveTrajectoryData._isFollowMove = false;
		followMoveTrajectoryData._isFollowRotate = true;
		followMoveTrajectoryData._oriPos = oriPos;
		followMoveTrajectoryData._speed = speed;
		followMoveTrajectoryData._lerpSpeed = 1f;
		followMoveTrajectoryData._radius = radius;
		followMoveTrajectoryData._isClockwise = isClockwise;
		followMoveTrajectoryData._followPoint = followPoint;
		followMoveTrajectoryData._followEntity = targetEntity;
		followMoveTrajectoryData._angle = Mathf.Atan2(relativeStartPosition.z, relativeStartPosition.x);
		followMoveTrajectoryData._angularSpeed = followMoveTrajectoryData._speed / radius;
		followMoveTrajectoryData._moveTime = moveTime;
		followMoveTrajectoryData._endRadius = ((radiusAcTime <= 0f) ? followMoveTrajectoryData._radius : endRadius);
		followMoveTrajectoryData._radiusAc = ((radiusAcTime <= 0f) ? 0f : ((endRadius - followMoveTrajectoryData._radius) / radiusAcTime));
		followMoveTrajectoryData._endSpeed = ((speedAcTime <= 0f) ? followMoveTrajectoryData._speed : endSpeed);
		followMoveTrajectoryData._speedAc = ((speedAcTime <= 0f) ? 0f : ((endSpeed - followMoveTrajectoryData._speed) / speedAcTime));
		followMoveTrajectoryData._trajectoryTypeEnum = ((targetEntity == null) ? MovementTrajectoryTypeEnum.RotateAround : MovementTrajectoryTypeEnum.FollowAndRotateAround);
		followMoveTrajectoryData._lastFramePosition = followMoveTrajectoryData._oriPos;
		followMoveTrajectoryData._lerpSpeed = 1f;
		return followMoveTrajectoryData;
	}

	public static FollowMoveTrajectoryData Create(FollowMoveTrajectoryData oriMoveTrajectoryData)
	{
		FollowMoveTrajectoryData followMoveTrajectoryData = ReferencePool.Acquire<FollowMoveTrajectoryData>();
		followMoveTrajectoryData._isFollowMove = oriMoveTrajectoryData._isFollowMove;
		followMoveTrajectoryData._followLocalOffset = oriMoveTrajectoryData._followLocalOffset;
		followMoveTrajectoryData._isFollowRotate = oriMoveTrajectoryData._isFollowRotate;
		followMoveTrajectoryData._oriPos = oriMoveTrajectoryData._oriPos;
		followMoveTrajectoryData._speed = oriMoveTrajectoryData._speed;
		followMoveTrajectoryData._lerpSpeed = oriMoveTrajectoryData._lerpSpeed;
		followMoveTrajectoryData._radius = oriMoveTrajectoryData._radius;
		followMoveTrajectoryData._isClockwise = oriMoveTrajectoryData._isClockwise;
		followMoveTrajectoryData._angle = oriMoveTrajectoryData._angle;
		followMoveTrajectoryData._angularSpeed = oriMoveTrajectoryData._angularSpeed;
		followMoveTrajectoryData._followEntity = oriMoveTrajectoryData._followEntity;
		followMoveTrajectoryData._followPoint = oriMoveTrajectoryData._followPoint;
		followMoveTrajectoryData._followWorldOffset = oriMoveTrajectoryData._followWorldOffset;
		followMoveTrajectoryData._followLocalOffset = oriMoveTrajectoryData._followLocalOffset;
		followMoveTrajectoryData._quaternionOffset = oriMoveTrajectoryData._quaternionOffset;
		followMoveTrajectoryData._oriQuaternionOffset = oriMoveTrajectoryData._oriQuaternionOffset;
		followMoveTrajectoryData._radiusAc = oriMoveTrajectoryData._radiusAc;
		followMoveTrajectoryData._endRadius = oriMoveTrajectoryData._endRadius;
		followMoveTrajectoryData._speedAc = oriMoveTrajectoryData._speedAc;
		followMoveTrajectoryData._endSpeed = oriMoveTrajectoryData._endSpeed;
		followMoveTrajectoryData._targetPoint = oriMoveTrajectoryData.TargetPoint;
		followMoveTrajectoryData._moveTime = oriMoveTrajectoryData._moveTime;
		followMoveTrajectoryData._tangent = oriMoveTrajectoryData._tangent;
		followMoveTrajectoryData._trajectoryTypeEnum = oriMoveTrajectoryData.TrajectoryTypeEnum;
		followMoveTrajectoryData._lastFramePosition = oriMoveTrajectoryData._lastFramePosition;
		followMoveTrajectoryData._lerpSpeed = oriMoveTrajectoryData._lerpSpeed;
		return followMoveTrajectoryData;
	}

	public override MovementTrajectoryData CopySelf()
	{
		FollowMoveTrajectoryData followMoveTrajectoryData = ReferencePool.Acquire<FollowMoveTrajectoryData>();
		followMoveTrajectoryData._isFollowMove = _isFollowMove;
		followMoveTrajectoryData._followLocalOffset = _followLocalOffset;
		followMoveTrajectoryData._isFollowRotate = _isFollowRotate;
		followMoveTrajectoryData._oriPos = _oriPos;
		followMoveTrajectoryData._speed = _speed;
		followMoveTrajectoryData._lerpSpeed = _lerpSpeed;
		followMoveTrajectoryData._radius = _radius;
		followMoveTrajectoryData._isClockwise = _isClockwise;
		followMoveTrajectoryData._angle = _angle;
		followMoveTrajectoryData._angularSpeed = _angularSpeed;
		followMoveTrajectoryData._followEntity = _followEntity;
		followMoveTrajectoryData._followPoint = _followPoint;
		followMoveTrajectoryData._followWorldOffset = _followWorldOffset;
		followMoveTrajectoryData._followLocalOffset = _followLocalOffset;
		followMoveTrajectoryData._quaternionOffset = _quaternionOffset;
		followMoveTrajectoryData._oriQuaternionOffset = _oriQuaternionOffset;
		followMoveTrajectoryData._radiusAc = _radiusAc;
		followMoveTrajectoryData._endRadius = _endRadius;
		followMoveTrajectoryData._speedAc = _speedAc;
		followMoveTrajectoryData._endSpeed = _endSpeed;
		followMoveTrajectoryData._targetPoint = TargetPoint;
		followMoveTrajectoryData._moveTime = _moveTime;
		followMoveTrajectoryData._tangent = _tangent;
		followMoveTrajectoryData._trajectoryTypeEnum = TrajectoryTypeEnum;
		followMoveTrajectoryData._lastFramePosition = _lastFramePosition;
		return followMoveTrajectoryData;
	}

	public void OverrideAcAndTime(float radiusAcTime = 0f, float endRadius = 0f, float speedAcTime = 0f, float endSpeed = 0f)
	{
		_endRadius = endRadius;
		_radiusAc = ((radiusAcTime <= 0f) ? 0f : ((endRadius - _radius) / radiusAcTime));
		_radius = ((radiusAcTime <= 0f) ? _endRadius : _radius);
		_endSpeed = endSpeed;
		_speedAc = ((speedAcTime <= 0f) ? 0f : ((endSpeed - _speed) / speedAcTime));
		_speed = ((speedAcTime <= 0f) ? endSpeed : _speed);
	}

	public void OverrideLerpSpeed(float lerpSpeed)
	{
		_lerpSpeed = lerpSpeed;
	}

	public void OverrideClockwise(bool isClockwise)
	{
		_isClockwise = isClockwise;
	}

	public void OverrideTargetPoint(BaseEntity target, Vector3 worldPoint, Vector3 worldOffset, Vector3 localOffset)
	{
		if (target == null)
		{
			_trajectoryTypeEnum = MovementTrajectoryTypeEnum.RotateAround;
			_followPoint = worldPoint;
			_followEntity = null;
		}
		else
		{
			_trajectoryTypeEnum = MovementTrajectoryTypeEnum.FollowAndRotateAround;
			_followEntity = target;
			_followWorldOffset = worldOffset;
			_followLocalOffset = localOffset;
		}
	}

	private Vector3 GetFollowRotatePointOffset(float deltaTime)
	{
		_speed = GetVal(_speed, _speedAc, deltaTime, _endSpeed);
		_radius = GetVal(_radius, _radiusAc, deltaTime, _endRadius);
		_angularSpeed = _speed / _radius;
		_angle += (float)((!_isClockwise) ? 1 : (-1)) * _angularSpeed * deltaTime;
		_quaternionOffset = Quaternion.Euler(0f, (float)(_isClockwise ? 1 : (-1)) * _angularSpeed * deltaTime, 0f);
		return new Vector3(_radius * Mathf.Cos(_angle), 0f, _radius * Mathf.Sin(_angle));
	}

	private float GetVal(float curVel, float acc, float deltaTime, float finalVel)
	{
		if (acc < 0f && (curVel <= finalVel || curVel + acc * deltaTime <= finalVel))
		{
			return finalVel;
		}
		if (acc > 0f && (curVel >= finalVel || curVel + acc * deltaTime >= finalVel))
		{
			return finalVel;
		}
		return curVel + acc * deltaTime;
	}

	public override Vector3 GetNextPoint(float deltaTime)
	{
		Vector3 vector;
		if (_isFollowMove)
		{
			if (_followEntity == null)
			{
				return _targetPoint;
			}
			_targetPoint = _followEntity.transform.position + TSUtil.TransformPoint(Vector3.zero, _followEntity.transform.eulerAngles, _followEntity.transform.localScale, _followLocalOffset);
			_targetPoint += _followWorldOffset;
			_tangent = _followEntity.transform.eulerAngles;
			vector = Vector3.Slerp(_lastFramePosition, _targetPoint, _lerpSpeed);
		}
		else if (_isFollowRotate)
		{
			if (_followEntity == null)
			{
				_targetPoint = _followPoint + GetFollowRotatePointOffset(deltaTime);
				_targetPoint += _followWorldOffset;
				_tangent = ((!_isClockwise) ? 1 : (-1)) * Vector3.Cross(_targetPoint, Vector3.up).normalized;
				return _targetPoint;
			}
			_targetPoint = _followEntity.transform.position + GetFollowRotatePointOffset(deltaTime);
			_targetPoint += TSUtil.TransformPoint(Vector3.zero, _followEntity.transform.eulerAngles, _followEntity.transform.localScale, _followLocalOffset);
			_targetPoint += _followWorldOffset;
			_followPoint = _followEntity.transform.position;
			_tangent = ((!_isClockwise) ? 1 : (-1)) * Vector3.Cross(_targetPoint, Vector3.up).normalized;
			vector = Vector3.Slerp(_lastFramePosition, _targetPoint, _lerpSpeed);
		}
		vector = Vector3.Slerp(_lastFramePosition, _targetPoint, _lerpSpeed);
		if (_lerpSpeed < 1f)
		{
			_lerpSpeed += 0.01f;
		}
		_lastFramePosition = vector;
		return vector;
	}

	public override Quaternion GetNextQuaternion(Quaternion quaternion, float deltaTime)
	{
		if (_isFollowMove)
		{
			return _followEntity.transform.rotation * _oriQuaternionOffset;
		}
		return quaternion * _quaternionOffset;
	}

	public override void Dispose()
	{
		ReferencePool.Release(this);
	}

	public override void Clear()
	{
		base.Clear();
		_followEntity = null;
	}
}
