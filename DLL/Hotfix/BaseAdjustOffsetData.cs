using Ase;
using Ase.ECS;
using Ase.Paradox;
using GameFramework;
using UnityEngine;

public class BaseAdjustOffsetData : IReference
{
	public CameraKey CameraKey;

	public AdjustCameraState AdjustCameraState;

	public float ShowTimer;

	public bool IsOpenCurveLerp;

	public AnimationCurve AnimationCurve;

	public int Priority;

	public float ExecuteTime;

	public Vector3 StartPosition;

	public Vector3 CmdStartHeroPosotion;

	public int CommandId;

	public Vector3 TargetPosition;

	public Vector3 TargetWorldPosition;

	public Vector3 StartReductionPosition;

	public float ReductionTick;

	public bool IsUpdateTargetPosition;

	public Transform FollowPoint;

	public Vector3 PointOffsetValue;

	public Vector3 StartShowTimePoint;

	public ChangeCameraPriorityType CameraPriorityType;

	public void UpdateTargetPosition()
	{
		if (IsUpdateTargetPosition && !(FollowPoint == null))
		{
			TargetWorldPosition = TSUtil.TransformPoint(FollowPoint.position, FollowPoint.eulerAngles, Vector3.one, PointOffsetValue);
			TargetPosition = TSUtil.TransformPoint(FollowPoint.position, FollowPoint.eulerAngles, Vector3.one, PointOffsetValue) - StartShowTimePoint;
		}
	}

	public float ShowTime(float deltaTime, float lerpTime, Vector3 startPosition, Vector3 targetPosition, out Vector3 progress)
	{
		if (IsOpenCurveLerp)
		{
			return CurveOffsetLerpShowTime(deltaTime, lerpTime, startPosition, targetPosition, out progress);
		}
		return LineAdjustOffsetVector(deltaTime, lerpTime, startPosition, targetPosition, out progress);
	}

	public float LineAdjustOffsetVector(float deltaTime, float lerpTime, Vector3 startPosition, Vector3 targetPosition, out Vector3 progress)
	{
		float num = 0f;
		if (lerpTime == 0f)
		{
			progress = targetPosition;
			num = 1f;
		}
		else
		{
			ExecuteTime += deltaTime;
			num = ExecuteTime / lerpTime;
			if (num <= 1f)
			{
				progress = Vector3.Lerp(startPosition, targetPosition, num);
			}
			else
			{
				progress = targetPosition;
			}
		}
		return num;
	}

	private float CurveOffsetLerpShowTime(float deltaTime, float lerpTime, Vector3 startPosition, Vector3 targetPosition, out Vector3 progress)
	{
		ExecuteTime += deltaTime;
		float num = ExecuteTime / lerpTime;
		if (num <= 1f)
		{
			float num2 = AnimationCurve.Evaluate(num);
			Vector3 normalized = (targetPosition - startPosition).normalized;
			float num3 = Vector3.Distance(targetPosition, startPosition);
			progress = startPosition + num2 * num3 * normalized;
		}
		else
		{
			progress = targetPosition;
		}
		return num;
	}

	public void Clear()
	{
		AnimationCurve = null;
		Priority = 0;
		IsOpenCurveLerp = false;
		ShowTimer = 0f;
		ExecuteTime = 0f;
		CommandId = 0;
		ReductionTick = 0f;
		FollowPoint = null;
		PointOffsetValue = Vector3.zero;
		IsUpdateTargetPosition = false;
		TargetWorldPosition = Vector3.zero;
		StartReductionPosition = Vector3.zero;
		TargetPosition = Vector3.zero;
		StartShowTimePoint = Vector3.zero;
		StartPosition = Vector3.zero;
	}
}
