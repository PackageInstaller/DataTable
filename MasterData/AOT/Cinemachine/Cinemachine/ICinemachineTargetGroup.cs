using UnityEngine;

namespace Cinemachine;

public interface ICinemachineTargetGroup
{
	Transform Transform { get; }

	Bounds BoundingBox { get; }

	BoundingSphere Sphere { get; }

	bool IsEmpty { get; }

	Bounds GetViewSpaceBoundingBox(Matrix4x4 observer);

	void GetViewSpaceAngularBounds(Matrix4x4 observer, out Vector2 minAngles, out Vector2 maxAngles, out Vector2 zRange);
}
