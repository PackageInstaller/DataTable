using System;

public sealed class Checksum : IEquatable<Checksum>
{
	private const int cHashInitialValue = 0;

	private const int cHashMultiplier = 65599;

	private int mSum;

	public int Sum => mSum;

	public Checksum()
	{
	}

	public Checksum(int sum)
	{
		mSum = sum;
	}

	public void Add(int val)
	{
		mSum = mSum * 65599 + val;
	}

	public void Add(bool val)
	{
		Add(val ? 1 : 0);
	}

	public void Add(Int3 val)
	{
		Add(Combine(val));
	}

	public void Add(long val)
	{
		Add(Combine((int)val, (int)(val >> 32)));
	}

	public static int Combine(int[] vals)
	{
		int num = 65599;
		if (vals != null)
		{
			for (int i = 0; i < vals.Length; i++)
			{
				num = num * 65599 + vals[i];
			}
		}
		return num;
	}

	public static int Combine(int val1, int val2)
	{
		int num = 0;
		num = num * 65599 + val1;
		return num * 65599 + val2;
	}

	public static int Combine(int val1, int val2, int val3)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		return num * 65599 + val3;
	}

	public static int Combine(Int3 val)
	{
		return Combine(val.x, val.y, val.z);
	}

	public static int Combine(int val1, int val2, int val3, int val4)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		return num * 65599 + val4;
	}

	public static int Combine(int val1, int val2, int val3, int val4, int val5)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		num = num * 65599 + val4;
		return num * 65599 + val5;
	}

	public static int Combine(int val1, int val2, int val3, int val4, int val5, int val6)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		num = num * 65599 + val4;
		num = num * 65599 + val5;
		return num * 65599 + val6;
	}

	public static int Combine(int val1, int val2, int val3, int val4, int val5, int val6, int val7)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		num = num * 65599 + val4;
		num = num * 65599 + val5;
		num = num * 65599 + val6;
		return num * 65599 + val7;
	}

	public static int Combine(int val1, int val2, int val3, int val4, int val5, int val6, int val7, int val8)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		num = num * 65599 + val4;
		num = num * 65599 + val5;
		num = num * 65599 + val6;
		num = num * 65599 + val7;
		return num * 65599 + val8;
	}

	public static int Combine(int val1, int val2, int val3, int val4, int val5, int val6, int val7, int val8, int val9)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		num = num * 65599 + val4;
		num = num * 65599 + val5;
		num = num * 65599 + val6;
		num = num * 65599 + val7;
		num = num * 65599 + val8;
		return num * 65599 + val9;
	}

	public static int Combine(int val1, int val2, int val3, int val4, int val5, int val6, int val7, int val8, int val9, int val10)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		num = num * 65599 + val4;
		num = num * 65599 + val5;
		num = num * 65599 + val6;
		num = num * 65599 + val7;
		num = num * 65599 + val8;
		num = num * 65599 + val9;
		return num * 65599 + val10;
	}

	public static int Combine(int val1, int val2, int val3, int val4, int val5, int val6, int val7, int val8, int val9, int val10, int val11)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		num = num * 65599 + val4;
		num = num * 65599 + val5;
		num = num * 65599 + val6;
		num = num * 65599 + val7;
		num = num * 65599 + val8;
		num = num * 65599 + val9;
		num = num * 65599 + val10;
		return num * 65599 + val11;
	}

	public static int Combine(int val1, int val2, int val3, int val4, int val5, int val6, int val7, int val8, int val9, int val10, int val11, int val12)
	{
		int num = 0;
		num = num * 65599 + val1;
		num = num * 65599 + val2;
		num = num * 65599 + val3;
		num = num * 65599 + val4;
		num = num * 65599 + val5;
		num = num * 65599 + val6;
		num = num * 65599 + val7;
		num = num * 65599 + val8;
		num = num * 65599 + val9;
		num = num * 65599 + val10;
		num = num * 65599 + val11;
		return num * 65599 + val12;
	}

	public bool Equals(Checksum other)
	{
		return mSum == other.mSum;
	}

	public override bool Equals(object obj)
	{
		if (obj is Checksum)
		{
			return Equals((Checksum)obj);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return mSum;
	}

	public static bool operator ==(Checksum lhs, Checksum rhs)
	{
		return lhs.Equals(rhs);
	}

	public static bool operator !=(Checksum lhs, Checksum rhs)
	{
		return lhs.mSum != rhs.mSum;
	}

	public override string ToString()
	{
		return mSum.ToString();
	}
}
