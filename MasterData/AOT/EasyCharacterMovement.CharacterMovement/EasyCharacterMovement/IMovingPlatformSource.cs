using UnityEngine;

namespace EasyCharacterMovement;

public interface IMovingPlatformSource
{
	bool IsReady { get; }

	bool TryGetDeltaPose(Vector3 characterPosition, out Vector3 deltaPosition, out Quaternion deltaRotation);
}
