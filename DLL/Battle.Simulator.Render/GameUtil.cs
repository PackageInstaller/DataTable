using UnityEngine;

public sealed class GameUtil
{
	private static RaycastHit[] _hits = new RaycastHit[64];

	private static Collider[] _colliders = new Collider[64];

	public static Vector3 GetClosestHit(Vector3 origin, Vector3 target, float minDistance, GameObject ignore)
	{
		Vector3 normalized = (target - origin).normalized;
		float num = Vector3.Distance(origin, target);
		Vector3 result = target;
		for (int i = 0; i < Physics.RaycastNonAlloc(origin, normalized, _hits); i++)
		{
			RaycastHit raycastHit = _hits[i];
			if (raycastHit.collider.gameObject != ignore && !raycastHit.collider.isTrigger && raycastHit.distance > minDistance && raycastHit.distance < num)
			{
				num = raycastHit.distance;
				result = raycastHit.point;
			}
		}
		return result;
	}

	public static void Lerp(ref float Value, float Target, float speed)
	{
		if (Target > Value)
		{
			if (Value + speed > Target)
			{
				Value = Target;
			}
			else if (speed > 0f)
			{
				Value += speed;
			}
		}
		else if (Value - speed < Target)
		{
			Value = Target;
		}
		else if (speed > 0f)
		{
			Value -= speed;
		}
	}

	public static void LerpAngle(ref float Value, float Target, float speed)
	{
		if (Mathf.DeltaAngle(Value, Target) > 0f)
		{
			if (Value + speed > Target)
			{
				Value = Target;
			}
			else if (speed > 0f)
			{
				Value += speed;
			}
		}
		else if (Value - speed < Target)
		{
			Value = Target;
		}
		else if (speed > 0f)
		{
			Value -= speed;
		}
	}

	public static bool InHiearchyOf(GameObject target, GameObject parent)
	{
		GameObject gameObject = target;
		while (gameObject != null)
		{
			if (gameObject == parent)
			{
				return true;
			}
			gameObject = ((!(gameObject.transform.parent != null)) ? null : gameObject.transform.parent.gameObject);
		}
		return false;
	}

	public static float FindDeltaPath(Vector3 a, Vector3 b, Vector3 point)
	{
		Vector3 vector = point - a;
		Vector3 vector2 = b - a;
		float num = vector2.x * vector2.x + vector2.z * vector2.z;
		return (vector.x * vector2.x + vector.z * vector2.z) / num;
	}

	public static Vector3 FindClosestToPath(Vector3 a, Vector3 b, Vector3 point)
	{
		Vector3 vector = point - a;
		Vector3 vector2 = b - a;
		float num = vector2.x * vector2.x + vector2.z * vector2.z;
		float value = (vector.x * vector2.x + vector.z * vector2.z) / num;
		return a + vector2 * Mathf.Clamp01(value);
	}

	public static float AngleOfVector(Vector3 vector)
	{
		Vector2 to = new Vector2(vector.z, vector.x);
		if (to.sqrMagnitude > 0.01f)
		{
			to.Normalize();
		}
		float num = ((to.y < 0f) ? (-1f) : 1f);
		return Vector2.Angle(Vector2.right, to) * num;
	}

	public static float DistanceToSegment(Vector3 point, Vector3 p0, Vector3 p1)
	{
		float sqrMagnitude = (p1 - p0).sqrMagnitude;
		if (sqrMagnitude <= float.Epsilon)
		{
			return Vector3.Distance(point, p0);
		}
		float num = Mathf.Clamp01(((point.x - p0.x) * (p1.x - p0.x) + (point.y - p0.y) * (p1.y - p0.y) + (point.z - p0.z) * (p1.z - p0.z)) / sqrMagnitude);
		return Vector3.Distance(point, p0 + (p1 - p0) * num);
	}
}
