using UnityEngine;

namespace Bamboo;

public struct FPQuaternion
{
	public FPFloat X;

	public FPFloat Y;

	public FPFloat Z;

	public FPFloat W;

	public static readonly FPQuaternion Identity;

	private static int[] _sINext;

	public FPVector3 EulerAngles
	{
		get
		{
			FPFloat fPFloat = W * W;
			FPFloat fPFloat2 = X * X;
			FPFloat fPFloat3 = Y * Y;
			FPFloat fPFloat4 = Z * Z;
			FPFloat fPFloat5 = fPFloat2 + fPFloat3 + fPFloat4 + fPFloat;
			FPFloat fPFloat6 = X * W - Y * Z;
			FPVector3 fPVector = default;
			if (fPFloat6 > 4995 * FPFloat.EN4 * fPFloat5)
			{
				fPVector.Y = 2 * FPMath.Atan2(Y, X);
				fPVector.X = FPFloat.Pi / 2;
				fPVector.Z = 0;
				return NormalizeAngles(fPVector * 57.29578f);
			}
			if (fPFloat6 < -4995 * FPFloat.EN4 * fPFloat5)
			{
				fPVector.Y = -2 * FPMath.Atan2(Y, X);
				fPVector.X = -FPFloat.Pi / 2;
				fPVector.Z = 0;
				return NormalizeAngles(fPVector * FPMath.Rad2Deg);
			}
			FPQuaternion fPQuaternion = new FPQuaternion(W, Z, X, Y);
			FPFloat y = 2 * fPQuaternion.X * fPQuaternion.W + 2 * fPQuaternion.Y * fPQuaternion.Z;
			FPFloat x = 2 * (FPFloat.Half - (fPQuaternion.Z * fPQuaternion.Z + fPQuaternion.W * fPQuaternion.W));
			fPVector.Y = FPMath.Atan2(y, x);
			FPFloat value = 2 * (fPQuaternion.X * fPQuaternion.Z - fPQuaternion.W * fPQuaternion.Y);
			fPVector.X = FPMath.Asin(value);
			fPVector.Z = FPMath.Atan2(2 * fPQuaternion.X * fPQuaternion.Y + 2 * fPQuaternion.Z * fPQuaternion.W, 2 * (FPFloat.Half - (fPQuaternion.Y * fPQuaternion.Y + fPQuaternion.Z * fPQuaternion.Z)));
			Mathf.Atan2(y.AsFloat(), x.AsFloat());
			Mathf.Asin(value.AsFloat());
			return NormalizeAngles(fPVector * FPMath.Rad2Deg);
		}
	}

	static FPQuaternion()
	{
		_sINext = new int[3] { 1, 2, 0 };
		Identity = new FPQuaternion(0, 0, 0, 1);
	}

	public FPQuaternion(FPFloat x, FPFloat y, FPFloat z, FPFloat w)
	{
		X = x;
		Y = y;
		Z = z;
		W = w;
	}

	public void Set(FPFloat new_x, FPFloat new_y, FPFloat new_z, FPFloat new_w)
	{
		X = new_x;
		Y = new_y;
		Z = new_z;
		W = new_w;
	}

	public void SetFromToRotation(FPVector3 fromDirection, FPVector3 toDirection)
	{
		FPQuaternion fPQuaternion = FromToRotation(fromDirection, toDirection);
		Set(fPQuaternion.X, fPQuaternion.Y, fPQuaternion.Z, fPQuaternion.W);
	}

	private static FPVector3 NormalizeAngles(FPVector3 angles)
	{
		angles.X = NormalizeAngle(angles.X);
		angles.Y = NormalizeAngle(angles.Y);
		angles.Z = NormalizeAngle(angles.Z);
		return angles;
	}

	private static FPFloat NormalizeAngle(FPFloat angle)
	{
		while (angle > 360)
		{
			angle -= (FPFloat)360;
		}
		while (angle < 0)
		{
			angle += (FPFloat)360;
		}
		return angle;
	}

	public static FPFloat Angle(FPQuaternion a, FPQuaternion b)
	{
		FPQuaternion fPQuaternion = Inverse(a);
		FPFloat fPFloat = FPFloat.Acos((b * fPQuaternion).W) * 2 * FPFloat.Rad2Deg;
		if (fPFloat > 180)
		{
			fPFloat = 360 - fPFloat;
		}
		return fPFloat;
	}

	public static FPQuaternion Add(FPQuaternion quaternion1, FPQuaternion quaternion2)
	{
		Add(ref quaternion1, ref quaternion2, out var result);
		return result;
	}

	public static FPQuaternion LookRotation(FPVector3 forward)
	{
		return CreateFromMatrix(FPMatrix.LookAt(forward, FPVector3.Up));
	}

	public static FPQuaternion LookRotation(FPVector3 forward, FPVector3 upwards)
	{
		return CreateFromMatrix(FPMatrix.LookAt(forward, upwards));
	}

	public static FPQuaternion Slerp(FPQuaternion from, FPQuaternion to, FPFloat t)
	{
		t = FPMath.Clamp(t, 0, 1);
		FPFloat fPFloat = Dot(from, to);
		if (fPFloat < 0f)
		{
			to = Multiply(to, -1);
			fPFloat = -fPFloat;
		}
		FPFloat fPFloat2 = FPFloat.Acos(fPFloat);
		return Multiply(Multiply(from, FPFloat.Sin((1 - t) * fPFloat2)) + Multiply(to, FPFloat.Sin(t * fPFloat2)), 1 / FPFloat.Sin(fPFloat2));
	}

	public static FPQuaternion RotateTowards(FPQuaternion from, FPQuaternion to, FPFloat maxDegreesDelta)
	{
		FPFloat fPFloat = Dot(from, to);
		if (fPFloat < 0f)
		{
			to = Multiply(to, -1);
			fPFloat = -fPFloat;
		}
		FPFloat fPFloat2 = FPFloat.Acos(fPFloat);
		FPFloat fPFloat3 = fPFloat2 * 2;
		maxDegreesDelta *= FPFloat.Deg2Rad;
		if (maxDegreesDelta >= fPFloat3)
		{
			return to;
		}
		maxDegreesDelta /= fPFloat3;
		return Multiply(Multiply(from, FPFloat.Sin((1 - maxDegreesDelta) * fPFloat2)) + Multiply(to, FPFloat.Sin(maxDegreesDelta * fPFloat2)), 1 / FPFloat.Sin(fPFloat2));
	}

	public static FPQuaternion Euler(FPFloat x, FPFloat y, FPFloat z)
	{
		x *= FPFloat.Deg2Rad;
		y *= FPFloat.Deg2Rad;
		z *= FPFloat.Deg2Rad;
		CreateFromYawPitchRoll(y, x, z, out var result);
		return result;
	}

	public static FPQuaternion Euler(FPVector3 eulerAngles)
	{
		return Euler(eulerAngles.X, eulerAngles.Y, eulerAngles.Z);
	}

	public static FPQuaternion AngleAxis(FPFloat angle, FPVector3 axis)
	{
		axis *= FPFloat.Deg2Rad;
		axis.Normalize();
		FPFloat x = angle * FPFloat.Deg2Rad * FPFloat.Half;
		FPFloat fPFloat = FPFloat.Sin(x);
		FPQuaternion result = default;
		result.X = axis.X * fPFloat;
		result.Y = axis.Y * fPFloat;
		result.Z = axis.Z * fPFloat;
		result.W = FPFloat.Cos(x);
		return result;
	}

	public static void CreateFromYawPitchRoll(FPFloat yaw, FPFloat pitch, FPFloat roll, out FPQuaternion result)
	{
		FPFloat value = roll * FPFloat.Half;
		FPFloat fPFloat = FPMath.Sin(value);
		FPFloat fPFloat2 = FPMath.Cos(value);
		FPFloat value2 = pitch * FPFloat.Half;
		FPFloat fPFloat3 = FPMath.Sin(value2);
		FPFloat fPFloat4 = FPMath.Cos(value2);
		FPFloat value3 = yaw * FPFloat.Half;
		FPFloat fPFloat5 = FPMath.Sin(value3);
		FPFloat fPFloat6 = FPMath.Cos(value3);
		_ = fPFloat6 * fPFloat4 * fPFloat2 + fPFloat5 * fPFloat3 * fPFloat;
		_ = fPFloat6 * fPFloat4 * fPFloat - fPFloat5 * fPFloat3 * fPFloat2;
		_ = fPFloat6 * fPFloat3 * fPFloat2 + fPFloat5 * fPFloat4 * fPFloat;
		_ = fPFloat5 * fPFloat4 * fPFloat2 - fPFloat6 * fPFloat3 * fPFloat;
		FPFloat x = fPFloat6 * fPFloat3 * fPFloat2 + fPFloat5 * fPFloat4 * fPFloat;
		FPFloat y = fPFloat5 * fPFloat4 * fPFloat2 - fPFloat6 * fPFloat3 * fPFloat;
		FPFloat z = fPFloat6 * fPFloat4 * fPFloat - fPFloat5 * fPFloat3 * fPFloat2;
		FPFloat w = fPFloat6 * fPFloat4 * fPFloat2 + fPFloat5 * fPFloat3 * fPFloat;
		result = new FPQuaternion(x, y, z, w);
	}

	public static void Add(ref FPQuaternion quaternion1, ref FPQuaternion quaternion2, out FPQuaternion result)
	{
		result.X = quaternion1.X + quaternion2.X;
		result.Y = quaternion1.Y + quaternion2.Y;
		result.Z = quaternion1.Z + quaternion2.Z;
		result.W = quaternion1.W + quaternion2.W;
	}

	public static FPQuaternion Conjugate(FPQuaternion value)
	{
		FPQuaternion result = default;
		result.X = -value.X;
		result.Y = -value.Y;
		result.Z = -value.Z;
		result.W = value.W;
		return result;
	}

	public static FPFloat Dot(FPQuaternion a, FPQuaternion b)
	{
		return a.W * b.W + a.X * b.X + a.Y * b.Y + a.Z * b.Z;
	}

	public static FPQuaternion Inverse(FPQuaternion rotation)
	{
		FPFloat scaleFactor = FPFloat.One / (rotation.X * rotation.X + rotation.Y * rotation.Y + rotation.Z * rotation.Z + rotation.W * rotation.W);
		return Multiply(Conjugate(rotation), scaleFactor);
	}

	public static FPQuaternion FromToRotation(FPVector3 fromVector, FPVector3 toVector)
	{
		FPVector3 fPVector = FPVector3.Cross(fromVector, toVector);
		FPQuaternion result = new FPQuaternion(fPVector.X, fPVector.Y, fPVector.Z, FPVector3.Dot(fromVector, toVector));
		result.W += FPFloat.Sqrt(fromVector.SqrMagnitude * toVector.SqrMagnitude);
		result.Normalize();
		return result;
	}

	public static FPQuaternion Lerp(FPQuaternion a, FPQuaternion b, FPFloat t)
	{
		t = FPMath.Clamp(t, FPFloat.Zero, FPFloat.One);
		return LerpUnclamped(a, b, t);
	}

	public static FPQuaternion LerpUnclamped(FPQuaternion a, FPQuaternion b, FPFloat t)
	{
		FPQuaternion result = Multiply(a, 1 - t) + Multiply(b, t);
		result.Normalize();
		return result;
	}

	public static FPQuaternion Subtract(FPQuaternion quaternion1, FPQuaternion quaternion2)
	{
		Subtract(ref quaternion1, ref quaternion2, out var result);
		return result;
	}

	public static void Subtract(ref FPQuaternion quaternion1, ref FPQuaternion quaternion2, out FPQuaternion result)
	{
		result.X = quaternion1.X - quaternion2.X;
		result.Y = quaternion1.Y - quaternion2.Y;
		result.Z = quaternion1.Z - quaternion2.Z;
		result.W = quaternion1.W - quaternion2.W;
	}

	public static FPQuaternion Multiply(FPQuaternion quaternion1, FPQuaternion quaternion2)
	{
		Multiply(ref quaternion1, ref quaternion2, out var result);
		return result;
	}

	public static void Multiply(ref FPQuaternion quaternion1, ref FPQuaternion quaternion2, out FPQuaternion result)
	{
		FPFloat x = quaternion1.X;
		FPFloat y = quaternion1.Y;
		FPFloat z = quaternion1.Z;
		FPFloat w = quaternion1.W;
		FPFloat x2 = quaternion2.X;
		FPFloat y2 = quaternion2.Y;
		FPFloat z2 = quaternion2.Z;
		FPFloat w2 = quaternion2.W;
		FPFloat fPFloat = y * z2 - z * y2;
		FPFloat fPFloat2 = z * x2 - x * z2;
		FPFloat fPFloat3 = x * y2 - y * x2;
		FPFloat fPFloat4 = x * x2 + y * y2 + z * z2;
		result.X = x * w2 + x2 * w + fPFloat;
		result.Y = y * w2 + y2 * w + fPFloat2;
		result.Z = z * w2 + z2 * w + fPFloat3;
		result.W = w * w2 - fPFloat4;
	}

	public static FPQuaternion Multiply(FPQuaternion quaternion1, FPFloat scaleFactor)
	{
		Multiply(ref quaternion1, scaleFactor, out var result);
		return result;
	}

	public static void Multiply(ref FPQuaternion quaternion1, FPFloat scaleFactor, out FPQuaternion result)
	{
		result.X = quaternion1.X * scaleFactor;
		result.Y = quaternion1.Y * scaleFactor;
		result.Z = quaternion1.Z * scaleFactor;
		result.W = quaternion1.W * scaleFactor;
	}

	public void Normalize()
	{
		FPFloat x = X * X + Y * Y + Z * Z + W * W;
		FPFloat fPFloat = 1 / FPFloat.Sqrt(x);
		X *= fPFloat;
		Y *= fPFloat;
		Z *= fPFloat;
		W *= fPFloat;
	}

	public static FPQuaternion CreateFromMatrix(FPMatrix matrix)
	{
		CreateFromMatrix(ref matrix, out var quat);
		return quat;
	}

	public static void CreateFromMatrix(ref FPMatrix matrix, out FPQuaternion quat)
	{
		FPFloat fPFloat = matrix.M11 + matrix.M22 + matrix.M33;
		if (fPFloat > FPFloat.Zero)
		{
			FPFloat fPFloat2 = FPFloat.Sqrt(fPFloat + FPFloat.One);
			quat.W = fPFloat2 * FPFloat.Half;
			fPFloat2 = FPFloat.Half / fPFloat2;
			quat.X = (matrix.M23 - matrix.M32) * fPFloat2;
			quat.Y = (matrix.M31 - matrix.M13) * fPFloat2;
			quat.Z = (matrix.M12 - matrix.M21) * fPFloat2;
		}
		else if (matrix.M11 >= matrix.M22 && matrix.M11 >= matrix.M33)
		{
			FPFloat fPFloat3 = FPFloat.Sqrt(FPFloat.One + matrix.M11 - matrix.M22 - matrix.M33);
			FPFloat fPFloat4 = FPFloat.Half / fPFloat3;
			quat.X = FPFloat.Half * fPFloat3;
			quat.Y = (matrix.M12 + matrix.M21) * fPFloat4;
			quat.Z = (matrix.M13 + matrix.M31) * fPFloat4;
			quat.W = (matrix.M23 - matrix.M32) * fPFloat4;
		}
		else if (matrix.M22 > matrix.M33)
		{
			FPFloat fPFloat5 = FPFloat.Sqrt(FPFloat.One + matrix.M22 - matrix.M11 - matrix.M33);
			FPFloat fPFloat6 = FPFloat.Half / fPFloat5;
			quat.X = (matrix.M21 + matrix.M12) * fPFloat6;
			quat.Y = FPFloat.Half * fPFloat5;
			quat.Z = (matrix.M32 + matrix.M23) * fPFloat6;
			quat.W = (matrix.M31 - matrix.M13) * fPFloat6;
		}
		else
		{
			FPFloat fPFloat7 = FPFloat.Sqrt(FPFloat.One + matrix.M33 - matrix.M11 - matrix.M22);
			FPFloat fPFloat8 = FPFloat.Half / fPFloat7;
			quat.X = (matrix.M31 + matrix.M13) * fPFloat8;
			quat.Y = (matrix.M32 + matrix.M23) * fPFloat8;
			quat.Z = FPFloat.Half * fPFloat7;
			quat.W = (matrix.M12 - matrix.M21) * fPFloat8;
		}
	}

	public static FPMatrix4x4d QuaternionToMatrix(FPQuaternion quat)
	{
		FPMatrix4x4d result = new FPMatrix4x4d(0);
		FPFloat fPFloat = quat.X * 2;
		FPFloat fPFloat2 = quat.Y * 2;
		FPFloat fPFloat3 = quat.Z * 2;
		FPFloat fPFloat4 = quat.X * fPFloat;
		FPFloat fPFloat5 = quat.Y * fPFloat2;
		FPFloat fPFloat6 = quat.Z * fPFloat3;
		FPFloat fPFloat7 = quat.X * fPFloat2;
		FPFloat fPFloat8 = quat.X * fPFloat3;
		FPFloat fPFloat9 = quat.Y * fPFloat3;
		FPFloat fPFloat10 = quat.W * fPFloat;
		FPFloat fPFloat11 = quat.W * fPFloat2;
		FPFloat fPFloat12 = quat.W * fPFloat3;
		result[0] = 4294967296L - (fPFloat5 + fPFloat6);
		result[1] = fPFloat7 + fPFloat12;
		result[2] = fPFloat8 - fPFloat11;
		result[3] = FPFloat.Zero;
		result[4] = fPFloat7 - fPFloat12;
		result[5] = 4294967296L - (fPFloat4 + fPFloat6);
		result[6] = fPFloat9 + fPFloat10;
		result[7] = FPFloat.Zero;
		result[8] = fPFloat8 + fPFloat11;
		result[9] = fPFloat9 - fPFloat10;
		result[10] = 4294967296L - (fPFloat4 + fPFloat5);
		result[11] = FPFloat.Zero;
		result[12] = FPFloat.Zero;
		result[13] = FPFloat.Zero;
		result[14] = FPFloat.Zero;
		result[15] = 4294967296L;
		return result;
	}

	private FPVector3 MatrixToEuler(FPMatrix4x4d m)
	{
		FPVector3 result = default;
		if (m[1, 2] < 4294967296L)
		{
			if (m[1, 2] > -4294967296L)
			{
				result.X = FPMath.Asin(-m[1, 2]);
				result.Y = FPMath.Atan2(m[0, 2], m[2, 2]);
				result.Z = FPMath.Atan2(m[1, 0], m[1, 1]);
			}
			else
			{
				result.X = FPMath.Pi * FPFloat.Half;
				result.Y = FPMath.Atan2(m[0, 1], m[0, 0]);
				result.Z = FPFloat.Zero;
			}
		}
		else
		{
			result.X = -FPMath.Pi * FPFloat.Half;
			result.Y = FPMath.Atan2(-m[0, 1], m[0, 0]);
			result.Z = FPFloat.Zero;
		}
		for (int i = 0; i < 3; i++)
		{
			if (result[i] < FPFloat.Zero)
			{
				result[i] += 2 * FPMath.Pi;
			}
			else if (result[i] > 2 * FPMath.Pi)
			{
				result[i] -= 2 * FPMath.Pi;
			}
		}
		return result;
	}

	public static FPQuaternion operator *(FPQuaternion value1, FPQuaternion value2)
	{
		Multiply(ref value1, ref value2, out var result);
		return result;
	}

	public static FPQuaternion operator +(FPQuaternion value1, FPQuaternion value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static FPQuaternion operator -(FPQuaternion value1, FPQuaternion value2)
	{
		Subtract(ref value1, ref value2, out var result);
		return result;
	}

	public static FPVector3 operator *(FPQuaternion quat, FPVector3 vec)
	{
		FPFloat fPFloat = quat.X * 2f;
		FPFloat fPFloat2 = quat.Y * 2f;
		FPFloat fPFloat3 = quat.Z * 2f;
		FPFloat fPFloat4 = quat.X * fPFloat;
		FPFloat fPFloat5 = quat.Y * fPFloat2;
		FPFloat fPFloat6 = quat.Z * fPFloat3;
		FPFloat fPFloat7 = quat.X * fPFloat2;
		FPFloat fPFloat8 = quat.X * fPFloat3;
		FPFloat fPFloat9 = quat.Y * fPFloat3;
		FPFloat fPFloat10 = quat.W * fPFloat;
		FPFloat fPFloat11 = quat.W * fPFloat2;
		FPFloat fPFloat12 = quat.W * fPFloat3;
		FPVector3 result = default;
		result.X = (1f - (fPFloat5 + fPFloat6)) * vec.X + (fPFloat7 - fPFloat12) * vec.Y + (fPFloat8 + fPFloat11) * vec.Z;
		result.Y = (fPFloat7 + fPFloat12) * vec.X + (1f - (fPFloat4 + fPFloat6)) * vec.Y + (fPFloat9 - fPFloat10) * vec.Z;
		result.Z = (fPFloat8 - fPFloat11) * vec.X + (fPFloat9 + fPFloat10) * vec.Y + (1f - (fPFloat4 + fPFloat5)) * vec.Z;
		return result;
	}

	public override string ToString()
	{
		return $"({X.AsFloat():f1}, {Y.AsFloat():f1}, {Z.AsFloat():f1}, {W.AsFloat():f1})";
	}

	public void SetValue(int i, FPFloat value)
	{
		switch (i)
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
		default:
			W = value;
			break;
		}
	}
}
