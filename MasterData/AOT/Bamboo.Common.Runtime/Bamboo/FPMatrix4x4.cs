using System;

namespace Bamboo;

public struct FPMatrix4x4
{
	public FPFloat M11;

	public FPFloat M12;

	public FPFloat M13;

	public FPFloat M14;

	public FPFloat M21;

	public FPFloat M22;

	public FPFloat M23;

	public FPFloat M24;

	public FPFloat M31;

	public FPFloat M32;

	public FPFloat M33;

	public FPFloat M34;

	public FPFloat M41;

	public FPFloat M42;

	public FPFloat M43;

	public FPFloat M44;

	internal static FPMatrix4x4 InternalIdentity;

	public static readonly FPMatrix4x4 Identity;

	public static readonly FPMatrix4x4 Zero;

	public FPFloat determinant
	{
		get
		{
			FPFloat m = M11;
			FPFloat m2 = M12;
			FPFloat m3 = M13;
			FPFloat m4 = M14;
			FPFloat m5 = M21;
			FPFloat m6 = M22;
			FPFloat m7 = M23;
			FPFloat m8 = M24;
			FPFloat m9 = M31;
			FPFloat m10 = M32;
			FPFloat m11 = M33;
			FPFloat m12 = M34;
			FPFloat m13 = M41;
			FPFloat m14 = M42;
			FPFloat m15 = M43;
			FPFloat m16 = M44;
			FPFloat fPFloat = m11 * m16 - m12 * m15;
			FPFloat fPFloat2 = m10 * m16 - m12 * m14;
			FPFloat fPFloat3 = m10 * m15 - m11 * m14;
			FPFloat fPFloat4 = m9 * m16 - m12 * m13;
			FPFloat fPFloat5 = m9 * m15 - m11 * m13;
			FPFloat fPFloat6 = m9 * m14 - m10 * m13;
			return m * (m6 * fPFloat - m7 * fPFloat2 + m8 * fPFloat3) - m2 * (m5 * fPFloat - m7 * fPFloat4 + m8 * fPFloat5) + m3 * (m5 * fPFloat2 - m6 * fPFloat4 + m8 * fPFloat6) - m4 * (m5 * fPFloat3 - m6 * fPFloat5 + m7 * fPFloat6);
		}
	}

	public FPFloat this[int row, int colum]
	{
		get
		{
			if (row == 1)
			{
				switch (colum)
				{
				case 1:
					return M11;
				case 2:
					return M12;
				case 3:
					return M13;
				case 4:
					return M14;
				}
			}
			if (row == 2)
			{
				switch (colum)
				{
				case 1:
					return M21;
				case 2:
					return M22;
				case 3:
					return M23;
				case 4:
					return M24;
				}
			}
			if (row == 3)
			{
				switch (colum)
				{
				case 1:
					return M31;
				case 2:
					return M32;
				case 3:
					return M33;
				case 4:
					return M34;
				}
			}
			if (row == 4)
			{
				return colum switch
				{
					1 => M41, 
					2 => M42, 
					3 => M43, 
					4 => M44, 
					_ => FPFloat.Zero, 
				};
			}
			throw new ArgumentOutOfRangeException("row,colum is not right [1,4]", $"{row},{colum}");
		}
		set
		{
			if (row == 1)
			{
				if (colum == 1)
				{
					M11 = value;
				}
				if (colum == 2)
				{
					M12 = value;
				}
				if (colum == 3)
				{
					M13 = value;
				}
				if (colum == 4)
				{
					M14 = value;
				}
			}
			if (row == 2)
			{
				if (colum == 1)
				{
					M21 = value;
				}
				if (colum == 2)
				{
					M22 = value;
				}
				if (colum == 3)
				{
					M23 = value;
				}
				if (colum == 4)
				{
					M24 = value;
				}
			}
			if (row == 3)
			{
				if (colum == 1)
				{
					M31 = value;
				}
				if (colum == 2)
				{
					M32 = value;
				}
				if (colum == 3)
				{
					M33 = value;
				}
				if (colum == 4)
				{
					M34 = value;
				}
			}
			if (row == 4)
			{
				if (colum == 1)
				{
					M41 = value;
				}
				if (colum == 2)
				{
					M42 = value;
				}
				if (colum == 3)
				{
					M43 = value;
				}
				if (colum == 4)
				{
					M44 = value;
				}
				return;
			}
			throw new ArgumentOutOfRangeException("row,colum is not right [1,4]", $"{row},{colum}");
		}
	}

	static FPMatrix4x4()
	{
		Zero = default;
		Identity = default;
		Identity.M11 = FPFloat.One;
		Identity.M22 = FPFloat.One;
		Identity.M33 = FPFloat.One;
		Identity.M44 = FPFloat.One;
		InternalIdentity = Identity;
	}

	public FPMatrix4x4(FPFloat m11, FPFloat m12, FPFloat m13, FPFloat m14, FPFloat m21, FPFloat m22, FPFloat m23, FPFloat m24, FPFloat m31, FPFloat m32, FPFloat m33, FPFloat m34, FPFloat m41, FPFloat m42, FPFloat m43, FPFloat m44)
	{
		M11 = m11;
		M12 = m12;
		M13 = m13;
		M14 = m14;
		M21 = m21;
		M22 = m22;
		M23 = m23;
		M24 = m24;
		M31 = m31;
		M32 = m32;
		M33 = m33;
		M34 = m34;
		M41 = m41;
		M42 = m42;
		M43 = m43;
		M44 = m44;
	}

	public static FPMatrix4x4 Multiply(FPMatrix4x4 matrix1, FPMatrix4x4 matrix2)
	{
		Multiply(ref matrix1, ref matrix2, out var result);
		return result;
	}

	public static void Multiply(ref FPMatrix4x4 matrix1, ref FPMatrix4x4 matrix2, out FPMatrix4x4 result)
	{
		result.M11 = matrix1.M11 * matrix2.M11 + matrix1.M12 * matrix2.M21 + matrix1.M13 * matrix2.M31 + matrix1.M14 * matrix2.M41;
		result.M12 = matrix1.M11 * matrix2.M12 + matrix1.M12 * matrix2.M22 + matrix1.M13 * matrix2.M32 + matrix1.M14 * matrix2.M42;
		result.M13 = matrix1.M11 * matrix2.M13 + matrix1.M12 * matrix2.M23 + matrix1.M13 * matrix2.M33 + matrix1.M14 * matrix2.M43;
		result.M14 = matrix1.M11 * matrix2.M14 + matrix1.M12 * matrix2.M24 + matrix1.M13 * matrix2.M34 + matrix1.M14 * matrix2.M44;
		result.M21 = matrix1.M21 * matrix2.M11 + matrix1.M22 * matrix2.M21 + matrix1.M23 * matrix2.M31 + matrix1.M24 * matrix2.M41;
		result.M22 = matrix1.M21 * matrix2.M12 + matrix1.M22 * matrix2.M22 + matrix1.M23 * matrix2.M32 + matrix1.M24 * matrix2.M42;
		result.M23 = matrix1.M21 * matrix2.M13 + matrix1.M22 * matrix2.M23 + matrix1.M23 * matrix2.M33 + matrix1.M24 * matrix2.M43;
		result.M24 = matrix1.M21 * matrix2.M14 + matrix1.M22 * matrix2.M24 + matrix1.M23 * matrix2.M34 + matrix1.M24 * matrix2.M44;
		result.M31 = matrix1.M31 * matrix2.M11 + matrix1.M32 * matrix2.M21 + matrix1.M33 * matrix2.M31 + matrix1.M34 * matrix2.M41;
		result.M32 = matrix1.M31 * matrix2.M12 + matrix1.M32 * matrix2.M22 + matrix1.M33 * matrix2.M32 + matrix1.M34 * matrix2.M42;
		result.M33 = matrix1.M31 * matrix2.M13 + matrix1.M32 * matrix2.M23 + matrix1.M33 * matrix2.M33 + matrix1.M34 * matrix2.M43;
		result.M34 = matrix1.M31 * matrix2.M14 + matrix1.M32 * matrix2.M24 + matrix1.M33 * matrix2.M34 + matrix1.M34 * matrix2.M44;
		result.M41 = matrix1.M41 * matrix2.M11 + matrix1.M42 * matrix2.M21 + matrix1.M43 * matrix2.M31 + matrix1.M44 * matrix2.M41;
		result.M42 = matrix1.M41 * matrix2.M12 + matrix1.M42 * matrix2.M22 + matrix1.M43 * matrix2.M32 + matrix1.M44 * matrix2.M42;
		result.M43 = matrix1.M41 * matrix2.M13 + matrix1.M42 * matrix2.M23 + matrix1.M43 * matrix2.M33 + matrix1.M44 * matrix2.M43;
		result.M44 = matrix1.M41 * matrix2.M14 + matrix1.M42 * matrix2.M24 + matrix1.M43 * matrix2.M34 + matrix1.M44 * matrix2.M44;
	}

	public static FPMatrix4x4 Add(FPMatrix4x4 matrix1, FPMatrix4x4 matrix2)
	{
		Add(ref matrix1, ref matrix2, out var result);
		return result;
	}

	public static void Add(ref FPMatrix4x4 matrix1, ref FPMatrix4x4 matrix2, out FPMatrix4x4 result)
	{
		result.M11 = matrix1.M11 + matrix2.M11;
		result.M12 = matrix1.M12 + matrix2.M12;
		result.M13 = matrix1.M13 + matrix2.M13;
		result.M14 = matrix1.M14 + matrix2.M14;
		result.M21 = matrix1.M21 + matrix2.M21;
		result.M22 = matrix1.M22 + matrix2.M22;
		result.M23 = matrix1.M23 + matrix2.M23;
		result.M24 = matrix1.M24 + matrix2.M24;
		result.M31 = matrix1.M31 + matrix2.M31;
		result.M32 = matrix1.M32 + matrix2.M32;
		result.M33 = matrix1.M33 + matrix2.M33;
		result.M34 = matrix1.M34 + matrix2.M34;
		result.M41 = matrix1.M41 + matrix2.M41;
		result.M42 = matrix1.M42 + matrix2.M42;
		result.M43 = matrix1.M43 + matrix2.M43;
		result.M44 = matrix1.M44 + matrix2.M44;
	}

	public static FPMatrix4x4 Inverse(FPMatrix4x4 matrix)
	{
		Inverse(ref matrix, out var result);
		return result;
	}

	public static void Inverse(ref FPMatrix4x4 matrix, out FPMatrix4x4 result)
	{
		FPFloat m = matrix.M11;
		FPFloat m2 = matrix.M12;
		FPFloat m3 = matrix.M13;
		FPFloat m4 = matrix.M14;
		FPFloat m5 = matrix.M21;
		FPFloat m6 = matrix.M22;
		FPFloat m7 = matrix.M23;
		FPFloat m8 = matrix.M24;
		FPFloat m9 = matrix.M31;
		FPFloat m10 = matrix.M32;
		FPFloat m11 = matrix.M33;
		FPFloat m12 = matrix.M34;
		FPFloat m13 = matrix.M41;
		FPFloat m14 = matrix.M42;
		FPFloat m15 = matrix.M43;
		FPFloat m16 = matrix.M44;
		FPFloat fPFloat = m11 * m16 - m12 * m15;
		FPFloat fPFloat2 = m10 * m16 - m12 * m14;
		FPFloat fPFloat3 = m10 * m15 - m11 * m14;
		FPFloat fPFloat4 = m9 * m16 - m12 * m13;
		FPFloat fPFloat5 = m9 * m15 - m11 * m13;
		FPFloat fPFloat6 = m9 * m14 - m10 * m13;
		FPFloat fPFloat7 = m6 * fPFloat - m7 * fPFloat2 + m8 * fPFloat3;
		FPFloat fPFloat8 = -(m5 * fPFloat - m7 * fPFloat4 + m8 * fPFloat5);
		FPFloat fPFloat9 = m5 * fPFloat2 - m6 * fPFloat4 + m8 * fPFloat6;
		FPFloat fPFloat10 = -(m5 * fPFloat3 - m6 * fPFloat5 + m7 * fPFloat6);
		FPFloat fPFloat11 = m * fPFloat7 + m2 * fPFloat8 + m3 * fPFloat9 + m4 * fPFloat10;
		if (fPFloat11 == FPFloat.Zero)
		{
			result.M11 = FPFloat.PositiveInfinity;
			result.M12 = FPFloat.PositiveInfinity;
			result.M13 = FPFloat.PositiveInfinity;
			result.M14 = FPFloat.PositiveInfinity;
			result.M21 = FPFloat.PositiveInfinity;
			result.M22 = FPFloat.PositiveInfinity;
			result.M23 = FPFloat.PositiveInfinity;
			result.M24 = FPFloat.PositiveInfinity;
			result.M31 = FPFloat.PositiveInfinity;
			result.M32 = FPFloat.PositiveInfinity;
			result.M33 = FPFloat.PositiveInfinity;
			result.M34 = FPFloat.PositiveInfinity;
			result.M41 = FPFloat.PositiveInfinity;
			result.M42 = FPFloat.PositiveInfinity;
			result.M43 = FPFloat.PositiveInfinity;
			result.M44 = FPFloat.PositiveInfinity;
		}
		else
		{
			FPFloat fPFloat12 = FPFloat.One / fPFloat11;
			result.M11 = fPFloat7 * fPFloat12;
			result.M21 = fPFloat8 * fPFloat12;
			result.M31 = fPFloat9 * fPFloat12;
			result.M41 = fPFloat10 * fPFloat12;
			result.M12 = -(m2 * fPFloat - m3 * fPFloat2 + m4 * fPFloat3) * fPFloat12;
			result.M22 = (m * fPFloat - m3 * fPFloat4 + m4 * fPFloat5) * fPFloat12;
			result.M32 = -(m * fPFloat2 - m2 * fPFloat4 + m4 * fPFloat6) * fPFloat12;
			result.M42 = (m * fPFloat3 - m2 * fPFloat5 + m3 * fPFloat6) * fPFloat12;
			FPFloat fPFloat13 = m7 * m16 - m8 * m15;
			FPFloat fPFloat14 = m6 * m16 - m8 * m14;
			FPFloat fPFloat15 = m6 * m15 - m7 * m14;
			FPFloat fPFloat16 = m5 * m16 - m8 * m13;
			FPFloat fPFloat17 = m5 * m15 - m7 * m13;
			FPFloat fPFloat18 = m5 * m14 - m6 * m13;
			result.M13 = (m2 * fPFloat13 - m3 * fPFloat14 + m4 * fPFloat15) * fPFloat12;
			result.M23 = -(m * fPFloat13 - m3 * fPFloat16 + m4 * fPFloat17) * fPFloat12;
			result.M33 = (m * fPFloat14 - m2 * fPFloat16 + m4 * fPFloat18) * fPFloat12;
			result.M43 = -(m * fPFloat15 - m2 * fPFloat17 + m3 * fPFloat18) * fPFloat12;
			FPFloat fPFloat19 = m7 * m12 - m8 * m11;
			FPFloat fPFloat20 = m6 * m12 - m8 * m10;
			FPFloat fPFloat21 = m6 * m11 - m7 * m10;
			FPFloat fPFloat22 = m5 * m12 - m8 * m9;
			FPFloat fPFloat23 = m5 * m11 - m7 * m9;
			FPFloat fPFloat24 = m5 * m10 - m6 * m9;
			result.M14 = -(m2 * fPFloat19 - m3 * fPFloat20 + m4 * fPFloat21) * fPFloat12;
			result.M24 = (m * fPFloat19 - m3 * fPFloat22 + m4 * fPFloat23) * fPFloat12;
			result.M34 = -(m * fPFloat20 - m2 * fPFloat22 + m4 * fPFloat24) * fPFloat12;
			result.M44 = (m * fPFloat21 - m2 * fPFloat23 + m3 * fPFloat24) * fPFloat12;
		}
	}

	public static FPMatrix4x4 Multiply(FPMatrix4x4 matrix1, FPFloat scaleFactor)
	{
		Multiply(ref matrix1, scaleFactor, out var result);
		return result;
	}

	public static void Multiply(ref FPMatrix4x4 matrix1, FPFloat scaleFactor, out FPMatrix4x4 result)
	{
		result.M11 = matrix1.M11 * scaleFactor;
		result.M12 = matrix1.M12 * scaleFactor;
		result.M13 = matrix1.M13 * scaleFactor;
		result.M14 = matrix1.M14 * scaleFactor;
		result.M21 = matrix1.M21 * scaleFactor;
		result.M22 = matrix1.M22 * scaleFactor;
		result.M23 = matrix1.M23 * scaleFactor;
		result.M24 = matrix1.M24 * scaleFactor;
		result.M31 = matrix1.M31 * scaleFactor;
		result.M32 = matrix1.M32 * scaleFactor;
		result.M33 = matrix1.M33 * scaleFactor;
		result.M34 = matrix1.M34 * scaleFactor;
		result.M41 = matrix1.M41 * scaleFactor;
		result.M42 = matrix1.M42 * scaleFactor;
		result.M43 = matrix1.M43 * scaleFactor;
		result.M44 = matrix1.M44 * scaleFactor;
	}

	public static FPMatrix4x4 Rotate(FPQuaternion quaternion)
	{
		Rotate(ref quaternion, out var result);
		return result;
	}

	public static void Rotate(ref FPQuaternion quaternion, out FPMatrix4x4 result)
	{
		FPFloat fPFloat = quaternion.X * 2;
		FPFloat fPFloat2 = quaternion.Y * 2;
		FPFloat fPFloat3 = quaternion.Z * 2;
		FPFloat fPFloat4 = quaternion.X * fPFloat;
		FPFloat fPFloat5 = quaternion.Y * fPFloat2;
		FPFloat fPFloat6 = quaternion.Z * fPFloat3;
		FPFloat fPFloat7 = quaternion.X * fPFloat2;
		FPFloat fPFloat8 = quaternion.X * fPFloat3;
		FPFloat fPFloat9 = quaternion.Y * fPFloat3;
		FPFloat fPFloat10 = quaternion.W * fPFloat;
		FPFloat fPFloat11 = quaternion.W * fPFloat2;
		FPFloat fPFloat12 = quaternion.W * fPFloat3;
		result.M11 = FPFloat.One - (fPFloat5 + fPFloat6);
		result.M21 = fPFloat7 + fPFloat12;
		result.M31 = fPFloat8 - fPFloat11;
		result.M41 = FPFloat.Zero;
		result.M12 = fPFloat7 - fPFloat12;
		result.M22 = FPFloat.One - (fPFloat4 + fPFloat6);
		result.M32 = fPFloat9 + fPFloat10;
		result.M42 = FPFloat.Zero;
		result.M13 = fPFloat8 + fPFloat11;
		result.M23 = fPFloat9 - fPFloat10;
		result.M33 = FPFloat.One - (fPFloat4 + fPFloat5);
		result.M43 = FPFloat.Zero;
		result.M14 = FPFloat.Zero;
		result.M24 = FPFloat.Zero;
		result.M34 = FPFloat.Zero;
		result.M44 = FPFloat.One;
	}

	public static FPMatrix4x4 Transpose(FPMatrix4x4 matrix)
	{
		Transpose(ref matrix, out var result);
		return result;
	}

	public static void Transpose(ref FPMatrix4x4 matrix, out FPMatrix4x4 result)
	{
		result.M11 = matrix.M11;
		result.M12 = matrix.M21;
		result.M13 = matrix.M31;
		result.M14 = matrix.M41;
		result.M21 = matrix.M12;
		result.M22 = matrix.M22;
		result.M23 = matrix.M32;
		result.M24 = matrix.M42;
		result.M31 = matrix.M13;
		result.M32 = matrix.M23;
		result.M33 = matrix.M33;
		result.M34 = matrix.M43;
		result.M41 = matrix.M14;
		result.M42 = matrix.M24;
		result.M43 = matrix.M34;
		result.M44 = matrix.M44;
	}

	public static FPMatrix4x4 operator *(FPMatrix4x4 value1, FPMatrix4x4 value2)
	{
		Multiply(ref value1, ref value2, out var result);
		return result;
	}

	public FPFloat Trace()
	{
		return M11 + M22 + M33 + M44;
	}

	public static FPMatrix4x4 operator +(FPMatrix4x4 value1, FPMatrix4x4 value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static FPMatrix4x4 operator -(FPMatrix4x4 value)
	{
		FPMatrix4x4 result = default;
		result.M11 = -value.M11;
		result.M12 = -value.M12;
		result.M13 = -value.M13;
		result.M14 = -value.M14;
		result.M21 = -value.M21;
		result.M22 = -value.M22;
		result.M23 = -value.M23;
		result.M24 = -value.M24;
		result.M31 = -value.M31;
		result.M32 = -value.M32;
		result.M33 = -value.M33;
		result.M34 = -value.M34;
		result.M41 = -value.M41;
		result.M42 = -value.M42;
		result.M43 = -value.M43;
		result.M44 = -value.M44;
		return result;
	}

	public static FPMatrix4x4 operator -(FPMatrix4x4 value1, FPMatrix4x4 value2)
	{
		Multiply(ref value2, -FPFloat.One, out value2);
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static bool operator ==(FPMatrix4x4 value1, FPMatrix4x4 value2)
	{
		if (value1.M11 == value2.M11 && value1.M12 == value2.M12 && value1.M13 == value2.M13 && value1.M14 == value2.M14 && value1.M21 == value2.M21 && value1.M22 == value2.M22 && value1.M23 == value2.M23 && value1.M24 == value2.M24 && value1.M31 == value2.M31 && value1.M32 == value2.M32 && value1.M33 == value2.M33 && value1.M34 == value2.M34 && value1.M41 == value2.M41 && value1.M42 == value2.M42 && value1.M43 == value2.M43)
		{
			return value1.M44 == value2.M44;
		}
		return false;
	}

	public static bool operator !=(FPMatrix4x4 value1, FPMatrix4x4 value2)
	{
		if (!(value1.M11 != value2.M11) && !(value1.M12 != value2.M12) && !(value1.M13 != value2.M13) && !(value1.M14 != value2.M14) && !(value1.M21 != value2.M21) && !(value1.M22 != value2.M22) && !(value1.M23 != value2.M23) && !(value1.M24 != value2.M24) && !(value1.M31 != value2.M31) && !(value1.M32 != value2.M32) && !(value1.M33 != value2.M33) && !(value1.M34 != value2.M34) && !(value1.M41 != value2.M41) && !(value1.M42 != value2.M42) && !(value1.M43 != value2.M43))
		{
			return value1.M44 != value2.M44;
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is FPMatrix4x4 fPMatrix4x))
		{
			return false;
		}
		if (M11 == fPMatrix4x.M11 && M12 == fPMatrix4x.M12 && M13 == fPMatrix4x.M13 && M14 == fPMatrix4x.M14 && M21 == fPMatrix4x.M21 && M22 == fPMatrix4x.M22 && M23 == fPMatrix4x.M23 && M24 == fPMatrix4x.M24 && M31 == fPMatrix4x.M31 && M32 == fPMatrix4x.M32 && M33 == fPMatrix4x.M33 && M34 == fPMatrix4x.M44 && M41 == fPMatrix4x.M41 && M42 == fPMatrix4x.M42 && M43 == fPMatrix4x.M43)
		{
			return M44 == fPMatrix4x.M44;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return M11.GetHashCode() ^ M12.GetHashCode() ^ M13.GetHashCode() ^ M14.GetHashCode() ^ M21.GetHashCode() ^ M22.GetHashCode() ^ M23.GetHashCode() ^ M24.GetHashCode() ^ M31.GetHashCode() ^ M32.GetHashCode() ^ M33.GetHashCode() ^ M34.GetHashCode() ^ M41.GetHashCode() ^ M42.GetHashCode() ^ M43.GetHashCode() ^ M44.GetHashCode();
	}

	public static FPMatrix4x4 Translate(FPFloat xPosition, FPFloat yPosition, FPFloat zPosition)
	{
		FPMatrix4x4 result = default;
		result.M11 = FPFloat.One;
		result.M12 = FPFloat.Zero;
		result.M13 = FPFloat.Zero;
		result.M14 = xPosition;
		result.M21 = FPFloat.Zero;
		result.M22 = FPFloat.One;
		result.M23 = FPFloat.Zero;
		result.M24 = yPosition;
		result.M31 = FPFloat.Zero;
		result.M32 = FPFloat.Zero;
		result.M33 = FPFloat.One;
		result.M34 = zPosition;
		result.M41 = FPFloat.Zero;
		result.M42 = FPFloat.Zero;
		result.M43 = FPFloat.Zero;
		result.M44 = FPFloat.One;
		return result;
	}

	public static FPMatrix4x4 Translate(FPVector3 translation)
	{
		return Translate(translation.X, translation.Y, translation.Z);
	}

	public static FPMatrix4x4 Scale(FPFloat xScale, FPFloat yScale, FPFloat zScale)
	{
		FPMatrix4x4 result = default;
		result.M11 = xScale;
		result.M12 = FPFloat.Zero;
		result.M13 = FPFloat.Zero;
		result.M14 = FPFloat.Zero;
		result.M21 = FPFloat.Zero;
		result.M22 = yScale;
		result.M23 = FPFloat.Zero;
		result.M24 = FPFloat.Zero;
		result.M31 = FPFloat.Zero;
		result.M32 = FPFloat.Zero;
		result.M33 = zScale;
		result.M34 = FPFloat.Zero;
		result.M41 = FPFloat.Zero;
		result.M42 = FPFloat.Zero;
		result.M43 = FPFloat.Zero;
		result.M44 = FPFloat.One;
		return result;
	}

	public static FPMatrix4x4 Scale(FPFloat xScale, FPFloat yScale, FPFloat zScale, FPVector3 centerPoint)
	{
		FPFloat m = centerPoint.X * (FPFloat.One - xScale);
		FPFloat m2 = centerPoint.Y * (FPFloat.One - yScale);
		FPFloat m3 = centerPoint.Z * (FPFloat.One - zScale);
		FPMatrix4x4 result = default;
		result.M11 = xScale;
		result.M12 = FPFloat.Zero;
		result.M13 = FPFloat.Zero;
		result.M14 = FPFloat.Zero;
		result.M21 = FPFloat.Zero;
		result.M22 = yScale;
		result.M23 = FPFloat.Zero;
		result.M24 = FPFloat.Zero;
		result.M31 = FPFloat.Zero;
		result.M32 = FPFloat.Zero;
		result.M33 = zScale;
		result.M34 = FPFloat.Zero;
		result.M41 = m;
		result.M42 = m2;
		result.M43 = m3;
		result.M44 = FPFloat.One;
		return result;
	}

	public static FPMatrix4x4 Scale(FPVector3 scales)
	{
		return Scale(scales.X, scales.Y, scales.Z);
	}

	public static FPMatrix4x4 Scale(FPVector3 scales, FPVector3 centerPoint)
	{
		return Scale(scales.X, scales.Y, scales.Z, centerPoint);
	}

	public static FPMatrix4x4 Scale(FPFloat scale)
	{
		return Scale(scale, scale, scale);
	}

	public static FPMatrix4x4 Scale(FPFloat scale, FPVector3 centerPoint)
	{
		return Scale(scale, scale, scale, centerPoint);
	}

	public static FPMatrix4x4 RotateX(FPFloat radians)
	{
		FPFloat fPFloat = FPMath.Cos(radians);
		FPFloat fPFloat2 = FPMath.Sin(radians);
		FPMatrix4x4 result = default;
		result.M11 = FPFloat.One;
		result.M12 = FPFloat.Zero;
		result.M13 = FPFloat.Zero;
		result.M14 = FPFloat.Zero;
		result.M21 = FPFloat.Zero;
		result.M22 = fPFloat;
		result.M23 = fPFloat2;
		result.M24 = FPFloat.Zero;
		result.M31 = FPFloat.Zero;
		result.M32 = -fPFloat2;
		result.M33 = fPFloat;
		result.M34 = FPFloat.Zero;
		result.M41 = FPFloat.Zero;
		result.M42 = FPFloat.Zero;
		result.M43 = FPFloat.Zero;
		result.M44 = FPFloat.One;
		return result;
	}

	public static FPMatrix4x4 RotateX(FPFloat radians, FPVector3 centerPoint)
	{
		FPFloat fPFloat = FPMath.Cos(radians);
		FPFloat fPFloat2 = FPMath.Sin(radians);
		FPFloat m = centerPoint.Y * (FPFloat.One - fPFloat) + centerPoint.Z * fPFloat2;
		FPFloat m2 = centerPoint.Z * (FPFloat.One - fPFloat) - centerPoint.Y * fPFloat2;
		FPMatrix4x4 result = default;
		result.M11 = FPFloat.One;
		result.M12 = FPFloat.Zero;
		result.M13 = FPFloat.Zero;
		result.M14 = FPFloat.Zero;
		result.M21 = FPFloat.Zero;
		result.M22 = fPFloat;
		result.M23 = fPFloat2;
		result.M24 = FPFloat.Zero;
		result.M31 = FPFloat.Zero;
		result.M32 = -fPFloat2;
		result.M33 = fPFloat;
		result.M34 = FPFloat.Zero;
		result.M41 = FPFloat.Zero;
		result.M42 = m;
		result.M43 = m2;
		result.M44 = FPFloat.One;
		return result;
	}

	public static FPMatrix4x4 RotateY(FPFloat radians)
	{
		FPFloat fPFloat = FPMath.Cos(radians);
		FPFloat fPFloat2 = FPMath.Sin(radians);
		FPMatrix4x4 result = default;
		result.M11 = fPFloat;
		result.M12 = FPFloat.Zero;
		result.M13 = -fPFloat2;
		result.M14 = FPFloat.Zero;
		result.M21 = FPFloat.Zero;
		result.M22 = FPFloat.One;
		result.M23 = FPFloat.Zero;
		result.M24 = FPFloat.Zero;
		result.M31 = fPFloat2;
		result.M32 = FPFloat.Zero;
		result.M33 = fPFloat;
		result.M34 = FPFloat.Zero;
		result.M41 = FPFloat.Zero;
		result.M42 = FPFloat.Zero;
		result.M43 = FPFloat.Zero;
		result.M44 = FPFloat.One;
		return result;
	}

	public static FPMatrix4x4 RotateY(FPFloat radians, FPVector3 centerPoint)
	{
		FPFloat fPFloat = FPMath.Cos(radians);
		FPFloat fPFloat2 = FPMath.Sin(radians);
		FPFloat m = centerPoint.X * (FPFloat.One - fPFloat) - centerPoint.Z * fPFloat2;
		FPFloat m2 = centerPoint.X * (FPFloat.One - fPFloat) + centerPoint.X * fPFloat2;
		FPMatrix4x4 result = default;
		result.M11 = fPFloat;
		result.M12 = FPFloat.Zero;
		result.M13 = -fPFloat2;
		result.M14 = FPFloat.Zero;
		result.M21 = FPFloat.Zero;
		result.M22 = FPFloat.One;
		result.M23 = FPFloat.Zero;
		result.M24 = FPFloat.Zero;
		result.M31 = fPFloat2;
		result.M32 = FPFloat.Zero;
		result.M33 = fPFloat;
		result.M34 = FPFloat.Zero;
		result.M41 = m;
		result.M42 = FPFloat.Zero;
		result.M43 = m2;
		result.M44 = FPFloat.One;
		return result;
	}

	public static FPMatrix4x4 RotateZ(FPFloat radians)
	{
		FPFloat fPFloat = FPMath.Cos(radians);
		FPFloat fPFloat2 = FPMath.Sin(radians);
		FPMatrix4x4 result = default;
		result.M11 = fPFloat;
		result.M12 = fPFloat2;
		result.M13 = FPFloat.Zero;
		result.M14 = FPFloat.Zero;
		result.M21 = -fPFloat2;
		result.M22 = fPFloat;
		result.M23 = FPFloat.Zero;
		result.M24 = FPFloat.Zero;
		result.M31 = FPFloat.Zero;
		result.M32 = FPFloat.Zero;
		result.M33 = FPFloat.One;
		result.M34 = FPFloat.Zero;
		result.M41 = FPFloat.Zero;
		result.M42 = FPFloat.Zero;
		result.M43 = FPFloat.Zero;
		result.M44 = FPFloat.One;
		return result;
	}

	public static FPMatrix4x4 RotateZ(FPFloat radians, FPVector3 centerPoint)
	{
		FPFloat fPFloat = FPMath.Cos(radians);
		FPFloat fPFloat2 = FPMath.Sin(radians);
		FPFloat m = centerPoint.X * (1 - fPFloat) + centerPoint.Y * fPFloat2;
		FPFloat m2 = centerPoint.Y * (1 - fPFloat) - centerPoint.X * fPFloat2;
		FPMatrix4x4 result = default;
		result.M11 = fPFloat;
		result.M12 = fPFloat2;
		result.M13 = FPFloat.Zero;
		result.M14 = FPFloat.Zero;
		result.M21 = -fPFloat2;
		result.M22 = fPFloat;
		result.M23 = FPFloat.Zero;
		result.M24 = FPFloat.Zero;
		result.M31 = FPFloat.Zero;
		result.M32 = FPFloat.Zero;
		result.M33 = FPFloat.One;
		result.M34 = FPFloat.Zero;
		result.M41 = m;
		result.M42 = m2;
		result.M43 = FPFloat.Zero;
		result.M44 = FPFloat.One;
		return result;
	}

	public static void AxisAngle(ref FPVector3 axis, FPFloat angle, out FPMatrix4x4 result)
	{
		FPFloat x = axis.X;
		FPFloat y = axis.Y;
		FPFloat z = axis.Z;
		FPFloat fPFloat = FPMath.Sin(angle);
		FPFloat fPFloat2 = FPMath.Cos(angle);
		FPFloat fPFloat3 = x * x;
		FPFloat fPFloat4 = y * y;
		FPFloat fPFloat5 = z * z;
		FPFloat fPFloat6 = x * y;
		FPFloat fPFloat7 = x * z;
		FPFloat fPFloat8 = y * z;
		result.M11 = fPFloat3 + fPFloat2 * (FPFloat.One - fPFloat3);
		result.M12 = fPFloat6 - fPFloat2 * fPFloat6 + fPFloat * z;
		result.M13 = fPFloat7 - fPFloat2 * fPFloat7 - fPFloat * y;
		result.M14 = FPFloat.Zero;
		result.M21 = fPFloat6 - fPFloat2 * fPFloat6 - fPFloat * z;
		result.M22 = fPFloat4 + fPFloat2 * (FPFloat.One - fPFloat4);
		result.M23 = fPFloat8 - fPFloat2 * fPFloat8 + fPFloat * x;
		result.M24 = FPFloat.Zero;
		result.M31 = fPFloat7 - fPFloat2 * fPFloat7 + fPFloat * y;
		result.M32 = fPFloat8 - fPFloat2 * fPFloat8 - fPFloat * x;
		result.M33 = fPFloat5 + fPFloat2 * (FPFloat.One - fPFloat5);
		result.M34 = FPFloat.Zero;
		result.M41 = FPFloat.Zero;
		result.M42 = FPFloat.Zero;
		result.M43 = FPFloat.Zero;
		result.M44 = FPFloat.One;
	}

	public static FPMatrix4x4 AngleAxis(FPFloat angle, FPVector3 axis)
	{
		AxisAngle(ref axis, angle, out var result);
		return result;
	}

	public override string ToString()
	{
		return $"{M11.RawValue}|{M12.RawValue}|{M13.RawValue}|{M14.RawValue}|{M21.RawValue}|{M22.RawValue}|{M23.RawValue}|{M24.RawValue}|{M31.RawValue}|{M32.RawValue}|{M33.RawValue}|{M34.RawValue}|{M41.RawValue}|{M42.RawValue}|{M43.RawValue}|{M44.RawValue}";
	}

	public static void TRS(FPVector3 translation, FPQuaternion rotation, FPVector3 scale, out FPMatrix4x4 matrix)
	{
		matrix = Translate(translation) * Rotate(rotation) * Scale(scale);
	}

	public static FPMatrix4x4 TRS(FPVector3 translation, FPQuaternion rotation, FPVector3 scale)
	{
		TRS(translation, rotation, scale, out var matrix);
		return matrix;
	}
}
