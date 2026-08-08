namespace FixedPoint;

public struct TSMatrix
{
	public FP M11;

	public FP M12;

	public FP M13;

	public FP M21;

	public FP M22;

	public FP M23;

	public FP M31;

	public FP M32;

	public FP M33;

	internal static TSMatrix InternalIdentity;

	public static readonly TSMatrix Identity;

	public static readonly TSMatrix Zero;

	public TSVector eulerAngles => new TSVector
	{
		x = TSMath.Atan2(M32, M33) * FP.Rad2Deg,
		y = TSMath.Atan2(-M31, TSMath.Sqrt(M32 * M32 + M33 * M33)) * FP.Rad2Deg,
		z = TSMath.Atan2(M21, M11) * FP.Rad2Deg
	} * -1;

	static TSMatrix()
	{
		Zero = default(TSMatrix);
		Identity = default(TSMatrix);
		Identity.M11 = FP.One;
		Identity.M22 = FP.One;
		Identity.M33 = FP.One;
		InternalIdentity = Identity;
	}

	public static TSMatrix CreateFromYawPitchRoll(FP yaw, FP pitch, FP roll)
	{
		TSQuaternion.CreateFromYawPitchRoll(yaw, pitch, roll, out var result);
		CreateFromQuaternion(ref result, out var result2);
		return result2;
	}

	public static TSMatrix CreateRotationX(FP radians)
	{
		FP fP = FP.Cos(radians);
		FP fP2 = FP.Sin(radians);
		TSMatrix result = default(TSMatrix);
		result.M11 = FP.One;
		result.M12 = FP.Zero;
		result.M13 = FP.Zero;
		result.M21 = FP.Zero;
		result.M22 = fP;
		result.M23 = fP2;
		result.M31 = FP.Zero;
		result.M32 = -fP2;
		result.M33 = fP;
		return result;
	}

	public static void CreateRotationX(FP radians, out TSMatrix result)
	{
		FP fP = FP.Cos(radians);
		FP fP2 = FP.Sin(radians);
		result.M11 = FP.One;
		result.M12 = FP.Zero;
		result.M13 = FP.Zero;
		result.M21 = FP.Zero;
		result.M22 = fP;
		result.M23 = fP2;
		result.M31 = FP.Zero;
		result.M32 = -fP2;
		result.M33 = fP;
	}

	public static TSMatrix CreateRotationY(FP radians)
	{
		FP fP = FP.Cos(radians);
		FP fP2 = FP.Sin(radians);
		TSMatrix result = default(TSMatrix);
		result.M11 = fP;
		result.M12 = FP.Zero;
		result.M13 = -fP2;
		result.M21 = FP.Zero;
		result.M22 = FP.One;
		result.M23 = FP.Zero;
		result.M31 = fP2;
		result.M32 = FP.Zero;
		result.M33 = fP;
		return result;
	}

	public static void CreateRotationY(FP radians, out TSMatrix result)
	{
		FP fP = FP.Cos(radians);
		FP fP2 = FP.Sin(radians);
		result.M11 = fP;
		result.M12 = FP.Zero;
		result.M13 = -fP2;
		result.M21 = FP.Zero;
		result.M22 = FP.One;
		result.M23 = FP.Zero;
		result.M31 = fP2;
		result.M32 = FP.Zero;
		result.M33 = fP;
	}

	public static TSMatrix CreateRotationZ(FP radians)
	{
		FP fP = FP.Cos(radians);
		FP fP2 = FP.Sin(radians);
		TSMatrix result = default(TSMatrix);
		result.M11 = fP;
		result.M12 = fP2;
		result.M13 = FP.Zero;
		result.M21 = -fP2;
		result.M22 = fP;
		result.M23 = FP.Zero;
		result.M31 = FP.Zero;
		result.M32 = FP.Zero;
		result.M33 = FP.One;
		return result;
	}

	public static void CreateRotationZ(FP radians, out TSMatrix result)
	{
		FP fP = FP.Cos(radians);
		FP fP2 = FP.Sin(radians);
		result.M11 = fP;
		result.M12 = fP2;
		result.M13 = FP.Zero;
		result.M21 = -fP2;
		result.M22 = fP;
		result.M23 = FP.Zero;
		result.M31 = FP.Zero;
		result.M32 = FP.Zero;
		result.M33 = FP.One;
	}

	public TSMatrix(FP m11, FP m12, FP m13, FP m21, FP m22, FP m23, FP m31, FP m32, FP m33)
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

	public static TSMatrix Multiply(TSMatrix matrix1, TSMatrix matrix2)
	{
		Multiply(ref matrix1, ref matrix2, out var result);
		return result;
	}

	public static void Multiply(ref TSMatrix matrix1, ref TSMatrix matrix2, out TSMatrix result)
	{
		FP m = matrix1.M11 * matrix2.M11 + matrix1.M12 * matrix2.M21 + matrix1.M13 * matrix2.M31;
		FP m2 = matrix1.M11 * matrix2.M12 + matrix1.M12 * matrix2.M22 + matrix1.M13 * matrix2.M32;
		FP m3 = matrix1.M11 * matrix2.M13 + matrix1.M12 * matrix2.M23 + matrix1.M13 * matrix2.M33;
		FP m4 = matrix1.M21 * matrix2.M11 + matrix1.M22 * matrix2.M21 + matrix1.M23 * matrix2.M31;
		FP m5 = matrix1.M21 * matrix2.M12 + matrix1.M22 * matrix2.M22 + matrix1.M23 * matrix2.M32;
		FP m6 = matrix1.M21 * matrix2.M13 + matrix1.M22 * matrix2.M23 + matrix1.M23 * matrix2.M33;
		FP m7 = matrix1.M31 * matrix2.M11 + matrix1.M32 * matrix2.M21 + matrix1.M33 * matrix2.M31;
		FP m8 = matrix1.M31 * matrix2.M12 + matrix1.M32 * matrix2.M22 + matrix1.M33 * matrix2.M32;
		FP m9 = matrix1.M31 * matrix2.M13 + matrix1.M32 * matrix2.M23 + matrix1.M33 * matrix2.M33;
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

	public static TSMatrix Add(TSMatrix matrix1, TSMatrix matrix2)
	{
		Add(ref matrix1, ref matrix2, out var result);
		return result;
	}

	public static void Add(ref TSMatrix matrix1, ref TSMatrix matrix2, out TSMatrix result)
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

	public static TSMatrix Inverse(TSMatrix matrix)
	{
		Inverse(ref matrix, out var result);
		return result;
	}

	public FP Determinant()
	{
		return M11 * M22 * M33 + M12 * M23 * M31 + M13 * M21 * M32 - M31 * M22 * M13 - M32 * M23 * M11 - M33 * M21 * M12;
	}

	public static void Invert(ref TSMatrix matrix, out TSMatrix result)
	{
		FP fP = 1 / matrix.Determinant();
		FP m = (matrix.M22 * matrix.M33 - matrix.M23 * matrix.M32) * fP;
		FP m2 = (matrix.M13 * matrix.M32 - matrix.M33 * matrix.M12) * fP;
		FP m3 = (matrix.M12 * matrix.M23 - matrix.M22 * matrix.M13) * fP;
		FP m4 = (matrix.M23 * matrix.M31 - matrix.M21 * matrix.M33) * fP;
		FP m5 = (matrix.M11 * matrix.M33 - matrix.M13 * matrix.M31) * fP;
		FP m6 = (matrix.M13 * matrix.M21 - matrix.M11 * matrix.M23) * fP;
		FP m7 = (matrix.M21 * matrix.M32 - matrix.M22 * matrix.M31) * fP;
		FP m8 = (matrix.M12 * matrix.M31 - matrix.M11 * matrix.M32) * fP;
		FP m9 = (matrix.M11 * matrix.M22 - matrix.M12 * matrix.M21) * fP;
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

	public static void Inverse(ref TSMatrix matrix, out TSMatrix result)
	{
		FP fP = 1024 * matrix.M11 * matrix.M22 * matrix.M33 - 1024 * matrix.M11 * matrix.M23 * matrix.M32 - 1024 * matrix.M12 * matrix.M21 * matrix.M33 + 1024 * matrix.M12 * matrix.M23 * matrix.M31 + 1024 * matrix.M13 * matrix.M21 * matrix.M32 - 1024 * matrix.M13 * matrix.M22 * matrix.M31;
		FP fP2 = 1024 * matrix.M22 * matrix.M33 - 1024 * matrix.M23 * matrix.M32;
		FP fP3 = 1024 * matrix.M13 * matrix.M32 - 1024 * matrix.M12 * matrix.M33;
		FP fP4 = 1024 * matrix.M12 * matrix.M23 - 1024 * matrix.M22 * matrix.M13;
		FP fP5 = 1024 * matrix.M23 * matrix.M31 - 1024 * matrix.M33 * matrix.M21;
		FP fP6 = 1024 * matrix.M11 * matrix.M33 - 1024 * matrix.M31 * matrix.M13;
		FP fP7 = 1024 * matrix.M13 * matrix.M21 - 1024 * matrix.M23 * matrix.M11;
		FP fP8 = 1024 * matrix.M21 * matrix.M32 - 1024 * matrix.M31 * matrix.M22;
		FP fP9 = 1024 * matrix.M12 * matrix.M31 - 1024 * matrix.M32 * matrix.M11;
		FP fP10 = 1024 * matrix.M11 * matrix.M22 - 1024 * matrix.M21 * matrix.M12;
		if (fP == 0)
		{
			result.M11 = FP.PositiveInfinity;
			result.M12 = FP.PositiveInfinity;
			result.M13 = FP.PositiveInfinity;
			result.M21 = FP.PositiveInfinity;
			result.M22 = FP.PositiveInfinity;
			result.M23 = FP.PositiveInfinity;
			result.M31 = FP.PositiveInfinity;
			result.M32 = FP.PositiveInfinity;
			result.M33 = FP.PositiveInfinity;
		}
		else
		{
			result.M11 = fP2 / fP;
			result.M12 = fP3 / fP;
			result.M13 = fP4 / fP;
			result.M21 = fP5 / fP;
			result.M22 = fP6 / fP;
			result.M23 = fP7 / fP;
			result.M31 = fP8 / fP;
			result.M32 = fP9 / fP;
			result.M33 = fP10 / fP;
		}
	}

	public static TSMatrix Multiply(TSMatrix matrix1, FP scaleFactor)
	{
		Multiply(ref matrix1, scaleFactor, out var result);
		return result;
	}

	public static void Multiply(ref TSMatrix matrix1, FP scaleFactor, out TSMatrix result)
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

	public static TSMatrix CreateFromLookAt(TSVector position, TSVector target)
	{
		LookAt(target - position, TSVector.up, out var result);
		return result;
	}

	public static TSMatrix LookAt(TSVector forward, TSVector upwards)
	{
		LookAt(forward, upwards, out var result);
		return result;
	}

	public static void LookAt(TSVector forward, TSVector upwards, out TSMatrix result)
	{
		TSVector tSVector = forward;
		tSVector.Normalize();
		TSVector vector = TSVector.Cross(upwards, tSVector);
		vector.Normalize();
		TSVector tSVector2 = TSVector.Cross(tSVector, vector);
		result.M11 = vector.x;
		result.M21 = tSVector2.x;
		result.M31 = tSVector.x;
		result.M12 = vector.y;
		result.M22 = tSVector2.y;
		result.M32 = tSVector.y;
		result.M13 = vector.z;
		result.M23 = tSVector2.z;
		result.M33 = tSVector.z;
	}

	public static TSMatrix CreateFromQuaternion(TSQuaternion quaternion)
	{
		CreateFromQuaternion(ref quaternion, out var result);
		return result;
	}

	public static void CreateFromQuaternion(ref TSQuaternion quaternion, out TSMatrix result)
	{
		FP fP = quaternion.x * quaternion.x;
		FP fP2 = quaternion.y * quaternion.y;
		FP fP3 = quaternion.z * quaternion.z;
		FP fP4 = quaternion.x * quaternion.y;
		FP fP5 = quaternion.z * quaternion.w;
		FP fP6 = quaternion.z * quaternion.x;
		FP fP7 = quaternion.y * quaternion.w;
		FP fP8 = quaternion.y * quaternion.z;
		FP fP9 = quaternion.x * quaternion.w;
		result.M11 = FP.One - 2 * (fP2 + fP3);
		result.M12 = 2 * (fP4 + fP5);
		result.M13 = 2 * (fP6 - fP7);
		result.M21 = 2 * (fP4 - fP5);
		result.M22 = FP.One - 2 * (fP3 + fP);
		result.M23 = 2 * (fP8 + fP9);
		result.M31 = 2 * (fP6 + fP7);
		result.M32 = 2 * (fP8 - fP9);
		result.M33 = FP.One - 2 * (fP2 + fP);
	}

	public static TSMatrix Transpose(TSMatrix matrix)
	{
		Transpose(ref matrix, out var result);
		return result;
	}

	public static void Transpose(ref TSMatrix matrix, out TSMatrix result)
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

	public static TSMatrix operator *(TSMatrix value1, TSMatrix value2)
	{
		Multiply(ref value1, ref value2, out var result);
		return result;
	}

	public TSVector MultiplyVector(TSVector v)
	{
		TSVector result = default(TSVector);
		result.x = M11 * v.x + M12 * v.y + M13 * v.z;
		result.y = M21 * v.x + M22 * v.y + M23 * v.z;
		result.z = M31 * v.x + M32 * v.y + M33 * v.z;
		return result;
	}

	public FP Trace()
	{
		return M11 + M22 + M33;
	}

	public static TSMatrix operator +(TSMatrix value1, TSMatrix value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static TSMatrix operator -(TSMatrix value1, TSMatrix value2)
	{
		Multiply(ref value2, -FP.One, out value2);
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static bool operator ==(TSMatrix value1, TSMatrix value2)
	{
		if (value1.M11 == value2.M11 && value1.M12 == value2.M12 && value1.M13 == value2.M13 && value1.M21 == value2.M21 && value1.M22 == value2.M22 && value1.M23 == value2.M23 && value1.M31 == value2.M31 && value1.M32 == value2.M32)
		{
			return value1.M33 == value2.M33;
		}
		return false;
	}

	public static bool operator !=(TSMatrix value1, TSMatrix value2)
	{
		if (!(value1.M11 != value2.M11) && !(value1.M12 != value2.M12) && !(value1.M13 != value2.M13) && !(value1.M21 != value2.M21) && !(value1.M22 != value2.M22) && !(value1.M23 != value2.M23) && !(value1.M31 != value2.M31) && !(value1.M32 != value2.M32))
		{
			return value1.M33 != value2.M33;
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is TSMatrix tSMatrix))
		{
			return false;
		}
		if (M11 == tSMatrix.M11 && M12 == tSMatrix.M12 && M13 == tSMatrix.M13 && M21 == tSMatrix.M21 && M22 == tSMatrix.M22 && M23 == tSMatrix.M23 && M31 == tSMatrix.M31 && M32 == tSMatrix.M32)
		{
			return M33 == tSMatrix.M33;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return M11.GetHashCode() ^ M12.GetHashCode() ^ M13.GetHashCode() ^ M21.GetHashCode() ^ M22.GetHashCode() ^ M23.GetHashCode() ^ M31.GetHashCode() ^ M32.GetHashCode() ^ M33.GetHashCode();
	}

	public static void CreateFromAxisAngle(ref TSVector axis, FP angle, out TSMatrix result)
	{
		FP x = axis.x;
		FP y = axis.y;
		FP z = axis.z;
		FP fP = FP.Sin(angle);
		FP fP2 = FP.Cos(angle);
		FP fP3 = x * x;
		FP fP4 = y * y;
		FP fP5 = z * z;
		FP fP6 = x * y;
		FP fP7 = x * z;
		FP fP8 = y * z;
		result.M11 = fP3 + fP2 * (FP.One - fP3);
		result.M12 = fP6 - fP2 * fP6 + fP * z;
		result.M13 = fP7 - fP2 * fP7 - fP * y;
		result.M21 = fP6 - fP2 * fP6 - fP * z;
		result.M22 = fP4 + fP2 * (FP.One - fP4);
		result.M23 = fP8 - fP2 * fP8 + fP * x;
		result.M31 = fP7 - fP2 * fP7 + fP * y;
		result.M32 = fP8 - fP2 * fP8 - fP * x;
		result.M33 = fP5 + fP2 * (FP.One - fP5);
	}

	public static TSMatrix AngleAxis(FP angle, TSVector axis)
	{
		CreateFromAxisAngle(ref axis, angle, out var result);
		return result;
	}

	public override string ToString()
	{
		return $"{M11.RawValue}|{M12.RawValue}|{M13.RawValue}|{M21.RawValue}|{M22.RawValue}|{M23.RawValue}|{M31.RawValue}|{M32.RawValue}|{M33.RawValue}";
	}
}
