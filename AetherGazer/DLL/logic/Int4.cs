using System;
using UnityEngine;

public struct Int4 : IEquatable<Int4>
{
	public int x;

	public int y;

	public int z;

	public int w;

	public const int Precision = 1000;

	public const float FloatPrecision = 1000f;

	public const float PrecisionFactor = 0.001f;

	public static Int4 zero => default(Int4);

	public static Int3 one => new Int3(1000, 1000, 1000);

	public static Int3 half => new Int3(500, 500, 500);

	public static Int3 forward => new Int3(0, 0, 1000);

	public static Int3 up => new Int3(0, 1000, 0);

	public static Int3 right => new Int3(1000, 0, 0);

	public int this[int i]
	{
		get
		{
			return i switch
			{
				2 => z, 
				1 => y, 
				0 => x, 
				_ => w, 
			};
		}
		set
		{
			switch (i)
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
				w = value;
				break;
			}
		}
	}

	public float magnitude
	{
		get
		{
			double num = x;
			double num2 = y;
			double num3 = z;
			return (float)Math.Sqrt(num * num + num2 * num2 + num3 * num3);
		}
	}

	public Int IntMagnitude => IntMath.Sqrt(x * x + y * y + z * z);

	public int costMagnitude => (int)Math.Round(magnitude);

	[Obsolete("This property is deprecated. Use magnitude or cast to a Vector3")]
	public float worldMagnitude
	{
		get
		{
			double num = x;
			double num2 = y;
			double num3 = z;
			return (float)Math.Sqrt(num * num + num2 * num2 + num3 * num3) * 0.001f;
		}
	}

	public float sqrMagnitude
	{
		get
		{
			double num = x;
			double num2 = y;
			double num3 = z;
			return (float)(num * num + num2 * num2 + num3 * num3);
		}
	}

	public long sqrMagnitudeLong
	{
		get
		{
			long num = x;
			long num2 = y;
			long num3 = z;
			return num * num + num2 * num2 + num3 * num3;
		}
	}

	public Int3 abs => new Int3(Math.Abs(x), Math.Abs(y), Math.Abs(z));

	public Vector3 vec3
	{
		get
		{
			//IL_0027: Unknown result type (might be due to invalid IL or missing references)
			return new Vector3((float)x * 0.001f, (float)y * 0.001f, (float)z * 0.001f);
		}
	}

	public Int2 xz => new Int2(x, z);

	public Int4(Vector4 position)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		x = (int)Math.Round(position.x * 1000f);
		y = (int)Math.Round(position.y * 1000f);
		z = (int)Math.Round(position.z * 1000f);
		w = (int)Math.Round(position.w * 1000f);
	}

	public Int4(int _x, int _y, int _z, int _w)
	{
		x = _x;
		y = _y;
		z = _z;
		w = _w;
	}

	public static bool operator ==(Int4 lhs, Int4 rhs)
	{
		if (lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z)
		{
			return lhs.w == rhs.w;
		}
		return false;
	}

	public static bool operator !=(Int4 lhs, Int4 rhs)
	{
		if (lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z)
		{
			return lhs.w == rhs.w;
		}
		return true;
	}

	public static explicit operator Int4(Vector4 ob)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		return new Int4((int)Math.Round(ob.x * 1000f), (int)Math.Round(ob.y * 1000f), (int)Math.Round(ob.z * 1000f), (int)Math.Round(ob.w * 1000f));
	}

	public static explicit operator Vector4(Int4 ob)
	{
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		return new Vector4((float)ob.x * 0.001f, (float)ob.y * 0.001f, (float)ob.z * 0.001f, (float)ob.w * 0.001f);
	}

	public static implicit operator Int3(Int4 ob)
	{
		return new Int3(ob.x, ob.y, ob.z);
	}

	public static Int4 operator -(Int4 lhs, Int4 rhs)
	{
		lhs.x -= rhs.x;
		lhs.y -= rhs.y;
		lhs.z -= rhs.z;
		lhs.w -= rhs.w;
		return lhs;
	}

	public static Int4 operator -(Int4 lhs)
	{
		lhs.x = -lhs.x;
		lhs.y = -lhs.y;
		lhs.z = -lhs.z;
		lhs.w = -lhs.w;
		return lhs;
	}

	public static Int4 operator +(Int4 lhs, Int4 rhs)
	{
		lhs.x += rhs.x;
		lhs.y += rhs.y;
		lhs.z += rhs.z;
		lhs.w += rhs.w;
		return lhs;
	}

	public static Int4 operator *(Int4 lhs, int rhs)
	{
		lhs.x *= rhs;
		lhs.y *= rhs;
		lhs.z *= rhs;
		lhs.w *= rhs;
		return lhs;
	}

	public static Int4 operator *(Int4 lhs, float rhs)
	{
		lhs.x = (int)Math.Round((float)lhs.x * rhs);
		lhs.y = (int)Math.Round((float)lhs.y * rhs);
		lhs.z = (int)Math.Round((float)lhs.z * rhs);
		lhs.w = (int)Math.Round((float)lhs.w * rhs);
		return lhs;
	}

	public static Int4 operator *(Int4 lhs, double rhs)
	{
		lhs.x = (int)Math.Round((double)lhs.x * rhs);
		lhs.y = (int)Math.Round((double)lhs.y * rhs);
		lhs.z = (int)Math.Round((double)lhs.z * rhs);
		lhs.w = (int)Math.Round((double)lhs.w * rhs);
		return lhs;
	}

	public static Int4 operator /(Int4 lhs, float rhs)
	{
		lhs.x = (int)Math.Round((float)lhs.x / rhs);
		lhs.y = (int)Math.Round((float)lhs.y / rhs);
		lhs.z = (int)Math.Round((float)lhs.z / rhs);
		lhs.w = (int)Math.Round((float)lhs.w / rhs);
		return lhs;
	}

	public static float Angle(Int3 lhs, Int3 rhs)
	{
		double num = (double)Dot(lhs, rhs) / ((double)lhs.magnitude * (double)rhs.magnitude);
		num = ((num < -1.0) ? (-1.0) : ((num > 1.0) ? 1.0 : num));
		return (float)Math.Acos(num);
	}

	public static int Dot(Int3 lhs, Int3 rhs)
	{
		return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z;
	}

	public static long DotLong(Int3 lhs, Int3 rhs)
	{
		return (long)lhs.x * (long)rhs.x + (long)lhs.y * (long)rhs.y + (long)lhs.z * (long)rhs.z;
	}

	public Int3 Normal2D()
	{
		return new Int3(z, y, -x);
	}

	public static Int3 Cross(ref Int3 lhs, ref Int3 rhs)
	{
		return new Int3(IntMath.Divide(lhs.y * rhs.z - lhs.z * rhs.y, 1000), IntMath.Divide(lhs.z * rhs.x - lhs.x * rhs.z, 1000), IntMath.Divide(lhs.x * rhs.y - lhs.y * rhs.x, 1000));
	}

	public static Int3 Cross(Int3 lhs, Int3 rhs)
	{
		return new Int3(IntMath.Divide(lhs.y * rhs.z - lhs.z * rhs.y, 1000), IntMath.Divide(lhs.z * rhs.x - lhs.x * rhs.z, 1000), IntMath.Divide(lhs.x * rhs.y - lhs.y * rhs.x, 1000));
	}

	public static Int3 MoveTowards(Int3 from, Int3 to, int dt)
	{
		if ((to - from).sqrMagnitudeLong <= dt * dt)
		{
			return to;
		}
		return from + (to - from).NormalizeTo(dt);
	}

	public static implicit operator string(Int4 obj)
	{
		return obj.ToString();
	}

	public Int3 NormalizeTo(int newMagn)
	{
		long num = x * 100;
		long num2 = y * 100;
		long num3 = z * 100;
		long num4 = num * num + num2 * num2 + num3 * num3;
		if (num4 != 0L)
		{
			long b = IntMath.Sqrt(num4);
			long num5 = newMagn;
			x = (int)IntMath.Divide(num * num5, b);
			y = (int)IntMath.Divide(num2 * num5, b);
			z = (int)IntMath.Divide(num3 * num5, b);
		}
		return this;
	}

	public long Normalize()
	{
		long num = x << 7;
		long num2 = y << 7;
		long num3 = z << 7;
		long num4 = num * num + num2 * num2 + num3 * num3;
		if (num4 == 0L)
		{
			return 0L;
		}
		long num5 = IntMath.Sqrt(num4);
		x = (int)IntMath.Divide(num * 1000, num5);
		y = (int)IntMath.Divide(num2 * 1000, num5);
		z = (int)IntMath.Divide(num3 * 1000, num5);
		return num5 >> 7;
	}

	public static Int3 Normalize(Int3 v, out long magnitude)
	{
		magnitude = v.Normalize();
		return v;
	}

	public Int3 RotateY(int degree)
	{
		IntMath.sincos(out var s, out var c, 31416 * degree, 1800000L);
		long num = c.nom * s.den;
		long num2 = c.den * s.nom;
		long b = c.den * s.den;
		Int3 @int = default(Int3);
		@int.x = (int)IntMath.Divide(x * num + z * num2, b);
		@int.z = (int)IntMath.Divide(-x * num2 + z * num, b);
		@int.y = 0;
		return @int.NormalizeTo(1000);
	}

	public Int3 RotateY(ref VFactor radians)
	{
		IntMath.sincos(out var s, out var c, radians.nom, radians.den);
		long num = c.nom * s.den;
		long num2 = c.den * s.nom;
		long b = c.den * s.den;
		Int3 @int = default(Int3);
		@int.x = (int)IntMath.Divide(x * num + z * num2, b);
		@int.z = (int)IntMath.Divide(-x * num2 + z * num, b);
		@int.y = 0;
		return @int.NormalizeTo(1000);
	}

	public override string ToString()
	{
		return "( " + x + ", " + y + ", " + z + ")";
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		Int4 @int = (Int4)obj;
		if (x == @int.x && y == @int.y && z == @int.z)
		{
			return w == @int.w;
		}
		return false;
	}

	public bool Equals(Int4 other)
	{
		if (x == other.x && y == other.y && z == other.z)
		{
			return w == other.w;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (x * 73856093) ^ (y * 19349663) ^ (z * 83492791);
	}
}
