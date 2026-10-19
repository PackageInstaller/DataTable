using UnityEngine;

namespace Cinemachine;

internal class BlendSourceVirtualCamera : ICinemachineCamera
{
	public CinemachineBlend Blend { get; set; }

	public string Name => "Mid-blend";

	public string Description
	{
		get
		{
			if (Blend != null)
			{
				return Blend.Description;
			}
			return "(null)";
		}
	}

	public int Priority { get; set; }

	public Transform LookAt { get; set; }

	public Transform Follow { get; set; }

	public CameraState State { get; private set; }

	public GameObject VirtualCameraGameObject => null;

	public bool IsValid
	{
		get
		{
			if (Blend != null)
			{
				return Blend.IsValid;
			}
			return false;
		}
	}

	public ICinemachineCamera ParentCamera => null;

	public BlendSourceVirtualCamera(CinemachineBlend blend)
	{
		Blend = blend;
	}

	public bool IsLiveChild(ICinemachineCamera vcam, bool dominantChildOnly = false)
	{
		if (Blend != null)
		{
			if (vcam != Blend.CamA)
			{
				return vcam == Blend.CamB;
			}
			return true;
		}
		return false;
	}

	public CameraState CalculateNewState(float deltaTime)
	{
		return State;
	}

	public void UpdateCameraState(Vector3 worldUp, float deltaTime)
	{
		if (Blend != null)
		{
			Blend.UpdateCameraState(worldUp, deltaTime);
			State = Blend.State;
		}
	}

	public void InternalUpdateCameraState(Vector3 worldUp, float deltaTime)
	{
	}

	public void OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime)
	{
	}

	public void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
	}
}
