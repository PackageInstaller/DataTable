using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using Unity.IL2CPP.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[NativeHeader("Runtime/Math/Vector3.h")]
[NativeHeader("Runtime/Math/MathScripting.h")]
[NativeType(Header = "Runtime/Math/Vector3.h")]
[NativeClass("Vector3f")]
[Il2CppEagerStaticClassConstruction]
public struct Vector3 : IEquatable<Vector3>, IFormattable
{
	public const float kEpsilon = 1E-05f;

	public const float kEpsilonNormalSqrt = 1E-15f;

	public float x;

	public float y;

	public float z;

	private static readonly Vector3 zeroVector = new Vector3(0f, 0f, 0f);

	private static readonly Vector3 oneVector = new Vector3(1f, 1f, 1f);

	private static readonly Vector3 upVector = new Vector3(0f, 1f, 0f);

	private static readonly Vector3 downVector = new Vector3(0f, -1f, 0f);

	private static readonly Vector3 leftVector = new Vector3(-1f, 0f, 0f);

	private static readonly Vector3 rightVector = new Vector3(1f, 0f, 0f);

	private static readonly Vector3 forwardVector = new Vector3(0f, 0f, 1f);

	private static readonly Vector3 backVector = new Vector3(0f, 0f, -1f);

	private static readonly Vector3 positiveInfinityVector = new Vector3(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity);

	private static readonly Vector3 negativeInfinityVector = new Vector3(float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity);

	public float this[int index]
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return index switch
			{
				0 => x, 
				1 => y, 
				2 => z, 
				_ => throw new IndexOutOfRangeException("Invalid Vector3 index!"), 
			};
		}
		[MethodImpl((MethodImplOptions)256)]
		set
		{
			switch (index)
			{
			case 0:
				x = value;
				break;
			case 1:
				y = value;
				break;
			case 2:
				z = value;
				break;
			default:
				throw new IndexOutOfRangeException("Invalid Vector3 index!");
			}
		}
	}

	public Vector3 normalized
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Normalize(this);
		}
	}

	public float magnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return (float)Math.Sqrt(x * x + y * y + z * z);
		}
	}

	public float sqrMagnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return x * x + y * y + z * z;
		}
	}

	public static Vector3 zero
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return zeroVector;
		}
	}

	public static Vector3 one
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return oneVector;
		}
	}

	public static Vector3 forward
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return forwardVector;
		}
	}

	public static Vector3 back
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return backVector;
		}
	}

	public static Vector3 up
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return upVector;
		}
	}

	public static Vector3 down
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return downVector;
		}
	}

	public static Vector3 left
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return leftVector;
		}
	}

	public static Vector3 right
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return rightVector;
		}
	}

	public static Vector3 positiveInfinity
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return positiveInfinityVector;
		}
	}

	public static Vector3 negativeInfinity
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return negativeInfinityVector;
		}
	}

	[Obsolete("Use Vector3.forward instead.")]
	public static Vector3 fwd => new Vector3(0f, 0f, 1f);

	[FreeFunction("VectorScripting::Slerp", IsThreadSafe = true)]
	public static Vector3 Slerp(Vector3 a, Vector3 b, float t)
	{
		Slerp_Injected(ref a, ref b, t, out var ret);
		return ret;
	}

	[FreeFunction("VectorScripting::SlerpUnclamped", IsThreadSafe = true)]
	public static Vector3 SlerpUnclamped(Vector3 a, Vector3 b, float t)
	{
		SlerpUnclamped_Injected(ref a, ref b, t, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("VectorScripting::OrthoNormalize", IsThreadSafe = true)]
	private static extern void OrthoNormalize2(ref Vector3 a, ref Vector3 b);

	public static void OrthoNormalize(ref Vector3 normal, ref Vector3 tangent)
	{
		OrthoNormalize2(ref normal, ref tangent);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("VectorScripting::OrthoNormalize", IsThreadSafe = true)]
	private static extern void OrthoNormalize3(ref Vector3 a, ref Vector3 b, ref Vector3 c);

	public static void OrthoNormalize(ref Vector3 normal, ref Vector3 tangent, ref Vector3 binormal)
	{
		OrthoNormalize3(ref normal, ref tangent, ref binormal);
	}

	[FreeFunction(IsThreadSafe = true)]
	public static Vector3 RotateTowards(Vector3 current, Vector3 target, float maxRadiansDelta, float maxMagnitudeDelta)
	{
		RotateTowards_Injected(ref current, ref target, maxRadiansDelta, maxMagnitudeDelta, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 Lerp(Vector3 a, Vector3 b, float t)
	{
		t = Mathf.Clamp01(t);
		return new Vector3(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t, a.z + (b.z - a.z) * t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 LerpUnclamped(Vector3 a, Vector3 b, float t)
	{
		return new Vector3(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t, a.z + (b.z - a.z) * t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 MoveTowards(Vector3 current, Vector3 target, float maxDistanceDelta)
	{
		float num = target.x - current.x;
		float num2 = target.y - current.y;
		float num3 = target.z - current.z;
		float num4 = num * num + num2 * num2 + num3 * num3;
		if (num4 == 0f || (maxDistanceDelta >= 0f && num4 <= maxDistanceDelta * maxDistanceDelta))
		{
			return target;
		}
		float num5 = (float)Math.Sqrt(num4);
		return new Vector3(current.x + num / num5 * maxDistanceDelta, current.y + num2 / num5 * maxDistanceDelta, current.z + num3 / num5 * maxDistanceDelta);
	}

	[MethodImpl((MethodImplOptions)256)]
	[ExcludeFromDocs]
	public static Vector3 SmoothDamp(Vector3 current, Vector3 target, ref Vector3 currentVelocity, float smoothTime, float maxSpeed)
	{
		float deltaTime = Time.deltaTime;
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	[MethodImpl((MethodImplOptions)256)]
	[ExcludeFromDocs]
	public static Vector3 SmoothDamp(Vector3 current, Vector3 target, ref Vector3 currentVelocity, float smoothTime)
	{
		float deltaTime = Time.deltaTime;
		float maxSpeed = float.PositiveInfinity;
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	public static Vector3 SmoothDamp(Vector3 current, Vector3 target, ref Vector3 currentVelocity, float smoothTime, [DefaultValue("Mathf.Infinity")] float maxSpeed, [DefaultValue("Time.deltaTime")] float deltaTime)
	{
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		smoothTime = Mathf.Max(0.0001f, smoothTime);
		float num4 = 2f / smoothTime;
		float num5 = num4 * deltaTime;
		float num6 = 1f / (1f + num5 + 0.48f * num5 * num5 + 0.235f * num5 * num5 * num5);
		float num7 = current.x - target.x;
		float num8 = current.y - target.y;
		float num9 = current.z - target.z;
		Vector3 vector = target;
		float num10 = maxSpeed * smoothTime;
		float num11 = num10 * num10;
		float num12 = num7 * num7 + num8 * num8 + num9 * num9;
		if (num12 > num11)
		{
			float num13 = (float)Math.Sqrt(num12);
			num7 = num7 / num13 * num10;
			num8 = num8 / num13 * num10;
			num9 = num9 / num13 * num10;
		}
		target.x = current.x - num7;
		target.y = current.y - num8;
		target.z = current.z - num9;
		float num14 = (currentVelocity.x + num4 * num7) * deltaTime;
		float num15 = (currentVelocity.y + num4 * num8) * deltaTime;
		float num16 = (currentVelocity.z + num4 * num9) * deltaTime;
		currentVelocity.x = (currentVelocity.x - num4 * num14) * num6;
		currentVelocity.y = (currentVelocity.y - num4 * num15) * num6;
		currentVelocity.z = (currentVelocity.z - num4 * num16) * num6;
		num = target.x + (num7 + num14) * num6;
		num2 = target.y + (num8 + num15) * num6;
		num3 = target.z + (num9 + num16) * num6;
		float num17 = vector.x - current.x;
		float num18 = vector.y - current.y;
		float num19 = vector.z - current.z;
		float num20 = num - vector.x;
		float num21 = num2 - vector.y;
		float num22 = num3 - vector.z;
		if (num17 * num20 + num18 * num21 + num19 * num22 > 0f)
		{
			num = vector.x;
			num2 = vector.y;
			num3 = vector.z;
			currentVelocity.x = (num - vector.x) / deltaTime;
			currentVelocity.y = (num2 - vector.y) / deltaTime;
			currentVelocity.z = (num3 - vector.z) / deltaTime;
		}
		return new Vector3(num, num2, num3);
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector3(float x, float y, float z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector3(float x, float y)
	{
		this.x = x;
		this.y = y;
		z = 0f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Set(float newX, float newY, float newZ)
	{
		x = newX;
		y = newY;
		z = newZ;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 Scale(Vector3 a, Vector3 b)
	{
		return new Vector3(a.x * b.x, a.y * b.y, a.z * b.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Scale(Vector3 scale)
	{
		x *= scale.x;
		y *= scale.y;
		z *= scale.z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 Cross(Vector3 lhs, Vector3 rhs)
	{
		return new Vector3(lhs.y * rhs.z - lhs.z * rhs.y, lhs.z * rhs.x - lhs.x * rhs.z, lhs.x * rhs.y - lhs.y * rhs.x);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		return x.GetHashCode() ^ (y.GetHashCode() << 2) ^ (z.GetHashCode() >> 2);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Vector3))
		{
			return false;
		}
		return Equals((Vector3)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Vector3 other)
	{
		return x == other.x && y == other.y && z == other.z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 Reflect(Vector3 inDirection, Vector3 inNormal)
	{
		float num = -2f * Dot(inNormal, inDirection);
		return new Vector3(num * inNormal.x + inDirection.x, num * inNormal.y + inDirection.y, num * inNormal.z + inDirection.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 Normalize(Vector3 value)
	{
		float num = Magnitude(value);
		if (num > 1E-05f)
		{
			return value / num;
		}
		return zero;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Normalize()
	{
		float num = Magnitude(this);
		if (num > 1E-05f)
		{
			this /= num;
		}
		else
		{
			this = zero;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Dot(Vector3 lhs, Vector3 rhs)
	{
		return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 Project(Vector3 vector, Vector3 onNormal)
	{
		float num = Dot(onNormal, onNormal);
		if (num < Mathf.Epsilon)
		{
			return zero;
		}
		float num2 = Dot(vector, onNormal);
		return new Vector3(onNormal.x * num2 / num, onNormal.y * num2 / num, onNormal.z * num2 / num);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 ProjectOnPlane(Vector3 vector, Vector3 planeNormal)
	{
		float num = Dot(planeNormal, planeNormal);
		if (num < Mathf.Epsilon)
		{
			return vector;
		}
		float num2 = Dot(vector, planeNormal);
		return new Vector3(vector.x - planeNormal.x * num2 / num, vector.y - planeNormal.y * num2 / num, vector.z - planeNormal.z * num2 / num);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Angle(Vector3 from, Vector3 to)
	{
		float num = (float)Math.Sqrt(from.sqrMagnitude * to.sqrMagnitude);
		if (num < 1E-15f)
		{
			return 0f;
		}
		float num2 = Mathf.Clamp(Dot(from, to) / num, -1f, 1f);
		return (float)Math.Acos(num2) * 57.29578f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float SignedAngle(Vector3 from, Vector3 to, Vector3 axis)
	{
		float num = Angle(from, to);
		float num2 = from.y * to.z - from.z * to.y;
		float num3 = from.z * to.x - from.x * to.z;
		float num4 = from.x * to.y - from.y * to.x;
		float num5 = Mathf.Sign(axis.x * num2 + axis.y * num3 + axis.z * num4);
		return num * num5;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Distance(Vector3 a, Vector3 b)
	{
		float num = a.x - b.x;
		float num2 = a.y - b.y;
		float num3 = a.z - b.z;
		return (float)Math.Sqrt(num * num + num2 * num2 + num3 * num3);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 ClampMagnitude(Vector3 vector, float maxLength)
	{
		float num = vector.sqrMagnitude;
		if (num > maxLength * maxLength)
		{
			float num2 = (float)Math.Sqrt(num);
			float num3 = vector.x / num2;
			float num4 = vector.y / num2;
			float num5 = vector.z / num2;
			return new Vector3(num3 * maxLength, num4 * maxLength, num5 * maxLength);
		}
		return vector;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Magnitude(Vector3 vector)
	{
		return (float)Math.Sqrt(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float SqrMagnitude(Vector3 vector)
	{
		return vector.x * vector.x + vector.y * vector.y + vector.z * vector.z;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 Min(Vector3 lhs, Vector3 rhs)
	{
		return new Vector3(Mathf.Min(lhs.x, rhs.x), Mathf.Min(lhs.y, rhs.y), Mathf.Min(lhs.z, rhs.z));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 Max(Vector3 lhs, Vector3 rhs)
	{
		return new Vector3(Mathf.Max(lhs.x, rhs.x), Mathf.Max(lhs.y, rhs.y), Mathf.Max(lhs.z, rhs.z));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 operator +(Vector3 a, Vector3 b)
	{
		return new Vector3(a.x + b.x, a.y + b.y, a.z + b.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 operator -(Vector3 a, Vector3 b)
	{
		return new Vector3(a.x - b.x, a.y - b.y, a.z - b.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 operator -(Vector3 a)
	{
		return new Vector3(0f - a.x, 0f - a.y, 0f - a.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 operator *(Vector3 a, float d)
	{
		return new Vector3(a.x * d, a.y * d, a.z * d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 operator *(float d, Vector3 a)
	{
		return new Vector3(a.x * d, a.y * d, a.z * d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector3 operator /(Vector3 a, float d)
	{
		return new Vector3(a.x / d, a.y / d, a.z / d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Vector3 lhs, Vector3 rhs)
	{
		float num = lhs.x - rhs.x;
		float num2 = lhs.y - rhs.y;
		float num3 = lhs.z - rhs.z;
		float num4 = num * num + num2 * num2 + num3 * num3;
		return num4 < 9.9999994E-11f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Vector3 lhs, Vector3 rhs)
	{
		return !(lhs == rhs);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override string ToString()
	{
		return ToString(null, null);
	}

	[MethodImpl((MethodImplOptions)256)]
	public string ToString(string format)
	{
		return ToString(format, null);
	}

	[MethodImpl((MethodImplOptions)256)]
	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (string.IsNullOrEmpty(format))
		{
			format = "F2";
		}
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.InvariantCulture.NumberFormat;
		}
		return UnityString.Format("({0}, {1}, {2})", x.ToString(format, formatProvider), y.ToString(format, formatProvider), z.ToString(format, formatProvider));
	}

	[Obsolete("Use Vector3.Angle instead. AngleBetween uses radians instead of degrees and was deprecated for this reason")]
	public static float AngleBetween(Vector3 from, Vector3 to)
	{
		return (float)Math.Acos(Mathf.Clamp(Dot(from.normalized, to.normalized), -1f, 1f));
	}

	[Obsolete("Use Vector3.ProjectOnPlane instead.")]
	public static Vector3 Exclude(Vector3 excludeThis, Vector3 fromThat)
	{
		return ProjectOnPlane(fromThat, excludeThis);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Slerp_Injected(ref Vector3 a, ref Vector3 b, float t, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SlerpUnclamped_Injected(ref Vector3 a, ref Vector3 b, float t, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void RotateTowards_Injected(ref Vector3 current, ref Vector3 target, float maxRadiansDelta, float maxMagnitudeDelta, out Vector3 ret);
}
