using UnityEngine;

namespace Cinemachine;

public interface ICinemachineCamera
{
	string Name { get; }

	string Description { get; }

	int Priority { get; set; }

	Transform LookAt { get; set; }

	Transform Follow { get; set; }

	CameraState State { get; }

	GameObject VirtualCameraGameObject { get; }

	bool IsValid { get; }

	ICinemachineCamera ParentCamera { get; }

	bool IsLiveChild(ICinemachineCamera vcam, bool dominantChildOnly = false);

	void UpdateCameraState(Vector3 worldUp, float deltaTime);

	void InternalUpdateCameraState(Vector3 worldUp, float deltaTime);

	void OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime);

	void OnTargetObjectWarped(Transform target, Vector3 positionDelta);
}
