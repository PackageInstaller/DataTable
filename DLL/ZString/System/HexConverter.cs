using System.Runtime.CompilerServices;

namespace System;

internal static class HexConverter
{
	public enum Casing : uint
	{
		Upper = 0u,
		Lower = 8224u
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void ToBytesBuffer(byte value, Span<byte> buffer, int startingIndex = 0, Casing casing = Casing.Upper)
	{
		uint num = (uint)(((value & 0xF0) << 4) + (value & 0xF) - 35209);
		uint num2 = ((((0 - num) & 0x7070) >> 4) + num + 47545) | (uint)casing;
		buffer[startingIndex + 1] = (byte)num2;
		buffer[startingIndex] = (byte)(num2 >> 8);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void ToCharsBuffer(byte value, Span<char> buffer, int startingIndex = 0, Casing casing = Casing.Upper)
	{
		uint num = (uint)(((value & 0xF0) << 4) + (value & 0xF) - 35209);
		uint num2 = ((((0 - num) & 0x7070) >> 4) + num + 47545) | (uint)casing;
		buffer[startingIndex + 1] = (char)(num2 & 0xFF);
		buffer[startingIndex] = (char)(num2 >> 8);
	}

	public static string ToString(ReadOnlySpan<byte> bytes, Casing casing = Casing.Upper)
	{
		Span<char> span = default(Span<char>);
		span = ((bytes.Length <= 16) ? stackalloc char[bytes.Length * 2] : new char[bytes.Length * 2].AsSpan());
		int num = 0;
		ReadOnlySpan<byte> readOnlySpan = bytes;
		for (int i = 0; i < readOnlySpan.Length; i++)
		{
			ToCharsBuffer(readOnlySpan[i], span, num, casing);
			num += 2;
		}
		return span.ToString();
	}

	[MethodImpl((MethodImplOptions)256)]
	public static char ToCharUpper(int value)
	{
		value &= 0xF;
		value += 48;
		if (value > 57)
		{
			value += 7;
		}
		return (char)value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static char ToCharLower(int value)
	{
		value &= 0xF;
		value += 48;
		if (value > 57)
		{
			value += 39;
		}
		return (char)value;
	}
}
