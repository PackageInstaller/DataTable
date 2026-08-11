using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class ParabolaMoveTrajectoryData : MovementTrajectoryData
{
	private Vector3 startPos;

	private float distanceToTarget;

	private Vector3 _lastTangent;

	private Vector3 _curTangent;

	private Quaternion _quaternionOffset;

	private Vector3 highestPoint;

	private Vector3 _targetPoint;

	private MovementTrajectoryTypeEnum _trajectoryTypeEnum;

	private float _moveTime;

	private Vector3 _curFramePosition;

	private Vector3 _lastFramePosition;

	public float DistanceToTarget => distanceToTarget;

	public override MovementTrajectoryTypeEnum TrajectoryTypeEnum => _trajectoryTypeEnum;

	public override Vector3 TargetPoint => _targetPoint;

	public override float MoveTime => _moveTime;

	public override Vector3 Tangent => _curTangent;

	public override Vector3 LastFramePosition => _lastFramePosition;

	public static ParabolaMoveTrajectoryData Create(Vector3 oriPos, Vector3 dis, Vector3 targetPos, float height, float time)
	{
		ParabolaMoveTrajectoryData parabolaMoveTrajectoryData = ReferencePool.Acquire<ParabolaMoveTrajectoryData>();
		parabolaMoveTrajectoryData._targetPoint = targetPos;
		parabolaMoveTrajectoryData.distanceToTarget = dis.magnitude;
		parabolaMoveTrajectoryData.startPos = oriPos;
		parabolaMoveTrajectoryData.highestPoint = new Vector3((parabolaMoveTrajectoryData.startPos.x + parabolaMoveTrajectoryData.TargetPoint.x) / 2f, Mathf.Max(oriPos.y, parabolaMoveTrajectoryData.TargetPoint.y) + height, (parabolaMoveTrajectoryData.startPos.z + parabolaMoveTrajectoryData.TargetPoint.z) / 2f);
		parabolaMoveTrajectoryData._moveTime = time;
		parabolaMoveTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.Parabola;
		parabolaMoveTrajectoryData._lastFramePosition = oriPos;
		parabolaMoveTrajectoryData._curFramePosition = oriPos;
		parabolaMoveTrajectoryData._lastTangent = parabolaMoveTrajectoryData.CalculateParabolicTangent(0f);
		return parabolaMoveTrajectoryData;
	}

	public override MovementTrajectoryData CopySelf()
	{
		ParabolaMoveTrajectoryData parabolaMoveTrajectoryData = ReferencePool.Acquire<ParabolaMoveTrajectoryData>();
		parabolaMoveTrajectoryData._targetPoint = TargetPoint;
		parabolaMoveTrajectoryData.distanceToTarget = distanceToTarget;
		parabolaMoveTrajectoryData.startPos = startPos;
		parabolaMoveTrajectoryData.highestPoint = highestPoint;
		parabolaMoveTrajectoryData._moveTime = MoveTime;
		parabolaMoveTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.Parabola;
		parabolaMoveTrajectoryData._lastFramePosition = LastFramePosition;
		parabolaMoveTrajectoryData._curFramePosition = _curFramePosition;
		parabolaMoveTrajectoryData._lastTangent = _lastTangent;
		return parabolaMoveTrajectoryData;
	}

	public override Vector3 GetNextPoint(float moveTime)
	{
		_lastFramePosition = _curFramePosition;
		float num = moveTime / _moveTime;
		if (num > 1f)
		{
			num = 1f;
		}
		float num2 = 1f - num;
		float num3 = num * num;
		Vector3 vector = num2 * num2 * startPos;
		vector += 2f * num2 * num * highestPoint;
		vector += num3 * _targetPoint;
		_lastTangent = _curTangent;
		_curTangent = CalculateParabolicTangent(moveTime);
		_curFramePosition = vector;
		return vector;
	}

	public Vector3 CalculateParabolicTangent(float moveTime)
	{
		float num = moveTime / _moveTime;
		if (num > 1f)
		{
			num = 1f;
		}
		float num2 = 1f - num;
		return (2f * num2 * (startPos + highestPoint - startPos) + 2f * num * (_targetPoint - startPos - highestPoint)).normalized;
	}

	public override Quaternion GetNextQuaternion(Quaternion quaternion, float deltaTime)
	{
		return Quaternion.Euler(quaternion.eulerAngles + Quaternion.FromToRotation(_lastTangent, _curTangent).eulerAngles);
	}

	public override void Dispose()
	{
		ReferencePool.Release(this);
	}
}
