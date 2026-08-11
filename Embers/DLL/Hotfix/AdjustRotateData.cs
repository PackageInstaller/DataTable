using Ase.ECS;
using Ase.Paradox;
using GameFramework;
using UnityEngine;

public class AdjustRotateData : IReference
{
	public CameraKey CameraKey;

	public AdjustCameraState AdjustCameraState;

	public float ShowTimer;

	public bool IsOpenCurveLerp;

	public AnimationCurve AnimationCurve;

	public float Priority;

	public float ExecuteTime;

	public Vector3 StartAngle;

	public int CommandId;

	public Vector3 TargetAngle;

	public Vector3 StartReductionAngle;

	public float ReductionTime;

	public ChangeCameraPriorityType CameraPriorityType;

	public bool ShowTime(float deltaTime, Vector3 startAngle, Vector3 endAngle, float time, out Vector3 resultAngle)
	{
		if (IsOpenCurveLerp)
		{
			return CurveRotateLerpShowTime(deltaTime, startAngle, endAngle, time, out resultAngle);
		}
		return AngleLerp(deltaTime, startAngle, endAngle, time, out resultAngle);
	}

	private bool CurveRotateLerpShowTime(float deltaTime, Vector3 startAngle, Vector3 endAngle, float lerpTime, out Vector3 resultAngle)
	{
		ExecuteTime += deltaTime;
		float num = ExecuteTime / lerpTime;
		if (num <= 1f)
		{
			float num2 = AnimationCurve.Evaluate(num);
			Vector3 normalized = (TargetAngle - StartAngle).normalized;
			float num3 = Vector3.Distance(endAngle, startAngle);
			resultAngle = startAngle + num2 * num3 * normalized;
			return false;
		}
		resultAngle = endAngle;
		return true;
	}

	public bool AngleLerp(float deltaTime, Vector3 startAngle, Vector3 endAngle, float time, out Vector3 resultAngle)
	{
		if (time == 0f)
		{
			resultAngle = endAngle;
			return true;
		}
		ExecuteTime += deltaTime;
		float num = ExecuteTime / time;
		if (num <= 1f)
		{
			resultAngle = Vector3.Lerp(startAngle, endAngle, num);
			return false;
		}
		resultAngle = endAngle;
		return true;
	}

	public void Clear()
	{
		AnimationCurve = null;
		Priority = 0f;
		IsOpenCurveLerp = false;
		ShowTimer = 0f;
		ExecuteTime = 0f;
		CommandId = 0;
		ReductionTime = 0f;
	}
}
