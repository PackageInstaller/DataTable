using UnityEngine;

namespace PathFinding2D.Runtime.Settings;

public static class VectorUtilities
{
	public static bool IsPointInPositiveHemisphere(this Vector3 position, Vector3 direction, Vector3 target)
	{
		Vector3 normalized = (target - position).normalized;
		return Vector3.Dot(direction.normalized, normalized) >= 0f;
	}
}
