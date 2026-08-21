namespace UnityEngine.Rendering;

public static class BitArrayUtilities
{
	public static bool Get8(uint index, byte data)
	{
		return (data & (1 << (int)index)) != 0;
	}

	public static bool Get16(uint index, ushort data)
	{
		return (data & (1 << (int)index)) != 0;
	}

	public static bool Get32(uint index, uint data)
	{
		return (data & (uint)(1 << (int)index)) != 0;
	}

	public static bool Get64(uint index, ulong data)
	{
		return (data & (ulong)(1L << (int)index)) != 0;
	}

	public static bool Get128(uint index, ulong data1, ulong data2)
	{
		if (index >= 64)
		{
			return (data2 & (ulong)(1L << (int)(index - 64))) != 0;
		}
		return (data1 & (ulong)(1L << (int)index)) != 0;
	}

	public static bool Get256(uint index, ulong data1, ulong data2, ulong data3, ulong data4)
	{
		switch (index)
		{
		default:
			return (data4 & (ulong)(1L << (int)(index - 192))) != 0;
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
			return (data3 & (ulong)(1L << (int)(index - 128))) != 0;
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
			return (data2 & (ulong)(1L << (int)(index - 64))) != 0;
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
			return (data1 & (ulong)(1L << (int)index)) != 0;
		}
	}

	public static void Set8(uint index, ref byte data, bool value)
	{
		data = (byte)(value ? (data | (1 << (int)index)) : (data & ~(1 << (int)index)));
	}

	public static void Set16(uint index, ref ushort data, bool value)
	{
		data = (ushort)(value ? (data | (1 << (int)index)) : (data & ~(1 << (int)index)));
	}

	public static void Set32(uint index, ref uint data, bool value)
	{
		data = (value ? (data | (uint)(1 << (int)index)) : (data & (uint)(~(1 << (int)index))));
	}

	public static void Set64(uint index, ref ulong data, bool value)
	{
		data = (value ? (data | (ulong)(1L << (int)index)) : (data & (ulong)(~(1L << (int)index))));
	}

	public static void Set128(uint index, ref ulong data1, ref ulong data2, bool value)
	{
		if (index < 64)
		{
			data1 = (value ? (data1 | (ulong)(1L << (int)index)) : (data1 & (ulong)(~(1L << (int)index))));
		}
		else
		{
			data2 = (value ? (data2 | (ulong)(1L << (int)(index - 64))) : (data2 & (ulong)(~(1L << (int)(index - 64)))));
		}
	}

	public static void Set256(uint index, ref ulong data1, ref ulong data2, ref ulong data3, ref ulong data4, bool value)
	{
		switch (index)
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
			data1 = (value ? (data1 | (ulong)(1L << (int)index)) : (data1 & (ulong)(~(1L << (int)index))));
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
			data2 = (value ? (data2 | (ulong)(1L << (int)(index - 64))) : (data2 & (ulong)(~(1L << (int)(index - 64)))));
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
			data3 = (value ? (data3 | (ulong)(1L << (int)(index - 64))) : (data3 & (ulong)(~(1L << (int)(index - 128)))));
			break;
		default:
			data4 = (value ? (data4 | (ulong)(1L << (int)(index - 64))) : (data4 & (ulong)(~(1L << (int)(index - 192)))));
			break;
		}
	}
}
