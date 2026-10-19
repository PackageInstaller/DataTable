using System;
using System.Globalization;
using System.Runtime.InteropServices;

namespace Sirenix.Serialization;

public static class ProperBitConverter
{
	[StructLayout(LayoutKind.Explicit)]
	private struct SingleByteUnion
	{
		[FieldOffset(0)]
		public byte Byte0;

		[FieldOffset(1)]
		public byte Byte1;

		[FieldOffset(2)]
		public byte Byte2;

		[FieldOffset(3)]
		public byte Byte3;

		[FieldOffset(0)]
		public float Value;
	}

	[StructLayout(LayoutKind.Explicit)]
	private struct DoubleByteUnion
	{
		[FieldOffset(0)]
		public byte Byte0;

		[FieldOffset(1)]
		public byte Byte1;

		[FieldOffset(2)]
		public byte Byte2;

		[FieldOffset(3)]
		public byte Byte3;

		[FieldOffset(4)]
		public byte Byte4;

		[FieldOffset(5)]
		public byte Byte5;

		[FieldOffset(6)]
		public byte Byte6;

		[FieldOffset(7)]
		public byte Byte7;

		[FieldOffset(0)]
		public double Value;
	}

	[StructLayout(LayoutKind.Explicit)]
	private struct DecimalByteUnion
	{
		[FieldOffset(0)]
		public byte Byte0;

		[FieldOffset(1)]
		public byte Byte1;

		[FieldOffset(2)]
		public byte Byte2;

		[FieldOffset(3)]
		public byte Byte3;

		[FieldOffset(4)]
		public byte Byte4;

		[FieldOffset(5)]
		public byte Byte5;

		[FieldOffset(6)]
		public byte Byte6;

		[FieldOffset(7)]
		public byte Byte7;

		[FieldOffset(8)]
		public byte Byte8;

		[FieldOffset(9)]
		public byte Byte9;

		[FieldOffset(10)]
		public byte Byte10;

		[FieldOffset(11)]
		public byte Byte11;

		[FieldOffset(12)]
		public byte Byte12;

		[FieldOffset(13)]
		public byte Byte13;

		[FieldOffset(14)]
		public byte Byte14;

		[FieldOffset(15)]
		public byte Byte15;

		[FieldOffset(0)]
		public decimal Value;
	}

	[StructLayout(LayoutKind.Explicit)]
	private struct GuidByteUnion
	{
		[FieldOffset(0)]
		public byte Byte0;

		[FieldOffset(1)]
		public byte Byte1;

		[FieldOffset(2)]
		public byte Byte2;

		[FieldOffset(3)]
		public byte Byte3;

		[FieldOffset(4)]
		public byte Byte4;

		[FieldOffset(5)]
		public byte Byte5;

		[FieldOffset(6)]
		public byte Byte6;

		[FieldOffset(7)]
		public byte Byte7;

		[FieldOffset(8)]
		public byte Byte8;

		[FieldOffset(9)]
		public byte Byte9;

		[FieldOffset(10)]
		public byte Byte10;

		[FieldOffset(11)]
		public byte Byte11;

		[FieldOffset(12)]
		public byte Byte12;

		[FieldOffset(13)]
		public byte Byte13;

		[FieldOffset(14)]
		public byte Byte14;

		[FieldOffset(15)]
		public byte Byte15;

		[FieldOffset(0)]
		public Guid Value;
	}

	private static readonly uint[] ByteToHexCharLookupLowerCase = CreateByteToHexLookup(upperCase: false);

	private static readonly uint[] ByteToHexCharLookupUpperCase = CreateByteToHexLookup(upperCase: true);

	private static readonly byte[] HexToByteLookup = new byte[256]
	{
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 0, 1,
		2, 3, 4, 5, 6, 7, 8, 9, 255, 255,
		255, 255, 255, 255, 255, 10, 11, 12, 13, 14,
		15, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 10, 11, 12,
		13, 14, 15, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
		255, 255, 255, 255, 255, 255
	};

	private static uint[] CreateByteToHexLookup(bool upperCase)
	{
		uint[] array = new uint[256];
		if (upperCase)
		{
			for (int i = 0; i < 256; i++)
			{
				string text = i.ToString("X2", CultureInfo.InvariantCulture);
				array[i] = text[0] + ((uint)text[1] << 16);
			}
		}
		else
		{
			for (int j = 0; j < 256; j++)
			{
				string text2 = j.ToString("x2", CultureInfo.InvariantCulture);
				array[j] = text2[0] + ((uint)text2[1] << 16);
			}
		}
		return array;
	}

	public static string BytesToHexString(byte[] bytes, bool lowerCaseHexChars = true)
	{
		uint[] array = (lowerCaseHexChars ? ByteToHexCharLookupLowerCase : ByteToHexCharLookupUpperCase);
		char[] array2 = new char[bytes.Length * 2];
		for (int i = 0; i < bytes.Length; i++)
		{
			int num = i * 2;
			uint num2 = array[bytes[i]];
			array2[num] = (char)num2;
			array2[num + 1] = (char)(num2 >> 16);
		}
		return new string(array2);
	}

	public static byte[] HexStringToBytes(string hex)
	{
		int length = hex.Length;
		int num = length / 2;
		if (length % 2 != 0)
		{
			throw new ArgumentException("Hex string must have an even length.");
		}
		byte[] array = new byte[num];
		for (int i = 0; i < num; i++)
		{
			int num2 = i * 2;
			byte b;
			try
			{
				b = HexToByteLookup[(uint)hex[num2]];
				if (b == byte.MaxValue)
				{
					throw new ArgumentException("Expected a hex character, got '" + hex[num2] + "' at string index '" + num2 + "'.");
				}
			}
			catch (IndexOutOfRangeException)
			{
				throw new ArgumentException("Expected a hex character, got '" + hex[num2] + "' at string index '" + num2 + "'.");
			}
			byte b2;
			try
			{
				b2 = HexToByteLookup[(uint)hex[num2 + 1]];
				if (b2 == byte.MaxValue)
				{
					throw new ArgumentException("Expected a hex character, got '" + hex[num2 + 1] + "' at string index '" + (num2 + 1) + "'.");
				}
			}
			catch (IndexOutOfRangeException)
			{
				throw new ArgumentException("Expected a hex character, got '" + hex[num2 + 1] + "' at string index '" + (num2 + 1) + "'.");
			}
			array[i] = (byte)((b << 4) | b2);
		}
		return array;
	}

	public static short ToInt16(byte[] buffer, int index)
	{
		short num = 0;
		num |= buffer[index + 1];
		num <<= 8;
		return (short)(num | buffer[index]);
	}

	public static ushort ToUInt16(byte[] buffer, int index)
	{
		ushort num = 0;
		num |= buffer[index + 1];
		num <<= 8;
		return (ushort)(num | buffer[index]);
	}

	public static int ToInt32(byte[] buffer, int index)
	{
		int num = 0;
		num |= buffer[index + 3];
		num <<= 8;
		num |= buffer[index + 2];
		num <<= 8;
		num |= buffer[index + 1];
		num <<= 8;
		return num | buffer[index];
	}

	public static uint ToUInt32(byte[] buffer, int index)
	{
		uint num = 0u;
		num |= buffer[index + 3];
		num <<= 8;
		num |= buffer[index + 2];
		num <<= 8;
		num |= buffer[index + 1];
		num <<= 8;
		return num | buffer[index];
	}

	public static long ToInt64(byte[] buffer, int index)
	{
		long num = 0L;
		num |= buffer[index + 7];
		num <<= 8;
		num |= buffer[index + 6];
		num <<= 8;
		num |= buffer[index + 5];
		num <<= 8;
		num |= buffer[index + 4];
		num <<= 8;
		num |= buffer[index + 3];
		num <<= 8;
		num |= buffer[index + 2];
		num <<= 8;
		num |= buffer[index + 1];
		num <<= 8;
		return num | buffer[index];
	}

	public static ulong ToUInt64(byte[] buffer, int index)
	{
		ulong num = 0uL;
		num |= buffer[index + 7];
		num <<= 8;
		num |= buffer[index + 6];
		num <<= 8;
		num |= buffer[index + 5];
		num <<= 8;
		num |= buffer[index + 4];
		num <<= 8;
		num |= buffer[index + 3];
		num <<= 8;
		num |= buffer[index + 2];
		num <<= 8;
		num |= buffer[index + 1];
		num <<= 8;
		return num | buffer[index];
	}

	public static float ToSingle(byte[] buffer, int index)
	{
		SingleByteUnion singleByteUnion = default;
		if (BitConverter.IsLittleEndian)
		{
			singleByteUnion.Byte0 = buffer[index];
			singleByteUnion.Byte1 = buffer[index + 1];
			singleByteUnion.Byte2 = buffer[index + 2];
			singleByteUnion.Byte3 = buffer[index + 3];
		}
		else
		{
			singleByteUnion.Byte3 = buffer[index];
			singleByteUnion.Byte2 = buffer[index + 1];
			singleByteUnion.Byte1 = buffer[index + 2];
			singleByteUnion.Byte0 = buffer[index + 3];
		}
		return singleByteUnion.Value;
	}

	public static double ToDouble(byte[] buffer, int index)
	{
		DoubleByteUnion doubleByteUnion = default;
		if (BitConverter.IsLittleEndian)
		{
			doubleByteUnion.Byte0 = buffer[index];
			doubleByteUnion.Byte1 = buffer[index + 1];
			doubleByteUnion.Byte2 = buffer[index + 2];
			doubleByteUnion.Byte3 = buffer[index + 3];
			doubleByteUnion.Byte4 = buffer[index + 4];
			doubleByteUnion.Byte5 = buffer[index + 5];
			doubleByteUnion.Byte6 = buffer[index + 6];
			doubleByteUnion.Byte7 = buffer[index + 7];
		}
		else
		{
			doubleByteUnion.Byte7 = buffer[index];
			doubleByteUnion.Byte6 = buffer[index + 1];
			doubleByteUnion.Byte5 = buffer[index + 2];
			doubleByteUnion.Byte4 = buffer[index + 3];
			doubleByteUnion.Byte3 = buffer[index + 4];
			doubleByteUnion.Byte2 = buffer[index + 5];
			doubleByteUnion.Byte1 = buffer[index + 6];
			doubleByteUnion.Byte0 = buffer[index + 7];
		}
		return doubleByteUnion.Value;
	}

	public static decimal ToDecimal(byte[] buffer, int index)
	{
		DecimalByteUnion decimalByteUnion = default;
		if (BitConverter.IsLittleEndian)
		{
			decimalByteUnion.Byte0 = buffer[index];
			decimalByteUnion.Byte1 = buffer[index + 1];
			decimalByteUnion.Byte2 = buffer[index + 2];
			decimalByteUnion.Byte3 = buffer[index + 3];
			decimalByteUnion.Byte4 = buffer[index + 4];
			decimalByteUnion.Byte5 = buffer[index + 5];
			decimalByteUnion.Byte6 = buffer[index + 6];
			decimalByteUnion.Byte7 = buffer[index + 7];
			decimalByteUnion.Byte8 = buffer[index + 8];
			decimalByteUnion.Byte9 = buffer[index + 9];
			decimalByteUnion.Byte10 = buffer[index + 10];
			decimalByteUnion.Byte11 = buffer[index + 11];
			decimalByteUnion.Byte12 = buffer[index + 12];
			decimalByteUnion.Byte13 = buffer[index + 13];
			decimalByteUnion.Byte14 = buffer[index + 14];
			decimalByteUnion.Byte15 = buffer[index + 15];
		}
		else
		{
			decimalByteUnion.Byte15 = buffer[index];
			decimalByteUnion.Byte14 = buffer[index + 1];
			decimalByteUnion.Byte13 = buffer[index + 2];
			decimalByteUnion.Byte12 = buffer[index + 3];
			decimalByteUnion.Byte11 = buffer[index + 4];
			decimalByteUnion.Byte10 = buffer[index + 5];
			decimalByteUnion.Byte9 = buffer[index + 6];
			decimalByteUnion.Byte8 = buffer[index + 7];
			decimalByteUnion.Byte7 = buffer[index + 8];
			decimalByteUnion.Byte6 = buffer[index + 9];
			decimalByteUnion.Byte5 = buffer[index + 10];
			decimalByteUnion.Byte4 = buffer[index + 11];
			decimalByteUnion.Byte3 = buffer[index + 12];
			decimalByteUnion.Byte2 = buffer[index + 13];
			decimalByteUnion.Byte1 = buffer[index + 14];
			decimalByteUnion.Byte0 = buffer[index + 15];
		}
		return decimalByteUnion.Value;
	}

	public static Guid ToGuid(byte[] buffer, int index)
	{
		GuidByteUnion guidByteUnion = new GuidByteUnion
		{
			Byte0 = buffer[index],
			Byte1 = buffer[index + 1],
			Byte2 = buffer[index + 2],
			Byte3 = buffer[index + 3],
			Byte4 = buffer[index + 4],
			Byte5 = buffer[index + 5],
			Byte6 = buffer[index + 6],
			Byte7 = buffer[index + 7],
			Byte8 = buffer[index + 8],
			Byte9 = buffer[index + 9]
		};
		if (BitConverter.IsLittleEndian)
		{
			guidByteUnion.Byte10 = buffer[index + 10];
			guidByteUnion.Byte11 = buffer[index + 11];
			guidByteUnion.Byte12 = buffer[index + 12];
			guidByteUnion.Byte13 = buffer[index + 13];
			guidByteUnion.Byte14 = buffer[index + 14];
			guidByteUnion.Byte15 = buffer[index + 15];
		}
		else
		{
			guidByteUnion.Byte15 = buffer[index + 10];
			guidByteUnion.Byte14 = buffer[index + 11];
			guidByteUnion.Byte13 = buffer[index + 12];
			guidByteUnion.Byte12 = buffer[index + 13];
			guidByteUnion.Byte11 = buffer[index + 14];
			guidByteUnion.Byte10 = buffer[index + 15];
		}
		return guidByteUnion.Value;
	}

	public static void GetBytes(byte[] buffer, int index, short value)
	{
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = (byte)value;
			buffer[index + 1] = (byte)(value >> 8);
		}
		else
		{
			buffer[index] = (byte)(value >> 8);
			buffer[index + 1] = (byte)value;
		}
	}

	public static void GetBytes(byte[] buffer, int index, ushort value)
	{
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = (byte)value;
			buffer[index + 1] = (byte)(value >> 8);
		}
		else
		{
			buffer[index] = (byte)(value >> 8);
			buffer[index + 1] = (byte)value;
		}
	}

	public static void GetBytes(byte[] buffer, int index, int value)
	{
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = (byte)value;
			buffer[index + 1] = (byte)(value >> 8);
			buffer[index + 2] = (byte)(value >> 16);
			buffer[index + 3] = (byte)(value >> 24);
		}
		else
		{
			buffer[index] = (byte)(value >> 24);
			buffer[index + 1] = (byte)(value >> 16);
			buffer[index + 2] = (byte)(value >> 8);
			buffer[index + 3] = (byte)value;
		}
	}

	public static void GetBytes(byte[] buffer, int index, uint value)
	{
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = (byte)value;
			buffer[index + 1] = (byte)(value >> 8);
			buffer[index + 2] = (byte)(value >> 16);
			buffer[index + 3] = (byte)(value >> 24);
		}
		else
		{
			buffer[index] = (byte)(value >> 24);
			buffer[index + 1] = (byte)(value >> 16);
			buffer[index + 2] = (byte)(value >> 8);
			buffer[index + 3] = (byte)value;
		}
	}

	public static void GetBytes(byte[] buffer, int index, long value)
	{
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = (byte)value;
			buffer[index + 1] = (byte)(value >> 8);
			buffer[index + 2] = (byte)(value >> 16);
			buffer[index + 3] = (byte)(value >> 24);
			buffer[index + 4] = (byte)(value >> 32);
			buffer[index + 5] = (byte)(value >> 40);
			buffer[index + 6] = (byte)(value >> 48);
			buffer[index + 7] = (byte)(value >> 56);
		}
		else
		{
			buffer[index] = (byte)(value >> 56);
			buffer[index + 1] = (byte)(value >> 48);
			buffer[index + 2] = (byte)(value >> 40);
			buffer[index + 3] = (byte)(value >> 32);
			buffer[index + 4] = (byte)(value >> 24);
			buffer[index + 5] = (byte)(value >> 16);
			buffer[index + 6] = (byte)(value >> 8);
			buffer[index + 7] = (byte)value;
		}
	}

	public static void GetBytes(byte[] buffer, int index, ulong value)
	{
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = (byte)value;
			buffer[index + 1] = (byte)(value >> 8);
			buffer[index + 2] = (byte)(value >> 16);
			buffer[index + 3] = (byte)(value >> 24);
			buffer[index + 4] = (byte)(value >> 32);
			buffer[index + 5] = (byte)(value >> 40);
			buffer[index + 6] = (byte)(value >> 48);
			buffer[index + 7] = (byte)(value >> 56);
		}
		else
		{
			buffer[index] = (byte)(value >> 56);
			buffer[index + 1] = (byte)(value >> 48);
			buffer[index + 2] = (byte)(value >> 40);
			buffer[index + 3] = (byte)(value >> 32);
			buffer[index + 4] = (byte)(value >> 24);
			buffer[index + 5] = (byte)(value >> 16);
			buffer[index + 6] = (byte)(value >> 8);
			buffer[index + 7] = (byte)value;
		}
	}

	public static void GetBytes(byte[] buffer, int index, float value)
	{
		SingleByteUnion singleByteUnion = new SingleByteUnion
		{
			Value = value
		};
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = singleByteUnion.Byte0;
			buffer[index + 1] = singleByteUnion.Byte1;
			buffer[index + 2] = singleByteUnion.Byte2;
			buffer[index + 3] = singleByteUnion.Byte3;
		}
		else
		{
			buffer[index] = singleByteUnion.Byte3;
			buffer[index + 1] = singleByteUnion.Byte2;
			buffer[index + 2] = singleByteUnion.Byte1;
			buffer[index + 3] = singleByteUnion.Byte0;
		}
	}

	public static void GetBytes(byte[] buffer, int index, double value)
	{
		DoubleByteUnion doubleByteUnion = new DoubleByteUnion
		{
			Value = value
		};
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = doubleByteUnion.Byte0;
			buffer[index + 1] = doubleByteUnion.Byte1;
			buffer[index + 2] = doubleByteUnion.Byte2;
			buffer[index + 3] = doubleByteUnion.Byte3;
			buffer[index + 4] = doubleByteUnion.Byte4;
			buffer[index + 5] = doubleByteUnion.Byte5;
			buffer[index + 6] = doubleByteUnion.Byte6;
			buffer[index + 7] = doubleByteUnion.Byte7;
		}
		else
		{
			buffer[index] = doubleByteUnion.Byte7;
			buffer[index + 1] = doubleByteUnion.Byte6;
			buffer[index + 2] = doubleByteUnion.Byte5;
			buffer[index + 3] = doubleByteUnion.Byte4;
			buffer[index + 4] = doubleByteUnion.Byte3;
			buffer[index + 5] = doubleByteUnion.Byte2;
			buffer[index + 6] = doubleByteUnion.Byte1;
			buffer[index + 7] = doubleByteUnion.Byte0;
		}
	}

	public static void GetBytes(byte[] buffer, int index, decimal value)
	{
		DecimalByteUnion decimalByteUnion = new DecimalByteUnion
		{
			Value = value
		};
		if (BitConverter.IsLittleEndian)
		{
			buffer[index] = decimalByteUnion.Byte0;
			buffer[index + 1] = decimalByteUnion.Byte1;
			buffer[index + 2] = decimalByteUnion.Byte2;
			buffer[index + 3] = decimalByteUnion.Byte3;
			buffer[index + 4] = decimalByteUnion.Byte4;
			buffer[index + 5] = decimalByteUnion.Byte5;
			buffer[index + 6] = decimalByteUnion.Byte6;
			buffer[index + 7] = decimalByteUnion.Byte7;
			buffer[index + 8] = decimalByteUnion.Byte8;
			buffer[index + 9] = decimalByteUnion.Byte9;
			buffer[index + 10] = decimalByteUnion.Byte10;
			buffer[index + 11] = decimalByteUnion.Byte11;
			buffer[index + 12] = decimalByteUnion.Byte12;
			buffer[index + 13] = decimalByteUnion.Byte13;
			buffer[index + 14] = decimalByteUnion.Byte14;
			buffer[index + 15] = decimalByteUnion.Byte15;
		}
		else
		{
			buffer[index] = decimalByteUnion.Byte15;
			buffer[index + 1] = decimalByteUnion.Byte14;
			buffer[index + 2] = decimalByteUnion.Byte13;
			buffer[index + 3] = decimalByteUnion.Byte12;
			buffer[index + 4] = decimalByteUnion.Byte11;
			buffer[index + 5] = decimalByteUnion.Byte10;
			buffer[index + 6] = decimalByteUnion.Byte9;
			buffer[index + 7] = decimalByteUnion.Byte8;
			buffer[index + 8] = decimalByteUnion.Byte7;
			buffer[index + 9] = decimalByteUnion.Byte6;
			buffer[index + 10] = decimalByteUnion.Byte5;
			buffer[index + 11] = decimalByteUnion.Byte4;
			buffer[index + 12] = decimalByteUnion.Byte3;
			buffer[index + 13] = decimalByteUnion.Byte2;
			buffer[index + 14] = decimalByteUnion.Byte1;
			buffer[index + 15] = decimalByteUnion.Byte0;
		}
	}

	public static void GetBytes(byte[] buffer, int index, Guid value)
	{
		GuidByteUnion guidByteUnion = new GuidByteUnion
		{
			Value = value
		};
		buffer[index] = guidByteUnion.Byte0;
		buffer[index + 1] = guidByteUnion.Byte1;
		buffer[index + 2] = guidByteUnion.Byte2;
		buffer[index + 3] = guidByteUnion.Byte3;
		buffer[index + 4] = guidByteUnion.Byte4;
		buffer[index + 5] = guidByteUnion.Byte5;
		buffer[index + 6] = guidByteUnion.Byte6;
		buffer[index + 7] = guidByteUnion.Byte7;
		buffer[index + 8] = guidByteUnion.Byte8;
		buffer[index + 9] = guidByteUnion.Byte9;
		if (BitConverter.IsLittleEndian)
		{
			buffer[index + 10] = guidByteUnion.Byte10;
			buffer[index + 11] = guidByteUnion.Byte11;
			buffer[index + 12] = guidByteUnion.Byte12;
			buffer[index + 13] = guidByteUnion.Byte13;
			buffer[index + 14] = guidByteUnion.Byte14;
			buffer[index + 15] = guidByteUnion.Byte15;
		}
		else
		{
			buffer[index + 10] = guidByteUnion.Byte15;
			buffer[index + 11] = guidByteUnion.Byte14;
			buffer[index + 12] = guidByteUnion.Byte13;
			buffer[index + 13] = guidByteUnion.Byte12;
			buffer[index + 14] = guidByteUnion.Byte11;
			buffer[index + 15] = guidByteUnion.Byte10;
		}
	}
}
