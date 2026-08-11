using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{this.GetType().Name} {humanizedData}")]
public struct BitArray8 : IBitArray
{
	[SerializeField]
	private byte data;

	public uint capacity => 8u;

	public bool allFalse => data == 0;

	public bool allTrue => data == byte.MaxValue;

	public string humanizedData => string.Format("{0, " + capacity + "}", Convert.ToString(data, 2)).Replace(' ', '0');

	public bool this[uint index]
	{
		get
		{
			return BitArrayUtilities.Get8(index, data);
		}
		set
		{
			BitArrayUtilities.Set8(index, ref data, value);
		}
	}

	public BitArray8(byte initValue)
	{
		data = initValue;
	}

	public BitArray8(IEnumerable<uint> bitIndexTrue)
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
				data |= (byte)(1 << (int)num2);
			}
		}
	}

	public static BitArray8 operator ~(BitArray8 a)
	{
		return new BitArray8((byte)(~a.data));
	}

	public static BitArray8 operator |(BitArray8 a, BitArray8 b)
	{
		return new BitArray8((byte)(a.data | b.data));
	}

	public static BitArray8 operator &(BitArray8 a, BitArray8 b)
	{
		return new BitArray8((byte)(a.data & b.data));
	}

	public IBitArray BitAnd(IBitArray other)
	{
		return this & (BitArray8)(object)other;
	}

	public IBitArray BitOr(IBitArray other)
	{
		return this | (BitArray8)(object)other;
	}

	public IBitArray BitNot()
	{
		return ~this;
	}

	public static bool operator ==(BitArray8 a, BitArray8 b)
	{
		return a.data == b.data;
	}

	public static bool operator !=(BitArray8 a, BitArray8 b)
	{
		return a.data != b.data;
	}

	public override bool Equals(object obj)
	{
		if (obj is BitArray8)
		{
			return ((BitArray8)obj).data == data;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return 1768953197 + data.GetHashCode();
	}
}
