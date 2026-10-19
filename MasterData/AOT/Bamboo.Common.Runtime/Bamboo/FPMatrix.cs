using System;

namespace Bamboo;

public struct FPMatrix
{
	public FPFloat M11;

	public FPFloat M12;

	public FPFloat M13;

	public FPFloat M21;

	public FPFloat M22;

	public FPFloat M23;

	public FPFloat M31;

	public FPFloat M32;

	public FPFloat M33;

	internal static FPMatrix InternalIdentity;

	public static FPMatrix Identity;

	public static readonly FPMatrix Zero;

	public FPVector3 EulerAngles => new FPVector3
	{
		X = FPMath.Atan2(M32, M33) * FPFloat.Rad2Deg,
		Y = FPMath.Atan2(-M31, FPMath.Sqrt(M32 * M32 + M33 * M33)) * FPFloat.Rad2Deg,
		Z = FPMath.Atan2(M21, M11) * FPFloat.Rad2Deg
	} * -1;

	static FPMatrix()
	{
		Zero = default;
		Identity = default;
		Identity.M11 = FPFloat.One;
		Identity.M22 = FPFloat.One;
		Identity.M33 = FPFloat.One;
		InternalIdentity = Identity;
	}

	public static FPMatrix CreateFromYawPitchRoll(FPFloat yaw, FPFloat pitch, FPFloat roll)
	{
		FPQuaternion.CreateFromYawPitchRoll(yaw, pitch, roll, out var result);
		CreateFromQuaternion(ref result, out var result2);
		return result2;
	}

	public static FPMatrix CreateRotationX(FPFloat radians)
	{
		FPFloat fPFloat = FPFloat.Cos(radians);
		FPFloat fPFloat2 = FPFloat.Sin(radians);
		FPMatrix result = default;
		result.M11 = FPFloat.One;
		result.M12 = FPFloat.Zero;
		result.M13 = FPFloat.Zero;
		result.M21 = FPFloat.Zero;
		result.M22 = fPFloat;
		result.M23 = fPFloat2;
		result.M31 = FPFloat.Zero;
		result.M32 = -fPFloat2;
		result.M33 = fPFloat;
		return result;
	}

	public static void CreateRotationX(FPFloat radians, out FPMatrix result)
	{
		FPFloat fPFloat = FPFloat.Cos(radians);
		FPFloat fPFloat2 = FPFloat.Sin(radians);
		result.M11 = FPFloat.One;
		result.M12 = FPFloat.Zero;
		result.M13 = FPFloat.Zero;
		result.M21 = FPFloat.Zero;
		result.M22 = fPFloat;
		result.M23 = fPFloat2;
		result.M31 = FPFloat.Zero;
		result.M32 = -fPFloat2;
		result.M33 = fPFloat;
	}

	public static FPMatrix CreateRotationY(FPFloat radians)
	{
		FPFloat fPFloat = FPFloat.Cos(radians);
		FPFloat fPFloat2 = FPFloat.Sin(radians);
		FPMatrix result = default;
		result.M11 = fPFloat;
		result.M12 = FPFloat.Zero;
		result.M13 = -fPFloat2;
		result.M21 = FPFloat.Zero;
		result.M22 = FPFloat.One;
		result.M23 = FPFloat.Zero;
		result.M31 = fPFloat2;
		result.M32 = FPFloat.Zero;
		result.M33 = fPFloat;
		return result;
	}

	public static void CreateRotationY(FPFloat radians, out FPMatrix result)
	{
		FPFloat fPFloat = FPFloat.Cos(radians);
		FPFloat fPFloat2 = FPFloat.Sin(radians);
		result.M11 = fPFloat;
		result.M12 = FPFloat.Zero;
		result.M13 = -fPFloat2;
		result.M21 = FPFloat.Zero;
		result.M22 = FPFloat.One;
		result.M23 = FPFloat.Zero;
		result.M31 = fPFloat2;
		result.M32 = FPFloat.Zero;
		result.M33 = fPFloat;
	}

	public static FPMatrix CreateRotationZ(FPFloat radians)
	{
		FPFloat fPFloat = FPFloat.Cos(radians);
		FPFloat fPFloat2 = FPFloat.Sin(radians);
		FPMatrix result = default;
		result.M11 = fPFloat;
		result.M12 = fPFloat2;
		result.M13 = FPFloat.Zero;
		result.M21 = -fPFloat2;
		result.M22 = fPFloat;
		result.M23 = FPFloat.Zero;
		result.M31 = FPFloat.Zero;
		result.M32 = FPFloat.Zero;
		result.M33 = FPFloat.One;
		return result;
	}

	public static void CreateRotationZ(FPFloat radians, out FPMatrix result)
	{
		FPFloat fPFloat = FPFloat.Cos(radians);
		FPFloat fPFloat2 = FPFloat.Sin(radians);
		result.M11 = fPFloat;
		result.M12 = fPFloat2;
		result.M13 = FPFloat.Zero;
		result.M21 = -fPFloat2;
		result.M22 = fPFloat;
		result.M23 = FPFloat.Zero;
		result.M31 = FPFloat.Zero;
		result.M32 = FPFloat.Zero;
		result.M33 = FPFloat.One;
	}

	public FPMatrix(FPFloat m11, FPFloat m12, FPFloat m13, FPFloat m21, FPFloat m22, FPFloat m23, FPFloat m31, FPFloat m32, FPFloat m33)
	{
		M11 = m11;
		M12 = m12;
		M13 = m13;
		M21 = m21;
		M22 = m22;
		M23 = m23;
		M31 = m31;
		M32 = m32;
		M33 = m33;
	}

	public static FPMatrix Multiply(FPMatrix matrix1, FPMatrix matrix2)
	{
		Multiply(ref matrix1, ref matrix2, out var result);
		return result;
	}

	public static void Multiply(ref FPMatrix matrix1, ref FPMatrix matrix2, out FPMatrix result)
	{
		FPFloat m = matrix1.M11 * matrix2.M11 + matrix1.M12 * matrix2.M21 + matrix1.M13 * matrix2.M31;
		FPFloat m2 = matrix1.M11 * matrix2.M12 + matrix1.M12 * matrix2.M22 + matrix1.M13 * matrix2.M32;
		FPFloat m3 = matrix1.M11 * matrix2.M13 + matrix1.M12 * matrix2.M23 + matrix1.M13 * matrix2.M33;
		FPFloat m4 = matrix1.M21 * matrix2.M11 + matrix1.M22 * matrix2.M21 + matrix1.M23 * matrix2.M31;
		FPFloat m5 = matrix1.M21 * matrix2.M12 + matrix1.M22 * matrix2.M22 + matrix1.M23 * matrix2.M32;
		FPFloat m6 = matrix1.M21 * matrix2.M13 + matrix1.M22 * matrix2.M23 + matrix1.M23 * matrix2.M33;
		FPFloat m7 = matrix1.M31 * matrix2.M11 + matrix1.M32 * matrix2.M21 + matrix1.M33 * matrix2.M31;
		FPFloat m8 = matrix1.M31 * matrix2.M12 + matrix1.M32 * matrix2.M22 + matrix1.M33 * matrix2.M32;
		FPFloat m9 = matrix1.M31 * matrix2.M13 + matrix1.M32 * matrix2.M23 + matrix1.M33 * matrix2.M33;
		result.M11 = m;
		result.M12 = m2;
		result.M13 = m3;
		result.M21 = m4;
		result.M22 = m5;
		result.M23 = m6;
		result.M31 = m7;
		result.M32 = m8;
		result.M33 = m9;
	}

	public static FPMatrix Add(FPMatrix matrix1, FPMatrix matrix2)
	{
		Add(ref matrix1, ref matrix2, out var result);
		return result;
	}

	public static void Add(ref FPMatrix matrix1, ref FPMatrix matrix2, out FPMatrix result)
	{
		result.M11 = matrix1.M11 + matrix2.M11;
		result.M12 = matrix1.M12 + matrix2.M12;
		result.M13 = matrix1.M13 + matrix2.M13;
		result.M21 = matrix1.M21 + matrix2.M21;
		result.M22 = matrix1.M22 + matrix2.M22;
		result.M23 = matrix1.M23 + matrix2.M23;
		result.M31 = matrix1.M31 + matrix2.M31;
		result.M32 = matrix1.M32 + matrix2.M32;
		result.M33 = matrix1.M33 + matrix2.M33;
	}

	public static FPMatrix Inverse(FPMatrix matrix)
	{
		Inverse(ref matrix, out var result);
		return result;
	}

	public FPFloat Determinant()
	{
		return M11 * M22 * M33 + M12 * M23 * M31 + M13 * M21 * M32 - M31 * M22 * M13 - M32 * M23 * M11 - M33 * M21 * M12;
	}

	public static void Invert(ref FPMatrix matrix, out FPMatrix result)
	{
		FPFloat fPFloat = 1 / matrix.Determinant();
		FPFloat m = (matrix.M22 * matrix.M33 - matrix.M23 * matrix.M32) * fPFloat;
		FPFloat m2 = (matrix.M13 * matrix.M32 - matrix.M33 * matrix.M12) * fPFloat;
		FPFloat m3 = (matrix.M12 * matrix.M23 - matrix.M22 * matrix.M13) * fPFloat;
		FPFloat m4 = (matrix.M23 * matrix.M31 - matrix.M21 * matrix.M33) * fPFloat;
		FPFloat m5 = (matrix.M11 * matrix.M33 - matrix.M13 * matrix.M31) * fPFloat;
		FPFloat m6 = (matrix.M13 * matrix.M21 - matrix.M11 * matrix.M23) * fPFloat;
		FPFloat m7 = (matrix.M21 * matrix.M32 - matrix.M22 * matrix.M31) * fPFloat;
		FPFloat m8 = (matrix.M12 * matrix.M31 - matrix.M11 * matrix.M32) * fPFloat;
		FPFloat m9 = (matrix.M11 * matrix.M22 - matrix.M12 * matrix.M21) * fPFloat;
		result.M11 = m;
		result.M12 = m2;
		result.M13 = m3;
		result.M21 = m4;
		result.M22 = m5;
		result.M23 = m6;
		result.M31 = m7;
		result.M32 = m8;
		result.M33 = m9;
	}

	public static void Inverse(ref FPMatrix matrix, out FPMatrix result)
	{
		FPFloat fPFloat = 1024 * matrix.M11 * matrix.M22 * matrix.M33 - 1024 * matrix.M11 * matrix.M23 * matrix.M32 - 1024 * matrix.M12 * matrix.M21 * matrix.M33 + 1024 * matrix.M12 * matrix.M23 * matrix.M31 + 1024 * matrix.M13 * matrix.M21 * matrix.M32 - 1024 * matrix.M13 * matrix.M22 * matrix.M31;
		FPFloat fPFloat2 = 1024 * matrix.M22 * matrix.M33 - 1024 * matrix.M23 * matrix.M32;
		FPFloat fPFloat3 = 1024 * matrix.M13 * matrix.M32 - 1024 * matrix.M12 * matrix.M33;
		FPFloat fPFloat4 = 1024 * matrix.M12 * matrix.M23 - 1024 * matrix.M22 * matrix.M13;
		FPFloat fPFloat5 = 1024 * matrix.M23 * matrix.M31 - 1024 * matrix.M33 * matrix.M21;
		FPFloat fPFloat6 = 1024 * matrix.M11 * matrix.M33 - 1024 * matrix.M31 * matrix.M13;
		FPFloat fPFloat7 = 1024 * matrix.M13 * matrix.M21 - 1024 * matrix.M23 * matrix.M11;
		FPFloat fPFloat8 = 1024 * matrix.M21 * matrix.M32 - 1024 * matrix.M31 * matrix.M22;
		FPFloat fPFloat9 = 1024 * matrix.M12 * matrix.M31 - 1024 * matrix.M32 * matrix.M11;
		FPFloat fPFloat10 = 1024 * matrix.M11 * matrix.M22 - 1024 * matrix.M21 * matrix.M12;
		if (fPFloat == 0)
		{
			result.M11 = FPFloat.PositiveInfinity;
			result.M12 = FPFloat.PositiveInfinity;
			result.M13 = FPFloat.PositiveInfinity;
			result.M21 = FPFloat.PositiveInfinity;
			result.M22 = FPFloat.PositiveInfinity;
			result.M23 = FPFloat.PositiveInfinity;
			result.M31 = FPFloat.PositiveInfinity;
			result.M32 = FPFloat.PositiveInfinity;
			result.M33 = FPFloat.PositiveInfinity;
		}
		else
		{
			result.M11 = fPFloat2 / fPFloat;
			result.M12 = fPFloat3 / fPFloat;
			result.M13 = fPFloat4 / fPFloat;
			result.M21 = fPFloat5 / fPFloat;
			result.M22 = fPFloat6 / fPFloat;
			result.M23 = fPFloat7 / fPFloat;
			result.M31 = fPFloat8 / fPFloat;
			result.M32 = fPFloat9 / fPFloat;
			result.M33 = fPFloat10 / fPFloat;
		}
	}

	public static FPMatrix Multiply(FPMatrix matrix1, FPFloat scaleFactor)
	{
		Multiply(ref matrix1, scaleFactor, out var result);
		return result;
	}

	public static void Multiply(ref FPMatrix matrix1, FPFloat scaleFactor, out FPMatrix result)
	{
		result.M11 = matrix1.M11 * scaleFactor;
		result.M12 = matrix1.M12 * scaleFactor;
		result.M13 = matrix1.M13 * scaleFactor;
		result.M21 = matrix1.M21 * scaleFactor;
		result.M22 = matrix1.M22 * scaleFactor;
		result.M23 = matrix1.M23 * scaleFactor;
		result.M31 = matrix1.M31 * scaleFactor;
		result.M32 = matrix1.M32 * scaleFactor;
		result.M33 = matrix1.M33 * scaleFactor;
	}

	public static FPMatrix CreateFromLookAt(FPVector3 position, FPVector3 target)
	{
		LookAt(target - position, FPVector3.Up, out var result);
		return result;
	}

	public static FPMatrix LookAt(FPVector3 forward, FPVector3 upwards)
	{
		LookAt(forward, upwards, out var result);
		return result;
	}

	public static void LookAt(FPVector3 forward, FPVector3 upwards, out FPMatrix result)
	{
		FPVector3 fPVector = forward;
		fPVector.Normalize();
		FPVector3 vector = FPVector3.Cross(upwards, fPVector);
		vector.Normalize();
		FPVector3 fPVector2 = FPVector3.Cross(fPVector, vector);
		result.M11 = vector.X;
		result.M21 = fPVector2.X;
		result.M31 = fPVector.X;
		result.M12 = vector.Y;
		result.M22 = fPVector2.Y;
		result.M32 = fPVector.Y;
		result.M13 = vector.Z;
		result.M23 = fPVector2.Z;
		result.M33 = fPVector.Z;
	}

	public static FPMatrix CreateFromQuaternion(FPQuaternion quaternion)
	{
		CreateFromQuaternion(ref quaternion, out var result);
		return result;
	}

	public static void CreateFromQuaternion(ref FPQuaternion quaternion, out FPMatrix result)
	{
		FPFloat fPFloat = quaternion.X * quaternion.X;
		FPFloat fPFloat2 = quaternion.Y * quaternion.Y;
		FPFloat fPFloat3 = quaternion.Z * quaternion.Z;
		FPFloat fPFloat4 = quaternion.X * quaternion.Y;
		FPFloat fPFloat5 = quaternion.Z * quaternion.W;
		FPFloat fPFloat6 = quaternion.Z * quaternion.X;
		FPFloat fPFloat7 = quaternion.Y * quaternion.W;
		FPFloat fPFloat8 = quaternion.Y * quaternion.Z;
		FPFloat fPFloat9 = quaternion.X * quaternion.W;
		result.M11 = FPFloat.One - 2 * (fPFloat2 + fPFloat3);
		result.M12 = 2 * (fPFloat4 + fPFloat5);
		result.M13 = 2 * (fPFloat6 - fPFloat7);
		result.M21 = 2 * (fPFloat4 - fPFloat5);
		result.M22 = FPFloat.One - 2 * (fPFloat3 + fPFloat);
		result.M23 = 2 * (fPFloat8 + fPFloat9);
		result.M31 = 2 * (fPFloat6 + fPFloat7);
		result.M32 = 2 * (fPFloat8 - fPFloat9);
		result.M33 = FPFloat.One - 2 * (fPFloat2 + fPFloat);
	}

	public static FPMatrix Transpose(FPMatrix matrix)
	{
		Transpose(ref matrix, out var result);
		return result;
	}

	public static void Transpose(ref FPMatrix matrix, out FPMatrix result)
	{
		result.M11 = matrix.M11;
		result.M12 = matrix.M21;
		result.M13 = matrix.M31;
		result.M21 = matrix.M12;
		result.M22 = matrix.M22;
		result.M23 = matrix.M32;
		result.M31 = matrix.M13;
		result.M32 = matrix.M23;
		result.M33 = matrix.M33;
	}

	public static FPMatrix operator *(FPMatrix value1, FPMatrix value2)
	{
		Multiply(ref value1, ref value2, out var result);
		return result;
	}

	public FPFloat Trace()
	{
		return M11 + M22 + M33;
	}

	public static FPMatrix operator +(FPMatrix value1, FPMatrix value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static FPMatrix operator -(FPMatrix value1, FPMatrix value2)
	{
		Multiply(ref value2, -FPFloat.One, out value2);
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static bool operator ==(FPMatrix value1, FPMatrix value2)
	{
		if (value1.M11 == value2.M11 && value1.M12 == value2.M12 && value1.M13 == value2.M13 && value1.M21 == value2.M21 && value1.M22 == value2.M22 && value1.M23 == value2.M23 && value1.M31 == value2.M31 && value1.M32 == value2.M32)
		{
			return value1.M33 == value2.M33;
		}
		return false;
	}

	public static bool operator !=(FPMatrix value1, FPMatrix value2)
	{
		if (!(value1.M11 != value2.M11) && !(value1.M12 != value2.M12) && !(value1.M13 != value2.M13) && !(value1.M21 != value2.M21) && !(value1.M22 != value2.M22) && !(value1.M23 != value2.M23) && !(value1.M31 != value2.M31) && !(value1.M32 != value2.M32))
		{
			return value1.M33 != value2.M33;
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is FPMatrix fPMatrix))
		{
			return false;
		}
		if (M11 == fPMatrix.M11 && M12 == fPMatrix.M12 && M13 == fPMatrix.M13 && M21 == fPMatrix.M21 && M22 == fPMatrix.M22 && M23 == fPMatrix.M23 && M31 == fPMatrix.M31 && M32 == fPMatrix.M32)
		{
			return M33 == fPMatrix.M33;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return M11.GetHashCode() ^ M12.GetHashCode() ^ M13.GetHashCode() ^ M21.GetHashCode() ^ M22.GetHashCode() ^ M23.GetHashCode() ^ M31.GetHashCode() ^ M32.GetHashCode() ^ M33.GetHashCode();
	}

	public static void CreateFromAxisAngle(ref FPVector3 axis, FPFloat angle, out FPMatrix result)
	{
		FPFloat x = axis.X;
		FPFloat y = axis.Y;
		FPFloat z = axis.Z;
		FPFloat fPFloat = FPFloat.Sin(angle);
		FPFloat fPFloat2 = FPFloat.Cos(angle);
		FPFloat fPFloat3 = x * x;
		FPFloat fPFloat4 = y * y;
		FPFloat fPFloat5 = z * z;
		FPFloat fPFloat6 = x * y;
		FPFloat fPFloat7 = x * z;
		FPFloat fPFloat8 = y * z;
		result.M11 = fPFloat3 + fPFloat2 * (FPFloat.One - fPFloat3);
		result.M12 = fPFloat6 - fPFloat2 * fPFloat6 + fPFloat * z;
		result.M13 = fPFloat7 - fPFloat2 * fPFloat7 - fPFloat * y;
		result.M21 = fPFloat6 - fPFloat2 * fPFloat6 - fPFloat * z;
		result.M22 = fPFloat4 + fPFloat2 * (FPFloat.One - fPFloat4);
		result.M23 = fPFloat8 - fPFloat2 * fPFloat8 + fPFloat * x;
		result.M31 = fPFloat7 - fPFloat2 * fPFloat7 + fPFloat * y;
		result.M32 = fPFloat8 - fPFloat2 * fPFloat8 - fPFloat * x;
		result.M33 = fPFloat5 + fPFloat2 * (FPFloat.One - fPFloat5);
	}

	public static FPMatrix AngleAxis(FPFloat angle, FPVector3 axis)
	{
		CreateFromAxisAngle(ref axis, angle, out var result);
		return result;
	}

	public override string ToString()
	{
		return $"{M11.RawValue}|{M12.RawValue}|{M13.RawValue}|{M21.RawValue}|{M22.RawValue}|{M23.RawValue}|{M31.RawValue}|{M32.RawValue}|{M33.RawValue}";
	}

	public FPFloat GetValue(int i, int j)
	{
		switch (i)
		{
		case 1:
			switch (j)
			{
			case 1:
				return M11;
			case 2:
				return M12;
			case 3:
				return M13;
			}
			break;
		case 2:
			switch (j)
			{
			case 1:
				return M21;
			case 2:
				return M22;
			case 3:
				return M23;
			}
			break;
		case 3:
			switch (j)
			{
			case 1:
				return M31;
			case 2:
				return M32;
			case 3:
				return M33;
			}
			break;
		}
		throw new ArgumentOutOfRangeException("i,j is not right [1,3]", $"{i},{j}");
	}
}
