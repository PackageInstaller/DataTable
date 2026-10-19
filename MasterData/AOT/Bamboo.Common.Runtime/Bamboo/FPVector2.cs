using System;

namespace Bamboo;

[Serializable]
public struct FPVector2 : IEquatable<FPVector2>
{
	public FPFloat X;

	public FPFloat Y;

	private static FPVector2 _zero = new FPVector2(0, 0);

	private static FPVector2 _one = new FPVector2(1, 1);

	private static FPVector2 _right = new FPVector2(1, 0);

	private static FPVector2 _left = new FPVector2(-1, 0);

	private static FPVector2 _up = new FPVector2(0, 1);

	private static FPVector2 _down = new FPVector2(0, -1);

	public static FPVector2 Zero => _zero;

	public static FPVector2 One => _one;

	public static FPVector2 Right => _right;

	public static FPVector2 Left => _left;

	public static FPVector2 Up => _up;

	public static FPVector2 Down => _down;

	public FPFloat Magnitude
	{
		get
		{
			FPFloat result = FPFloat.Zero;
			DistanceSquared(ref this, ref _zero, out result);
			return FPFloat.Sqrt(result);
		}
	}

	public FPVector2 Normalized
	{
		get
		{
			Normalize(ref this, out var result);
			return result;
		}
	}

	public FPVector2(FPFloat x, FPFloat y)
	{
		X = x;
		Y = y;
	}

	public FPVector2(FPFloat value)
	{
		X = value;
		Y = value;
	}

	public void Set(FPFloat x, FPFloat y)
	{
		X = x;
		Y = y;
	}

	public static void Reflect(ref FPVector2 vector, ref FPVector2 normal, out FPVector2 result)
	{
		FPFloat fPFloat = Dot(vector, normal);
		result.X = vector.X - 2f * fPFloat * normal.X;
		result.Y = vector.Y - 2f * fPFloat * normal.Y;
	}

	public static FPVector2 Reflect(FPVector2 vector, FPVector2 normal)
	{
		Reflect(ref vector, ref normal, out var result);
		return result;
	}

	public static FPVector2 Add(FPVector2 value1, FPVector2 value2)
	{
		value1.X += value2.X;
		value1.Y += value2.Y;
		return value1;
	}

	public static void Add(ref FPVector2 value1, ref FPVector2 value2, out FPVector2 result)
	{
		result.X = value1.X + value2.X;
		result.Y = value1.Y + value2.Y;
	}

	public static FPVector2 Barycentric(FPVector2 value1, FPVector2 value2, FPVector2 value3, FPFloat amount1, FPFloat amount2)
	{
		return new FPVector2(FPMath.Barycentric(value1.X, value2.X, value3.X, amount1, amount2), FPMath.Barycentric(value1.Y, value2.Y, value3.Y, amount1, amount2));
	}

	public static void Barycentric(ref FPVector2 value1, ref FPVector2 value2, ref FPVector2 value3, FPFloat amount1, FPFloat amount2, out FPVector2 result)
	{
		result = new FPVector2(FPMath.Barycentric(value1.X, value2.X, value3.X, amount1, amount2), FPMath.Barycentric(value1.Y, value2.Y, value3.Y, amount1, amount2));
	}

	public static FPVector2 CatmullRom(FPVector2 value1, FPVector2 value2, FPVector2 value3, FPVector2 value4, FPFloat amount)
	{
		return new FPVector2(FPMath.CatmullRom(value1.X, value2.X, value3.X, value4.X, amount), FPMath.CatmullRom(value1.Y, value2.Y, value3.Y, value4.Y, amount));
	}

	public static void CatmullRom(ref FPVector2 value1, ref FPVector2 value2, ref FPVector2 value3, ref FPVector2 value4, FPFloat amount, out FPVector2 result)
	{
		result = new FPVector2(FPMath.CatmullRom(value1.X, value2.X, value3.X, value4.X, amount), FPMath.CatmullRom(value1.Y, value2.Y, value3.Y, value4.Y, amount));
	}

	public static FPVector2 Clamp(FPVector2 value1, FPVector2 min, FPVector2 max)
	{
		return new FPVector2(FPMath.Clamp(value1.X, min.X, max.X), FPMath.Clamp(value1.Y, min.Y, max.Y));
	}

	public static void Clamp(ref FPVector2 value1, ref FPVector2 min, ref FPVector2 max, out FPVector2 result)
	{
		result = new FPVector2(FPMath.Clamp(value1.X, min.X, max.X), FPMath.Clamp(value1.Y, min.Y, max.Y));
	}

	public static FPFloat Distance(FPVector2 value1, FPVector2 value2)
	{
		FPFloat result = FPFloat.Zero;
		DistanceSquared(ref value1, ref value2, out result);
		return FPFloat.Sqrt(result);
	}

	public static void Distance(ref FPVector2 value1, ref FPVector2 value2, out FPFloat result)
	{
		DistanceSquared(ref value1, ref value2, out result);
		result = FPFloat.Sqrt(result);
	}

	public static FPFloat DistanceSquared(FPVector2 value1, FPVector2 value2)
	{
		FPFloat result = FPFloat.Zero;
		DistanceSquared(ref value1, ref value2, out result);
		return result;
	}

	public static void DistanceSquared(ref FPVector2 value1, ref FPVector2 value2, out FPFloat result)
	{
		result = (value1.X - value2.X) * (value1.X - value2.X) + (value1.Y - value2.Y) * (value1.Y - value2.Y);
		if (result < 0)
		{
			result = FPFloat.MaxValue;
		}
	}

	public static FPVector2 Divide(FPVector2 value1, FPVector2 value2)
	{
		value1.X /= value2.X;
		value1.Y /= value2.Y;
		return value1;
	}

	public static void Divide(ref FPVector2 value1, ref FPVector2 value2, out FPVector2 result)
	{
		result.X = value1.X / value2.X;
		result.Y = value1.Y / value2.Y;
	}

	public static FPVector2 Divide(FPVector2 value1, FPFloat divider)
	{
		FPFloat fPFloat = 1 / divider;
		value1.X *= fPFloat;
		value1.Y *= fPFloat;
		return value1;
	}

	public static void Divide(ref FPVector2 value1, FPFloat divider, out FPVector2 result)
	{
		FPFloat fPFloat = 1 / divider;
		result.X = value1.X * fPFloat;
		result.Y = value1.Y * fPFloat;
	}

	public static FPFloat Dot(FPVector2 value1, FPVector2 value2)
	{
		return value1.X * value2.X + value1.Y * value2.Y;
	}

	public static void Dot(ref FPVector2 value1, ref FPVector2 value2, out FPFloat result)
	{
		result = value1.X * value2.X + value1.Y * value2.Y;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is FPVector2))
		{
			return false;
		}
		return this == (FPVector2)obj;
	}

	public bool Equals(FPVector2 other)
	{
		return this == other;
	}

	public override int GetHashCode()
	{
		return (int)(long)(X + Y);
	}

	public static FPVector2 Hermite(FPVector2 value1, FPVector2 tangent1, FPVector2 value2, FPVector2 tangent2, FPFloat amount)
	{
		FPVector2 result = default;
		Hermite(ref value1, ref tangent1, ref value2, ref tangent2, amount, out result);
		return result;
	}

	public static void Hermite(ref FPVector2 value1, ref FPVector2 tangent1, ref FPVector2 value2, ref FPVector2 tangent2, FPFloat amount, out FPVector2 result)
	{
		result.X = FPMath.Hermite(value1.X, tangent1.X, value2.X, tangent2.X, amount);
		result.Y = FPMath.Hermite(value1.Y, tangent1.Y, value2.Y, tangent2.Y, amount);
	}

	public static FPVector2 ClampMagnitude(FPVector2 vector, FPFloat maxLength)
	{
		return Normalize(vector) * maxLength;
	}

	public FPFloat LengthSquared()
	{
		FPFloat result = FPFloat.Zero;
		DistanceSquared(ref this, ref _zero, out result);
		return result;
	}

	public static FPVector2 Lerp(FPVector2 value1, FPVector2 value2, FPFloat amount)
	{
		amount = FPMath.Clamp(amount, 0, 1);
		return new FPVector2(FPMath.Lerp(value1.X, value2.X, amount), FPMath.Lerp(value1.Y, value2.Y, amount));
	}

	public static FPVector2 LerpUnclamped(FPVector2 value1, FPVector2 value2, FPFloat amount)
	{
		return new FPVector2(FPMath.Lerp(value1.X, value2.X, amount), FPMath.Lerp(value1.Y, value2.Y, amount));
	}

	public static void LerpUnclamped(ref FPVector2 value1, ref FPVector2 value2, FPFloat amount, out FPVector2 result)
	{
		result = new FPVector2(FPMath.Lerp(value1.X, value2.X, amount), FPMath.Lerp(value1.Y, value2.Y, amount));
	}

	public static FPVector2 Max(FPVector2 value1, FPVector2 value2)
	{
		return new FPVector2(FPMath.Max(value1.X, value2.X), FPMath.Max(value1.Y, value2.Y));
	}

	public static void Max(ref FPVector2 value1, ref FPVector2 value2, out FPVector2 result)
	{
		result.X = FPMath.Max(value1.X, value2.X);
		result.Y = FPMath.Max(value1.Y, value2.Y);
	}

	public static FPVector2 Min(FPVector2 value1, FPVector2 value2)
	{
		return new FPVector2(FPMath.Min(value1.X, value2.X), FPMath.Min(value1.Y, value2.Y));
	}

	public static void Min(ref FPVector2 value1, ref FPVector2 value2, out FPVector2 result)
	{
		result.X = FPMath.Min(value1.X, value2.X);
		result.Y = FPMath.Min(value1.Y, value2.Y);
	}

	public void Scale(FPVector2 other)
	{
		X *= other.X;
		Y *= other.Y;
	}

	public static FPVector2 Scale(FPVector2 value1, FPVector2 value2)
	{
		FPVector2 result = default;
		result.X = value1.X * value2.X;
		result.Y = value1.Y * value2.Y;
		return result;
	}

	public static FPVector2 Multiply(FPVector2 value1, FPVector2 value2)
	{
		value1.X *= value2.X;
		value1.Y *= value2.Y;
		return value1;
	}

	public static FPVector2 Multiply(FPVector2 value1, FPFloat scaleFactor)
	{
		value1.X *= scaleFactor;
		value1.Y *= scaleFactor;
		return value1;
	}

	public static void Multiply(ref FPVector2 value1, FPFloat scaleFactor, out FPVector2 result)
	{
		result.X = value1.X * scaleFactor;
		result.Y = value1.Y * scaleFactor;
	}

	public static void Multiply(ref FPVector2 value1, ref FPVector2 value2, out FPVector2 result)
	{
		result.X = value1.X * value2.X;
		result.Y = value1.Y * value2.Y;
	}

	public static FPVector2 Negate(FPVector2 value)
	{
		value.X = -value.X;
		value.Y = -value.Y;
		return value;
	}

	public static void Negate(ref FPVector2 value, out FPVector2 result)
	{
		result.X = -value.X;
		result.Y = -value.Y;
	}

	public void Normalize()
	{
		Normalize(ref this, out this);
	}

	public static FPVector2 Normalize(FPVector2 value)
	{
		Normalize(ref value, out value);
		return value;
	}

	public static void Normalize(ref FPVector2 value, out FPVector2 result)
	{
		DistanceSquared(ref value, ref _zero, out var result2);
		result2 = 1f / FPFloat.Sqrt(result2);
		result.X = value.X * result2;
		result.Y = value.Y * result2;
	}

	public static FPVector2 SmoothStep(FPVector2 value1, FPVector2 value2, FPFloat amount)
	{
		return new FPVector2(FPMath.SmoothStep(value1.X, value2.X, amount), FPMath.SmoothStep(value1.Y, value2.Y, amount));
	}

	public static void SmoothStep(ref FPVector2 value1, ref FPVector2 value2, FPFloat amount, out FPVector2 result)
	{
		result = new FPVector2(FPMath.SmoothStep(value1.X, value2.X, amount), FPMath.SmoothStep(value1.Y, value2.Y, amount));
	}

	public static FPVector2 Subtract(FPVector2 value1, FPVector2 value2)
	{
		value1.X -= value2.X;
		value1.Y -= value2.Y;
		return value1;
	}

	public static void Subtract(ref FPVector2 value1, ref FPVector2 value2, out FPVector2 result)
	{
		result.X = value1.X - value2.X;
		result.Y = value1.Y - value2.Y;
	}

	public static FPFloat Angle(FPVector2 from, FPVector2 to)
	{
		return FPFloat.Acos(FPMath.Clamp(from.Normalized * to.Normalized, -FPFloat.One, FPFloat.One)) * FPFloat.Rad2Deg;
	}

	public FPVector3 ToFPVector3()
	{
		return new FPVector3(X, Y, 0);
	}

	public override string ToString()
	{
		return $"({X.AsFloat():f1}, {Y.AsFloat():f1})";
	}

	public static FPVector2 operator -(FPVector2 value)
	{
		value.X = -value.X;
		value.Y = -value.Y;
		return value;
	}

	public static bool operator ==(FPVector2 value1, FPVector2 value2)
	{
		if (value1.X == value2.X)
		{
			return value1.Y == value2.Y;
		}
		return false;
	}

	public static bool operator !=(FPVector2 value1, FPVector2 value2)
	{
		if (!(value1.X != value2.X))
		{
			return value1.Y != value2.Y;
		}
		return true;
	}

	public static FPVector2 operator +(FPVector2 value1, FPVector2 value2)
	{
		value1.X += value2.X;
		value1.Y += value2.Y;
		return value1;
	}

	public static FPVector2 operator -(FPVector2 value1, FPVector2 value2)
	{
		value1.X -= value2.X;
		value1.Y -= value2.Y;
		return value1;
	}

	public static FPFloat operator *(FPVector2 value1, FPVector2 value2)
	{
		return Dot(value1, value2);
	}

	public static FPVector2 operator *(FPVector2 value, FPFloat scaleFactor)
	{
		value.X *= scaleFactor;
		value.Y *= scaleFactor;
		return value;
	}

	public static FPVector2 operator *(FPFloat scaleFactor, FPVector2 value)
	{
		value.X *= scaleFactor;
		value.Y *= scaleFactor;
		return value;
	}

	public static FPVector2 operator /(FPVector2 value1, FPVector2 value2)
	{
		value1.X /= value2.X;
		value1.Y /= value2.Y;
		return value1;
	}

	public static FPVector2 operator /(FPVector2 value1, FPFloat divider)
	{
		FPFloat fPFloat = 1 / divider;
		value1.X *= fPFloat;
		value1.Y *= fPFloat;
		return value1;
	}

	public static FPFloat Cross(FPVector2 vector1, FPVector2 vector2)
	{
		return FPMath.Cross2D(vector1, vector2);
	}
}
