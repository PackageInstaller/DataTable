using System;
using UnityEngine;

namespace P08Common;

[Serializable]
public struct Vector2d : IEquatable<Vector2d>
{
	public static Vector2d Zero = new Vector2d(0.0, 0.0);

	public static Vector2d NaN = new Vector2d(double.NaN, double.NaN);

	public static Vector2d Right = new Vector2d(1.0, 0.0);

	public static Vector2d Left = new Vector2d(-1.0, 0.0);

	public static Vector2d Up = new Vector2d(0.0, 1.0);

	public static Vector2d Down = new Vector2d(0.0, -1.0);

	public static Vector2d One = new Vector2d(1.0, 1.0);

	public double x;

	public double y;

	public double SquareMagnitude => Dot(this, this);

	public double Magnitude => Math.Sqrt(SquareMagnitude);

	public Vector2d Normalized => this / Magnitude;

	public Vector2d Perpendicular => new Vector2d(y, 0.0 - x);

	public bool IsNaN
	{
		get
		{
			if (!double.IsNaN(x))
			{
				return double.IsNaN(y);
			}
			return true;
		}
	}

	public bool IsInfinity
	{
		get
		{
			if (!double.IsInfinity(x))
			{
				return double.IsInfinity(y);
			}
			return true;
		}
	}

	public Vector2d(double x, double y)
	{
		this.x = x;
		this.y = y;
	}

	public Vector2d(Vector2 vector2)
	{
		x = vector2.x;
		y = vector2.y;
	}

	public Vector2d Rotate(double cos, double sin)
	{
		return new Vector2d(x * cos - y * sin, y * cos + x * sin);
	}

	public Vector3 ToVector3(float height)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3((float)x, height, (float)y);
	}

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public bool Equals(Vector2d v)
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

	public override string ToString()
	{
		return string.Format("(" + x + ", " + y + ")");
	}

	public static double Dot(Vector2d a, Vector2d b)
	{
		return a.x * b.x + a.y * b.y;
	}

	public static double Det(Vector2d a, Vector2d b)
	{
		return a.x * b.y - a.y * b.x;
	}

	public static double RightOf(Vector2d A, Vector2d B, Vector2d C)
	{
		return (C.x - A.x) * (B.y - A.y) - (C.y - A.y) * (B.x - A.x);
	}

	public static double SquareDistance(Vector2d a, Vector2d b)
	{
		return (a - b).SquareMagnitude;
	}

	public static double Distance(Vector2d a, Vector2d b)
	{
		return (a - b).Magnitude;
	}

	public static double Angle(Vector2d a, Vector2d b)
	{
		if (Det(a, b) >= 0.0)
		{
			return Math.Acos(Dot(a.Normalized, b.Normalized));
		}
		return 6.283185 - Math.Acos(Dot(a.Normalized, b.Normalized));
	}

	public static double AngleNormalized(Vector2d a, Vector2d b)
	{
		if (Det(a, b) >= 0.0)
		{
			return Math.Acos(Dot(a, b));
		}
		return 6.283185 - Math.Acos(Dot(a, b));
	}

	public static double FastAngle(Vector2d a, Vector2d b)
	{
		if (Det(a, b) >= 0.0)
		{
			return Math.FastAngle(Dot(a.Normalized, b.Normalized));
		}
		return 6.283185005187988 - Math.FastAngle(Dot(a.Normalized, b.Normalized));
	}

	public static double FastAngleNormalized(Vector2d a, Vector2d b)
	{
		if (Det(a, b) >= 0.0)
		{
			return Math.FastAngle(Dot(a, b));
		}
		return 6.283185005187988 - Math.FastAngle(Dot(a, b));
	}

	public static Vector2d Rotate(Vector2d a, double cos, double sin)
	{
		return new Vector2d(a.x * cos - a.y * sin, a.y * cos + a.x * sin);
	}

	public static Vector2d operator +(Vector2d a, Vector2d b)
	{
		return new Vector2d(a.x + b.x, a.y + b.y);
	}

	public static Vector2d operator -(Vector2d a, Vector2d b)
	{
		return new Vector2d(a.x - b.x, a.y - b.y);
	}

	public static Vector2d operator -(Vector2d a)
	{
		return new Vector2d(0.0 - a.x, 0.0 - a.y);
	}

	public static double operator *(Vector2d a, Vector2d b)
	{
		return Dot(a, b);
	}

	public static Vector2d operator *(Vector2d a, double d)
	{
		return new Vector2d(a.x * d, a.y * d);
	}

	public static Vector2d operator *(double d, Vector2d a)
	{
		return new Vector2d(a.x * d, a.y * d);
	}

	public static Vector2d operator /(Vector2d a, double d)
	{
		return new Vector2d(a.x / d, a.y / d);
	}

	public static bool operator ==(Vector2d a, Vector2d b)
	{
		if (a.x == b.x)
		{
			return a.y == b.y;
		}
		return false;
	}

	public static bool operator !=(Vector2d a, Vector2d b)
	{
		if (a.x == b.x)
		{
			return a.y != b.y;
		}
		return true;
	}

	public static implicit operator Vector2d(Vector2 vector2)
	{
		return new Vector2d(vector2.x, vector2.y);
	}

	public static implicit operator Vector2d(Vector2 vector2)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		return new Vector2d(vector2.x, vector2.y);
	}

	public static explicit operator Vector2(Vector2d v)
	{
		return new Vector2((float)v.x, (float)v.y);
	}

	public static explicit operator Vector2(Vector2d v)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		return new Vector2((float)v.x, (float)v.y);
	}
}
