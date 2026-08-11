using UnityEngine;

namespace Cinemachine;

public interface ICameraOverrideStack
{
	Vector3 DefaultWorldUp { get; }

	int SetCameraOverride(int overrideId, ICinemachineCamera camA, ICinemachineCamera camB, float weightB, float deltaTime);

	void ReleaseCameraOverride(int overrideId);
}
