using System;

[Serializable]
public struct Int
{
	public int i;

	public static Int one => new Int(1000);

	public float scalar => (float)i * 0.001f;

	public static Int MaxValue => new Int(int.MaxValue);

	public Int(int i)
	{
		this.i = i;
	}

	public Int(long i)
	{
		this.i = (int)i;
	}

	public Int(float f)
	{
		i = (int)Math.Round(f * 1000f);
	}

	public override bool Equals(object o)
	{
		if (o == null)
		{
			return false;
		}
		Int obj = (Int)o;
		return i == obj.i;
	}

	public override int GetHashCode()
	{
		return i.GetHashCode();
	}

	public static Int Min(Int a, Int b)
	{
		return new Int(Math.Min(a.i, b.i));
	}

	public static Int Max(Int a, Int b)
	{
		return new Int(Math.Max(a.i, b.i));
	}

	public override string ToString()
	{
		return scalar.ToString();
	}

	public static explicit operator Int(float f)
	{
		return new Int((int)Math.Round(f * 1000f));
	}

	public static implicit operator Int(int i)
	{
		return new Int(i);
	}

	public static implicit operator Int(long i)
	{
		return new Int(i);
	}

	public static explicit operator float(Int ob)
	{
		return (float)ob.i * 0.001f;
	}

	public static explicit operator long(Int ob)
	{
		return ob.i;
	}

	public static explicit operator VFactor(Int ob)
	{
		return new VFactor(ob.i, 1000L);
	}

	public static Int operator +(Int a, Int b)
	{
		return new Int(a.i + b.i);
	}

	public static Int operator +(Int a, VFactor b)
	{
		return a + (Int)b;
	}

	public static Int operator -(Int a, Int b)
	{
		return new Int(a.i - b.i);
	}

	public static Int operator -(Int a, VFactor b)
	{
		return a - (Int)b;
	}

	public static bool operator ==(Int a, Int b)
	{
		return a.i == b.i;
	}

	public static bool operator !=(Int a, Int b)
	{
		return a.i != b.i;
	}

	public static bool operator <(Int a, Int b)
	{
		return a.i < b.i;
	}

	public static bool operator >(Int a, Int b)
	{
		return a.i > b.i;
	}

	public static bool operator <=(Int a, Int b)
	{
		return a.i <= b.i;
	}

	public static bool operator >=(Int a, Int b)
	{
		return a.i >= b.i;
	}

	public static Int operator *(Int a, Int b)
	{
		return a.i * b.i;
	}

	public static Int operator *(Int a, int b)
	{
		return a.i * b;
	}

	public static Int operator *(Int a, VFactor f)
	{
		return IntMath.Divide(a, f.nom, f.den);
	}

	public static Int operator /(Int a, VFactor f)
	{
		return IntMath.Divide(a, f.den, f.nom);
	}
}
