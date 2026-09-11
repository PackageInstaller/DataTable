using System.Collections.Generic;
using UnityEngine;

public class EffectOverlapUtil
{
	private static int m_interestLayerMask;

	public static int InterestLayerMask
	{
		get
		{
			if (m_interestLayerMask == 0)
			{
				m_interestLayerMask = LayerMask.GetMask("EffectCollision");
			}
			return m_interestLayerMask;
		}
	}

	private static int CalcStartAngle(int angle, int turnDirection)
	{
		int num = angle / 2;
		int result = -num;
		switch (turnDirection)
		{
		case 1:
			result = -num;
			break;
		case -1:
			result = num;
			break;
		}
		return result;
	}

	public static bool OverlapCloseHit(Vector3 origin, List<Collider> colliders, out RaycastHit closestHitInfo, Vector3 target)
	{
		Vector3 vector = target - origin;
		closestHitInfo = default(RaycastHit);
		target = origin + vector * 0.9f;
		if (colliders == null || colliders.Count == 0)
		{
			return false;
		}
		float num = float.MaxValue;
		Collider collider = null;
		Vector3 vector2 = Vector3.zero;
		for (int i = 0; i < colliders.Count; i++)
		{
			float sqrMagnitude = (colliders[i].ClosestPoint(target) - target).sqrMagnitude;
			if (sqrMagnitude < num)
			{
				num = sqrMagnitude;
				collider = colliders[i];
				vector2 = colliders[i].bounds.center;
			}
		}
		if (collider != null)
		{
			if (vector2 == origin)
			{
				return false;
			}
			float maxDistance = (vector2 - origin).magnitude * 1.5f;
			if ((vector2 - origin).normalized == Vector3.zero)
			{
				return false;
			}
			Ray ray = new Ray(origin - (vector2 - origin) * 0.2f, (vector2 - origin).normalized);
			if (collider.Raycast(ray, out closestHitInfo, maxDistance))
			{
				return true;
			}
		}
		return false;
	}
}
