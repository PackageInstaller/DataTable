using System;

namespace Bamboo;

[Serializable]
public struct FPVector3 : IEquatable<FPVector3>
{
	public FPFloat X;

	public FPFloat Y;

	public FPFloat Z;

	public static FPVector3 Zero = new FPVector3(0, 0, 0);

	public static readonly FPVector3 One = new FPVector3(1, 1, 1);

	public static readonly FPVector3 Left = new FPVector3(-1, 0, 0);

	public static readonly FPVector3 Right = new FPVector3(1, 0, 0);

	public static readonly FPVector3 Up = new FPVector3(0, 1, 0);

	public static readonly FPVector3 Down = new FPVector3(0, -1, 0);

	public static readonly FPVector3 Back = new FPVector3(0, 0, -1);

	public static readonly FPVector3 Forward = new FPVector3(0, 0, 1);

	public FPFloat this[int index]
	{
		get
		{
			FPFloat zero = FPFloat.Zero;
			return index switch
			{
				0 => X, 
				1 => Y, 
				2 => Z, 
				_ => 0, 
			};
		}
		set
		{
			switch (index)
			{
			case 0:
				X = value;
				break;
			case 1:
				Y = value;
				break;
			case 2:
				Z = value;
				break;
			}
		}
	}

	public FPVector3 Normalized => Normalize(this);

	public FPFloat Magnitude => FPFloat.Sqrt(X * X + Y * Y + Z * Z);

	public FPFloat SqrMagnitude => X * X + Y * Y + Z * Z;

	public FPVector3(FPFloat x, FPFloat y, FPFloat z)
	{
		X = x;
		Y = y;
		Z = z;
	}

	public FPVector3(FPFloat x)
	{
		X = x;
		Y = X;
		Z = X;
	}

	public static FPVector3 Abs(FPVector3 other)
	{
		return new FPVector3(FPFloat.Abs(other.X), FPFloat.Abs(other.Y), FPFloat.Abs(other.Z));
	}

	public static FPVector3 ClampMagnitude(FPVector3 vector, FPFloat maxLength)
	{
		return Normalize(vector) * maxLength;
	}

	public void Scale(FPVector3 other)
	{
		X *= other.X;
		Y *= other.Y;
		Z *= other.Z;
	}

	public void Set(FPFloat x, FPFloat y, FPFloat z)
	{
		X = x;
		Y = y;
		Z = z;
	}

	public void Set(FPVector3 val)
	{
		X = val.X;
		Y = val.Y;
		Z = val.Z;
	}

	public static FPVector3 Lerp(FPVector3 from, FPVector3 to, FPFloat percent)
	{
		return from + (to - from) * percent;
	}

	public override string ToString()
	{
		return $"({X.AsFloat():f1}, {Y.AsFloat():f1}, {Z.AsFloat():f1})";
	}

	public bool Equals(FPVector3 other)
	{
		if (X == other.X && Y == other.Y)
		{
			return Z == other.Z;
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is FPVector3 other))
		{
			return false;
		}
		return Equals(other);
	}

	public static FPVector3 Scale(FPVector3 vecA, FPVector3 vecB)
	{
		FPVector3 result = default;
		result.X = vecA.X * vecB.X;
		result.Y = vecA.Y * vecB.Y;
		result.Z = vecA.Z * vecB.Z;
		return result;
	}

	public static bool operator ==(FPVector3 value1, FPVector3 value2)
	{
		if (value1.X == value2.X && value1.Y == value2.Y)
		{
			return value1.Z == value2.Z;
		}
		return false;
	}

	public static bool operator !=(FPVector3 value1, FPVector3 value2)
	{
		if (value1.X == value2.X && value1.Y == value2.Y)
		{
			return value1.Z != value2.Z;
		}
		return true;
	}

	public static FPVector3 Min(FPVector3 value1, FPVector3 value2)
	{
		Min(ref value1, ref value2, out var result);
		return result;
	}

	public static void Min(ref FPVector3 value1, ref FPVector3 value2, out FPVector3 result)
	{
		result.X = ((value1.X < value2.X) ? value1.X : value2.X);
		result.Y = ((value1.Y < value2.Y) ? value1.Y : value2.Y);
		result.Z = ((value1.Z < value2.Z) ? value1.Z : value2.Z);
	}

	public static FPVector3 Max(FPVector3 value1, FPVector3 value2)
	{
		Max(ref value1, ref value2, out var result);
		return result;
	}

	public static FPFloat Distance(FPVector3 v1, FPVector3 v2)
	{
		FPFloat fPFloat = (v1.X - v2.X) * (v1.X - v2.X) + (v1.Y - v2.Y) * (v1.Y - v2.Y) + (v1.Z - v2.Z) * (v1.Z - v2.Z);
		if (fPFloat < 0)
		{
			return FPFloat.SqrtMaxValue;
		}
		return FPFloat.Sqrt(fPFloat);
	}

	public static FPFloat DistanceSquared(FPVector3 v1, FPVector3 v2)
	{
		FPFloat fPFloat = (v1.X - v2.X) * (v1.X - v2.X) + (v1.Y - v2.Y) * (v1.Y - v2.Y) + (v1.Z - v2.Z) * (v1.Z - v2.Z);
		if (!(fPFloat < 0))
		{
			return fPFloat;
		}
		return FPFloat.MaxValue;
	}

	public static void Max(ref FPVector3 value1, ref FPVector3 value2, out FPVector3 result)
	{
		result.X = ((value1.X > value2.X) ? value1.X : value2.X);
		result.Y = ((value1.Y > value2.Y) ? value1.Y : value2.Y);
		result.Z = ((value1.Z > value2.Z) ? value1.Z : value2.Z);
	}

	public void MakeZero()
	{
		X = FPFloat.Zero;
		Y = FPFloat.Zero;
		Z = FPFloat.Zero;
	}

	public bool IsZero()
	{
		return SqrMagnitude == FPFloat.Zero;
	}

	public bool IsNearlyZero()
	{
		return SqrMagnitude < FPMath.Epsilon;
	}

	public static FPVector3 Transform(FPVector3 position, FPMatrix matrix)
	{
		Transform(ref position, ref matrix, out var result);
		return result;
	}

	public static void Transform(ref FPVector3 position, ref FPMatrix matrix, out FPVector3 result)
	{
		FPFloat x = position.X * matrix.M11 + position.Y * matrix.M21 + position.Z * matrix.M31;
		FPFloat y = position.X * matrix.M12 + position.Y * matrix.M22 + position.Z * matrix.M32;
		FPFloat z = position.X * matrix.M13 + position.Y * matrix.M23 + position.Z * matrix.M33;
		result.X = x;
		result.Y = y;
		result.Z = z;
	}

	public static void TransposedTransform(ref FPVector3 position, ref FPMatrix matrix, out FPVector3 result)
	{
		FPFloat x = position.X * matrix.M11 + position.Y * matrix.M12 + position.Z * matrix.M13;
		FPFloat y = position.X * matrix.M21 + position.Y * matrix.M22 + position.Z * matrix.M23;
		FPFloat z = position.X * matrix.M31 + position.Y * matrix.M32 + position.Z * matrix.M33;
		result.X = x;
		result.Y = y;
		result.Z = z;
	}

	public static FPFloat Dot(FPVector3 vector1, FPVector3 vector2)
	{
		return Dot(ref vector1, ref vector2);
	}

	public static FPFloat Dot(ref FPVector3 vector1, ref FPVector3 vector2)
	{
		return vector1.X * vector2.X + vector1.Y * vector2.Y + vector1.Z * vector2.Z;
	}

	public static FPVector3 Project(FPVector3 vector, FPVector3 onNormal)
	{
		FPFloat fPFloat = Dot(onNormal, onNormal);
		if (fPFloat < FPMath.Epsilon)
		{
			return Zero;
		}
		return onNormal * Dot(vector, onNormal) / fPFloat;
	}

	public static FPVector3 ProjectOnPlane(FPVector3 vector, FPVector3 planeNormal)
	{
		return vector - Project(vector, planeNormal);
	}

	public static FPFloat Angle(FPVector3 from, FPVector3 to)
	{
		return FPMath.Acos(FPMath.Clamp(Dot(from.Normalized, to.Normalized), -FPFloat.One, FPFloat.One)) * FPMath.Rad2Deg;
	}

	public static FPFloat SignedAngle(FPVector3 from, FPVector3 to, FPVector3 axis)
	{
		FPVector3 normalized = from.Normalized;
		FPVector3 normalized2 = to.Normalized;
		FPFloat fPFloat = FPMath.Acos(FPMath.Clamp(Dot(normalized, normalized2), -FPFloat.One, FPFloat.One)) * FPMath.Rad2Deg;
		FPFloat fPFloat2 = FPMath.Sign(Dot(axis, Cross(normalized, normalized2)));
		return fPFloat * fPFloat2;
	}

	public static FPVector3 Add(FPVector3 value1, FPVector3 value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static void Add(ref FPVector3 value1, ref FPVector3 value2, out FPVector3 result)
	{
		FPFloat x = value1.X + value2.X;
		FPFloat y = value1.Y + value2.Y;
		FPFloat z = value1.Z + value2.Z;
		result.X = x;
		result.Y = y;
		result.Z = z;
	}

	public static FPVector3 Divide(FPVector3 value1, FPFloat scaleFactor)
	{
		Divide(ref value1, scaleFactor, out var result);
		return result;
	}

	public static void Divide(ref FPVector3 value1, FPFloat scaleFactor, out FPVector3 result)
	{
		result.X = value1.X / scaleFactor;
		result.Y = value1.Y / scaleFactor;
		result.Z = value1.Z / scaleFactor;
	}

	public static FPVector3 Subtract(FPVector3 value1, FPVector3 value2)
	{
		Subtract(ref value1, ref value2, out var result);
		return result;
	}

	public static void Subtract(ref FPVector3 value1, ref FPVector3 value2, out FPVector3 result)
	{
		FPFloat x = value1.X - value2.X;
		FPFloat y = value1.Y - value2.Y;
		FPFloat z = value1.Z - value2.Z;
		result.X = x;
		result.Y = y;
		result.Z = z;
	}

	public static FPVector3 Cross(FPVector3 vector1, FPVector3 vector2)
	{
		Cross(ref vector1, ref vector2, out var result);
		return result;
	}

	public static void Cross(ref FPVector3 vector1, ref FPVector3 vector2, out FPVector3 result)
	{
		FPFloat x = vector1.Y * vector2.Z - vector1.Z * vector2.Y;
		FPFloat y = vector1.Z * vector2.X - vector1.X * vector2.Z;
		FPFloat z = vector1.X * vector2.Y - vector1.Y * vector2.X;
		result.X = x;
		result.Y = y;
		result.Z = z;
	}

	public override int GetHashCode()
	{
		return X.GetHashCode() ^ Y.GetHashCode() ^ Z.GetHashCode();
	}

	public void Negate()
	{
		X = -X;
		Y = -Y;
		Z = -Z;
	}

	public static FPVector3 Negate(FPVector3 value)
	{
		Negate(ref value, out var result);
		return result;
	}

	public static void Negate(ref FPVector3 value, out FPVector3 result)
	{
		FPFloat x = -value.X;
		FPFloat y = -value.Y;
		FPFloat z = -value.Z;
		result.X = x;
		result.Y = y;
		result.Z = z;
	}

	public static FPVector3 Normalize(FPVector3 value)
	{
		Normalize(ref value, out var result);
		return result;
	}

	public void Normalize()
	{
		FPFloat x = X * X + Y * Y + Z * Z;
		FPFloat fPFloat = FPFloat.One / FPFloat.Sqrt(x);
		X *= fPFloat;
		Y *= fPFloat;
		Z *= fPFloat;
	}

	public static void Normalize(ref FPVector3 value, out FPVector3 result)
	{
		FPFloat x = value.X * value.X + value.Y * value.Y + value.Z * value.Z;
		FPFloat fPFloat = FPFloat.One / FPFloat.Sqrt(x);
		result.X = value.X * fPFloat;
		result.Y = value.Y * fPFloat;
		result.Z = value.Z * fPFloat;
	}

	public static void Swap(ref FPVector3 vector1, ref FPVector3 vector2)
	{
		FPFloat x = vector1.X;
		vector1.X = vector2.X;
		vector2.X = x;
		x = vector1.Y;
		vector1.Y = vector2.Y;
		vector2.Y = x;
		x = vector1.Z;
		vector1.Z = vector2.Z;
		vector2.Z = x;
	}

	public static FPVector3 Multiply(FPVector3 value1, FPFloat scaleFactor)
	{
		Multiply(ref value1, scaleFactor, out var result);
		return result;
	}

	public static void Multiply(ref FPVector3 value1, FPFloat scaleFactor, out FPVector3 result)
	{
		result.X = value1.X * scaleFactor;
		result.Y = value1.Y * scaleFactor;
		result.Z = value1.Z * scaleFactor;
	}

	public static FPVector3 operator %(FPVector3 value1, FPVector3 value2)
	{
		Cross(ref value1, ref value2, out var result);
		return result;
	}

	public static FPFloat operator *(FPVector3 value1, FPVector3 value2)
	{
		return Dot(ref value1, ref value2);
	}

	public static FPVector3 operator *(FPVector3 value1, FPFloat value2)
	{
		Multiply(ref value1, value2, out var result);
		return result;
	}

	public static FPVector3 operator *(FPFloat value1, FPVector3 value2)
	{
		Multiply(ref value2, value1, out var result);
		return result;
	}

	public static FPVector3 operator -(FPVector3 value1, FPVector3 value2)
	{
		Subtract(ref value1, ref value2, out var result);
		return result;
	}

	public static FPVector3 operator +(FPVector3 value1, FPVector3 value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static FPVector3 operator /(FPVector3 value1, FPFloat value2)
	{
		Divide(ref value1, value2, out var result);
		return result;
	}

	public FPVector2 ToFPVector2()
	{
		return new FPVector2(X, Y);
	}

	public FPFloat LengthSquared()
	{
		return X * X + Y * Y + Z * Z;
	}

	public FPFloat Length()
	{
		return FPMath.Sqrt(LengthSquared());
	}

	public static FPVector2 ToFPVector2XZ(FPVector3 vec)
	{
		return new FPVector2(vec.X, vec.Z);
	}
}
