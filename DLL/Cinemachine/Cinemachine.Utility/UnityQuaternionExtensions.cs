using UnityEngine;

namespace Cinemachine.Utility;

public static class UnityQuaternionExtensions
{
	public static Quaternion SlerpWithReferenceUp(Quaternion qA, Quaternion qB, float t, Vector3 up)
	{
		Vector3 vector = (qA * Vector3.forward).ProjectOntoPlane(up);
		Vector3 v = (qB * Vector3.forward).ProjectOntoPlane(up);
		if (vector.AlmostZero() || v.AlmostZero())
		{
			return Quaternion.Slerp(qA, qB, t);
		}
		Quaternion quaternion = Quaternion.LookRotation(vector, up);
		Quaternion quaternion2 = Quaternion.Inverse(quaternion);
		Quaternion quaternion3 = quaternion2 * qA;
		Quaternion quaternion4 = quaternion2 * qB;
		Vector3 eulerAngles = quaternion3.eulerAngles;
		Vector3 eulerAngles2 = quaternion4.eulerAngles;
		return quaternion * Quaternion.Euler(Mathf.LerpAngle(eulerAngles.x, eulerAngles2.x, t), Mathf.LerpAngle(eulerAngles.y, eulerAngles2.y, t), Mathf.LerpAngle(eulerAngles.z, eulerAngles2.z, t));
	}

	public static Quaternion Normalized(this Quaternion q)
	{
		Vector4 normalized = new Vector4(q.x, q.y, q.z, q.w).normalized;
		return new Quaternion(normalized.x, normalized.y, normalized.z, normalized.w);
	}

	public static Vector2 GetCameraRotationToTarget(this Quaternion orient, Vector3 lookAtDir, Vector3 worldUp)
	{
		if (lookAtDir.AlmostZero())
		{
			return Vector2.zero;
		}
		Quaternion quaternion = Quaternion.Inverse(orient);
		Vector3 vector = quaternion * worldUp;
		lookAtDir = quaternion * lookAtDir;
		float num = 0f;
		Vector3 vector2 = lookAtDir.ProjectOntoPlane(vector);
		if (!vector2.AlmostZero())
		{
			Vector3 vector3 = Vector3.forward.ProjectOntoPlane(vector);
			if (vector3.AlmostZero())
			{
				vector3 = ((!(Vector3.Dot(vector3, vector) > 0f)) ? Vector3.up.ProjectOntoPlane(vector) : Vector3.down.ProjectOntoPlane(vector));
			}
			num = UnityVectorExtensions.SignedAngle(vector3, vector2, vector);
		}
		Quaternion quaternion2 = Quaternion.AngleAxis(num, vector);
		return new Vector2(UnityVectorExtensions.SignedAngle(quaternion2 * Vector3.forward, lookAtDir, quaternion2 * Vector3.right), num);
	}

	public static Quaternion ApplyCameraRotation(this Quaternion orient, Vector2 rot, Vector3 worldUp)
	{
		if (rot.sqrMagnitude < 0.0001f)
		{
			return orient;
		}
		Quaternion quaternion = Quaternion.AngleAxis(rot.x, Vector3.right);
		return Quaternion.AngleAxis(rot.y, worldUp) * orient * quaternion;
	}
}
