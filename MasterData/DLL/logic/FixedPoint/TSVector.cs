using System;

namespace FixedPoint;

[Serializable]
public struct TSVector
{
	private static FP ZeroEpsilonSq;

	internal static TSVector InternalZero;

	internal static TSVector Arbitrary;

	public FP x;

	public FP y;

	public FP z;

	public static readonly TSVector zero;

	public static readonly TSVector left;

	public static readonly TSVector right;

	public static readonly TSVector up;

	public static readonly TSVector down;

	public static readonly TSVector back;

	public static readonly TSVector forward;

	public static readonly TSVector one;

	public static readonly TSVector MinValue;

	public static readonly TSVector MaxValue;

	public FP sqrMagnitude => x * x + y * y + z * z;

	public FP magnitude
	{
		get
		{
			FP fP = x * x + y * y + z * z;
			return FP.Sqrt(fP);
		}
	}

	public TSVector normalized
	{
		get
		{
			TSVector result = new TSVector(x, y, z);
			result.Normalize();
			return result;
		}
	}

	static TSVector()
	{
		ZeroEpsilonSq = TSMath.Epsilon;
		one = new TSVector(1, 1, 1);
		zero = new TSVector(0, 0, 0);
		left = new TSVector(-1, 0, 0);
		right = new TSVector(1, 0, 0);
		up = new TSVector(0, 1, 0);
		down = new TSVector(0, -1, 0);
		back = new TSVector(0, 0, -1);
		forward = new TSVector(0, 0, 1);
		MinValue = new TSVector(FP.MinValue);
		MaxValue = new TSVector(FP.MaxValue);
		Arbitrary = new TSVector(1, 1, 1);
		InternalZero = zero;
	}

	public static TSVector Abs(TSVector other)
	{
		return new TSVector(FP.Abs(other.x), FP.Abs(other.y), FP.Abs(other.z));
	}

	public static TSVector ClampMagnitude(TSVector vector, FP maxLength)
	{
		return Normalize(vector) * maxLength;
	}

	public TSVector(int x, int y, int z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public TSVector(FP x, FP y, FP z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public void Scale(TSVector other)
	{
		x *= other.x;
		y *= other.y;
		z *= other.z;
	}

	public void Set(FP x, FP y, FP z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public TSVector(FP xyz)
	{
		x = xyz;
		y = xyz;
		z = xyz;
	}

	public static TSVector Lerp(TSVector from, TSVector to, FP percent)
	{
		return from + (to - from) * percent;
	}

	public override string ToString()
	{
		return $"({x.AsFloat():f1}, {y.AsFloat():f1}, {z.AsFloat():f1})";
	}

	public override bool Equals(object obj)
	{
		if (!(obj is TSVector tSVector))
		{
			return false;
		}
		if (x == tSVector.x && y == tSVector.y)
		{
			return z == tSVector.z;
		}
		return false;
	}

	public static TSVector Scale(TSVector vecA, TSVector vecB)
	{
		TSVector result = default(TSVector);
		result.x = vecA.x * vecB.x;
		result.y = vecA.y * vecB.y;
		result.z = vecA.z * vecB.z;
		return result;
	}

	public static bool operator ==(TSVector value1, TSVector value2)
	{
		if (value1.x == value2.x && value1.y == value2.y)
		{
			return value1.z == value2.z;
		}
		return false;
	}

	public static bool operator !=(TSVector value1, TSVector value2)
	{
		if (value1.x == value2.x && value1.y == value2.y)
		{
			return value1.z != value2.z;
		}
		return true;
	}

	public static TSVector Min(TSVector value1, TSVector value2)
	{
		Min(ref value1, ref value2, out var result);
		return result;
	}

	public static void Min(ref TSVector value1, ref TSVector value2, out TSVector result)
	{
		result.x = ((value1.x < value2.x) ? value1.x : value2.x);
		result.y = ((value1.y < value2.y) ? value1.y : value2.y);
		result.z = ((value1.z < value2.z) ? value1.z : value2.z);
	}

	public static TSVector Max(TSVector value1, TSVector value2)
	{
		Max(ref value1, ref value2, out var result);
		return result;
	}

	public static FP Distance(TSVector v1, TSVector v2)
	{
		return FP.Sqrt((v1.x - v2.x) * (v1.x - v2.x) + (v1.y - v2.y) * (v1.y - v2.y) + (v1.z - v2.z) * (v1.z - v2.z));
	}

	public static void Max(ref TSVector value1, ref TSVector value2, out TSVector result)
	{
		result.x = ((value1.x > value2.x) ? value1.x : value2.x);
		result.y = ((value1.y > value2.y) ? value1.y : value2.y);
		result.z = ((value1.z > value2.z) ? value1.z : value2.z);
	}

	public void MakeZero()
	{
		x = FP.Zero;
		y = FP.Zero;
		z = FP.Zero;
	}

	public bool IsZero()
	{
		return sqrMagnitude == FP.Zero;
	}

	public bool IsNearlyZero()
	{
		return sqrMagnitude < ZeroEpsilonSq;
	}

	public static TSVector Transform(TSVector position, TSMatrix matrix)
	{
		Transform(ref position, ref matrix, out var result);
		return result;
	}

	public static void Transform(ref TSVector position, ref TSMatrix matrix, out TSVector result)
	{
		FP fP = position.x * matrix.M11 + position.y * matrix.M21 + position.z * matrix.M31;
		FP fP2 = position.x * matrix.M12 + position.y * matrix.M22 + position.z * matrix.M32;
		FP fP3 = position.x * matrix.M13 + position.y * matrix.M23 + position.z * matrix.M33;
		result.x = fP;
		result.y = fP2;
		result.z = fP3;
	}

	public static void TransposedTransform(ref TSVector position, ref TSMatrix matrix, out TSVector result)
	{
		FP fP = position.x * matrix.M11 + position.y * matrix.M12 + position.z * matrix.M13;
		FP fP2 = position.x * matrix.M21 + position.y * matrix.M22 + position.z * matrix.M23;
		FP fP3 = position.x * matrix.M31 + position.y * matrix.M32 + position.z * matrix.M33;
		result.x = fP;
		result.y = fP2;
		result.z = fP3;
	}

	public static FP Dot(TSVector vector1, TSVector vector2)
	{
		return Dot(ref vector1, ref vector2);
	}

	public static FP Dot(ref TSVector vector1, ref TSVector vector2)
	{
		return vector1.x * vector2.x + vector1.y * vector2.y + vector1.z * vector2.z;
	}

	public static TSVector Add(TSVector value1, TSVector value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static void Add(ref TSVector value1, ref TSVector value2, out TSVector result)
	{
		FP fP = value1.x + value2.x;
		FP fP2 = value1.y + value2.y;
		FP fP3 = value1.z + value2.z;
		result.x = fP;
		result.y = fP2;
		result.z = fP3;
	}

	public static TSVector Divide(TSVector value1, FP scaleFactor)
	{
		Divide(ref value1, scaleFactor, out var result);
		return result;
	}

	public static void Divide(ref TSVector value1, FP scaleFactor, out TSVector result)
	{
		result.x = value1.x / scaleFactor;
		result.y = value1.y / scaleFactor;
		result.z = value1.z / scaleFactor;
	}

	public static TSVector Subtract(TSVector value1, TSVector value2)
	{
		Subtract(ref value1, ref value2, out var result);
		return result;
	}

	public static void Subtract(ref TSVector value1, ref TSVector value2, out TSVector result)
	{
		FP fP = value1.x - value2.x;
		FP fP2 = value1.y - value2.y;
		FP fP3 = value1.z - value2.z;
		result.x = fP;
		result.y = fP2;
		result.z = fP3;
	}

	public static TSVector Cross(TSVector vector1, TSVector vector2)
	{
		Cross(ref vector1, ref vector2, out var result);
		return result;
	}

	public static void Cross(ref TSVector vector1, ref TSVector vector2, out TSVector result)
	{
		FP fP = vector1.y * vector2.z - vector1.z * vector2.y;
		FP fP2 = vector1.z * vector2.x - vector1.x * vector2.z;
		FP fP3 = vector1.x * vector2.y - vector1.y * vector2.x;
		result.x = fP;
		result.y = fP2;
		result.z = fP3;
	}

	public override int GetHashCode()
	{
		return x.GetHashCode() ^ y.GetHashCode() ^ z.GetHashCode();
	}

	public void Negate()
	{
		x = -x;
		y = -y;
		z = -z;
	}

	public static TSVector Negate(TSVector value)
	{
		Negate(ref value, out var result);
		return result;
	}

	public static void Negate(ref TSVector value, out TSVector result)
	{
		FP fP = -value.x;
		FP fP2 = -value.y;
		FP fP3 = -value.z;
		result.x = fP;
		result.y = fP2;
		result.z = fP3;
	}

	public static TSVector Normalize(TSVector value)
	{
		Normalize(ref value, out var result);
		return result;
	}

	public void Normalize()
	{
		FP fP = x * x + y * y + z * z;
		FP fP2 = FP.One / FP.Sqrt(fP);
		x *= fP2;
		y *= fP2;
		z *= fP2;
	}

	public static void Normalize(ref TSVector value, out TSVector result)
	{
		FP fP = value.x * value.x + value.y * value.y + value.z * value.z;
		FP fP2 = FP.One / FP.Sqrt(fP);
		result.x = value.x * fP2;
		result.y = value.y * fP2;
		result.z = value.z * fP2;
	}

	public static void Swap(ref TSVector vector1, ref TSVector vector2)
	{
		FP fP = vector1.x;
		vector1.x = vector2.x;
		vector2.x = fP;
		fP = vector1.y;
		vector1.y = vector2.y;
		vector2.y = fP;
		fP = vector1.z;
		vector1.z = vector2.z;
		vector2.z = fP;
	}

	public static TSVector Multiply(TSVector value1, FP scaleFactor)
	{
		Multiply(ref value1, scaleFactor, out var result);
		return result;
	}

	public static void Multiply(ref TSVector value1, FP scaleFactor, out TSVector result)
	{
		result.x = value1.x * scaleFactor;
		result.y = value1.y * scaleFactor;
		result.z = value1.z * scaleFactor;
	}

	public static TSVector operator %(TSVector value1, TSVector value2)
	{
		Cross(ref value1, ref value2, out var result);
		return result;
	}

	public static FP operator *(TSVector value1, TSVector value2)
	{
		return Dot(ref value1, ref value2);
	}

	public static TSVector operator *(TSVector value1, FP value2)
	{
		Multiply(ref value1, value2, out var result);
		return result;
	}

	public static TSVector operator *(FP value1, TSVector value2)
	{
		Multiply(ref value2, value1, out var result);
		return result;
	}

	public static TSVector operator -(TSVector value1, TSVector value2)
	{
		Subtract(ref value1, ref value2, out var result);
		return result;
	}

	public static TSVector operator +(TSVector value1, TSVector value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static TSVector operator /(TSVector value1, FP value2)
	{
		Divide(ref value1, value2, out var result);
		return result;
	}

	public static FP Angle(TSVector a, TSVector b)
	{
		return FP.Acos(a.normalized * b.normalized) * FP.Rad2Deg;
	}

	public TSVector2 ToTSVector2()
	{
		return new TSVector2(x, y);
	}
}
