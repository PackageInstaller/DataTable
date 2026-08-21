using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{this.GetType().Name} {humanizedData}")]
public struct BitArray256 : IBitArray
{
	[SerializeField]
	private ulong data1;

	[SerializeField]
	private ulong data2;

	[SerializeField]
	private ulong data3;

	[SerializeField]
	private ulong data4;

	public uint capacity => 256u;

	public bool allFalse
	{
		get
		{
			if (data1 == 0L && data2 == 0L && data3 == 0L)
			{
				return data4 == 0;
			}
			return false;
		}
	}

	public bool allTrue
	{
		get
		{
			if (data1 == ulong.MaxValue && data2 == ulong.MaxValue && data3 == ulong.MaxValue)
			{
				return data4 == ulong.MaxValue;
			}
			return false;
		}
	}

	public string humanizedData => Regex.Replace(string.Format("{0, " + 64u + "}", Convert.ToString((long)data4, 2)).Replace(' ', '0'), ".{8}", "$0.") + Regex.Replace(string.Format("{0, " + 64u + "}", Convert.ToString((long)data3, 2)).Replace(' ', '0'), ".{8}", "$0.") + Regex.Replace(string.Format("{0, " + 64u + "}", Convert.ToString((long)data2, 2)).Replace(' ', '0'), ".{8}", "$0.") + Regex.Replace(string.Format("{0, " + 64u + "}", Convert.ToString((long)data1, 2)).Replace(' ', '0'), ".{8}", "$0.").TrimEnd('.');

	public bool this[uint index]
	{
		get
		{
			return BitArrayUtilities.Get256(index, data1, data2, data3, data4);
		}
		set
		{
			BitArrayUtilities.Set256(index, ref data1, ref data2, ref data3, ref data4, value);
		}
	}

	public BitArray256(ulong initValue1, ulong initValue2, ulong initValue3, ulong initValue4)
	{
		data1 = initValue1;
		data2 = initValue2;
		data3 = initValue3;
		data4 = initValue4;
	}

	public BitArray256(IEnumerable<uint> bitIndexTrue)
	{
		data1 = (data2 = (data3 = (data4 = 0uL)));
		if (bitIndexTrue == null)
		{
			return;
		}
		for (int num = bitIndexTrue.Count() - 1; num >= 0; num--)
		{
			uint num2 = bitIndexTrue.ElementAt(num);
			switch (num2)
			{
			case 0u:
			case 1u:
			case 2u:
			case 3u:
			case 4u:
			case 5u:
			case 6u:
			case 7u:
			case 8u:
			case 9u:
			case 10u:
			case 11u:
			case 12u:
			case 13u:
			case 14u:
			case 15u:
			case 16u:
			case 17u:
			case 18u:
			case 19u:
			case 20u:
			case 21u:
			case 22u:
			case 23u:
			case 24u:
			case 25u:
			case 26u:
			case 27u:
			case 28u:
			case 29u:
			case 30u:
			case 31u:
			case 32u:
			case 33u:
			case 34u:
			case 35u:
			case 36u:
			case 37u:
			case 38u:
			case 39u:
			case 40u:
			case 41u:
			case 42u:
			case 43u:
			case 44u:
			case 45u:
			case 46u:
			case 47u:
			case 48u:
			case 49u:
			case 50u:
			case 51u:
			case 52u:
			case 53u:
			case 54u:
			case 55u:
			case 56u:
			case 57u:
			case 58u:
			case 59u:
			case 60u:
			case 61u:
			case 62u:
			case 63u:
				data1 |= (ulong)(1L << (int)num2);
				break;
			case 64u:
			case 65u:
			case 66u:
			case 67u:
			case 68u:
			case 69u:
			case 70u:
			case 71u:
			case 72u:
			case 73u:
			case 74u:
			case 75u:
			case 76u:
			case 77u:
			case 78u:
			case 79u:
			case 80u:
			case 81u:
			case 82u:
			case 83u:
			case 84u:
			case 85u:
			case 86u:
			case 87u:
			case 88u:
			case 89u:
			case 90u:
			case 91u:
			case 92u:
			case 93u:
			case 94u:
			case 95u:
			case 96u:
			case 97u:
			case 98u:
			case 99u:
			case 100u:
			case 101u:
			case 102u:
			case 103u:
			case 104u:
			case 105u:
			case 106u:
			case 107u:
			case 108u:
			case 109u:
			case 110u:
			case 111u:
			case 112u:
			case 113u:
			case 114u:
			case 115u:
			case 116u:
			case 117u:
			case 118u:
			case 119u:
			case 120u:
			case 121u:
			case 122u:
			case 123u:
			case 124u:
			case 125u:
			case 126u:
			case 127u:
				data2 |= (ulong)(1L << (int)(num2 - 64));
				break;
			case 128u:
			case 129u:
			case 130u:
			case 131u:
			case 132u:
			case 133u:
			case 134u:
			case 135u:
			case 136u:
			case 137u:
			case 138u:
			case 139u:
			case 140u:
			case 141u:
			case 142u:
			case 143u:
			case 144u:
			case 145u:
			case 146u:
			case 147u:
			case 148u:
			case 149u:
			case 150u:
			case 151u:
			case 152u:
			case 153u:
			case 154u:
			case 155u:
			case 156u:
			case 157u:
			case 158u:
			case 159u:
			case 160u:
			case 161u:
			case 162u:
			case 163u:
			case 164u:
			case 165u:
			case 166u:
			case 167u:
			case 168u:
			case 169u:
			case 170u:
			case 171u:
			case 172u:
			case 173u:
			case 174u:
			case 175u:
			case 176u:
			case 177u:
			case 178u:
			case 179u:
			case 180u:
			case 181u:
			case 182u:
			case 183u:
			case 184u:
			case 185u:
			case 186u:
			case 187u:
			case 188u:
			case 189u:
			case 190u:
			case 191u:
				data3 |= (ulong)(1L << (int)(num2 - 128));
				break;
			default:
				if (num2 < capacity)
				{
					data4 |= (ulong)(1L << (int)(num2 - 192));
				}
				break;
			}
		}
	}

	public static BitArray256 operator ~(BitArray256 a)
	{
		return new BitArray256(~a.data1, ~a.data2, ~a.data3, ~a.data4);
	}

	public static BitArray256 operator |(BitArray256 a, BitArray256 b)
	{
		return new BitArray256(a.data1 | b.data1, a.data2 | b.data2, a.data3 | b.data3, a.data4 | b.data4);
	}

	public static BitArray256 operator &(BitArray256 a, BitArray256 b)
	{
		return new BitArray256(a.data1 & b.data1, a.data2 & b.data2, a.data3 & b.data3, a.data4 & b.data4);
	}

	public IBitArray BitAnd(IBitArray other)
	{
		return this & (BitArray256)(object)other;
	}

	public IBitArray BitOr(IBitArray other)
	{
		return this | (BitArray256)(object)other;
	}

	public IBitArray BitNot()
	{
		return ~this;
	}

	public static bool operator ==(BitArray256 a, BitArray256 b)
	{
		if (a.data1 == b.data1 && a.data2 == b.data2 && a.data3 == b.data3)
		{
			return a.data4 == b.data4;
		}
		return false;
	}

	public static bool operator !=(BitArray256 a, BitArray256 b)
	{
		if (a.data1 == b.data1 && a.data2 == b.data2 && a.data3 == b.data3)
		{
			return a.data4 != b.data4;
		}
		return true;
	}

	public override bool Equals(object obj)
	{
		if (obj is BitArray256 && data1.Equals(((BitArray256)obj).data1) && data2.Equals(((BitArray256)obj).data2) && data3.Equals(((BitArray256)obj).data3))
		{
			return data4.Equals(((BitArray256)obj).data4);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (((unchecked(1870826326 * -1521134295) + data1.GetHashCode()) * -1521134295 + data2.GetHashCode()) * -1521134295 + data3.GetHashCode()) * -1521134295 + data4.GetHashCode();
	}
}
