using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using Unity.IL2CPP.CompilerServices;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[Il2CppEagerStaticClassConstruction]
[NativeClass("Vector2f")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
public struct Vector2 : IEquatable<Vector2>, IFormattable
{
	public float x;

	public float y;

	private static readonly Vector2 zeroVector = new Vector2(0f, 0f);

	private static readonly Vector2 oneVector = new Vector2(1f, 1f);

	private static readonly Vector2 upVector = new Vector2(0f, 1f);

	private static readonly Vector2 downVector = new Vector2(0f, -1f);

	private static readonly Vector2 leftVector = new Vector2(-1f, 0f);

	private static readonly Vector2 rightVector = new Vector2(1f, 0f);

	private static readonly Vector2 positiveInfinityVector = new Vector2(float.PositiveInfinity, float.PositiveInfinity);

	private static readonly Vector2 negativeInfinityVector = new Vector2(float.NegativeInfinity, float.NegativeInfinity);

	public const float kEpsilon = 1E-05f;

	public const float kEpsilonNormalSqrt = 1E-15f;

	public float this[int index]
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return index switch
			{
				0 => x, 
				1 => y, 
				_ => throw new IndexOutOfRangeException("Invalid Vector2 index!"), 
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
			default:
				throw new IndexOutOfRangeException("Invalid Vector2 index!");
			}
		}
	}

	public Vector2 normalized
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			Vector2 result = new Vector2(x, y);
			result.Normalize();
			return result;
		}
	}

	public float magnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return (float)Math.Sqrt(x * x + y * y);
		}
	}

	public float sqrMagnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return x * x + y * y;
		}
	}

	public static Vector2 zero
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return zeroVector;
		}
	}

	public static Vector2 one
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return oneVector;
		}
	}

	public static Vector2 up
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return upVector;
		}
	}

	public static Vector2 down
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return downVector;
		}
	}

	public static Vector2 left
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return leftVector;
		}
	}

	public static Vector2 right
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return rightVector;
		}
	}

	public static Vector2 positiveInfinity
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return positiveInfinityVector;
		}
	}

	public static Vector2 negativeInfinity
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return negativeInfinityVector;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector2(float x, float y)
	{
		this.x = x;
		this.y = y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Set(float newX, float newY)
	{
		x = newX;
		y = newY;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 Lerp(Vector2 a, Vector2 b, float t)
	{
		t = Mathf.Clamp01(t);
		return new Vector2(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 LerpUnclamped(Vector2 a, Vector2 b, float t)
	{
		return new Vector2(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 MoveTowards(Vector2 current, Vector2 target, float maxDistanceDelta)
	{
		float num = target.x - current.x;
		float num2 = target.y - current.y;
		float num3 = num * num + num2 * num2;
		if (num3 == 0f || (maxDistanceDelta >= 0f && num3 <= maxDistanceDelta * maxDistanceDelta))
		{
			return target;
		}
		float num4 = (float)Math.Sqrt(num3);
		return new Vector2(current.x + num / num4 * maxDistanceDelta, current.y + num2 / num4 * maxDistanceDelta);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 Scale(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x * b.x, a.y * b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Scale(Vector2 scale)
	{
		x *= scale.x;
		y *= scale.y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Normalize()
	{
		float num = magnitude;
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
		return UnityString.Format("({0}, {1})", x.ToString(format, formatProvider), y.ToString(format, formatProvider));
	}

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		return x.GetHashCode() ^ (y.GetHashCode() << 2);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Vector2))
		{
			return false;
		}
		return Equals((Vector2)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Vector2 other)
	{
		return x == other.x && y == other.y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 Reflect(Vector2 inDirection, Vector2 inNormal)
	{
		float num = -2f * Dot(inNormal, inDirection);
		return new Vector2(num * inNormal.x + inDirection.x, num * inNormal.y + inDirection.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 Perpendicular(Vector2 inDirection)
	{
		return new Vector2(0f - inDirection.y, inDirection.x);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Dot(Vector2 lhs, Vector2 rhs)
	{
		return lhs.x * rhs.x + lhs.y * rhs.y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Angle(Vector2 from, Vector2 to)
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
	public static float SignedAngle(Vector2 from, Vector2 to)
	{
		float num = Angle(from, to);
		float num2 = Mathf.Sign(from.x * to.y - from.y * to.x);
		return num * num2;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Distance(Vector2 a, Vector2 b)
	{
		float num = a.x - b.x;
		float num2 = a.y - b.y;
		return (float)Math.Sqrt(num * num + num2 * num2);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 ClampMagnitude(Vector2 vector, float maxLength)
	{
		float num = vector.sqrMagnitude;
		if (num > maxLength * maxLength)
		{
			float num2 = (float)Math.Sqrt(num);
			float num3 = vector.x / num2;
			float num4 = vector.y / num2;
			return new Vector2(num3 * maxLength, num4 * maxLength);
		}
		return vector;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float SqrMagnitude(Vector2 a)
	{
		return a.x * a.x + a.y * a.y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public float SqrMagnitude()
	{
		return x * x + y * y;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 Min(Vector2 lhs, Vector2 rhs)
	{
		return new Vector2(Mathf.Min(lhs.x, rhs.x), Mathf.Min(lhs.y, rhs.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 Max(Vector2 lhs, Vector2 rhs)
	{
		return new Vector2(Mathf.Max(lhs.x, rhs.x), Mathf.Max(lhs.y, rhs.y));
	}

	[MethodImpl((MethodImplOptions)256)]
	[ExcludeFromDocs]
	public static Vector2 SmoothDamp(Vector2 current, Vector2 target, ref Vector2 currentVelocity, float smoothTime, float maxSpeed)
	{
		float deltaTime = Time.deltaTime;
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	[MethodImpl((MethodImplOptions)256)]
	[ExcludeFromDocs]
	public static Vector2 SmoothDamp(Vector2 current, Vector2 target, ref Vector2 currentVelocity, float smoothTime)
	{
		float deltaTime = Time.deltaTime;
		float maxSpeed = float.PositiveInfinity;
		return SmoothDamp(current, target, ref currentVelocity, smoothTime, maxSpeed, deltaTime);
	}

	public static Vector2 SmoothDamp(Vector2 current, Vector2 target, ref Vector2 currentVelocity, float smoothTime, [DefaultValue("Mathf.Infinity")] float maxSpeed, [DefaultValue("Time.deltaTime")] float deltaTime)
	{
		smoothTime = Mathf.Max(0.0001f, smoothTime);
		float num = 2f / smoothTime;
		float num2 = num * deltaTime;
		float num3 = 1f / (1f + num2 + 0.48f * num2 * num2 + 0.235f * num2 * num2 * num2);
		float num4 = current.x - target.x;
		float num5 = current.y - target.y;
		Vector2 vector = target;
		float num6 = maxSpeed * smoothTime;
		float num7 = num6 * num6;
		float num8 = num4 * num4 + num5 * num5;
		if (num8 > num7)
		{
			float num9 = (float)Math.Sqrt(num8);
			num4 = num4 / num9 * num6;
			num5 = num5 / num9 * num6;
		}
		target.x = current.x - num4;
		target.y = current.y - num5;
		float num10 = (currentVelocity.x + num * num4) * deltaTime;
		float num11 = (currentVelocity.y + num * num5) * deltaTime;
		currentVelocity.x = (currentVelocity.x - num * num10) * num3;
		currentVelocity.y = (currentVelocity.y - num * num11) * num3;
		float num12 = target.x + (num4 + num10) * num3;
		float num13 = target.y + (num5 + num11) * num3;
		float num14 = vector.x - current.x;
		float num15 = vector.y - current.y;
		float num16 = num12 - vector.x;
		float num17 = num13 - vector.y;
		if (num14 * num16 + num15 * num17 > 0f)
		{
			num12 = vector.x;
			num13 = vector.y;
			currentVelocity.x = (num12 - vector.x) / deltaTime;
			currentVelocity.y = (num13 - vector.y) / deltaTime;
		}
		return new Vector2(num12, num13);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 operator +(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x + b.x, a.y + b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 operator -(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x - b.x, a.y - b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 operator *(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x * b.x, a.y * b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 operator /(Vector2 a, Vector2 b)
	{
		return new Vector2(a.x / b.x, a.y / b.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 operator -(Vector2 a)
	{
		return new Vector2(0f - a.x, 0f - a.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 operator *(Vector2 a, float d)
	{
		return new Vector2(a.x * d, a.y * d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 operator *(float d, Vector2 a)
	{
		return new Vector2(a.x * d, a.y * d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector2 operator /(Vector2 a, float d)
	{
		return new Vector2(a.x / d, a.y / d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Vector2 lhs, Vector2 rhs)
	{
		float num = lhs.x - rhs.x;
		float num2 = lhs.y - rhs.y;
		return num * num + num2 * num2 < 9.9999994E-11f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Vector2 lhs, Vector2 rhs)
	{
		return !(lhs == rhs);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector2(Vector3 v)
	{
		return new Vector2(v.x, v.y);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector3(Vector2 v)
	{
		return new Vector3(v.x, v.y, 0f);
	}
}
