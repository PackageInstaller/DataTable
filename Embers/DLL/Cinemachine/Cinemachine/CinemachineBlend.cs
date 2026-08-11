using System.Text;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

public class CinemachineBlend
{
	public ICinemachineCamera CamA;

	public ICinemachineCamera CamB;

	public AnimationCurve BlendCurve;

	public float TimeInBlend;

	public float Duration;

	public float BlendWeight
	{
		get
		{
			if (BlendCurve == null || BlendCurve.length < 2 || IsComplete)
			{
				return 1f;
			}
			return Mathf.Clamp01(BlendCurve.Evaluate(TimeInBlend / Duration));
		}
	}

	public bool IsValid
	{
		get
		{
			if (CamA == null || !CamA.IsValid)
			{
				if (CamB != null)
				{
					return CamB.IsValid;
				}
				return false;
			}
			return true;
		}
	}

	public bool IsComplete
	{
		get
		{
			if (!(TimeInBlend >= Duration))
			{
				return !IsValid;
			}
			return true;
		}
	}

	public string Description
	{
		get
		{
			StringBuilder stringBuilder = CinemachineDebug.SBFromPool();
			if (CamB == null || !CamB.IsValid)
			{
				stringBuilder.Append("(none)");
			}
			else
			{
				stringBuilder.Append("[");
				stringBuilder.Append(CamB.Name);
				stringBuilder.Append("]");
			}
			stringBuilder.Append(" ");
			stringBuilder.Append((int)(BlendWeight * 100f));
			stringBuilder.Append("% from ");
			if (CamA == null || !CamA.IsValid)
			{
				stringBuilder.Append("(none)");
			}
			else
			{
				stringBuilder.Append("[");
				stringBuilder.Append(CamA.Name);
				stringBuilder.Append("]");
			}
			string result = stringBuilder.ToString();
			CinemachineDebug.ReturnToPool(stringBuilder);
			return result;
		}
	}

	public CameraState State
	{
		get
		{
			if (CamA == null || !CamA.IsValid)
			{
				if (CamB == null || !CamB.IsValid)
				{
					return CameraState.Default;
				}
				return CamB.State;
			}
			if (CamB == null || !CamB.IsValid)
			{
				return CamA.State;
			}
			return CameraState.Lerp(CamA.State, CamB.State, BlendWeight);
		}
	}

	public bool Uses(ICinemachineCamera cam)
	{
		if (cam == CamA || cam == CamB)
		{
			return true;
		}
		if (CamA is BlendSourceVirtualCamera blendSourceVirtualCamera && blendSourceVirtualCamera.Blend.Uses(cam))
		{
			return true;
		}
		if (CamB is BlendSourceVirtualCamera blendSourceVirtualCamera2 && blendSourceVirtualCamera2.Blend.Uses(cam))
		{
			return true;
		}
		return false;
	}

	public CinemachineBlend(ICinemachineCamera a, ICinemachineCamera b, AnimationCurve curve, float duration, float t)
	{
		CamA = a;
		CamB = b;
		BlendCurve = curve;
		TimeInBlend = t;
		Duration = duration;
	}

	public void UpdateCameraState(Vector3 worldUp, float deltaTime)
	{
		if (CamA != null && CamA.IsValid)
		{
			CamA.UpdateCameraState(worldUp, deltaTime);
		}
		if (CamB != null && CamB.IsValid)
		{
			CamB.UpdateCameraState(worldUp, deltaTime);
		}
	}
}
