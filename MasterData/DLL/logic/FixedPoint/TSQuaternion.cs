using System;

namespace FixedPoint;

[Serializable]
public struct TSQuaternion
{
	public FP x;

	public FP y;

	public FP z;

	public FP w;

	public static readonly TSQuaternion identity;

	public TSVector eulerAngles
	{
		get
		{
			TSVector tSVector = default(TSVector);
			FP fP = y * y;
			FP fP2 = -2f * (fP + z * z) + 1f;
			FP fP3 = 2f * (x * y - w * z);
			FP fP4 = -2f * (x * z + w * y);
			FP fP5 = 2f * (y * z - w * x);
			FP fP6 = -2f * (x * x + fP) + 1f;
			fP4 = ((fP4 > 1f) ? ((FP)1f) : fP4);
			fP4 = ((fP4 < -1f) ? ((FP)(-1f)) : fP4);
			tSVector.x = FP.Atan2(fP5, fP6) * FP.Rad2Deg;
			tSVector.y = FP.Asin(fP4) * FP.Rad2Deg;
			tSVector.z = FP.Atan2(fP3, fP2) * FP.Rad2Deg;
			return tSVector * -1;
		}
	}

	static TSQuaternion()
	{
		identity = new TSQuaternion(0, 0, 0, 1);
	}

	public TSQuaternion(FP x, FP y, FP z, FP w)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	public void Set(FP new_x, FP new_y, FP new_z, FP new_w)
	{
		x = new_x;
		y = new_y;
		z = new_z;
		w = new_w;
	}

	public void SetFromToRotation(TSVector fromDirection, TSVector toDirection)
	{
		TSQuaternion tSQuaternion = FromToRotation(fromDirection, toDirection);
		Set(tSQuaternion.x, tSQuaternion.y, tSQuaternion.z, tSQuaternion.w);
	}

	public static FP Angle(TSQuaternion a, TSQuaternion b)
	{
		TSQuaternion tSQuaternion = Inverse(a);
		FP fP = FP.Acos((b * tSQuaternion).w) * 2 * FP.Rad2Deg;
		if (fP > 180)
		{
			fP = 360 - fP;
		}
		return fP;
	}

	public static TSQuaternion Add(TSQuaternion quaternion1, TSQuaternion quaternion2)
	{
		Add(ref quaternion1, ref quaternion2, out var result);
		return result;
	}

	public static TSQuaternion LookRotation(TSVector forward)
	{
		return CreateFromMatrix(TSMatrix.LookAt(forward, TSVector.up));
	}

	public static TSQuaternion LookRotation(TSVector forward, TSVector upwards)
	{
		return CreateFromMatrix(TSMatrix.LookAt(forward, upwards));
	}

	public static TSQuaternion Slerp(TSQuaternion from, TSQuaternion to, FP t)
	{
		t = TSMath.Clamp(t, 0, 1);
		FP fP = Dot(from, to);
		if (fP < 0f)
		{
			to = Multiply(to, -1);
			fP = -fP;
		}
		FP fP2 = FP.Acos(fP);
		return Multiply(Multiply(from, FP.Sin((1 - t) * fP2)) + Multiply(to, FP.Sin(t * fP2)), 1 / FP.Sin(fP2));
	}

	public static TSQuaternion RotateTowards(TSQuaternion from, TSQuaternion to, FP maxDegreesDelta)
	{
		FP fP = Dot(from, to);
		if (fP < 0f)
		{
			to = Multiply(to, -1);
			fP = -fP;
		}
		FP fP2 = FP.Acos(fP);
		FP fP3 = fP2 * 2;
		maxDegreesDelta *= FP.Deg2Rad;
		if (maxDegreesDelta >= fP3)
		{
			return to;
		}
		maxDegreesDelta /= fP3;
		return Multiply(Multiply(from, FP.Sin((1 - maxDegreesDelta) * fP2)) + Multiply(to, FP.Sin(maxDegreesDelta * fP2)), 1 / FP.Sin(fP2));
	}

	public static TSQuaternion Euler(FP x, FP y, FP z)
	{
		x *= FP.Deg2Rad;
		y *= FP.Deg2Rad;
		z *= FP.Deg2Rad;
		CreateFromYawPitchRoll(y, x, z, out var result);
		return result;
	}

	public static TSQuaternion Euler(TSVector eulerAngles)
	{
		return Euler(eulerAngles.x, eulerAngles.y, eulerAngles.z);
	}

	public static TSQuaternion AngleAxis(FP angle, TSVector axis)
	{
		axis *= FP.Deg2Rad;
		axis.Normalize();
		FP fP = angle * FP.Deg2Rad * FP.Half;
		FP fP2 = FP.Sin(fP);
		TSQuaternion result = default(TSQuaternion);
		result.x = axis.x * fP2;
		result.y = axis.y * fP2;
		result.z = axis.z * fP2;
		result.w = FP.Cos(fP);
		return result;
	}

	public static void CreateFromYawPitchRoll(FP yaw, FP pitch, FP roll, out TSQuaternion result)
	{
		FP fP = roll * FP.Half;
		FP fP2 = FP.Sin(fP);
		FP fP3 = FP.Cos(fP);
		FP fP4 = pitch * FP.Half;
		FP fP5 = FP.Sin(fP4);
		FP fP6 = FP.Cos(fP4);
		FP fP7 = yaw * FP.Half;
		FP fP8 = FP.Sin(fP7);
		FP fP9 = FP.Cos(fP7);
		result.x = fP9 * fP5 * fP3 + fP8 * fP6 * fP2;
		result.y = fP8 * fP6 * fP3 - fP9 * fP5 * fP2;
		result.z = fP9 * fP6 * fP2 - fP8 * fP5 * fP3;
		result.w = fP9 * fP6 * fP3 + fP8 * fP5 * fP2;
	}

	public static void Add(ref TSQuaternion quaternion1, ref TSQuaternion quaternion2, out TSQuaternion result)
	{
		result.x = quaternion1.x + quaternion2.x;
		result.y = quaternion1.y + quaternion2.y;
		result.z = quaternion1.z + quaternion2.z;
		result.w = quaternion1.w + quaternion2.w;
	}

	public static TSQuaternion Conjugate(TSQuaternion value)
	{
		TSQuaternion result = default(TSQuaternion);
		result.x = -value.x;
		result.y = -value.y;
		result.z = -value.z;
		result.w = value.w;
		return result;
	}

	public static FP Dot(TSQuaternion a, TSQuaternion b)
	{
		return a.w * b.w + a.x * b.x + a.y * b.y + a.z * b.z;
	}

	public static TSQuaternion Inverse(TSQuaternion rotation)
	{
		FP scaleFactor = FP.One / (rotation.x * rotation.x + rotation.y * rotation.y + rotation.z * rotation.z + rotation.w * rotation.w);
		return Multiply(Conjugate(rotation), scaleFactor);
	}

	public static TSQuaternion FromToRotation(TSVector fromVector, TSVector toVector)
	{
		TSVector tSVector = TSVector.Cross(fromVector, toVector);
		TSQuaternion result = new TSQuaternion(tSVector.x, tSVector.y, tSVector.z, TSVector.Dot(fromVector, toVector));
		string[] obj = new string[8] { "TSQuaternion q.x == ", null, null, null, null, null, null, null };
		FP fP = result.x;
		obj[1] = fP.ToString();
		obj[2] = ",q.y == ";
		fP = result.y;
		obj[3] = fP.ToString();
		obj[4] = "q.z == ";
		fP = result.z;
		obj[5] = fP.ToString();
		obj[6] = "q.w== ";
		fP = result.w;
		obj[7] = fP.ToString();
		XLogger.Debug(string.Concat(obj));
		result.w += FP.Sqrt(fromVector.sqrMagnitude * toVector.sqrMagnitude);
		fP = result.w;
		XLogger.Debug("TSQuaternion q.w == " + fP.ToString());
		result.Normalize();
		return result;
	}

	public static TSQuaternion Lerp(TSQuaternion a, TSQuaternion b, FP t)
	{
		t = TSMath.Clamp(t, FP.Zero, FP.One);
		return LerpUnclamped(a, b, t);
	}

	public static TSQuaternion LerpUnclamped(TSQuaternion a, TSQuaternion b, FP t)
	{
		TSQuaternion result = Multiply(a, 1 - t) + Multiply(b, t);
		result.Normalize();
		return result;
	}

	public static TSQuaternion Subtract(TSQuaternion quaternion1, TSQuaternion quaternion2)
	{
		Subtract(ref quaternion1, ref quaternion2, out var result);
		return result;
	}

	public static void Subtract(ref TSQuaternion quaternion1, ref TSQuaternion quaternion2, out TSQuaternion result)
	{
		result.x = quaternion1.x - quaternion2.x;
		result.y = quaternion1.y - quaternion2.y;
		result.z = quaternion1.z - quaternion2.z;
		result.w = quaternion1.w - quaternion2.w;
	}

	public static TSQuaternion Multiply(TSQuaternion quaternion1, TSQuaternion quaternion2)
	{
		Multiply(ref quaternion1, ref quaternion2, out var result);
		return result;
	}

	public static void Multiply(ref TSQuaternion quaternion1, ref TSQuaternion quaternion2, out TSQuaternion result)
	{
		FP fP = quaternion1.x;
		FP fP2 = quaternion1.y;
		FP fP3 = quaternion1.z;
		FP fP4 = quaternion1.w;
		FP fP5 = quaternion2.x;
		FP fP6 = quaternion2.y;
		FP fP7 = quaternion2.z;
		FP fP8 = quaternion2.w;
		FP fP9 = fP2 * fP7 - fP3 * fP6;
		FP fP10 = fP3 * fP5 - fP * fP7;
		FP fP11 = fP * fP6 - fP2 * fP5;
		FP fP12 = fP * fP5 + fP2 * fP6 + fP3 * fP7;
		result.x = fP * fP8 + fP5 * fP4 + fP9;
		result.y = fP2 * fP8 + fP6 * fP4 + fP10;
		result.z = fP3 * fP8 + fP7 * fP4 + fP11;
		result.w = fP4 * fP8 - fP12;
	}

	public static TSQuaternion Multiply(TSQuaternion quaternion1, FP scaleFactor)
	{
		Multiply(ref quaternion1, scaleFactor, out var result);
		return result;
	}

	public static void Multiply(ref TSQuaternion quaternion1, FP scaleFactor, out TSQuaternion result)
	{
		result.x = quaternion1.x * scaleFactor;
		result.y = quaternion1.y * scaleFactor;
		result.z = quaternion1.z * scaleFactor;
		result.w = quaternion1.w * scaleFactor;
	}

	public void Normalize()
	{
		FP fP = x * x + y * y + z * z + w * w;
		FP fP2 = fP;
		XLogger.Debug("num2== " + fP2.ToString());
		FP fP3 = 1 / FP.Sqrt(fP);
		fP2 = fP3;
		XLogger.Debug("num == " + fP2.ToString());
		x *= fP3;
		y *= fP3;
		z *= fP3;
		w *= fP3;
	}

	public static TSQuaternion CreateFromMatrix(TSMatrix matrix)
	{
		CreateFromMatrix(ref matrix, out var result);
		return result;
	}

	public static void CreateFromMatrix(ref TSMatrix matrix, out TSQuaternion result)
	{
		string[] obj = new string[6] { "x == ", null, null, null, null, null };
		FP m = matrix.M11;
		obj[1] = m.ToString();
		obj[2] = ",";
		m = matrix.M12;
		obj[3] = m.ToString();
		obj[4] = ",";
		m = matrix.M13;
		obj[5] = m.ToString();
		XLogger.Debug(string.Concat(obj));
		string[] obj2 = new string[6] { "y == ", null, null, null, null, null };
		m = matrix.M21;
		obj2[1] = m.ToString();
		obj2[2] = ",";
		m = matrix.M22;
		obj2[3] = m.ToString();
		obj2[4] = ",";
		m = matrix.M23;
		obj2[5] = m.ToString();
		XLogger.Debug(string.Concat(obj2));
		string[] obj3 = new string[6] { "z == ", null, null, null, null, null };
		m = matrix.M31;
		obj3[1] = m.ToString();
		obj3[2] = ",";
		m = matrix.M32;
		obj3[3] = m.ToString();
		obj3[4] = ",";
		m = matrix.M33;
		obj3[5] = m.ToString();
		XLogger.Debug(string.Concat(obj3));
		FP fP = matrix.M11 + matrix.M22 + matrix.M33;
		if (fP > FP.Zero)
		{
			m = fP;
			XLogger.Debug("num8 == " + m.ToString());
			FP fP2 = FP.Sqrt(fP + FP.One);
			m = fP2;
			XLogger.Debug("num1 == " + m.ToString());
			result.w = fP2 * FP.Half;
			fP2 = FP.Half / fP2;
			m = fP2;
			XLogger.Debug("num2 == " + m.ToString());
			m = matrix.M23;
			string text = m.ToString();
			m = matrix.M32;
			XLogger.Debug("(matrix.M23,matrix.M32 == " + text + "," + m.ToString());
			result.x = (matrix.M23 - matrix.M32) * fP2;
			result.y = (matrix.M31 - matrix.M13) * fP2;
			result.z = (matrix.M12 - matrix.M21) * fP2;
			string[] obj4 = new string[8] { "result == ", null, null, null, null, null, null, null };
			m = result.x;
			obj4[1] = m.ToString();
			obj4[2] = ",";
			m = result.y;
			obj4[3] = m.ToString();
			obj4[4] = ",";
			m = result.z;
			obj4[5] = m.ToString();
			obj4[6] = ",";
			m = result.w;
			obj4[7] = m.ToString();
			XLogger.Debug(string.Concat(obj4));
		}
		else if (matrix.M11 >= matrix.M22 && matrix.M11 >= matrix.M33)
		{
			FP fP3 = FP.Sqrt(FP.One + matrix.M11 - matrix.M22 - matrix.M33);
			FP fP4 = FP.Half / fP3;
			result.x = FP.Half * fP3;
			result.y = (matrix.M12 + matrix.M21) * fP4;
			result.z = (matrix.M13 + matrix.M31) * fP4;
			result.w = (matrix.M23 - matrix.M32) * fP4;
		}
		else if (matrix.M22 > matrix.M33)
		{
			FP fP5 = FP.Sqrt(FP.One + matrix.M22 - matrix.M11 - matrix.M33);
			FP fP6 = FP.Half / fP5;
			result.x = (matrix.M21 + matrix.M12) * fP6;
			result.y = FP.Half * fP5;
			result.z = (matrix.M32 + matrix.M23) * fP6;
			result.w = (matrix.M31 - matrix.M13) * fP6;
		}
		else
		{
			FP fP7 = FP.Sqrt(FP.One + matrix.M33 - matrix.M11 - matrix.M22);
			FP fP8 = FP.Half / fP7;
			result.x = (matrix.M31 + matrix.M13) * fP8;
			result.y = (matrix.M32 + matrix.M23) * fP8;
			result.z = FP.Half * fP7;
			result.w = (matrix.M12 - matrix.M21) * fP8;
		}
	}

	public static TSQuaternion operator *(TSQuaternion value1, TSQuaternion value2)
	{
		Multiply(ref value1, ref value2, out var result);
		return result;
	}

	public static TSQuaternion operator +(TSQuaternion value1, TSQuaternion value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static TSQuaternion operator -(TSQuaternion value1, TSQuaternion value2)
	{
		Subtract(ref value1, ref value2, out var result);
		return result;
	}

	public static TSVector operator *(TSQuaternion quat, TSVector vec)
	{
		FP fP = quat.x * 2f;
		FP fP2 = quat.y * 2f;
		FP fP3 = quat.z * 2f;
		FP fP4 = quat.x * fP;
		FP fP5 = quat.y * fP2;
		FP fP6 = quat.z * fP3;
		FP fP7 = quat.x * fP2;
		FP fP8 = quat.x * fP3;
		FP fP9 = quat.y * fP3;
		FP fP10 = quat.w * fP;
		FP fP11 = quat.w * fP2;
		FP fP12 = quat.w * fP3;
		TSVector result = default(TSVector);
		result.x = (1f - (fP5 + fP6)) * vec.x + (fP7 - fP12) * vec.y + (fP8 + fP11) * vec.z;
		result.y = (fP7 + fP12) * vec.x + (1f - (fP4 + fP6)) * vec.y + (fP9 - fP10) * vec.z;
		result.z = (fP8 - fP11) * vec.x + (fP9 + fP10) * vec.y + (1f - (fP4 + fP5)) * vec.z;
		return result;
	}

	public override string ToString()
	{
		return $"({x.AsFloat():f1}, {y.AsFloat():f1}, {z.AsFloat():f1}, {w.AsFloat():f1})";
	}
}
