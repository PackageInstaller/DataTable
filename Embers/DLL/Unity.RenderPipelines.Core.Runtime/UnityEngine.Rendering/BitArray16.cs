using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{this.GetType().Name} {humanizedData}")]
public struct BitArray16 : IBitArray
{
	[SerializeField]
	private ushort data;

	public uint capacity => 16u;

	public bool allFalse => data == 0;

	public bool allTrue => data == ushort.MaxValue;

	public string humanizedData => Regex.Replace(string.Format("{0, " + capacity + "}", Convert.ToString(data, 2)).Replace(' ', '0'), ".{8}", "$0.").TrimEnd('.');

	public bool this[uint index]
	{
		get
		{
			return BitArrayUtilities.Get16(index, data);
		}
		set
		{
			BitArrayUtilities.Set16(index, ref data, value);
		}
	}

	public BitArray16(ushort initValue)
	{
		data = initValue;
	}

	public BitArray16(IEnumerable<uint> bitIndexTrue)
	{
		data = 0;
		if (bitIndexTrue == null)
		{
			return;
		}
		for (int num = bitIndexTrue.Count() - 1; num >= 0; num--)
		{
			uint num2 = bitIndexTrue.ElementAt(num);
			if (num2 < capacity)
			{
				data |= (ushort)(1 << (int)num2);
			}
		}
	}

	public static BitArray16 operator ~(BitArray16 a)
	{
		return new BitArray16((ushort)(~a.data));
	}

	public static BitArray16 operator |(BitArray16 a, BitArray16 b)
	{
		return new BitArray16((ushort)(a.data | b.data));
	}

	public static BitArray16 operator &(BitArray16 a, BitArray16 b)
	{
		return new BitArray16((ushort)(a.data & b.data));
	}

	public IBitArray BitAnd(IBitArray other)
	{
		return this & (BitArray16)(object)other;
	}

	public IBitArray BitOr(IBitArray other)
	{
		return this | (BitArray16)(object)other;
	}

	public IBitArray BitNot()
	{
		return ~this;
	}

	public static bool operator ==(BitArray16 a, BitArray16 b)
	{
		return a.data == b.data;
	}

	public static bool operator !=(BitArray16 a, BitArray16 b)
	{
		return a.data != b.data;
	}

	public override bool Equals(object obj)
	{
		if (obj is BitArray16)
		{
			return ((BitArray16)obj).data == data;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return 1768953197 + data.GetHashCode();
	}
}
