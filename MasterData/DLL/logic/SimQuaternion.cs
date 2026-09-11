public struct SimQuaternion
{
	public Int x;

	public Int y;

	public Int z;

	public Int w;

	public static readonly SimQuaternion identity;

	public Int3 eulerAngles
	{
		get
		{
			Int3 @int = default(Int3);
			Int obj = -2 * IntMath.Divide(y.i * y.i + z.i * z.i, 1000) + 1000;
			Int obj2 = IntMath.Divide(2 * (x.i * y.i - w.i * z.i), 1000);
			Int obj3 = IntMath.Divide(-2 * (x * z + w * y).i, 1000);
			Int obj4 = IntMath.Divide(2 * (y * z - w * x).i, 1000);
			Int obj5 = -2 * IntMath.Divide(x.i * x.i + y.i * y.i, 1000) + 1000;
			obj3 = ((obj3 > 1000) ? ((Int)1000) : obj3);
			obj3 = ((obj3 < -1000) ? ((Int)(-1000)) : obj3);
			@int.x = ((Int)(IntMath.atan2(obj4.i, obj5.i) * IntMath.Rad2Deg)).i;
			@int.y = ((Int)(IntMath.asin((VFactor)obj3) * IntMath.Rad2Deg)).i;
			@int.z = ((Int)(IntMath.atan2(obj2.i, obj.i) * IntMath.Rad2Deg)).i;
			return @int * -1;
		}
	}

	static SimQuaternion()
	{
		identity = new SimQuaternion(0, 0, 0, 0);
	}

	public SimQuaternion(Int x, Int y, Int z, Int w)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	public void Set(Int new_x, Int new_y, Int new_z, Int new_w)
	{
		x = new_x;
		y = new_y;
		z = new_z;
		w = new_w;
	}

	public void SetFromToRotation(Int3 fromDirection, Int3 toDirection)
	{
		SimQuaternion simQuaternion = FromToRotation(fromDirection, toDirection);
		Set(simQuaternion.x, simQuaternion.y, simQuaternion.z, simQuaternion.w);
	}

	public static SimQuaternion Euler(SimQuaternion eulerAngles)
	{
		return Euler(eulerAngles.x, eulerAngles.y, eulerAngles.z);
	}

	public static SimQuaternion RotateTowards(SimQuaternion from, SimQuaternion to, VFactor maxDegreesDelta)
	{
		Int obj = Dot(from, to);
		if (obj < 0)
		{
			to = Multiply(to, -VFactor.one);
			obj = -obj.i;
		}
		VFactor vFactor = IntMath.acos((VFactor)obj);
		VFactor vFactor2 = vFactor * 2L;
		maxDegreesDelta *= IntMath.Deg2Rad;
		if (maxDegreesDelta >= vFactor2)
		{
			return to;
		}
		maxDegreesDelta /= vFactor2;
		return Multiply(Multiply(from, IntMath.sin((VFactor.one - maxDegreesDelta) * vFactor)) + Multiply(to, IntMath.sin(maxDegreesDelta * vFactor)), VFactor.one / IntMath.sin(vFactor));
	}

	public static Int Dot(SimQuaternion a, SimQuaternion b)
	{
		return IntMath.Divide((a.w * b.w + a.x * b.x + a.y * b.y + a.z * b.z).i, 1000);
	}

	public static SimQuaternion Euler(Int x, Int y, Int z)
	{
		x *= IntMath.Deg2Rad;
		y *= IntMath.Deg2Rad;
		z *= IntMath.Deg2Rad;
		CreateFromYawPitchRoll(y, x, z, out var result);
		return result;
	}

	public static SimQuaternion Euler(Int3 eulerAngles)
	{
		return Euler(eulerAngles.x, eulerAngles.y, eulerAngles.z);
	}

	public static SimQuaternion AngleAxis(VFactor angle, Int3 axis)
	{
		axis *= IntMath.Deg2Rad;
		axis.Normalize();
		VFactor a = angle * IntMath.Deg2Rad * VFactor.half;
		VFactor vFactor = IntMath.sin(a);
		SimQuaternion result = default(SimQuaternion);
		result.x = (Int)(axis.x * vFactor);
		result.y = (Int)(axis.y * vFactor);
		result.z = (Int)(axis.z * vFactor);
		result.w = (Int)IntMath.cos(a);
		return result;
	}

	public static void CreateFromYawPitchRoll(Int yaw, Int pitch, Int roll, out SimQuaternion result)
	{
		Int obj = roll * VFactor.half;
		VFactor vFactor = IntMath.sin((VFactor)obj);
		VFactor vFactor2 = IntMath.cos((VFactor)obj);
		Int obj2 = pitch * VFactor.half;
		VFactor vFactor3 = IntMath.sin((VFactor)obj2);
		VFactor vFactor4 = IntMath.cos((VFactor)obj2);
		Int obj3 = yaw * VFactor.half;
		VFactor vFactor5 = IntMath.sin((VFactor)obj3);
		VFactor vFactor6 = IntMath.cos((VFactor)obj3);
		result.x = (Int)(vFactor6 * vFactor3 * vFactor2 + vFactor5 * vFactor4 * vFactor);
		result.y = (Int)(vFactor5 * vFactor4 * vFactor2 - vFactor6 * vFactor3 * vFactor);
		result.z = (Int)(vFactor6 * vFactor4 * vFactor - vFactor5 * vFactor3 * vFactor2);
		result.w = (Int)(vFactor6 * vFactor4 * vFactor2 + vFactor5 * vFactor3 * vFactor);
	}

	public static void Add(ref SimQuaternion quaternion1, ref SimQuaternion quaternion2, out SimQuaternion result)
	{
		result.x = quaternion1.x + quaternion2.x;
		result.y = quaternion1.y + quaternion2.y;
		result.z = quaternion1.z + quaternion2.z;
		result.w = quaternion1.w + quaternion2.w;
	}

	public static VFactor Angle(SimQuaternion a, SimQuaternion b)
	{
		SimQuaternion simQuaternion = Inverse(a);
		VFactor vFactor = IntMath.acos((VFactor)(b * simQuaternion).w) * 2L * IntMath.Rad2Deg;
		if (vFactor > IntMath.PI * IntMath.Rad2Deg)
		{
			vFactor = IntMath.PI * IntMath.Rad2Deg * 2L - vFactor;
		}
		return vFactor;
	}

	public static SimQuaternion FromToRotation(Int3 fromVector, Int3 toVector)
	{
		Int3 @int = Int3.Cross(fromVector, toVector);
		SimQuaternion result = new SimQuaternion(@int.x, @int.y, @int.z, IntMath.Divide(Int3.Dot(fromVector, toVector), 1000));
		long sqrMagnitudeLong = fromVector.sqrMagnitudeLong;
		long sqrMagnitudeLong2 = toVector.sqrMagnitudeLong;
		result.w += (Int)IntMath.Divide(IntMath.Sqrt(sqrMagnitudeLong) * IntMath.Sqrt(sqrMagnitudeLong2), 1000);
		result.Normalize();
		return result;
	}

	public void Normalize()
	{
		long num = (long)x.i * (long)x.i + (long)y.i * (long)y.i + (long)z.i * (long)z.i + (long)w.i * (long)w.i;
		VFactor vFactor = VFactor.zero;
		if (num != 0L)
		{
			vFactor = new VFactor(1000L, IntMath.Sqrt(num));
		}
		x *= vFactor;
		y *= vFactor;
		z *= vFactor;
		w *= vFactor;
	}

	public static SimQuaternion Inverse(SimQuaternion rotation)
	{
		return Multiply(scaleFactor: new VFactor(1000L, IntMath.Divide((rotation.x * rotation.x + rotation.y * rotation.y + rotation.z * rotation.z + rotation.w * rotation.w).i, 1000)), quaternion1: Conjugate(rotation));
	}

	public static SimQuaternion Multiply(SimQuaternion quaternion1, VFactor scaleFactor)
	{
		Multiply(ref quaternion1, scaleFactor, out var result);
		return result;
	}

	public static void Multiply(ref SimQuaternion quaternion1, VFactor scaleFactor, out SimQuaternion result)
	{
		result.x = quaternion1.x * scaleFactor;
		result.y = quaternion1.y * scaleFactor;
		result.z = quaternion1.z * scaleFactor;
		result.w = quaternion1.w * scaleFactor;
	}

	public static SimQuaternion Conjugate(SimQuaternion value)
	{
		SimQuaternion result = default(SimQuaternion);
		result.x = -value.x.i;
		result.y = -value.y.i;
		result.z = -value.z.i;
		result.w = value.w;
		return result;
	}

	public static SimQuaternion operator *(SimQuaternion value1, SimQuaternion value2)
	{
		Multiply(ref value1, ref value2, out var result);
		return result;
	}

	public static void Multiply(ref SimQuaternion quaternion1, ref SimQuaternion quaternion2, out SimQuaternion result)
	{
		Int obj = quaternion1.x;
		Int obj2 = quaternion1.y;
		Int obj3 = quaternion1.z;
		Int obj4 = quaternion1.w;
		Int obj5 = quaternion2.x;
		Int obj6 = quaternion2.y;
		Int obj7 = quaternion2.z;
		Int obj8 = quaternion2.w;
		Int obj9 = IntMath.Divide((obj2 * obj7 - obj3 * obj6).i, 1000);
		Int obj10 = obj3 * obj5 - obj * obj7;
		Int obj11 = obj * obj6 - obj2 * obj5;
		Int obj12 = obj * obj5 + obj2 * obj6 + obj3 * obj7;
		result.x = obj * obj8 + obj5 * obj4 + obj9;
		result.y = obj2 * obj8 + obj6 * obj4 + obj10;
		result.z = obj3 * obj8 + obj7 * obj4 + obj11;
		result.w = obj4 * obj8 - obj12;
	}

	public static Int3 operator *(SimQuaternion quat, Int3 vec)
	{
		Int obj = IntMath.Divide(quat.x.i * (quat.x.i * 2), 1000);
		Int obj2 = IntMath.Divide(quat.y.i * (quat.y.i * 2), 1000);
		Int obj3 = IntMath.Divide(quat.z.i * (quat.z.i * 2), 1000);
		Int obj4 = IntMath.Divide(quat.x.i * (quat.y.i * 2), 1000);
		Int obj5 = IntMath.Divide(quat.x.i * (quat.z.i * 2), 1000);
		Int obj6 = IntMath.Divide(quat.y.i * (quat.z.i * 2), 1000);
		Int obj7 = IntMath.Divide(quat.w.i * (quat.x.i * 2), 1000);
		Int obj8 = IntMath.Divide(quat.w.i * (quat.y.i * 2), 1000);
		Int obj9 = IntMath.Divide(quat.w.i * (quat.z.i * 2), 1000);
		Int3 result = default(Int3);
		result.x = IntMath.Divide((vec.x * (1000 - (obj2 + obj3)) + vec.y * (obj4 - obj9) + vec.z * (obj5 + obj8)).i, 1000);
		result.y = IntMath.Divide(((obj4 + obj9) * vec.x + (1000 - (obj + obj3)) * vec.y + (obj6 - obj7) * vec.z).i, 1000);
		result.z = IntMath.Divide(((obj5 - obj8) * vec.x + (obj6 + obj7) * vec.y + (1000 - (obj + obj2)) * vec.z).i, 1000);
		return result;
	}

	public static SimQuaternion operator +(SimQuaternion value1, SimQuaternion value2)
	{
		Add(ref value1, ref value2, out var result);
		return result;
	}

	public static SimQuaternion operator -(SimQuaternion value1, SimQuaternion value2)
	{
		Subtract(ref value1, ref value2, out var result);
		return result;
	}

	public static void Subtract(ref SimQuaternion quaternion1, ref SimQuaternion quaternion2, out SimQuaternion result)
	{
		result.x = quaternion1.x - quaternion2.x;
		result.y = quaternion1.y - quaternion2.y;
		result.z = quaternion1.z - quaternion2.z;
		result.w = quaternion1.w - quaternion2.w;
	}
}
