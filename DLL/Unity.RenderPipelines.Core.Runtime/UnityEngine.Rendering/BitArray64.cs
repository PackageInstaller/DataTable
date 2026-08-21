using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{this.GetType().Name} {humanizedData}")]
public struct BitArray64 : IBitArray
{
	[SerializeField]
	private ulong data;

	public uint capacity => 64u;

	public bool allFalse => data == 0;

	public bool allTrue => data == ulong.MaxValue;

	public string humanizedData => Regex.Replace(string.Format("{0, " + capacity + "}", Convert.ToString((long)data, 2)).Replace(' ', '0'), ".{8}", "$0.").TrimEnd('.');

	public bool this[uint index]
	{
		get
		{
			return BitArrayUtilities.Get64(index, data);
		}
		set
		{
			BitArrayUtilities.Set64(index, ref data, value);
		}
	}

	public BitArray64(ulong initValue)
	{
		data = initValue;
	}

	public BitArray64(IEnumerable<uint> bitIndexTrue)
	{
		data = 0uL;
		if (bitIndexTrue == null)
		{
			return;
		}
		for (int num = bitIndexTrue.Count() - 1; num >= 0; num--)
		{
			uint num2 = bitIndexTrue.ElementAt(num);
			if (num2 < capacity)
			{
				data |= (ulong)(1L << (int)num2);
			}
		}
	}

	public static BitArray64 operator ~(BitArray64 a)
	{
		return new BitArray64(~a.data);
	}

	public static BitArray64 operator |(BitArray64 a, BitArray64 b)
	{
		return new BitArray64(a.data | b.data);
	}

	public static BitArray64 operator &(BitArray64 a, BitArray64 b)
	{
		return new BitArray64(a.data & b.data);
	}

	public IBitArray BitAnd(IBitArray other)
	{
		return this & (BitArray64)(object)other;
	}

	public IBitArray BitOr(IBitArray other)
	{
		return this | (BitArray64)(object)other;
	}

	public IBitArray BitNot()
	{
		return ~this;
	}

	public static bool operator ==(BitArray64 a, BitArray64 b)
	{
		return a.data == b.data;
	}

	public static bool operator !=(BitArray64 a, BitArray64 b)
	{
		return a.data != b.data;
	}

	public override bool Equals(object obj)
	{
		if (obj is BitArray64)
		{
			return ((BitArray64)obj).data == data;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return 1768953197 + data.GetHashCode();
	}
}
