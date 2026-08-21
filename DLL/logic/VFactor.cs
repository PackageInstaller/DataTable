using System;

[Serializable]
public struct VFactor(long n, long d)
{
	public long nom = n;

	public long den = d;

	[NonSerialized]
	public static VFactor zero;

	[NonSerialized]
	public static VFactor one;

	[NonSerialized]
	public static VFactor pi;

	[NonSerialized]
	public static VFactor twoPi;

	[NonSerialized]
	public static VFactor minValue;

	[NonSerialized]
	public static VFactor half;

	private static long mask_;

	private static long upper_;

	public int roundInt => (int)Math.Round((double)nom / (double)den);

	public int floorInt => (int)Math.Floor((double)nom / (double)den);

	public int integer => (int)(nom / den);

	public float single
	{
		get
		{
			double num = (double)nom / (double)den;
			return (float)num;
		}
	}

	public bool IsPositive
	{
		get
		{
			if (nom == 0L)
			{
				return false;
			}
			bool flag = nom > 0;
			bool flag2 = den > 0;
			return flag == flag2;
		}
	}

	public bool IsNegative
	{
		get
		{
			if (nom == 0L)
			{
				return false;
			}
			bool flag = nom > 0;
			bool flag2 = den > 0;
			return flag ^ flag2;
		}
	}

	public bool IsZero => nom == 0;

	public VFactor Inverse => new VFactor(den, nom);

	static VFactor()
	{
		zero = new VFactor(0L, 1L);
		one = new VFactor(1L, 1L);
		half = new VFactor(1L, 2L);
		pi = new VFactor(31416L, 10000L);
		twoPi = new VFactor(62832L, 10000L);
		minValue = new VFactor(1L, 10000L);
		mask_ = long.MaxValue;
		upper_ = 16777215L;
	}

	public static explicit operator Int(VFactor ob)
	{
		if (ob.den == 0L)
		{
			return 0;
		}
		return (int)IntMath.Divide(ob.nom * 1000, ob.den);
	}

	public static explicit operator VFactor(float ob)
	{
		return new VFactor((int)Math.Round(ob * 1000f), 1000L);
	}

	public override bool Equals(object obj)
	{
		if (obj != null && GetType() == obj.GetType())
		{
			return this == (VFactor)obj;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public override string ToString()
	{
		return single.ToString();
	}

	public void strip()
	{
		while ((nom & mask_) > upper_ && (den & mask_) > upper_)
		{
			nom >>= 1;
			den >>= 1;
		}
	}

	public static bool operator <(VFactor a, VFactor b)
	{
		long num = a.nom * b.den;
		long num2 = b.nom * a.den;
		if ((b.den > 0) ^ (a.den > 0))
		{
			return num > num2;
		}
		return num < num2;
	}

	public static bool operator >(VFactor a, VFactor b)
	{
		long num = a.nom * b.den;
		long num2 = b.nom * a.den;
		if ((b.den > 0) ^ (a.den > 0))
		{
			return num < num2;
		}
		return num > num2;
	}

	public static bool operator <=(VFactor a, VFactor b)
	{
		long num = a.nom * b.den;
		long num2 = b.nom * a.den;
		if ((b.den > 0) ^ (a.den > 0))
		{
			return num >= num2;
		}
		return num <= num2;
	}

	public static bool operator >=(VFactor a, VFactor b)
	{
		long num = a.nom * b.den;
		long num2 = b.nom * a.den;
		if ((b.den > 0) ^ (a.den > 0))
		{
			return num <= num2;
		}
		return num >= num2;
	}

	public static bool operator ==(VFactor a, VFactor b)
	{
		return a.nom * b.den == b.nom * a.den;
	}

	public static bool operator !=(VFactor a, VFactor b)
	{
		return a.nom * b.den != b.nom * a.den;
	}

	public static bool operator <(VFactor a, long b)
	{
		long num = a.nom;
		long num2 = b * a.den;
		if (a.den > 0)
		{
			return num < num2;
		}
		return num > num2;
	}

	public static bool operator >(VFactor a, long b)
	{
		long num = a.nom;
		long num2 = b * a.den;
		if (a.den > 0)
		{
			return num > num2;
		}
		return num < num2;
	}

	public static bool operator <=(VFactor a, long b)
	{
		long num = a.nom;
		long num2 = b * a.den;
		if (a.den > 0)
		{
			return num <= num2;
		}
		return num >= num2;
	}

	public static bool operator >=(VFactor a, long b)
	{
		long num = a.nom;
		long num2 = b * a.den;
		if (a.den > 0)
		{
			return num >= num2;
		}
		return num <= num2;
	}

	public static bool operator ==(VFactor a, long b)
	{
		return a.nom == b * a.den;
	}

	public static bool operator !=(VFactor a, long b)
	{
		return a.nom != b * a.den;
	}

	public static VFactor operator +(VFactor a, VFactor b)
	{
		return new VFactor
		{
			nom = a.nom * b.den + b.nom * a.den,
			den = a.den * b.den
		};
	}

	public static VFactor operator +(VFactor a, long b)
	{
		a.nom += b * a.den;
		return a;
	}

	public static VFactor operator -(VFactor a, VFactor b)
	{
		return new VFactor
		{
			nom = a.nom * b.den - b.nom * a.den,
			den = a.den * b.den
		};
	}

	public static VFactor operator /(VFactor a, VFactor b)
	{
		return new VFactor
		{
			nom = a.nom * b.den,
			den = a.den * b.nom
		};
	}

	public static VFactor operator *(VFactor a, VFactor b)
	{
		return new VFactor
		{
			nom = a.nom * b.nom,
			den = a.den * b.den
		};
	}

	public static VFactor operator -(VFactor a, long b)
	{
		a.nom -= b * a.den;
		return a;
	}

	public static VFactor operator *(VFactor a, long b)
	{
		a.nom *= b;
		return a;
	}

	public static VFactor operator /(VFactor a, long b)
	{
		a.den *= b;
		return a;
	}

	public static Int3 operator *(Int3 v, VFactor f)
	{
		return IntMath.Divide(v, f.nom, f.den);
	}

	public static Int2 operator *(Int2 v, VFactor f)
	{
		return IntMath.Divide(v, f.nom, f.den);
	}

	public static Int3 operator /(Int3 v, VFactor f)
	{
		return IntMath.Divide(v, f.den, f.nom);
	}

	public static Int2 operator /(Int2 v, VFactor f)
	{
		return IntMath.Divide(v, f.den, f.nom);
	}

	public static VFactor operator *(int i, VFactor f)
	{
		return new VFactor(f.nom * i, f.den);
	}

	public static VFactor operator -(VFactor a)
	{
		a.nom = -a.nom;
		return a;
	}

	public static VFactor Clamp01(VFactor a)
	{
		if ((a.den < 0 && a.nom > 0) || (a.den > 0 && a.nom < 0))
		{
			return zero;
		}
		if (Math.Abs(a.nom) >= Math.Abs(a.den))
		{
			return one;
		}
		return a;
	}

	public static VFactor Clamp01(int nom, int den)
	{
		if ((den < 0 && nom > 0) || (den > 0 && nom < 0))
		{
			return zero;
		}
		if (Math.Abs(nom) >= Math.Abs(den))
		{
			return one;
		}
		return new VFactor(nom, den);
	}

	public static VFactor Max(VFactor lh, VFactor rh)
	{
		if (!(lh > rh))
		{
			return rh;
		}
		return lh;
	}

	public static VFactor Min(VFactor lh, VFactor rh)
	{
		if (!(lh > rh))
		{
			return lh;
		}
		return rh;
	}

	public static VFactor GCD(VFactor factor)
	{
		long num = factor.nom;
		long num2 = factor.den;
		if (num < num2)
		{
			long num3 = num2;
			num2 = num;
			num = num3;
		}
		while (num2 != 0L)
		{
			long num4 = num % num2;
			num = num2;
			num2 = num4;
		}
		return new VFactor(factor.nom / num, factor.den / num);
	}
}
