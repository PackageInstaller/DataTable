using System.Runtime.CompilerServices;

namespace System.Buffers.Text;

internal static class FormattingHelpers
{
	public enum HexCasing : uint
	{
		Uppercase = 0u,
		Lowercase = 8224u
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int CountDigits(ulong value)
	{
		int num = 1;
		uint num2;
		if (value >= 10000000)
		{
			if (value >= 100000000000000L)
			{
				num2 = (uint)(value / 100000000000000L);
				num += 14;
			}
			else
			{
				num2 = (uint)(value / 10000000);
				num += 7;
			}
		}
		else
		{
			num2 = (uint)value;
		}
		if (num2 >= 10)
		{
			num = ((num2 < 100) ? (num + 1) : ((num2 < 1000) ? (num + 2) : ((num2 < 10000) ? (num + 3) : ((num2 < 100000) ? (num + 4) : ((num2 >= 1000000) ? (num + 6) : (num + 5))))));
		}
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int CountDigits(uint value)
	{
		int num = 1;
		if (value >= 100000)
		{
			value /= 100000;
			num += 5;
		}
		if (value >= 10)
		{
			num = ((value < 100) ? (num + 1) : ((value < 1000) ? (num + 2) : ((value >= 10000) ? (num + 4) : (num + 3))));
		}
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int CountHexDigits(ulong value)
	{
		int num = 1;
		if (value > uint.MaxValue)
		{
			num += 8;
			value >>= 32;
		}
		if (value > 65535)
		{
			num += 4;
			value >>= 16;
		}
		if (value > 255)
		{
			num += 2;
			value >>= 8;
		}
		if (value > 15)
		{
			num++;
		}
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static char GetSymbolOrDefault(in StandardFormat format, char defaultSymbol)
	{
		char c = format.Symbol;
		if (c == '\0' && format.Precision == 0)
		{
			c = defaultSymbol;
		}
		return c;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void FillWithAsciiZeros(Span<byte> buffer)
	{
		for (int i = 0; i < buffer.Length; i++)
		{
			buffer[i] = 48;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void WriteHexByte(byte value, Span<byte> buffer, int startingIndex = 0, HexCasing casing = HexCasing.Uppercase)
	{
		uint num = (uint)(((value & 0xF0) << 4) + (value & 0xF) - 35209);
		uint num2 = ((((0 - num) & 0x7070) >> 4) + num + 47545) | (uint)casing;
		buffer[startingIndex + 1] = (byte)num2;
		buffer[startingIndex] = (byte)(num2 >> 8);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void WriteDigits(ulong value, Span<byte> buffer)
	{
		for (int num = buffer.Length - 1; num >= 1; num--)
		{
			ulong num2 = 48 + value;
			value /= 10;
			buffer[num] = (byte)(num2 - value * 10);
		}
		buffer[0] = (byte)(48 + value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void WriteDigitsWithGroupSeparator(ulong value, Span<byte> buffer)
	{
		int num = 0;
		for (int num2 = buffer.Length - 1; num2 >= 1; num2--)
		{
			ulong num3 = 48 + value;
			value /= 10;
			buffer[num2] = (byte)(num3 - value * 10);
			if (num == 2)
			{
				buffer[--num2] = 44;
				num = 0;
			}
			else
			{
				num++;
			}
		}
		buffer[0] = (byte)(48 + value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void WriteDigits(uint value, Span<byte> buffer)
	{
		for (int num = buffer.Length - 1; num >= 1; num--)
		{
			uint num2 = 48 + value;
			value /= 10;
			buffer[num] = (byte)(num2 - value * 10);
		}
		buffer[0] = (byte)(48 + value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void WriteFourDecimalDigits(uint value, Span<byte> buffer, int startingIndex = 0)
	{
		uint num = 48 + value;
		value /= 10;
		buffer[startingIndex + 3] = (byte)(num - value * 10);
		num = 48 + value;
		value /= 10;
		buffer[startingIndex + 2] = (byte)(num - value * 10);
		num = 48 + value;
		value /= 10;
		buffer[startingIndex + 1] = (byte)(num - value * 10);
		buffer[startingIndex] = (byte)(48 + value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void WriteTwoDecimalDigits(uint value, Span<byte> buffer, int startingIndex = 0)
	{
		uint num = 48 + value;
		value /= 10;
		buffer[startingIndex + 1] = (byte)(num - value * 10);
		buffer[startingIndex] = (byte)(48 + value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ulong DivMod(ulong numerator, ulong denominator, out ulong modulo)
	{
		ulong num = numerator / denominator;
		modulo = numerator - num * denominator;
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static uint DivMod(uint numerator, uint denominator, out uint modulo)
	{
		uint num = numerator / denominator;
		modulo = numerator - num * denominator;
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int CountDecimalTrailingZeros(uint value, out uint valueWithoutTrailingZeros)
	{
		int num = 0;
		if (value != 0)
		{
			while (true)
			{
				uint num2 = DivMod(value, 10u, out var modulo);
				if (modulo != 0)
				{
					break;
				}
				value = num2;
				num++;
			}
		}
		valueWithoutTrailingZeros = value;
		return num;
	}
}
