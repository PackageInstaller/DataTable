using System;
using UnityEngine;

namespace P08Common;

[Serializable]
public struct Vector2(float x, float y) : IEquatable<Vector2>
{
	public static readonly Vector2 Zero = new Vector2(0f, 0f);

	public static readonly Vector2 NaN = new Vector2(float.NaN, float.NaN);

	public static readonly Vector2 Right = new Vector2(1f, 0f);

	public static readonly Vector2 Left = new Vector2(-1f, 0f);

	public static readonly Vector2 Up = new Vector2(0f, 1f);

	public static readonly Vector2 Down = new Vector2(0f, -1f);

	public static readonly Vector2 One = new Vector2(1f, 1f);

	public float x = x;

	public float y = y;

	public float SquareMagnitude => x * x + y * y;

	public float Magnitude => Math.Sqrt(x * x + y * y);

	public Vector2 Normalized => this / Math.Sqrt(x * x + y * y);

	public Vector2 Perpendicular => new Vector2(y, 0f - x);

	public bool IsZero => this == Zero;

	public bool IsNaN
	{
		get
		{
			if (!float.IsNaN(x))
			{
				return float.IsNaN(y);
			}
			return true;
		}
	}

	public bool IsInfinity
	{
		get
		{
			if (!float.IsInfinity(x))
			{
				return float.IsInfinity(y);
			}
			return true;
		}
	}

	public Vector2 Rotate(float cos, float sin)
	{
		return new Vector2(x * cos - y * sin, y * cos + x * sin);
	}

	public Vector2 Rotate(float radAngle)
	{
		float num = Math.Cos(radAngle);
		float num2 = Math.Sin(radAngle);
		return new Vector2(x * num - y * num2, y * num + x * num2);
	}

	public Vector3 ToVector3(float height)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3(x, height, y);
	}

	public override string ToString()
	{
		return $"({x}, {y})";
	}

	public string ToString(string format)
	{
		return $"({x.ToString(format)}, {y.ToString(format)})";
	}

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public bool Equals(Vector2 v)
	{
		if (x == v.x)
		{
			return y == v.y;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static float Dot(Vector2 a, Vector2 b)
	{
		return a.x * b.x + a.y * b.y;
	}

	public static float Det(Vector2 a, Vector2 b)
	{
		return a.x * b.y - a.y * b.x;
	}

	public static float SquareDistance(Vector2 a, Vector2 b)
	{
		return (a - b).SquareMagnitude;
	}

	public static float Distance(Vector2 a, Vector2 b)
	{
		return (a - b).Magnitude;
	}

	public static float Angle(Vector2 a, Vector2 b)
	{
		float num = Dot(a.Normalized, b.Normalized);
		if (num <= -1f)
		{
			return 3.141593f;
		}
		if (num >= 1f)
		{
			return 0f;
		}
		if (Det(a, b) >= 0f)
		{
			return (float)System.Math.Acos(num);
		}
		return 6.283185f - (float)System.Math.Acos(num);
	}

	public static float AngleNormalized(Vector2 unitA, Vector2 unitB)
	{
		float num = Dot(unitA, unitB);
		if (num <= -1f)
		{
			return 3.141593f;
		}
		if (num >= 1f)
		{
			return 0f;
		}
		if (Det(unitA, unitB) >= 0f)
		{
			return (float)System.Math.Acos(num);
		}
		return 6.283185f - (float)System.Math.Acos(num);
	}

	public static float ShortAngle(Vector2 a, Vector2 b)
	{
		float num = Dot(a.Normalized, b.Normalized);
		if (num <= -1f)
		{
			return 3.141593f;
		}
		if (num >= 1f)
		{
			return 0f;
		}
		return (float)System.Math.Acos(num);
	}

	public static float ShortAngleNormalized(Vector2 unitA, Vector2 unitB)
	{
		float num = Dot(unitA, unitB);
		if (num <= -1f)
		{
			return 3.141593f;
		}
		if (num >= 1f)
		{
			return 0f;
		}
		return (float)System.Math.Acos(num);
	}

	public static float FastAngle(Vector2 a, Vector2 b)
	{
		if (Det(a, b) >= 0f)
		{
			return Math.FastAngle(Dot(a.Normalized, b.Normalized));
		}
		return 6.283185f - Math.FastAngle(Dot(a.Normalized, b.Normalized));
	}

	public static float FastAngleNormalized(Vector2 unitA, Vector2 unitB)
	{
		if (Det(unitA, unitB) >= 0f)
		{
			return Math.FastAngle(Dot(unitA, unitB));
		}
		return 6.283185f - Math.FastAngle(Dot(unitA, unitB));
	}

	public static float FastShortAngle(Vector2 a, Vector2 b)
	{
		return Math.FastAngle(Dot(a.Normalized, b.Normalized));
	}

	public static float FastShortAngleNormalized(Vector2 unitA, Vector2 unitB)
	{
		return Math.FastAngle(Dot(unitA, unitB));
	}

	public static Vector2 operator +(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x + b.x, a.y + b.y);
	}

	public static Vector2 operator -(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x - b.x, a.y - b.y);
	}

	public static Vector2 operator -(Vector2 a)
	{
		return new Vector2(0f - a.x, 0f - a.y);
	}

	public static Vector2 operator *(Vector2 a, float b)
	{
		return new Vector2(a.x * b, a.y * b);
	}

	public static Vector2 operator *(float f, Vector2 a)
	{
		return new Vector2(a.x * f, a.y * f);
	}

	public static Vector2 operator /(Vector2 a, float f)
	{
		return new Vector2(a.x / f, a.y / f);
	}

	public static bool operator ==(Vector2 a, Vector2 b)
	{
		if (a.x == b.x)
		{
			return a.y == b.y;
		}
		return false;
	}

	public static bool operator !=(Vector2 a, Vector2 b)
	{
		if (a.x == b.x)
		{
			return a.y != b.y;
		}
		return true;
	}

	public static implicit operator Vector2(Vector2 vector)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return new Vector2(vector.x, vector.y);
	}

	public static implicit operator Vector2(Vector3 vector)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return new Vector2(vector.x, vector.z);
	}

	public static implicit operator Vector2(Int2 vector)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return (Vector2)vector;
	}

	public static implicit operator Vector2(Vector2 vector)
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		return new Vector2(vector.x, vector.y);
	}

	public static implicit operator Vector3(Vector2 vector)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3(vector.x, 0f, vector.y);
	}
}
