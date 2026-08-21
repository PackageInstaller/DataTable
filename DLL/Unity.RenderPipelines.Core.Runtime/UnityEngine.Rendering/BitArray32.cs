using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{this.GetType().Name} {humanizedData}")]
public struct BitArray32 : IBitArray
{
	[SerializeField]
	private uint data;

	public uint capacity => 32u;

	public bool allFalse => data == 0;

	public bool allTrue => data == uint.MaxValue;

	private string humanizedVersion => Convert.ToString(data, 2);

	public string humanizedData => Regex.Replace(string.Format("{0, " + capacity + "}", Convert.ToString(data, 2)).Replace(' ', '0'), ".{8}", "$0.").TrimEnd('.');

	public bool this[uint index]
	{
		get
		{
			return BitArrayUtilities.Get32(index, data);
		}
		set
		{
			BitArrayUtilities.Set32(index, ref data, value);
		}
	}

	public BitArray32(uint initValue)
	{
		data = initValue;
	}

	public BitArray32(IEnumerable<uint> bitIndexTrue)
	{
		data = 0u;
		if (bitIndexTrue == null)
		{
			return;
		}
		for (int num = bitIndexTrue.Count() - 1; num >= 0; num--)
		{
			uint num2 = bitIndexTrue.ElementAt(num);
			if (num2 < capacity)
			{
				data |= (uint)(1 << (int)num2);
			}
		}
	}

	public IBitArray BitAnd(IBitArray other)
	{
		return this & (BitArray32)(object)other;
	}

	public IBitArray BitOr(IBitArray other)
	{
		return this | (BitArray32)(object)other;
	}

	public IBitArray BitNot()
	{
		return ~this;
	}

	public static BitArray32 operator ~(BitArray32 a)
	{
		return new BitArray32(~a.data);
	}

	public static BitArray32 operator |(BitArray32 a, BitArray32 b)
	{
		return new BitArray32(a.data | b.data);
	}

	public static BitArray32 operator &(BitArray32 a, BitArray32 b)
	{
		return new BitArray32(a.data & b.data);
	}

	public static bool operator ==(BitArray32 a, BitArray32 b)
	{
		return a.data == b.data;
	}

	public static bool operator !=(BitArray32 a, BitArray32 b)
	{
		return a.data != b.data;
	}

	public override bool Equals(object obj)
	{
		if (obj is BitArray32)
		{
			return ((BitArray32)obj).data == data;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return 1768953197 + data.GetHashCode();
	}
}
