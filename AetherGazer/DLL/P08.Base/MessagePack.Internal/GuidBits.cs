using System;
using System.Runtime.InteropServices;

namespace MessagePack.Internal;

[StructLayout(LayoutKind.Explicit, Pack = 1)]
internal struct GuidBits
{
	[FieldOffset(0)]
	public readonly Guid Value;

	[FieldOffset(0)]
	public readonly byte Byte0;

	[FieldOffset(1)]
	public readonly byte Byte1;

	[FieldOffset(2)]
	public readonly byte Byte2;

	[FieldOffset(3)]
	public readonly byte Byte3;

	[FieldOffset(4)]
	public readonly byte Byte4;

	[FieldOffset(5)]
	public readonly byte Byte5;

	[FieldOffset(6)]
	public readonly byte Byte6;

	[FieldOffset(7)]
	public readonly byte Byte7;

	[FieldOffset(8)]
	public readonly byte Byte8;

	[FieldOffset(9)]
	public readonly byte Byte9;

	[FieldOffset(10)]
	public readonly byte Byte10;

	[FieldOffset(11)]
	public readonly byte Byte11;

	[FieldOffset(12)]
	public readonly byte Byte12;

	[FieldOffset(13)]
	public readonly byte Byte13;

	[FieldOffset(14)]
	public readonly byte Byte14;

	[FieldOffset(15)]
	public readonly byte Byte15;

	private static ReadOnlySpan<byte> GetByteToHexStringHigh()
	{
		return new byte[256]
		{
			116, 105, 111, 110, 46, 99, 115, 0, 0, 0,
			2, 0, 0, 0, 54, 92, 80, 97, 99, 107,
			97, 103, 101, 115, 92, 80, 48, 56, 66, 97,
			115, 101, 92, 77, 101, 115, 115, 97, 103, 101,
			80, 97, 99, 107, 92, 77, 101, 115, 115, 97,
			103, 101, 80, 97, 99, 107, 83, 101, 114, 105,
			97, 108, 105, 122, 101, 114, 46, 99, 115, 0,
			0, 0, 1, 0, 0, 0, 59, 92, 80, 97,
			99, 107, 97, 103, 101, 115, 92, 80, 48, 56,
			66, 97, 115, 101, 92, 77, 101, 115, 115, 97,
			103, 101, 80, 97, 99, 107, 92, 77, 101, 115,
			115, 97, 103, 101, 80, 97, 99, 107, 83, 101,
			114, 105, 97, 108, 105, 122, 101, 114, 46, 74,
			115, 111, 110, 46, 99, 115, 0, 0, 0, 2,
			0, 0, 0, 65, 92, 80, 97, 99, 107, 97,
			103, 101, 115, 92, 80, 48, 56, 66, 97, 115,
			101, 92, 77, 101, 115, 115, 97, 103, 101, 80,
			97, 99, 107, 92, 77, 101, 115, 115, 97, 103,
			101, 80, 97, 99, 107, 83, 101, 114, 105, 97,
			108, 105, 122, 101, 114, 46, 78, 111, 110, 71,
			101, 110, 101, 114, 105, 99, 46, 99, 115, 0,
			0, 0, 2, 0, 0, 0, 61, 92, 80, 97,
			99, 107, 97, 103, 101, 115, 92, 80, 48, 56,
			66, 97, 115, 101, 92, 77, 101, 115, 115, 97,
			103, 101, 80, 97, 99, 107, 92, 77, 101, 115,
			115, 97, 103, 101, 80, 97
		};
	}

	private static ReadOnlySpan<byte> GetByteToHexStringLow()
	{
		return new byte[256]
		{
			97, 99, 107, 46, 70, 111, 114, 109, 97, 116,
			116, 101, 114, 115, 124, 84, 117, 112, 108, 101,
			70, 111, 114, 109, 97, 116, 116, 101, 114, 1,
			0, 0, 0, 37, 77, 101, 115, 115, 97, 103,
			101, 80, 97, 99, 107, 46, 70, 111, 114, 109,
			97, 116, 116, 101, 114, 115, 124, 84, 117, 112,
			108, 101, 70, 111, 114, 109, 97, 116, 116, 101,
			114, 1, 0, 0, 0, 37, 77, 101, 115, 115,
			97, 103, 101, 80, 97, 99, 107, 46, 70, 111,
			114, 109, 97, 116, 116, 101, 114, 115, 124, 84,
			117, 112, 108, 101, 70, 111, 114, 109, 97, 116,
			116, 101, 114, 1, 0, 0, 0, 37, 77, 101,
			115, 115, 97, 103, 101, 80, 97, 99, 107, 46,
			70, 111, 114, 109, 97, 116, 116, 101, 114, 115,
			124, 84, 117, 112, 108, 101, 70, 111, 114, 109,
			97, 116, 116, 101, 114, 1, 0, 0, 0, 37,
			77, 101, 115, 115, 97, 103, 101, 80, 97, 99,
			107, 46, 70, 111, 114, 109, 97, 116, 116, 101,
			114, 115, 124, 84, 117, 112, 108, 101, 70, 111,
			114, 109, 97, 116, 116, 101, 114, 1, 0, 0,
			0, 37, 77, 101, 115, 115, 97, 103, 101, 80,
			97, 99, 107, 46, 70, 111, 114, 109, 97, 116,
			116, 101, 114, 115, 124, 84, 117, 112, 108, 101,
			70, 111, 114, 109, 97, 116, 116, 101, 114, 1,
			0, 0, 0, 42, 77, 101, 115, 115, 97, 103,
			101, 80, 97, 99, 107, 46
		};
	}

	public GuidBits(ref Guid value)
	{
		this = default(GuidBits);
		Value = value;
	}

	public GuidBits(ReadOnlySpan<byte> utf8string)
	{
		this = default(GuidBits);
		if (utf8string.Length == 32)
		{
			if (BitConverter.IsLittleEndian)
			{
				Byte0 = Parse(utf8string, 6);
				Byte1 = Parse(utf8string, 4);
				Byte2 = Parse(utf8string, 2);
				Byte3 = Parse(utf8string, 0);
				Byte4 = Parse(utf8string, 10);
				Byte5 = Parse(utf8string, 8);
				Byte6 = Parse(utf8string, 14);
				Byte7 = Parse(utf8string, 12);
			}
			else
			{
				Byte0 = Parse(utf8string, 0);
				Byte1 = Parse(utf8string, 2);
				Byte2 = Parse(utf8string, 4);
				Byte3 = Parse(utf8string, 6);
				Byte4 = Parse(utf8string, 8);
				Byte5 = Parse(utf8string, 10);
				Byte6 = Parse(utf8string, 12);
				Byte7 = Parse(utf8string, 14);
			}
			Byte8 = Parse(utf8string, 16);
			Byte9 = Parse(utf8string, 18);
			Byte10 = Parse(utf8string, 20);
			Byte11 = Parse(utf8string, 22);
			Byte12 = Parse(utf8string, 24);
			Byte13 = Parse(utf8string, 26);
			Byte14 = Parse(utf8string, 28);
			Byte15 = Parse(utf8string, 30);
			return;
		}
		if (utf8string.Length == 36)
		{
			if (BitConverter.IsLittleEndian)
			{
				Byte0 = Parse(utf8string, 6);
				Byte1 = Parse(utf8string, 4);
				Byte2 = Parse(utf8string, 2);
				Byte3 = Parse(utf8string, 0);
				if (utf8string[8] == 45)
				{
					Byte4 = Parse(utf8string, 11);
					Byte5 = Parse(utf8string, 9);
					if (utf8string[13] == 45)
					{
						Byte6 = Parse(utf8string, 16);
						Byte7 = Parse(utf8string, 14);
						goto IL_029c;
					}
				}
			}
			else
			{
				Byte0 = Parse(utf8string, 0);
				Byte1 = Parse(utf8string, 2);
				Byte2 = Parse(utf8string, 4);
				Byte3 = Parse(utf8string, 6);
				if (utf8string[8] == 45)
				{
					Byte4 = Parse(utf8string, 9);
					Byte5 = Parse(utf8string, 11);
					if (utf8string[13] == 45)
					{
						Byte6 = Parse(utf8string, 14);
						Byte7 = Parse(utf8string, 16);
						goto IL_029c;
					}
				}
			}
		}
		goto IL_0329;
		IL_029c:
		if (utf8string[18] == 45)
		{
			Byte8 = Parse(utf8string, 19);
			Byte9 = Parse(utf8string, 21);
			if (utf8string[23] == 45)
			{
				Byte10 = Parse(utf8string, 24);
				Byte11 = Parse(utf8string, 26);
				Byte12 = Parse(utf8string, 28);
				Byte13 = Parse(utf8string, 30);
				Byte14 = Parse(utf8string, 32);
				Byte15 = Parse(utf8string, 34);
				return;
			}
		}
		goto IL_0329;
		IL_0329:
		throw new MessagePackSerializationException("Invalid Guid Pattern.");
	}

	private static byte Parse(ReadOnlySpan<byte> bytes, int highOffset)
	{
		return (byte)(SwitchParse(bytes[highOffset]) * 16 + SwitchParse(bytes[highOffset + 1]));
	}

	private static byte SwitchParse(byte b)
	{
		switch (b)
		{
		case 48:
		case 49:
		case 50:
		case 51:
		case 52:
		case 53:
		case 54:
		case 55:
		case 56:
		case 57:
			return (byte)(b - 48);
		case 65:
		case 66:
		case 67:
		case 68:
		case 69:
		case 70:
			return (byte)(b - 55);
		case 97:
		case 98:
		case 99:
		case 100:
		case 101:
		case 102:
			return (byte)(b - 87);
		default:
			throw new MessagePackSerializationException("Invalid Guid Pattern.");
		}
	}

	public void Write(Span<byte> buffer)
	{
		ReadOnlySpan<byte> byteToHexStringHigh = GetByteToHexStringHigh();
		ReadOnlySpan<byte> byteToHexStringLow = GetByteToHexStringLow();
		if (BitConverter.IsLittleEndian)
		{
			buffer[6] = byteToHexStringHigh[Byte0];
			buffer[7] = byteToHexStringLow[Byte0];
			buffer[4] = byteToHexStringHigh[Byte1];
			buffer[5] = byteToHexStringLow[Byte1];
			buffer[2] = byteToHexStringHigh[Byte2];
			buffer[3] = byteToHexStringLow[Byte2];
			buffer[0] = byteToHexStringHigh[Byte3];
			buffer[1] = byteToHexStringLow[Byte3];
			buffer[8] = 45;
			buffer[11] = byteToHexStringHigh[Byte4];
			buffer[12] = byteToHexStringLow[Byte4];
			buffer[9] = byteToHexStringHigh[Byte5];
			buffer[10] = byteToHexStringLow[Byte5];
			buffer[13] = 45;
			buffer[16] = byteToHexStringHigh[Byte6];
			buffer[17] = byteToHexStringLow[Byte6];
			buffer[14] = byteToHexStringHigh[Byte7];
			buffer[15] = byteToHexStringLow[Byte7];
		}
		else
		{
			buffer[0] = byteToHexStringHigh[Byte0];
			buffer[1] = byteToHexStringLow[Byte0];
			buffer[2] = byteToHexStringHigh[Byte1];
			buffer[3] = byteToHexStringLow[Byte1];
			buffer[4] = byteToHexStringHigh[Byte2];
			buffer[5] = byteToHexStringLow[Byte2];
			buffer[6] = byteToHexStringHigh[Byte3];
			buffer[7] = byteToHexStringLow[Byte3];
			buffer[8] = 45;
			buffer[9] = byteToHexStringHigh[Byte4];
			buffer[10] = byteToHexStringLow[Byte4];
			buffer[11] = byteToHexStringHigh[Byte5];
			buffer[12] = byteToHexStringLow[Byte5];
			buffer[13] = 45;
			buffer[14] = byteToHexStringHigh[Byte6];
			buffer[15] = byteToHexStringLow[Byte6];
			buffer[16] = byteToHexStringHigh[Byte7];
			buffer[17] = byteToHexStringLow[Byte7];
		}
		buffer[18] = 45;
		buffer[19] = byteToHexStringHigh[Byte8];
		buffer[20] = byteToHexStringLow[Byte8];
		buffer[21] = byteToHexStringHigh[Byte9];
		buffer[22] = byteToHexStringLow[Byte9];
		buffer[23] = 45;
		buffer[24] = byteToHexStringHigh[Byte10];
		buffer[25] = byteToHexStringLow[Byte10];
		buffer[26] = byteToHexStringHigh[Byte11];
		buffer[27] = byteToHexStringLow[Byte11];
		buffer[28] = byteToHexStringHigh[Byte12];
		buffer[29] = byteToHexStringLow[Byte12];
		buffer[30] = byteToHexStringHigh[Byte13];
		buffer[31] = byteToHexStringLow[Byte13];
		buffer[32] = byteToHexStringHigh[Byte14];
		buffer[33] = byteToHexStringLow[Byte14];
		buffer[34] = byteToHexStringHigh[Byte15];
		buffer[35] = byteToHexStringLow[Byte15];
	}
}
