using UnityEngine;

namespace Cinemachine;

internal class StaticPointVirtualCamera : ICinemachineCamera
{
	public string Name { get; private set; }

	public string Description => "";

	public int Priority { get; set; }

	public Transform LookAt { get; set; }

	public Transform Follow { get; set; }

	public CameraState State { get; private set; }

	public GameObject VirtualCameraGameObject => null;

	public bool IsValid => true;

	public ICinemachineCamera ParentCamera => null;

	public StaticPointVirtualCamera(CameraState state, string name)
	{
		State = state;
		Name = name;
	}

	public void SetState(CameraState state)
	{
		State = state;
	}

	public bool IsLiveChild(ICinemachineCamera vcam, bool dominantChildOnly = false)
	{
		return false;
	}

	public void UpdateCameraState(Vector3 worldUp, float deltaTime)
	{
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
