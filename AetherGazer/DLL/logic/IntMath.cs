using System;

public class IntMath
{
	public static VFactor Deg2Rad = new VFactor(1745L, 100000L);

	public static VFactor Rad2Deg = new VFactor(57296L, 1000L);

	public static VFactor PI = new VFactor(31416L, 10000L);

	public static VFactor HALFPI = new VFactor(1571L, 1000L);

	public static VFactor QUARTERPI = new VFactor(785L, 1000L);

	public static VFactor F360 = new VFactor(360000L, 1000L);

	public static VFactor F180 = new VFactor(180000L, 1000L);

	public static VFactor F90 = new VFactor(90000L, 1000L);

	public static VFactor F45 = new VFactor(45000L, 1000L);

	public static VFactor acos(long nom, long den)
	{
		int a = (int)Divide(nom * AcosLookupTable.HALF_COUNT, den) + AcosLookupTable.HALF_COUNT;
		a = Clamp(a, 0, AcosLookupTable.COUNT);
		return new VFactor
		{
			nom = AcosLookupTable.table[a],
			den = 10000L
		};
	}

	public static double acos(double x)
	{
		return (-0.6981317007977321 * x * x - Math.PI * 5.0 / 18.0) * x + Math.PI / 2.0;
	}

	public static VFactor acos(VFactor factor)
	{
		long nom = factor.nom;
		long den = factor.den;
		int a = (int)Divide(nom * AcosLookupTable.HALF_COUNT, den) + AcosLookupTable.HALF_COUNT;
		a = Clamp(a, 0, AcosLookupTable.COUNT);
		return new VFactor
		{
			nom = AcosLookupTable.table[a],
			den = 10000L
		};
	}

	public static VFactor asin(long nom, long den)
	{
		return HALFPI - acos(nom, den);
	}

	public static VFactor asin(VFactor fac)
	{
		return HALFPI - acos(fac);
	}

	public static VFactor atan2(int y, int x)
	{
		int num;
		int num2;
		if (x < 0)
		{
			if (y < 0)
			{
				x = -x;
				y = -y;
				num = 1;
			}
			else
			{
				x = -x;
				num = -1;
			}
			num2 = -31416;
		}
		else
		{
			if (y < 0)
			{
				y = -y;
				num = -1;
			}
			else
			{
				num = 1;
			}
			num2 = 0;
		}
		int dIM = Atan2LookupTable.DIM;
		long num3 = dIM - 1;
		long num4 = ((x >= y) ? x : y);
		int num5 = (int)((num4 == 0L) ? 1 : Divide(x * num3, num4));
		int num6 = (int)((num4 == 0L) ? 1 : Divide(y * num3, num4));
		int num7 = Atan2LookupTable.table[num6 * dIM + num5];
		return new VFactor
		{
			nom = (num7 + num2) * num,
			den = 10000L
		};
	}

	public static int CeilPowerOfTwo(int x)
	{
		x--;
		x |= x >> 1;
		x |= x >> 2;
		x |= x >> 4;
		x |= x >> 8;
		x |= x >> 16;
		x++;
		return x;
	}

	public static long Clamp(long a, long min, long max)
	{
		if (a < min)
		{
			return min;
		}
		if (a > max)
		{
			return max;
		}
		return a;
	}

	public static int Clamp(int a, int min, int max)
	{
		if (a < min)
		{
			return min;
		}
		if (a > max)
		{
			return max;
		}
		return a;
	}

	public static VFactor cos(long nom, long den)
	{
		int index = SinCosLookupTable.getIndex(nom, den);
		return new VFactor(SinCosLookupTable.cos_table[index], SinCosLookupTable.FACTOR);
	}

	public static VFactor cos(VFactor a)
	{
		int index = SinCosLookupTable.getIndex(a.nom, a.den);
		return new VFactor(SinCosLookupTable.cos_table[index], SinCosLookupTable.FACTOR);
	}

	public static int Divide(int a, int b)
	{
		int num = 1;
		if ((a ^ b) < 0)
		{
			num = -1;
		}
		return (a + b / 2 * num) / b;
	}

	public static long Divide(long a, long b)
	{
		long num = 1L;
		if ((a ^ b) < 0)
		{
			num = -1L;
		}
		return (a + b / 2 * num) / b;
	}

	public static Int2 Divide(Int2 a, long b)
	{
		a.x = (int)Divide(a.x, b);
		a.y = (int)Divide(a.y, b);
		return a;
	}

	public static Int2 Divide(Int2 a, int b)
	{
		a.x = (int)Divide((long)a.x, (long)b);
		a.y = (int)Divide((long)a.y, (long)b);
		return a;
	}

	public static Int3 Divide(Int3 a, int b)
	{
		a.x = Divide(a.x, b);
		a.y = Divide(a.y, b);
		a.z = Divide(a.z, b);
		return a;
	}

	public static Int3 Divide(Int3 a, long b)
	{
		a.x = (int)Divide(a.x, b);
		a.y = (int)Divide(a.y, b);
		a.z = (int)Divide(a.z, b);
		return a;
	}

	public static Int2 Divide(Int2 a, long m, long b)
	{
		a.x = (int)Divide(a.x * m, b);
		a.y = (int)Divide(a.y * m, b);
		return a;
	}

	public static Int3 Divide(Int3 a, long m, long b)
	{
		a.x = (int)Divide(a.x * m, b);
		a.y = (int)Divide(a.y * m, b);
		a.z = (int)Divide(a.z * m, b);
		return a;
	}

	public static Int Divide(Int a, long m, long b)
	{
		return (int)Divide(a.i * m, b);
	}

	public static int Divide(long a, long m, long b)
	{
		return (int)Divide(a * m, b);
	}

	public static bool IntersectSegment(ref Int2 seg1Src, ref Int2 seg1Vec, ref Int2 seg2Src, ref Int2 seg2Vec, out Int2 interPoint)
	{
		SegvecToLinegen(ref seg1Src, ref seg1Vec, out var a, out var b, out var c);
		SegvecToLinegen(ref seg2Src, ref seg2Vec, out var a2, out var b2, out var c2);
		long num = a * b2 - a2 * b;
		if (num != 0L)
		{
			long num2 = Divide(b * c2 - b2 * c, num);
			long num3 = Divide(a2 * c - a * c2, num);
			bool result = IsPointOnSegment(ref seg1Src, ref seg1Vec, num2, num3) && IsPointOnSegment(ref seg2Src, ref seg2Vec, num2, num3);
			interPoint.x = (int)num2;
			interPoint.y = (int)num3;
			return result;
		}
		interPoint = Int2.zero;
		return false;
	}

	private static bool IsPointOnSegment(ref Int2 segSrc, ref Int2 segVec, long x, long y)
	{
		long num = x - segSrc.x;
		long num2 = y - segSrc.y;
		if (segVec.x * num + segVec.y * num2 >= 0)
		{
			return num * num + num2 * num2 <= segVec.sqrMagnitudeLong;
		}
		return false;
	}

	public static bool IsPowerOfTwo(int x)
	{
		return (x & (x - 1)) == 0;
	}

	public static int Lerp(int src, int dest, int nom, int den)
	{
		return Divide(src * den + (dest - src) * nom, den);
	}

	public static long Lerp(long src, long dest, long nom, long den)
	{
		if (den == 0L || nom > den)
		{
			return dest;
		}
		if (nom * den < 0)
		{
			return src;
		}
		return Divide(src * den + (dest - src) * nom, den);
	}

	public static Int3 Lerp(Int3 a, Int3 b, VFactor f)
	{
		return a + (b - a) * VFactor.Clamp01(f);
	}

	public static long Max(long a, long b)
	{
		if (a > b)
		{
			return a;
		}
		return b;
	}

	public static void Max(ref Int3 value1, ref Int3 value2, out Int3 result)
	{
		result.x = ((value1.x > value2.x) ? value1.x : value2.x);
		result.y = ((value1.y > value2.y) ? value1.y : value2.y);
		result.z = ((value1.z > value2.z) ? value1.z : value2.z);
	}

	public static int Max(int a, int b)
	{
		if (a > b)
		{
			return a;
		}
		return b;
	}

	public static int Max(int a, int b, int c)
	{
		if (a <= b)
		{
			return Max(b, c);
		}
		return Max(a, c);
	}

	public static void Min(ref Int3 value1, ref Int3 value2, out Int3 result)
	{
		result.x = ((value1.x < value2.x) ? value1.x : value2.x);
		result.y = ((value1.y < value2.y) ? value1.y : value2.y);
		result.z = ((value1.z < value2.z) ? value1.z : value2.z);
	}

	public static Int Min(Int a, Int b)
	{
		if (!(a <= b))
		{
			return b;
		}
		return a;
	}

	public static int Min(int a, int b)
	{
		if (a > b)
		{
			return b;
		}
		return a;
	}

	public static Int Max(Int a, Int b)
	{
		if (!(a <= b))
		{
			return a;
		}
		return b;
	}

	public static VFactor Max(VFactor a, VFactor b)
	{
		if (!(a <= b))
		{
			return a;
		}
		return b;
	}

	public static VFactor Min(VFactor a, VFactor b)
	{
		if (!(a <= b))
		{
			return b;
		}
		return a;
	}

	public static VFactor Abs(VFactor a)
	{
		a.nom = Math.Abs(a.nom);
		a.den = Math.Abs(a.den);
		return a;
	}

	public static Int Abs(Int a)
	{
		a.i = Math.Abs(a.i);
		return a;
	}

	public static bool PointInPolygon(ref Int2 pnt, Int2[] plg)
	{
		if (plg == null || plg.Length < 3)
		{
			return false;
		}
		bool flag = false;
		int num = 0;
		int num2 = plg.Length - 1;
		while (num < plg.Length)
		{
			Int2 @int = plg[num];
			Int2 int2 = plg[num2];
			if ((@int.y <= pnt.y && pnt.y < int2.y) || (int2.y <= pnt.y && pnt.y < @int.y))
			{
				int num3 = int2.y - @int.y;
				long num4 = (pnt.y - @int.y) * (int2.x - @int.x) - (pnt.x - @int.x) * num3;
				if (num3 > 0)
				{
					if (num4 > 0)
					{
						flag = !flag;
					}
				}
				else if (num4 < 0)
				{
					flag = !flag;
				}
			}
			num2 = num++;
		}
		return flag;
	}

	public static double Exp(double x)
	{
		x = 1.0 + x / 256.0;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		return x;
	}

	public static double Exp2(double x)
	{
		x = 1.0 + x / 1024.0;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		x *= x;
		return x;
	}

	public static bool SegIntersectPlg(ref Int2 segSrc, ref Int2 segVec, Int2[] plg, out Int2 nearPoint, out Int2 projectVec)
	{
		nearPoint = Int2.zero;
		projectVec = Int2.zero;
		if (plg == null || plg.Length < 2)
		{
			return false;
		}
		bool result = false;
		long num = -1L;
		int num2 = -1;
		for (int i = 0; i < plg.Length; i++)
		{
			Int2 seg2Vec = plg[(i + 1) % plg.Length] - plg[i];
			if (IntersectSegment(ref segSrc, ref segVec, ref plg[i], ref seg2Vec, out var interPoint))
			{
				long sqrMagnitudeLong = (interPoint - segSrc).sqrMagnitudeLong;
				if (num < 0 || sqrMagnitudeLong < num)
				{
					nearPoint = interPoint;
					num = sqrMagnitudeLong;
					num2 = i;
					result = true;
				}
			}
		}
		if (num2 >= 0)
		{
			Int2 @int = plg[(num2 + 1) % plg.Length] - plg[num2];
			Int2 int2 = segSrc + segVec - nearPoint;
			long num3 = int2.x * @int.x + int2.y * @int.y;
			if (num3 < 0)
			{
				num3 = -num3;
				@int = -@int;
			}
			long sqrMagnitudeLong2 = @int.sqrMagnitudeLong;
			projectVec.x = (int)Divide(@int.x * num3, sqrMagnitudeLong2);
			projectVec.y = (int)Divide(@int.y * num3, sqrMagnitudeLong2);
		}
		return result;
	}

	public static void SegvecToLinegen(ref Int2 segSrc, ref Int2 segVec, out long a, out long b, out long c)
	{
		a = segVec.y;
		b = -segVec.x;
		c = segVec.x * segSrc.y - segSrc.x * segVec.y;
	}

	public static VFactor sin(long nom, long den)
	{
		int index = SinCosLookupTable.getIndex(nom, den);
		return new VFactor(SinCosLookupTable.sin_table[index], SinCosLookupTable.FACTOR);
	}

	public static VFactor sin(VFactor a)
	{
		int index = SinCosLookupTable.getIndex(a.nom, a.den);
		return new VFactor(SinCosLookupTable.sin_table[index], SinCosLookupTable.FACTOR);
	}

	public static void sincos(out VFactor s, out VFactor c, VFactor angle)
	{
		int index = SinCosLookupTable.getIndex(angle.nom, angle.den);
		s = new VFactor(SinCosLookupTable.sin_table[index], SinCosLookupTable.FACTOR);
		c = new VFactor(SinCosLookupTable.cos_table[index], SinCosLookupTable.FACTOR);
	}

	public static void sincos(out VFactor s, out VFactor c, long nom, long den)
	{
		int index = SinCosLookupTable.getIndex(nom, den);
		s = new VFactor(SinCosLookupTable.sin_table[index], SinCosLookupTable.FACTOR);
		c = new VFactor(SinCosLookupTable.cos_table[index], SinCosLookupTable.FACTOR);
	}

	public static long Square(int a)
	{
		return a * a;
	}

	public static VFactor Square(VFactor a)
	{
		return a * a;
	}

	public static int Sqrt(long a)
	{
		if (a <= 0)
		{
			return 0;
		}
		if (a <= uint.MaxValue)
		{
			return (int)Sqrt32((uint)a);
		}
		return (int)Sqrt64((ulong)a);
	}

	public static uint Sqrt32(uint a)
	{
		uint num = 0u;
		uint num2 = 0u;
		for (int i = 0; i < 16; i++)
		{
			num2 <<= 1;
			num <<= 2;
			num += a >> 30;
			a <<= 2;
			if (num2 < num)
			{
				num2++;
				num -= num2;
				num2++;
			}
		}
		return (num2 >> 1) & 0xFFFF;
	}

	public static ulong Sqrt64(ulong a)
	{
		ulong num = 0uL;
		ulong num2 = 0uL;
		for (int i = 0; i < 32; i++)
		{
			num2 <<= 1;
			num <<= 2;
			num += a >> 62;
			a <<= 2;
			if (num2 < num)
			{
				num2++;
				num -= num2;
				num2++;
			}
		}
		return (num2 >> 1) & 0xFFFFFFFFu;
	}

	public static long SqrtLong(long a)
	{
		if (a <= 0)
		{
			return 0L;
		}
		if (a <= uint.MaxValue)
		{
			return Sqrt32((uint)a);
		}
		return (long)Sqrt64((ulong)a);
	}

	public static Int AngleOfVector(Int3 vector)
	{
		VFactor vFactor = atan2(vector.z, vector.x);
		if (vFactor < 0L)
		{
			vFactor = 2 * PI + vFactor;
		}
		vFactor *= Rad2Deg;
		return (Int)vFactor;
	}

	public static Int3 VectorOfAngle(Int angle, int y = 0)
	{
		sincos(out var s, out var c, (VFactor)angle * Deg2Rad);
		return new Int3(((Int)c).i, y, ((Int)s).i);
	}

	public static void LerpAngle(ref Int Value, Int Target, Int speed)
	{
		Int obj = DeltaAngle(Value, Target);
		if (obj > 0)
		{
			Int obj2 = Value + speed;
			if (obj - speed <= 0)
			{
				obj2 = Target;
			}
			else
			{
				Value = obj2;
			}
		}
		else
		{
			Int obj3 = Value - speed;
			if (obj + speed > 0)
			{
				Value = Target;
			}
			else
			{
				Value = obj3;
			}
		}
	}

	public static Int LerpAngle(Int a, Int b, VFactor t)
	{
		Int obj = Repeat(b - a, 360000);
		if (obj > 180000)
		{
			obj -= (Int)360000;
		}
		return a + obj * VFactor.Clamp01(t);
	}

	public static Int DeltaAngle(Int current, Int target)
	{
		Int obj = Repeat(target - current, 360000);
		if (obj > 180000)
		{
			obj -= (Int)360000;
		}
		return obj;
	}

	public static Int Repeat(Int t, Int length)
	{
		return t - new VFactor(t.i, length.i).floorInt * length;
	}

	public static Int3 GetXZRight(Int3 forward)
	{
		Int3 lhs = new Int3(0, 1000, 0);
		return Int3.Cross(ref lhs, ref forward);
	}

	public static Int3 GetXZLeft(Int3 forward)
	{
		Int3 lhs = new Int3(0, 1000, 0);
		return -Int3.Cross(ref lhs, ref forward);
	}

	public static Int3 Transform(ref Int3 point, ref Int3 forward, ref Int3 trans)
	{
		Int3 axis_y = Int3.up;
		Int3 axis_x = Int3.Cross(Int3.up, forward);
		return Transform(ref point, ref axis_x, ref axis_y, ref forward, ref trans);
	}

	public static Int3 Transform(Int3 point, Int3 forward, Int3 trans)
	{
		Int3 axis_y = Int3.up;
		Int3 axis_x = Int3.Cross(Int3.up, forward);
		return Transform(ref point, ref axis_x, ref axis_y, ref forward, ref trans);
	}

	public static Int3 Transform(Int3 point, Int3 forward, Int3 trans, Int3 scale)
	{
		Int3 axis_y = Int3.up;
		Int3 axis_x = Int3.Cross(Int3.up, forward);
		return Transform(ref point, ref axis_x, ref axis_y, ref forward, ref trans, ref scale);
	}

	public static Int3 InvertTransform(ref Int3 point, ref Int3 axis_x, ref Int3 axis_y, ref Int3 axis_z, ref Int3 worldPosition)
	{
		Int3 rhs = point - worldPosition;
		int x = Divide(Int3.Dot(axis_x, rhs), 1000);
		int y = Divide(Int3.Dot(axis_y, rhs), 1000);
		int z = Divide(Int3.Dot(axis_z, rhs), 1000);
		return new Int3(x, y, z);
	}

	public static Int3 InvertTransform(ref Int3 point, ref Int3 axis_x, ref Int3 axis_y, ref Int3 axis_z)
	{
		int x = Divide(Int3.Dot(axis_x, point), 1000);
		int y = Divide(Int3.Dot(axis_y, point), 1000);
		int z = Divide(Int3.Dot(axis_z, point), 1000);
		return new Int3(x, y, z);
	}

	public static Int3 Transform(ref Int3 point, ref Int3 axis_x, ref Int3 axis_y, ref Int3 axis_z, ref Int3 trans)
	{
		return new Int3(Divide(axis_x.x * point.x + axis_y.x * point.y + axis_z.x * point.z, 1000) + trans.x, Divide(axis_x.y * point.x + axis_y.y * point.y + axis_z.y * point.z, 1000) + trans.y, Divide(axis_x.z * point.x + axis_y.z * point.y + axis_z.z * point.z, 1000) + trans.z);
	}

	public static Int3 Transform(ref Int3 point, ref Int3 axis_x, ref Int3 axis_y, ref Int3 axis_z)
	{
		return new Int3(Divide(axis_x.x * point.x + axis_y.x * point.y + axis_z.x * point.z, 1000), Divide(axis_x.y * point.x + axis_y.y * point.y + axis_z.y * point.z, 1000), Divide(axis_x.z * point.x + axis_y.z * point.y + axis_z.z * point.z, 1000));
	}

	public static Int3 Transform(ref Int3 point, ref Int3 axis_x, ref Int3 axis_y, ref Int3 axis_z, ref Int3 trans, ref Int3 scale)
	{
		long num = point.x * scale.x;
		long num2 = point.y * scale.x;
		long num3 = point.z * scale.x;
		return new Int3((int)Divide(axis_x.x * num + axis_y.x * num2 + axis_z.x * num3, 1000000L) + trans.x, (int)Divide(axis_x.y * num + axis_y.y * num2 + axis_z.y * num3, 1000000L) + trans.y, (int)Divide(axis_x.z * num + axis_y.z * num2 + axis_z.z * num3, 1000000L) + trans.z);
	}

	public static Int3 InvertTransfrom(Int3 point, Int3 forward, Int3 trans)
	{
		Int3 axis_y = Int3.up;
		Int3 axis_x = Int3.Cross(Int3.up, forward);
		return InvertTransfrom(ref point, ref axis_x, ref axis_y, ref forward, ref trans);
	}

	public static Int3 InvertTransfrom(ref Int3 point, ref Int3 axis_x, ref Int3 axis_y, ref Int3 axis_z, ref Int3 trans)
	{
		Int3 result = new Int3(int.MaxValue, int.MaxValue, int.MaxValue);
		long num = Divide(axis_x.x * axis_y.y * axis_z.z - axis_x.x * axis_z.y * axis_y.z - axis_y.x * axis_x.y * axis_z.z + axis_y.x * axis_z.y * axis_x.z + axis_z.x * axis_x.y * axis_y.z - axis_z.x * axis_y.y * axis_x.z, 1000);
		long num2 = axis_y.y * axis_z.z - axis_z.y * axis_y.z;
		long num3 = axis_z.x * axis_y.z - axis_y.x * axis_z.z;
		long num4 = axis_y.x * axis_z.y - axis_y.y * axis_z.x;
		long num5 = axis_z.y * axis_x.z - axis_z.z * axis_x.y;
		long num6 = axis_x.x * axis_z.z - axis_x.z * axis_z.x;
		long num7 = axis_z.x * axis_x.y - axis_z.y * axis_x.x;
		long num8 = axis_x.y * axis_y.z - axis_x.z * axis_y.y;
		long num9 = axis_y.x * axis_x.z - axis_y.z * axis_x.x;
		long num10 = axis_x.x * axis_y.y - axis_x.y * axis_y.x;
		if (num == 0L)
		{
			XLogger.Error("matrix det == 0");
			return result;
		}
		Int3 axis_x2 = Int3.zero;
		Int3 axis_y2 = Int3.zero;
		Int3 axis_z2 = Int3.zero;
		axis_x2.x = (int)Divide(num2 * 1000, num);
		axis_y2.x = (int)Divide(num3 * 1000, num);
		axis_z2.x = (int)Divide(num4 * 1000, num);
		axis_x2.y = (int)Divide(num5 * 1000, num);
		axis_y2.y = (int)Divide(num6 * 1000, num);
		axis_z2.y = (int)Divide(num7 * 1000, num);
		axis_x2.z = (int)Divide(num8 * 1000, num);
		axis_y2.z = (int)Divide(num9 * 1000, num);
		axis_z2.z = (int)Divide(num10 * 1000, num);
		point -= trans;
		Int3 trans2 = Int3.zero;
		return Transform(ref point, ref axis_x2, ref axis_y2, ref axis_z2, ref trans2);
	}

	public static void LookAt(Int3 forward, Int3 upwards, out Int3 axis_x, out Int3 axis_y, out Int3 axis_z)
	{
		Int3 @int = forward;
		@int.Normalize();
		Int3 int2 = Int3.Cross(upwards, @int);
		int2.Normalize();
		Int3 int3 = Int3.Cross(@int, int2);
		axis_x = int2;
		axis_y = int3;
		axis_z = @int;
	}

	public static Int3 TransformDirection(Int3 foward, Int3 localDirection)
	{
		LookAt(foward, Int3.up, out var axis_x, out var _, out var axis_z);
		axis_x *= localDirection.x;
		axis_z *= localDirection.z;
		return (axis_x + axis_z) / 1000f;
	}

	public static SimQuaternion LookRotation(Int3 forward, Int3 upwards)
	{
		LookAt(forward, upwards, out var axis_x, out var axis_y, out var axis_z);
		return LookRotation(ref axis_x, ref axis_y, ref axis_z);
	}

	public static SimQuaternion LookRotation(ref Int3 axis_x, ref Int3 axis_y, ref Int3 axis_z)
	{
		SimQuaternion result = default(SimQuaternion);
		int num = axis_x.x + axis_y.y + axis_z.z;
		if (num > 0)
		{
			int num2 = Sqrt((num + 1000) * 1000);
			result.w = num2 / 2;
			VFactor vFactor = new VFactor(500L, num2);
			result.x = ((Int)(axis_y.z - axis_z.y) * vFactor).i;
			result.y = ((Int)(axis_z.x - axis_x.z) * vFactor).i;
			result.z = ((Int)(axis_x.y - axis_y.x) * vFactor).i;
		}
		else if (axis_x.x >= axis_y.y && axis_x.x >= axis_z.z)
		{
			int num3 = Sqrt((1000 + axis_x.x - axis_y.y - axis_z.z) * 1000);
			VFactor vFactor2 = new VFactor(500L, num3);
			result.x = num3 / 2;
			result.y = ((Int)(axis_x.y + axis_y.x) * vFactor2).i;
			result.z = ((Int)(axis_x.z + axis_z.x) * vFactor2).i;
			result.w = ((Int)(axis_y.z - axis_z.y) * vFactor2).i;
		}
		else if (axis_y.y > axis_z.z)
		{
			int num4 = Sqrt((1000 + axis_y.y - axis_x.x - axis_z.z) * 1000);
			VFactor vFactor3 = new VFactor(500L, num4);
			result.x = ((Int)(axis_y.x + axis_x.y) * vFactor3).i;
			result.y = num4 / 2;
			result.z = ((Int)(axis_z.y + axis_y.z) * vFactor3).i;
			result.w = ((Int)(axis_z.x - axis_x.z) * vFactor3).i;
		}
		else
		{
			int num5 = Sqrt((1000 + axis_z.z - axis_x.x - axis_y.y) * 1000);
			VFactor vFactor4 = new VFactor(500L, num5);
			result.x = ((Int)(axis_z.x + axis_x.z) * vFactor4).i;
			result.y = ((Int)(axis_z.y + axis_y.z) * vFactor4).i;
			result.z = num5 / 2;
			result.w = ((Int)(axis_x.y - axis_y.x) * vFactor4).i;
		}
		return result;
	}
}
