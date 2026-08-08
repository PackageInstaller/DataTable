using System;
using System.Runtime.CompilerServices;
using UnityEngine;

public struct Int2 : IEquatable<Int2>
{
	public int x;

	public int y;

	private static readonly int[] Rotations;

	public static Int2 zero => default(Int2);

	public static Int2 one => new Int2(1, 1);

	public long sqrMagnitudeLong => (long)x * (long)x + (long)y * (long)y;

	public int magnitude
	{
		get
		{
			long num = x;
			long num2 = y;
			return IntMath.Sqrt(num * num + num2 * num2);
		}
	}

	public Int2 normalized
	{
		get
		{
			Int2 result = new Int2(x, y);
			result.Normalize();
			return result;
		}
	}

	public Int2 Perpendicular => new Int2(y, -x);

	public Int2(int x, int y)
	{
		this.x = x;
		this.y = y;
	}

	public static Int2 operator +(Int2 a, Int2 b)
	{
		return new Int2(a.x + b.x, a.y + b.y);
	}

	public static Int2 operator -(Int2 a, Int2 b)
	{
		return new Int2(a.x - b.x, a.y - b.y);
	}

	public static bool operator ==(Int2 a, Int2 b)
	{
		if (a.x == b.x)
		{
			return a.y == b.y;
		}
		return false;
	}

	public static bool operator !=(Int2 a, Int2 b)
	{
		if (a.x == b.x)
		{
			return a.y != b.y;
		}
		return true;
	}

	public static Int2 operator *(Int2 lhs, int rhs)
	{
		lhs.x *= rhs;
		lhs.y *= rhs;
		return lhs;
	}

	public static Int2 operator -(Int2 lhs)
	{
		lhs.x = -lhs.x;
		lhs.y = -lhs.y;
		return lhs;
	}

	public static Int2 operator /(Int2 lhs, float rhs)
	{
		lhs.x = (int)Math.Round((float)lhs.x / rhs);
		lhs.y = (int)Math.Round((float)lhs.y / rhs);
		return lhs;
	}

	public static Int2 ClampMagnitude(Int2 v, int maxLength)
	{
		long num = v.sqrMagnitudeLong;
		if (num > maxLength * maxLength)
		{
			long b = IntMath.Sqrt(num);
			return new Int2((int)IntMath.Divide(v.x * maxLength, b), (int)IntMath.Divide(v.y * maxLength, b));
		}
		return v;
	}

	public static implicit operator Int3(Int2 ob)
	{
		return new Int3(ob.x, ob.y, 0);
	}

	public static long DotLong(Int2 a, Int2 b)
	{
		return (long)a.x * (long)b.x + (long)a.y * (long)b.y;
	}

	internal static long SquareDistance(Int2 a, Int2 b)
	{
		return (a - b).sqrMagnitudeLong;
	}

	public static int Dot(Int2 a, Int2 b)
	{
		return a.x * b.x + a.y * b.y;
	}

	public static long DotLong(ref Int2 a, ref Int2 b)
	{
		return a.x * b.x + a.y * b.y;
	}

	public static long DetLong(ref Int2 a, ref Int2 b)
	{
		return (long)a.x * (long)b.y - (long)a.y * (long)b.x;
	}

	public static long DetLong(Int2 a, Int2 b)
	{
		return (long)a.x * (long)b.y - (long)a.y * (long)b.x;
	}

	public static Int2 Lerp(Int2 a, Int2 b, VFactor f)
	{
		return a + (b - a) * VFactor.Clamp01(f);
	}

	public override bool Equals(object o)
	{
		if (o == null)
		{
			return false;
		}
		Int2 @int = (Int2)o;
		if (x == @int.x)
		{
			return y == @int.y;
		}
		return false;
	}

	public bool Equals(Int2 other)
	{
		if (x == other.x)
		{
			return y == other.y;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return x * 49157 + y * 98317;
	}

	[Obsolete("Deprecated becuase it is not used by any part of the A* Pathfinding Project")]
	public static Int2 Rotate(Int2 v, int r)
	{
		r %= 4;
		return new Int2(v.x * Rotations[r * 4] + v.y * Rotations[r * 4 + 1], v.x * Rotations[r * 4 + 2] + v.y * Rotations[r * 4 + 3]);
	}

	public static Int2 Min(Int2 a, Int2 b)
	{
		return new Int2(Math.Min(a.x, b.x), Math.Min(a.y, b.y));
	}

	public static Int2 Max(Int2 a, Int2 b)
	{
		return new Int2(Math.Max(a.x, b.x), Math.Max(a.y, b.y));
	}

	public static Int2 FromInt3XZ(Int3 o)
	{
		return new Int2(o.x, o.z);
	}

	public static Int3 ToInt3XZ(Int2 o)
	{
		return new Int3(o.x, 0, o.y);
	}

	public static explicit operator Vector2(Int2 ob)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		return new Vector2((float)ob.x * 0.001f, (float)ob.y * 0.001f);
	}

	public static explicit operator Int2(Vector2 ob)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		return new Int2((int)Math.Round(ob.x * 1000f), (int)Math.Round(ob.y * 1000f));
	}

	public long Normalize()
	{
		long num = x << 7;
		long num2 = y << 7;
		long num3 = num * num + num2 * num2;
		if (num3 == 0L)
		{
			return 0L;
		}
		long num4 = IntMath.Sqrt(num3);
		x = (int)IntMath.Divide(num * 1000, num4);
		y = (int)IntMath.Divide(num2 * 1000, num4);
		return num4 >> 7;
	}

	public override string ToString()
	{
		return "(" + (float)x * 0.001f + ", " + (float)y * 0.001f + ")";
	}

	static Int2()
	{
		//IL_000d: Field data (rva=0xe38) could not be found in any section!
		//IL_000d: Field data (rva=0xe38) could not be found in any section!
		int[] array = new int[16];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		Rotations = array;
	}
}
