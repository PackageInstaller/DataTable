using System.Runtime.CompilerServices;

namespace System;

internal static class ParseNumbers
{
	public static long StringToLong(ReadOnlySpan<char> s, int radix, int flags)
	{
		int currPos = 0;
		return StringToLong(s, radix, flags, ref currPos);
	}

	public static long StringToLong(ReadOnlySpan<char> s, int radix, int flags, ref int currPos)
	{
		int i = currPos;
		int num = ((-1 == radix) ? 10 : radix);
		if (num != 2 && num != 10 && num != 8 && num != 16)
		{
			throw new ArgumentException("Invalid Base.", "radix");
		}
		int length = s.Length;
		if (i < 0 || i >= length)
		{
			throw new ArgumentOutOfRangeException("Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if ((flags & 0x1000) == 0 && (flags & 0x2000) == 0)
		{
			EatWhiteSpace(s, ref i);
			if (i == length)
			{
				throw new FormatException("Input string was either empty or contained only whitespace.");
			}
		}
		int num2 = 1;
		if (s[i] == '-')
		{
			if (num != 10)
			{
				throw new ArgumentException("String cannot contain a minus sign if the base is not 10.");
			}
			if ((flags & 0x200) != 0)
			{
				throw new OverflowException("The string was being parsed as an unsigned number and could not have a negative sign.");
			}
			num2 = -1;
			i++;
		}
		else if (s[i] == '+')
		{
			i++;
		}
		if ((radix == -1 || radix == 16) && i + 1 < length && s[i] == '0' && (s[i + 1] == 'x' || s[i + 1] == 'X'))
		{
			num = 16;
			i += 2;
		}
		int num3 = i;
		long num4 = GrabLongs(num, s, ref i, (flags & 0x200) != 0);
		if (i == num3)
		{
			throw new FormatException("Could not find any recognizable digits.");
		}
		if ((flags & 0x1000) != 0 && i < length)
		{
			throw new FormatException("Additional non-parsable characters are at the end of the string.");
		}
		currPos = i;
		if (num4 == long.MinValue && num2 == 1 && num == 10 && (flags & 0x200) == 0)
		{
			throw new OverflowException("Value was either too large or too small for an Int64.");
		}
		if (num == 10)
		{
			num4 *= num2;
		}
		return num4;
	}

	public static int StringToInt(ReadOnlySpan<char> s, int radix, int flags)
	{
		int currPos = 0;
		return StringToInt(s, radix, flags, ref currPos);
	}

	public static int StringToInt(ReadOnlySpan<char> s, int radix, int flags, ref int currPos)
	{
		int i = currPos;
		int num = ((-1 == radix) ? 10 : radix);
		if (num != 2 && num != 10 && num != 8 && num != 16)
		{
			throw new ArgumentException("Invalid Base.", "radix");
		}
		int length = s.Length;
		if (i < 0 || i >= length)
		{
			throw new ArgumentOutOfRangeException("Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if ((flags & 0x1000) == 0 && (flags & 0x2000) == 0)
		{
			EatWhiteSpace(s, ref i);
			if (i == length)
			{
				throw new FormatException("Input string was either empty or contained only whitespace.");
			}
		}
		int num2 = 1;
		if (s[i] == '-')
		{
			if (num != 10)
			{
				throw new ArgumentException("String cannot contain a minus sign if the base is not 10.");
			}
			if ((flags & 0x200) != 0)
			{
				throw new OverflowException("The string was being parsed as an unsigned number and could not have a negative sign.");
			}
			num2 = -1;
			i++;
		}
		else if (s[i] == '+')
		{
			i++;
		}
		if ((radix == -1 || radix == 16) && i + 1 < length && s[i] == '0' && (s[i + 1] == 'x' || s[i + 1] == 'X'))
		{
			num = 16;
			i += 2;
		}
		int num3 = i;
		int num4 = GrabInts(num, s, ref i, (flags & 0x200) != 0);
		if (i == num3)
		{
			throw new FormatException("Could not find any recognizable digits.");
		}
		if ((flags & 0x1000) != 0 && i < length)
		{
			throw new FormatException("Additional non-parsable characters are at the end of the string.");
		}
		currPos = i;
		if ((flags & 0x400) != 0)
		{
			if ((uint)num4 > 255u)
			{
				throw new OverflowException("Value was either too large or too small for a signed byte.");
			}
		}
		else if ((flags & 0x800) != 0)
		{
			if ((uint)num4 > 65535u)
			{
				throw new OverflowException("Value was either too large or too small for an Int16.");
			}
		}
		else if (num4 == int.MinValue && num2 == 1 && num == 10 && (flags & 0x200) == 0)
		{
			throw new OverflowException("Value was either too large or too small for an Int32.");
		}
		if (num == 10)
		{
			num4 *= num2;
		}
		return num4;
	}

	public unsafe static string IntToString(int n, int radix, int width, char paddingChar, int flags)
	{
		Span<char> span = stackalloc char[66];
		if (radix < 2 || radix > 36)
		{
			throw new ArgumentException("Invalid Base.", "radix");
		}
		bool flag = false;
		uint num;
		if (n < 0)
		{
			flag = true;
			num = (uint)((10 == radix) ? (-n) : n);
		}
		else
		{
			num = (uint)n;
		}
		if ((flags & 0x40) != 0)
		{
			num &= 0xFF;
		}
		else if ((flags & 0x80) != 0)
		{
			num &= 0xFFFF;
		}
		int num2;
		if (num == 0)
		{
			span[0] = '0';
			num2 = 1;
		}
		else
		{
			num2 = 0;
			for (int i = 0; i < span.Length; i++)
			{
				uint num3 = num / (uint)radix;
				uint num4 = num - (uint)((int)num3 * radix);
				num = num3;
				span[i] = ((num4 < 10) ? ((char)(num4 + 48)) : ((char)(num4 + 97 - 10)));
				if (num == 0)
				{
					num2 = i + 1;
					break;
				}
			}
		}
		if (radix != 10 && (flags & 0x20) != 0)
		{
			if (16 == radix)
			{
				span[num2++] = 'x';
				span[num2++] = '0';
			}
			else if (8 == radix)
			{
				span[num2++] = '0';
			}
		}
		if (10 == radix)
		{
			if (flag)
			{
				span[num2++] = '-';
			}
			else if ((flags & 0x10) != 0)
			{
				span[num2++] = '+';
			}
			else if ((flags & 8) != 0)
			{
				span[num2++] = ' ';
			}
		}
		string text = string.FastAllocateString(Math.Max(width, num2));
		fixed (char* ptr = text)
		{
			char* ptr2 = ptr;
			int num5 = text.Length - num2;
			if ((flags & 1) != 0)
			{
				for (int j = 0; j < num5; j++)
				{
					*(ptr2++) = paddingChar;
				}
				for (int k = 0; k < num2; k++)
				{
					*(ptr2++) = span[num2 - k - 1];
				}
			}
			else
			{
				for (int l = 0; l < num2; l++)
				{
					*(ptr2++) = span[num2 - l - 1];
				}
				for (int m = 0; m < num5; m++)
				{
					*(ptr2++) = paddingChar;
				}
			}
		}
		return text;
	}

	public unsafe static string LongToString(long n, int radix, int width, char paddingChar, int flags)
	{
		Span<char> span = stackalloc char[67];
		if (radix < 2 || radix > 36)
		{
			throw new ArgumentException("Invalid Base.", "radix");
		}
		bool flag = false;
		ulong num;
		if (n < 0)
		{
			flag = true;
			num = (ulong)((10 == radix) ? (-n) : n);
		}
		else
		{
			num = (ulong)n;
		}
		if ((flags & 0x40) != 0)
		{
			num &= 0xFF;
		}
		else if ((flags & 0x80) != 0)
		{
			num &= 0xFFFF;
		}
		else if ((flags & 0x100) != 0)
		{
			num &= 0xFFFFFFFFu;
		}
		int num2;
		if (num == 0L)
		{
			span[0] = '0';
			num2 = 1;
		}
		else
		{
			num2 = 0;
			for (int i = 0; i < span.Length; i++)
			{
				ulong num3 = num / (ulong)radix;
				int num4 = (int)((long)num - (long)num3 * (long)radix);
				num = num3;
				span[i] = ((num4 < 10) ? ((char)(num4 + 48)) : ((char)(num4 + 97 - 10)));
				if (num == 0L)
				{
					num2 = i + 1;
					break;
				}
			}
		}
		if (radix != 10 && (flags & 0x20) != 0)
		{
			if (16 == radix)
			{
				span[num2++] = 'x';
				span[num2++] = '0';
			}
			else if (8 == radix)
			{
				span[num2++] = '0';
			}
			else if ((flags & 0x4000) != 0)
			{
				span[num2++] = '#';
				span[num2++] = (char)(radix % 10 + 48);
				span[num2++] = (char)(radix / 10 + 48);
			}
		}
		if (10 == radix)
		{
			if (flag)
			{
				span[num2++] = '-';
			}
			else if ((flags & 0x10) != 0)
			{
				span[num2++] = '+';
			}
			else if ((flags & 8) != 0)
			{
				span[num2++] = ' ';
			}
		}
		string text = string.FastAllocateString(Math.Max(width, num2));
		fixed (char* ptr = text)
		{
			char* ptr2 = ptr;
			int num5 = text.Length - num2;
			if ((flags & 1) != 0)
			{
				for (int j = 0; j < num5; j++)
				{
					*(ptr2++) = paddingChar;
				}
				for (int k = 0; k < num2; k++)
				{
					*(ptr2++) = span[num2 - k - 1];
				}
			}
			else
			{
				for (int l = 0; l < num2; l++)
				{
					*(ptr2++) = span[num2 - l - 1];
				}
				for (int m = 0; m < num5; m++)
				{
					*(ptr2++) = paddingChar;
				}
			}
		}
		return text;
	}

	private static void EatWhiteSpace(ReadOnlySpan<char> s, ref int i)
	{
		int j;
		for (j = i; j < s.Length && char.IsWhiteSpace(s[j]); j++)
		{
		}
		i = j;
	}

	private static long GrabLongs(int radix, ReadOnlySpan<char> s, ref int i, bool isUnsigned)
	{
		ulong num = 0uL;
		if (radix == 10 && !isUnsigned)
		{
			ulong num2 = 922337203685477580uL;
			int result;
			while (i < s.Length && IsDigit(s[i], radix, out result))
			{
				if (num > num2 || (long)num < 0L)
				{
					ThrowOverflowInt64Exception();
				}
				num = (ulong)((long)num * (long)radix + result);
				i++;
			}
			if ((long)num < 0L && num != 9223372036854775808uL)
			{
				ThrowOverflowInt64Exception();
			}
		}
		else
		{
			ulong num2 = radix switch
			{
				8 => 2305843009213693951uL, 
				16 => 1152921504606846975uL, 
				10 => 1844674407370955161uL, 
				_ => 9223372036854775807uL, 
			};
			int result2;
			while (i < s.Length && IsDigit(s[i], radix, out result2))
			{
				if (num > num2)
				{
					ThrowOverflowUInt64Exception();
				}
				long num3 = (long)num * (long)radix + result2;
				if ((ulong)num3 < num)
				{
					ThrowOverflowUInt64Exception();
				}
				num = (ulong)num3;
				i++;
			}
		}
		return (long)num;
	}

	private static int GrabInts(int radix, ReadOnlySpan<char> s, ref int i, bool isUnsigned)
	{
		uint num = 0u;
		if (radix == 10 && !isUnsigned)
		{
			uint num2 = 214748364u;
			int result;
			while (i < s.Length && IsDigit(s[i], radix, out result))
			{
				if (num > num2 || (int)num < 0)
				{
					ThrowOverflowInt32Exception();
				}
				num = (uint)((int)num * radix + result);
				i++;
			}
			if ((int)num < 0 && num != 2147483648u)
			{
				ThrowOverflowInt32Exception();
			}
		}
		else
		{
			uint num2 = radix switch
			{
				8 => 536870911u, 
				16 => 268435455u, 
				10 => 429496729u, 
				_ => 2147483647u, 
			};
			int result2;
			while (i < s.Length && IsDigit(s[i], radix, out result2))
			{
				if (num > num2)
				{
					throw new OverflowException("Value was either too large or too small for a UInt32.");
				}
				int num3 = (int)num * radix + result2;
				if ((uint)num3 < num)
				{
					ThrowOverflowUInt32Exception();
				}
				num = (uint)num3;
				i++;
			}
		}
		return (int)num;
	}

	private static void ThrowOverflowInt32Exception()
	{
		throw new OverflowException("Value was either too large or too small for an Int32.");
	}

	private static void ThrowOverflowInt64Exception()
	{
		throw new OverflowException("Value was either too large or too small for an Int64.");
	}

	private static void ThrowOverflowUInt32Exception()
	{
		throw new OverflowException("Value was either too large or too small for a UInt32.");
	}

	private static void ThrowOverflowUInt64Exception()
	{
		throw new OverflowException("Value was either too large or too small for a UInt64.");
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool IsDigit(char c, int radix, out int result)
	{
		int num;
		switch (c)
		{
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			num = (result = c - 48);
			break;
		case 'A':
		case 'B':
		case 'C':
		case 'D':
		case 'E':
		case 'F':
		case 'G':
		case 'H':
		case 'I':
		case 'J':
		case 'K':
		case 'L':
		case 'M':
		case 'N':
		case 'O':
		case 'P':
		case 'Q':
		case 'R':
		case 'S':
		case 'T':
		case 'U':
		case 'V':
		case 'W':
		case 'X':
		case 'Y':
		case 'Z':
			num = (result = c - 65 + 10);
			break;
		case 'a':
		case 'b':
		case 'c':
		case 'd':
		case 'e':
		case 'f':
		case 'g':
		case 'h':
		case 'i':
		case 'j':
		case 'k':
		case 'l':
		case 'm':
		case 'n':
		case 'o':
		case 'p':
		case 'q':
		case 'r':
		case 's':
		case 't':
		case 'u':
		case 'v':
		case 'w':
		case 'x':
		case 'y':
		case 'z':
			num = (result = c - 97 + 10);
			break;
		default:
			result = -1;
			return false;
		}
		return num < radix;
	}
}
