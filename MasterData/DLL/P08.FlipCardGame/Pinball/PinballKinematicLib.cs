using UnityEngine;

namespace Pinball;

public static class PinballKinematicLib
{
	public const float OPERATIONALMAX = 560000f;

	public const float MIN_COLLISION_TIME = 0.0001f;

	public const float SEPARATION_FACTOR = 0.12f;

	public const float MIN_SEPARATION = 0.01f;

	public const float MIN_POST_VEL = 0.02f;

	public const float POST_VEL_TANGENT_JITTER = 5f;

	public const int MAX_KINEMATICS_ITER = 6;

	public static float CalculateCollision(Vector2 ballPos, Vector2 ballVelocity, float ballRadius, Vector2 lineStart, Vector2 lineEnd, Vector2 lineNormal, out Vector2 resPos, out Vector2 resVel)
	{
		resPos = ballPos;
		resVel = ballVelocity;
		if (Vector2.Dot(ballVelocity, lineNormal) >= -1E-05f)
		{
			return -1f;
		}
		if (ballVelocity.sqrMagnitude < 1E-12f)
		{
			return -1f;
		}
		float num = v2Cross(ballVelocity, lineEnd - lineStart);
		if (Mathf.Abs(num) < 1E-08f)
		{
			return -1f;
		}
		Vector2 vector = lineStart + ballRadius * lineNormal;
		Vector2 vector2 = lineEnd + ballRadius * lineNormal;
		Vector2 rhs = vector - ballPos;
		Vector2 rhs2 = vector2 - ballPos;
		if (v2Cross(ballVelocity, rhs) * v2Cross(ballVelocity, rhs2) <= 0f)
		{
			float num2 = (v2Cross(vector, lineEnd - lineStart) + v2Cross(lineEnd - lineStart, ballPos)) / num;
			if (num2 <= 0.0001f)
			{
				return -1f;
			}
			resPos = ballPos + ballVelocity * num2;
			Vector2 vector3 = lineNormal;
			if (vector3.sqrMagnitude > 1E-08f)
			{
				vector3.Normalize();
			}
			resVel = ballVelocity - 2f * Vector2.Dot(ballVelocity, vector3) * vector3;
			return num2;
		}
		float num3 = TimeToCircle(ballPos, ballVelocity, lineStart, ballRadius);
		float num4 = TimeToCircle(ballPos, ballVelocity, lineEnd, ballRadius);
		float num5 = float.PositiveInfinity;
		bool flag = false;
		if (num3 > 0.0001f && num3 < num5)
		{
			num5 = num3;
			flag = true;
		}
		if (num4 > 0.0001f && num4 < num5)
		{
			num5 = num4;
			flag = false;
		}
		if (!float.IsInfinity(num5) && num5 < 560000f)
		{
			resPos = ballPos + ballVelocity * num5;
			Vector2 vector4 = (flag ? lineStart : lineEnd);
			Vector2 vector5 = resPos - vector4;
			if (vector5.sqrMagnitude < 1E-08f)
			{
				Vector2 vector6 = lineEnd - lineStart;
				if (vector6.sqrMagnitude > 1E-08f)
				{
					vector6.Normalize();
					vector5 = new Vector2(0f - vector6.y, vector6.x);
				}
				else
				{
					vector5 = Vector2.up;
				}
			}
			vector5.Normalize();
			resVel = ballVelocity - 2f * Vector2.Dot(ballVelocity, vector5) * vector5;
			return num5;
		}
		return -1f;
	}

	private static float TimeToCircle(Vector2 pos, Vector2 vel, Vector2 center, float radius)
	{
		Vector2 rhs = pos - center;
		float sqrMagnitude = vel.sqrMagnitude;
		if (sqrMagnitude < 1E-12f)
		{
			return -1f;
		}
		float num = 2f * Vector2.Dot(vel, rhs);
		float num2 = rhs.sqrMagnitude - radius * radius;
		float num3 = num * num - 4f * sqrMagnitude * num2;
		if (num3 < 0f)
		{
			return -1f;
		}
		float num4 = Mathf.Sqrt(num3);
		float num5 = (0f - num - num4) / (2f * sqrMagnitude);
		float num6 = (0f - num + num4) / (2f * sqrMagnitude);
		float num7 = float.PositiveInfinity;
		if (num5 > 0.0001f)
		{
			num7 = Mathf.Min(num7, num5);
		}
		if (num6 > 0.0001f)
		{
			num7 = Mathf.Min(num7, num6);
		}
		if (!float.IsInfinity(num7))
		{
			return num7;
		}
		return -1f;
	}

	public static float CalculateCollisionCircle(Vector2 ballPos, Vector2 ballVelocity, float ballRadius, Vector2 cirPos, float cirRadius, bool isTrigger, out Vector2 resPos, out Vector2 resVel)
	{
		resPos = ballPos;
		resVel = ballVelocity;
		float num = 560000f;
		float num2 = ballPos.x - cirPos.x;
		float num3 = ballPos.y - cirPos.y;
		float num4 = ballRadius + cirRadius;
		float num5 = (ballVelocity.x * num2 + ballVelocity.y * num3) * (ballVelocity.x * num2 + ballVelocity.y * num3) - (num2 * num2 + num3 * num3 - num4 * num4) * ballVelocity.sqrMagnitude;
		if (num5 > 0f)
		{
			float num6 = (ballVelocity.x * num2 + ballVelocity.y * num3) / ballVelocity.sqrMagnitude;
			float num7 = Mathf.Sqrt(num5 / ballVelocity.sqrMagnitude / ballVelocity.sqrMagnitude) - num6;
			float num8 = 0f - Mathf.Sqrt(num5 / ballVelocity.sqrMagnitude / ballVelocity.sqrMagnitude) - num6;
			if (num7 > 0f && num8 > 0f)
			{
				num = Mathf.Min(num7, num8);
			}
			else if (num7 > 0f)
			{
				num = num7;
			}
			else if (num8 > 0f)
			{
				num = num8;
			}
		}
		if (num >= 560000f)
		{
			return -1f;
		}
		resPos = ballPos + ballVelocity * Mathf.Max(num - 0.01f, 0f);
		if (!isTrigger)
		{
			Vector2 vector = resPos - cirPos;
			resVel = ballVelocity - 2f * Vector2.Dot(ballVelocity, vector) / Vector2.Dot(vector, vector) * vector;
		}
		return num;
	}

	public static float FunctionPolygonCountToGenerateCount(float rate)
	{
		return 1f - Mathf.Pow(rate, 3f);
	}

	public static Vector3 GenerateBezierCurve(Vector3 start, Vector3 ctrl1, Vector3 ctrl2, Vector3 end, float time)
	{
		if (time < 0f)
		{
			return start;
		}
		if (time > 1f)
		{
			return end;
		}
		Vector3 a = Vector3.Lerp(start, ctrl1, time);
		Vector3 vector = Vector3.Lerp(ctrl1, ctrl2, time);
		Vector3 b = Vector3.Lerp(ctrl2, end, time);
		Vector3 a2 = Vector3.Lerp(a, vector, time);
		Vector3 b2 = Vector3.Lerp(vector, b, time);
		return Vector3.Lerp(a2, b2, time);
	}

	private static float v2Cross(Vector2 lhs, Vector2 rhs)
	{
		return lhs.x * rhs.y - lhs.y * rhs.x;
	}
}
