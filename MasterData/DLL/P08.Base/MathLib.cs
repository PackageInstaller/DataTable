using System;
using UnityEngine;

public class MathLib
{
	public static float Half_PI = MathF.PI / 2f;

	public static Vector3 Gravity = new Vector3(0f, -19.6f, 0f);

	public static float Gravity_Magnitude = 19.6f;

	public static float Throw_Angle = 30f;

	public static float Throw_Tangent = Mathf.Tan(MathF.PI / 6f);

	public static float Throw_Cosine = Mathf.Cos(MathF.PI / 6f);

	public static Vector3 RandomRotateVector(Vector3 axis, float angle)
	{
		float num = angle * (MathF.PI / 180f);
		float f = UnityEngine.Random.Range(0f - num, num);
		Vector3 vector = new Vector3(Mathf.Sin(f), 0f, Mathf.Cos(f));
		return Quaternion.LookRotation(axis) * vector;
	}

	public static float CipherValue(float value, uint xor)
	{
		return BitConverter.ToSingle(BitConverter.GetBytes(CipherValue(BitConverter.ToUInt32(BitConverter.GetBytes(value), 0), xor)), 0);
	}

	public static Vector3 RandomVectorInsideCone(Vector3 coneAxis, float coneAngle)
	{
		float f = UnityEngine.Random.Range(0f, MathF.PI * 2f);
		float f2 = UnityEngine.Random.Range(0f, coneAngle * (MathF.PI / 180f));
		float num = Mathf.Sin(f2);
		Vector3 vector = new Vector3(Mathf.Sin(f) * num, Mathf.Cos(f) * num, Mathf.Cos(f2));
		return Quaternion.LookRotation(coneAxis) * vector;
	}

	public static Vector3 RotateVector(Vector3 inAxis, float inAngle)
	{
		float f = inAngle * (MathF.PI / 180f);
		Vector3 vector = new Vector3(Mathf.Sin(f), 0f, Mathf.Cos(f));
		return Quaternion.LookRotation(inAxis) * vector;
	}

	public static Vector3 RotateVectorInRadian(Vector3 inAxis, float inRad)
	{
		Vector3 vector = new Vector3(Mathf.Sin(inRad), 0f, Mathf.Cos(inRad));
		return Quaternion.LookRotation(inAxis) * vector;
	}

	public static Vector3 ComputeParabolaEnd(Vector3 srcPos, Vector3 velocity, Vector3 gravity, float elapsedTime)
	{
		return srcPos + velocity * elapsedTime + gravity * (elapsedTime * elapsedTime) * 0.5f;
	}

	public static uint CipherValue(uint value, uint xor)
	{
		return ~(~value ^ xor);
	}

	public static Vector3 LinearBezierCurve(Vector3 p0, Vector3 p1, float t)
	{
		return (1f - t) * p0 + t * p1;
	}

	public static Vector3 BezierCurvePaths(float t, params Vector3[] points)
	{
		if (points.Length < 2)
		{
			return Vector3.zero;
		}
		if (points.Length == 2)
		{
			return LinearBezierCurve(points[0], points[1], t);
		}
		Vector3[] points2 = points.SubArray(0, points.Length - 1);
		Vector3[] points3 = points.SubArray(1, points.Length - 1);
		return (1f - t) * BezierCurvePaths(t, points2) + t * BezierCurvePaths(t, points3);
	}

	public static Vector3 QuadraticBezierCurves(float t, params Vector3[] points)
	{
		if (points.Length != 3)
		{
			return Vector3.zero;
		}
		return Mathf.Pow(1f - t, 2f) * points[0] + 2f * (1f - t) * t * points[1] + Mathf.Pow(t, 2f) * points[2];
	}
}
