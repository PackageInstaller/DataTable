using System;
using UnityEngine;

namespace Ase;

public static class VectorMath
{
	public static Vector2 ComplexMultiply(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
	}

	public static float ClosestPointOnLineFactor(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{
		Vector3 rhs = lineEnd - lineStart;
		float sqrMagnitude = rhs.sqrMagnitude;
		if ((double)sqrMagnitude <= 1E-06)
		{
			return 0f;
		}
		return Vector3.Dot(point - lineStart, rhs) / sqrMagnitude;
	}

	public static float LineCircleIntersectionFactor(Vector3 circleCenter, Vector3 linePoint1, Vector3 linePoint2, float radius)
	{
		Vector3 rhs = Normalize(linePoint2 - linePoint1, out var magnitude);
		Vector3 lhs = linePoint1 - circleCenter;
		float num = Vector3.Dot(lhs, rhs);
		float num2 = num * num - (lhs.sqrMagnitude - radius * radius);
		if (num2 < 0f)
		{
			num2 = 0f;
		}
		float num3 = 0f - num + Mathf.Sqrt(num2);
		if (!(magnitude > 1E-05f))
		{
			return 1f;
		}
		return num3 / magnitude;
	}

	public static Vector3 Normalize(Vector3 v, out float magnitude)
	{
		magnitude = v.magnitude;
		if (magnitude > 1E-05f)
		{
			return v / magnitude;
		}
		return Vector3.zero;
	}

	public static Vector2 Normalize(Vector2 v, out float magnitude)
	{
		magnitude = v.magnitude;
		if (magnitude > 1E-05f)
		{
			return v / magnitude;
		}
		return Vector2.zero;
	}

	public static Vector2 ComplexMultiplyConjugate(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x * b.x + a.y * b.y, a.y * b.x - a.x * b.y);
	}

	public static Vector2 CalculateAccelerationToReachPoint(Vector2 deltaPosition, Vector2 targetVelocity, Vector2 currentVelocity, float forwardsAcceleration, float rotationSpeed, float maxSpeed, Vector2 forwardsVector)
	{
		if (forwardsAcceleration <= 0f)
		{
			return Vector2.zero;
		}
		float magnitude = currentVelocity.magnitude;
		float a = magnitude * rotationSpeed * (MathF.PI / 180f);
		a = Mathf.Max(a, forwardsAcceleration);
		deltaPosition = ComplexMultiplyConjugate(deltaPosition, forwardsVector);
		targetVelocity = ComplexMultiplyConjugate(targetVelocity, forwardsVector);
		currentVelocity = ComplexMultiplyConjugate(currentVelocity, forwardsVector);
		float num = 1f / (forwardsAcceleration * forwardsAcceleration);
		float num2 = 1f / (a * a);
		if (targetVelocity == Vector2.zero)
		{
			float num3 = 0.01f;
			float num4 = 10f;
			while (num4 - num3 > 0.01f)
			{
				float num5 = (num4 + num3) * 0.5f;
				Vector2 vector = (6f * deltaPosition - 4f * num5 * currentVelocity) / (num5 * num5);
				Vector2 vector2 = 6f * (num5 * currentVelocity - 2f * deltaPosition) / (num5 * num5 * num5);
				Vector2 vector3 = vector + vector2 * num5;
				if (vector.x * vector.x * num + vector.y * vector.y * num2 > 1f || vector3.x * vector3.x * num + vector3.y * vector3.y * num2 > 1f)
				{
					num3 = num5;
				}
				else
				{
					num4 = num5;
				}
			}
			Vector2 a2 = (6f * deltaPosition - 4f * num4 * currentVelocity) / (num4 * num4);
			a2.y *= 2f;
			float num6 = a2.x * a2.x * num + a2.y * a2.y * num2;
			if (num6 > 1f)
			{
				a2 /= Mathf.Sqrt(num6);
			}
			return ComplexMultiply(a2, forwardsVector);
		}
		Vector2 vector4 = Normalize(targetVelocity, out var magnitude2);
		float magnitude3 = deltaPosition.magnitude;
		Vector2 a3 = ((deltaPosition - vector4 * Math.Min(0.5f * magnitude3 * magnitude2 / (magnitude + magnitude2), maxSpeed * 1.5f)).normalized * maxSpeed - currentVelocity) * 10f;
		float num7 = a3.x * a3.x * num + a3.y * a3.y * num2;
		if (num7 > 1f)
		{
			a3 /= Mathf.Sqrt(num7);
		}
		return ComplexMultiply(a3, forwardsVector);
	}

	public static Vector2 ClampVelocity(Vector2 velocity, float maxSpeed, float slowdownFactor, bool slowWhenNotFacingTarget, Vector2 forward)
	{
		float num = maxSpeed * slowdownFactor;
		if (slowWhenNotFacingTarget && (forward.x != 0f || forward.y != 0f))
		{
			Vector2 lhs = Normalize(velocity, out var magnitude);
			float num2 = Vector2.Dot(lhs, forward);
			float num3 = Mathf.Clamp(num2 + 0.707f, 0.2f, 1f);
			num *= num3;
			magnitude = Mathf.Min(magnitude, num);
			float f = Mathf.Min(Mathf.Acos(Mathf.Clamp(num2, -1f, 1f)), (20f + 180f * (1f - slowdownFactor * slowdownFactor)) * (MathF.PI / 180f));
			float num4 = Mathf.Sin(f);
			float num5 = Mathf.Cos(f);
			num4 *= Mathf.Sign(lhs.x * forward.y - lhs.y * forward.x);
			return new Vector2(forward.x * num5 + forward.y * num4, forward.y * num5 - forward.x * num4) * magnitude;
		}
		return Vector2.ClampMagnitude(velocity, num);
	}

	public static Vector2 ToPlane(Vector3 point)
	{
		return new Vector2(point.x, point.z);
	}

	public static Vector2 ToPlane(Vector3 point, out float elevation)
	{
		elevation = point.y;
		return new Vector2(point.x, point.z);
	}

	public static Vector3 ToWorld(Vector2 point, float elevation)
	{
		return new Vector3(point.x, elevation, point.y);
	}
}
