using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{this.GetType().Name} {humanizedData}")]
public struct BitArray128 : IBitArray
{
	[SerializeField]
	private ulong data1;

	[SerializeField]
	private ulong data2;

	public uint capacity => 128u;

	public bool allFalse
	{
		get
		{
			if (data1 == 0L)
			{
				return data2 == 0;
			}
			return false;
		}
	}

	public bool allTrue
	{
		get
		{
			if (data1 == ulong.MaxValue)
			{
				return data2 == ulong.MaxValue;
			}
			return false;
		}
	}

	public string humanizedData => Regex.Replace(string.Format("{0, " + 64u + "}", Convert.ToString((long)data2, 2)).Replace(' ', '0'), ".{8}", "$0.") + Regex.Replace(string.Format("{0, " + 64u + "}", Convert.ToString((long)data1, 2)).Replace(' ', '0'), ".{8}", "$0.").TrimEnd('.');

	public bool this[uint index]
	{
		get
		{
			return BitArrayUtilities.Get128(index, data1, data2);
		}
		set
		{
			BitArrayUtilities.Set128(index, ref data1, ref data2, value);
		}
	}

	public BitArray128(ulong initValue1, ulong initValue2)
	{
		data1 = initValue1;
		data2 = initValue2;
	}

	public BitArray128(IEnumerable<uint> bitIndexTrue)
	{
		data1 = (data2 = 0uL);
		if (bitIndexTrue == null)
		{
			return;
		}
		for (int num = bitIndexTrue.Count() - 1; num >= 0; num--)
		{
			uint num2 = bitIndexTrue.ElementAt(num);
			if (num2 < 64)
			{
				data1 |= (ulong)(1L << (int)num2);
			}
			else if (num2 < capacity)
			{
				data2 |= (ulong)(1L << (int)(num2 - 64));
			}
		}
	}

	public static BitArray128 operator ~(BitArray128 a)
	{
		return new BitArray128(~a.data1, ~a.data2);
	}

	public static BitArray128 operator |(BitArray128 a, BitArray128 b)
	{
		return new BitArray128(a.data1 | b.data1, a.data2 | b.data2);
	}

	public static BitArray128 operator &(BitArray128 a, BitArray128 b)
	{
		return new BitArray128(a.data1 & b.data1, a.data2 & b.data2);
	}

	public IBitArray BitAnd(IBitArray other)
	{
		return this & (BitArray128)(object)other;
	}

	public IBitArray BitOr(IBitArray other)
	{
		return this | (BitArray128)(object)other;
	}

	public IBitArray BitNot()
	{
		return ~this;
	}

	public static bool operator ==(BitArray128 a, BitArray128 b)
	{
		if (a.data1 == b.data1)
		{
			return a.data2 == b.data2;
		}
		return false;
	}

	public static bool operator !=(BitArray128 a, BitArray128 b)
	{
		if (a.data1 == b.data1)
		{
			return a.data2 != b.data2;
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		if (obj is BitArray128 && data1.Equals(((BitArray128)obj).data1))
		{
			return data2.Equals(((BitArray128)obj).data2);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (unchecked(1755735569 * -1521134295) + data1.GetHashCode()) * -1521134295 + data2.GetHashCode();
	}
}
