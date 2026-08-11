using System;
using System.Globalization;
using System.Runtime.CompilerServices;
using Unity.IL2CPP.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeClass("Vector4f")]
[NativeHeader("Runtime/Math/Vector4.h")]
[RequiredByNativeCode(Optional = true, GenerateProxy = true)]
[Il2CppEagerStaticClassConstruction]
public struct Vector4 : IEquatable<Vector4>, IFormattable
{
	public const float kEpsilon = 1E-05f;

	public float x;

	public float y;

	public float z;

	public float w;

	private static readonly Vector4 zeroVector = new Vector4(0f, 0f, 0f, 0f);

	private static readonly Vector4 oneVector = new Vector4(1f, 1f, 1f, 1f);

	private static readonly Vector4 positiveInfinityVector = new Vector4(float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity, float.PositiveInfinity);

	private static readonly Vector4 negativeInfinityVector = new Vector4(float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity, float.NegativeInfinity);

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
				3 => w, 
				_ => throw new IndexOutOfRangeException("Invalid Vector4 index!"), 
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
			case 3:
				w = value;
				break;
			default:
				throw new IndexOutOfRangeException("Invalid Vector4 index!");
			}
		}
	}

	public Vector4 normalized
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
			return (float)Math.Sqrt(Dot(this, this));
		}
	}

	public float sqrMagnitude
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return Dot(this, this);
		}
	}

	public static Vector4 zero
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return zeroVector;
		}
	}

	public static Vector4 one
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return oneVector;
		}
	}

	public static Vector4 positiveInfinity
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return positiveInfinityVector;
		}
	}

	public static Vector4 negativeInfinity
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return negativeInfinityVector;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector4(float x, float y, float z, float w)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector4(float x, float y, float z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		w = 0f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public Vector4(float x, float y)
	{
		this.x = x;
		this.y = y;
		z = 0f;
		w = 0f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Set(float newX, float newY, float newZ, float newW)
	{
		x = newX;
		y = newY;
		z = newZ;
		w = newW;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 Lerp(Vector4 a, Vector4 b, float t)
	{
		t = Mathf.Clamp01(t);
		return new Vector4(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t, a.z + (b.z - a.z) * t, a.w + (b.w - a.w) * t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 LerpUnclamped(Vector4 a, Vector4 b, float t)
	{
		return new Vector4(a.x + (b.x - a.x) * t, a.y + (b.y - a.y) * t, a.z + (b.z - a.z) * t, a.w + (b.w - a.w) * t);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 MoveTowards(Vector4 current, Vector4 target, float maxDistanceDelta)
	{
		float num = target.x - current.x;
		float num2 = target.y - current.y;
		float num3 = target.z - current.z;
		float num4 = target.w - current.w;
		float num5 = num * num + num2 * num2 + num3 * num3 + num4 * num4;
		if (num5 == 0f || (maxDistanceDelta >= 0f && num5 <= maxDistanceDelta * maxDistanceDelta))
		{
			return target;
		}
		float num6 = (float)Math.Sqrt(num5);
		return new Vector4(current.x + num / num6 * maxDistanceDelta, current.y + num2 / num6 * maxDistanceDelta, current.z + num3 / num6 * maxDistanceDelta, current.w + num4 / num6 * maxDistanceDelta);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 Scale(Vector4 a, Vector4 b)
	{
		return new Vector4(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Scale(Vector4 scale)
	{
		x *= scale.x;
		y *= scale.y;
		z *= scale.z;
		w *= scale.w;
	}

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		return x.GetHashCode() ^ (y.GetHashCode() << 2) ^ (z.GetHashCode() >> 2) ^ (w.GetHashCode() >> 1);
	}

	[MethodImpl((MethodImplOptions)256)]
	public override bool Equals(object other)
	{
		if (!(other is Vector4))
		{
			return false;
		}
		return Equals((Vector4)other);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool Equals(Vector4 other)
	{
		return x == other.x && y == other.y && z == other.z && w == other.w;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 Normalize(Vector4 a)
	{
		float num = Magnitude(a);
		if (num > 1E-05f)
		{
			return a / num;
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
	public static float Dot(Vector4 a, Vector4 b)
	{
		return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 Project(Vector4 a, Vector4 b)
	{
		return b * (Dot(a, b) / Dot(b, b));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Distance(Vector4 a, Vector4 b)
	{
		return Magnitude(a - b);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float Magnitude(Vector4 a)
	{
		return (float)Math.Sqrt(Dot(a, a));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 Min(Vector4 lhs, Vector4 rhs)
	{
		return new Vector4(Mathf.Min(lhs.x, rhs.x), Mathf.Min(lhs.y, rhs.y), Mathf.Min(lhs.z, rhs.z), Mathf.Min(lhs.w, rhs.w));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 Max(Vector4 lhs, Vector4 rhs)
	{
		return new Vector4(Mathf.Max(lhs.x, rhs.x), Mathf.Max(lhs.y, rhs.y), Mathf.Max(lhs.z, rhs.z), Mathf.Max(lhs.w, rhs.w));
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 operator +(Vector4 a, Vector4 b)
	{
		return new Vector4(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 operator -(Vector4 a, Vector4 b)
	{
		return new Vector4(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 operator -(Vector4 a)
	{
		return new Vector4(0f - a.x, 0f - a.y, 0f - a.z, 0f - a.w);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 operator *(Vector4 a, float d)
	{
		return new Vector4(a.x * d, a.y * d, a.z * d, a.w * d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 operator *(float d, Vector4 a)
	{
		return new Vector4(a.x * d, a.y * d, a.z * d, a.w * d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Vector4 operator /(Vector4 a, float d)
	{
		return new Vector4(a.x / d, a.y / d, a.z / d, a.w / d);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator ==(Vector4 lhs, Vector4 rhs)
	{
		float num = lhs.x - rhs.x;
		float num2 = lhs.y - rhs.y;
		float num3 = lhs.z - rhs.z;
		float num4 = lhs.w - rhs.w;
		float num5 = num * num + num2 * num2 + num3 * num3 + num4 * num4;
		return num5 < 9.9999994E-11f;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool operator !=(Vector4 lhs, Vector4 rhs)
	{
		return !(lhs == rhs);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector4(Vector3 v)
	{
		return new Vector4(v.x, v.y, v.z, 0f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector3(Vector4 v)
	{
		return new Vector3(v.x, v.y, v.z);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector4(Vector2 v)
	{
		return new Vector4(v.x, v.y, 0f, 0f);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static implicit operator Vector2(Vector4 v)
	{
		return new Vector2(v.x, v.y);
	}

	public override string ToString()
	{
		return ToString(null, null);
	}

	public string ToString(string format)
	{
		return ToString(format, null);
	}

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
		return UnityString.Format("({0}, {1}, {2}, {3})", new object[4]
		{
			x.ToString(format, formatProvider),
			y.ToString(format, formatProvider),
			z.ToString(format, formatProvider),
			w.ToString(format, formatProvider)
		});
	}

	[MethodImpl((MethodImplOptions)256)]
	public static float SqrMagnitude(Vector4 a)
	{
		return Dot(a, a);
	}

	[MethodImpl((MethodImplOptions)256)]
	public float SqrMagnitude()
	{
		return Dot(this, this);
	}
}
