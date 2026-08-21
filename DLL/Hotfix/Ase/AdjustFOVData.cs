using Ase.ECS;
using Ase.Paradox;
using GameFramework;
using UnityEngine;

namespace Ase;

public class AdjustFOVData : IReference
{
	public CameraKey CameraKey;

	public AdjustCameraState AdjustCameraState;

	public float ShowTimer;

	public bool IsOpenCurveLerp;

	public AnimationCurve AnimationCurve;

	public float ExecuteTime;

	public int CommandId;

	public int Priority;

	public float StartFov;

	public float TargetFov;

	public float ReductionTime;

	public ChangeCameraPriorityType CameraPriorityType;

	public float StartReductionFov;

	public float EndReductionFov;

	public void ShowTime(float deltaTime, float valueA, float valueB, float time, out float progress)
	{
		if (IsOpenCurveLerp)
		{
			CurveLerpShowTime(deltaTime, valueA, valueB, time, out progress);
		}
		else
		{
			ValueLerp(deltaTime, valueA, valueB, time, out progress);
		}
	}

	private void CurveLerpShowTime(float deltaTime, float valueA, float valueB, float time, out float progress)
	{
		ExecuteTime += deltaTime;
		float num = ExecuteTime / time;
		if (num <= 1f)
		{
			float num2 = AnimationCurve.Evaluate(num);
			progress = valueA + num2 * (valueB - valueA);
		}
		else
		{
			progress = valueB;
		}
	}

	public void ValueLerp(float deltaTime, float valueA, float valueB, float time, out float progress)
	{
		if (time == 0f)
		{
			progress = valueB;
			return;
		}
		ExecuteTime += deltaTime;
		float num = ExecuteTime / time;
		if (num <= 1f)
		{
			float num2 = Mathf.Lerp(valueA, valueB, num);
			progress = num2;
		}
		else
		{
			progress = valueB;
		}
	}

	public virtual void Clear()
	{
		AnimationCurve = null;
		Priority = 0;
		IsOpenCurveLerp = false;
		ShowTimer = 0f;
		ExecuteTime = 0f;
		CommandId = 0;
		AdjustCameraState = AdjustCameraState.Null;
		ReductionTime = 0f;
	}
}
