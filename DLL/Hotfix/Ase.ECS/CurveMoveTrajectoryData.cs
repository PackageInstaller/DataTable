using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class CurveMoveTrajectoryData : MovementTrajectoryData
{
	private AnimationCurveData _curveDataX;

	private AnimationCurveData _curveDataY;

	private AnimationCurveData _curveDataZ;

	private AnimationCurveRotateDataBase _curveRotateData;

	private MovementTrajectoryTypeEnum _trajectoryTypeEnum;

	private Vector3 _oriPos;

	private Vector3 _targetPoint;

	private float _moveTime;

	private Vector3 _tangent;

	private Quaternion _quaternion;

	private bool _isFollowParent;

	private BaseEntity _ownerEntity;

	private Vector3 _lastFramePosition;

	public override MovementTrajectoryTypeEnum TrajectoryTypeEnum => _trajectoryTypeEnum;

	public override Vector3 TargetPoint => _targetPoint;

	public override float MoveTime => _moveTime;

	public override Vector3 Tangent => _tangent;

	public override Vector3 LastFramePosition => _lastFramePosition;

	public static CurveMoveTrajectoryData Create(AnimationCurveData curveX, AnimationCurveData curveY, AnimationCurveData curveZ, Vector3 oriPos, Quaternion quaternion, bool isFollowParent, BaseEntity ownerEntity)
	{
		CurveMoveTrajectoryData curveMoveTrajectoryData = ReferencePool.Acquire<CurveMoveTrajectoryData>();
		curveMoveTrajectoryData._curveDataX = curveX;
		curveMoveTrajectoryData._curveDataY = curveY;
		curveMoveTrajectoryData._curveDataZ = curveZ;
		curveMoveTrajectoryData._moveTime = Mathf.Max(Mathf.Max(curveX.MoveTime, curveY.MoveTime), curveZ.MoveTime);
		curveMoveTrajectoryData._quaternion = quaternion;
		curveMoveTrajectoryData._oriPos = oriPos;
		curveMoveTrajectoryData._targetPoint = oriPos;
		curveMoveTrajectoryData._lastFramePosition = oriPos;
		curveMoveTrajectoryData._isFollowParent = isFollowParent;
		curveMoveTrajectoryData._ownerEntity = ownerEntity;
		curveMoveTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.Curve;
		return curveMoveTrajectoryData;
	}

	public override MovementTrajectoryData CopySelf()
	{
		CurveMoveTrajectoryData curveMoveTrajectoryData = ReferencePool.Acquire<CurveMoveTrajectoryData>();
		curveMoveTrajectoryData._curveDataX = _curveDataX.CopySelf();
		curveMoveTrajectoryData._curveDataY = _curveDataY.CopySelf();
		curveMoveTrajectoryData._curveDataZ = _curveDataZ.CopySelf();
		curveMoveTrajectoryData._moveTime = _moveTime;
		curveMoveTrajectoryData._quaternion = _quaternion;
		curveMoveTrajectoryData._oriPos = _oriPos;
		curveMoveTrajectoryData._targetPoint = _targetPoint;
		curveMoveTrajectoryData._lastFramePosition = LastFramePosition;
		curveMoveTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.Curve;
		curveMoveTrajectoryData._isFollowParent = _isFollowParent;
		curveMoveTrajectoryData._ownerEntity = _ownerEntity;
		curveMoveTrajectoryData._curveRotateData = _curveRotateData;
		return curveMoveTrajectoryData;
	}

	public virtual void OverrideCureveRotate(AnimationCurveRotateDataBase curveRotate)
	{
		_curveRotateData = curveRotate;
	}

	public override Vector3 GetNextPoint(float deltaTime)
	{
		_lastFramePosition = _targetPoint;
		Vector3 vector = new Vector3(_curveDataX.GetOffset(deltaTime), _curveDataY.GetOffset(deltaTime), _curveDataZ.GetOffset(deltaTime));
		Vector3 vector2 = ((!_isFollowParent) ? _oriPos : (_ownerEntity?.transform.position ?? _oriPos));
		_targetPoint = vector2 + _quaternion * vector;
		_tangent = (_targetPoint - _lastFramePosition).normalized;
		return _targetPoint;
	}

	public override Quaternion GetNextQuaternion(Quaternion quaternion, float deltaTime)
	{
		if (_curveRotateData == null)
		{
			return quaternion;
		}
		return _curveRotateData.GetQuaternionOffset(deltaTime);
	}

	public override void Dispose()
	{
		ReferencePool.Release(this);
	}

	public override void Clear()
	{
		ReferencePool.Release(_curveDataX);
		ReferencePool.Release(_curveDataY);
		ReferencePool.Release(_curveDataZ);
		_ownerEntity = null;
	}
}
