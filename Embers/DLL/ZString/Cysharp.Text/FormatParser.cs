using System;
using System.Runtime.CompilerServices;

namespace Cysharp.Text;

internal static class FormatParser
{
	public readonly ref struct ParseResult(int index, ReadOnlySpan<char> formatString, int lastIndex, int alignment)
	{
		public readonly int Index = index;

		public readonly ReadOnlySpan<char> FormatString = formatString;

		public readonly int LastIndex = lastIndex;

		public readonly int Alignment = alignment;
	}

	internal const int ArgLengthLimit = 16;

	internal const int WidthLimit = 1000;

	[MethodImpl((MethodImplOptions)256)]
	public static ParserScanResult ScanFormatString(string format, ref int i)
	{
		int length = format.Length;
		char c = format[i];
		i++;
		switch (c)
		{
		case '}':
			if (i < length && format[i] == '}')
			{
				i++;
				return ParserScanResult.EscapedChar;
			}
			ExceptionUtil.ThrowFormatError();
			return ParserScanResult.NormalChar;
		case '{':
			if (i < length && format[i] == '{')
			{
				i++;
				return ParserScanResult.EscapedChar;
			}
			i--;
			return ParserScanResult.BraceOpen;
		default:
			return ParserScanResult.NormalChar;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ParserScanResult ScanFormatString(ReadOnlySpan<char> format, ref int i)
	{
		int length = format.Length;
		char c = format[i];
		i++;
		switch (c)
		{
		case '}':
			if (i < length && format[i] == '}')
			{
				i++;
				return ParserScanResult.EscapedChar;
			}
			ExceptionUtil.ThrowFormatError();
			return ParserScanResult.NormalChar;
		case '{':
			if (i < length && format[i] == '{')
			{
				i++;
				return ParserScanResult.EscapedChar;
			}
			i--;
			return ParserScanResult.BraceOpen;
		default:
			return ParserScanResult.NormalChar;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool IsDigit(char c)
	{
		if ('0' <= c)
		{
			return c <= '9';
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ParseResult Parse(ReadOnlySpan<char> format, int i)
	{
		char c = '\0';
		int length = format.Length;
		i++;
		if (i == length || !IsDigit(c = format[i]))
		{
			ExceptionUtil.ThrowFormatError();
		}
		int num = 0;
		do
		{
			num = num * 10 + c - 48;
			if (++i == length)
			{
				ExceptionUtil.ThrowFormatError();
			}
			c = format[i];
		}
		while (IsDigit(c) && num < 16);
		if (num >= 16)
		{
			ExceptionUtil.ThrowFormatException();
		}
		while (i < length && (c = format[i]) == ' ')
		{
			i++;
		}
		int num2 = 0;
		if (c == ',')
		{
			i++;
			while (i < length && (c = format[i]) == ' ')
			{
				i++;
			}
			if (i == length)
			{
				ExceptionUtil.ThrowFormatError();
			}
			bool flag = false;
			if (c == '-')
			{
				flag = true;
				if (++i == length)
				{
					ExceptionUtil.ThrowFormatError();
				}
				c = format[i];
			}
			if (!IsDigit(c))
			{
				ExceptionUtil.ThrowFormatError();
			}
			do
			{
				num2 = num2 * 10 + c - 48;
				if (++i == length)
				{
					ExceptionUtil.ThrowFormatError();
				}
				c = format[i];
			}
			while (IsDigit(c) && num2 < 1000);
			if (flag)
			{
				num2 *= -1;
			}
		}
		while (i < length && (c = format[i]) == ' ')
		{
			i++;
		}
		ReadOnlySpan<char> formatString = default(ReadOnlySpan<char>);
		switch (c)
		{
		case ':':
		{
			i++;
			int num3 = i;
			while (true)
			{
				if (i == length)
				{
					ExceptionUtil.ThrowFormatError();
				}
				switch (format[i])
				{
				case '{':
					ExceptionUtil.ThrowFormatError();
					goto IL_016c;
				default:
					goto IL_016c;
				case '}':
					break;
				}
				break;
				IL_016c:
				i++;
			}
			if (i > num3)
			{
				formatString = format.Slice(num3, i - num3);
			}
			break;
		}
		default:
			ExceptionUtil.ThrowFormatError();
			break;
		case '}':
			break;
		}
		i++;
		return new ParseResult(num, formatString, i, num2);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static ParseResult Parse(string format, int i)
	{
		char c = '\0';
		int length = format.Length;
		i++;
		if (i == length || !IsDigit(c = format[i]))
		{
			ExceptionUtil.ThrowFormatError();
		}
		int num = 0;
		do
		{
			num = num * 10 + c - 48;
			if (++i == length)
			{
				ExceptionUtil.ThrowFormatError();
			}
			c = format[i];
		}
		while (IsDigit(c) && num < 16);
		if (num >= 16)
		{
			ExceptionUtil.ThrowFormatException();
		}
		while (i < length && (c = format[i]) == ' ')
		{
			i++;
		}
		int num2 = 0;
		if (c == ',')
		{
			i++;
			while (i < length && (c = format[i]) == ' ')
			{
				i++;
			}
			if (i == length)
			{
				ExceptionUtil.ThrowFormatError();
			}
			bool flag = false;
			if (c == '-')
			{
				flag = true;
				if (++i == length)
				{
					ExceptionUtil.ThrowFormatError();
				}
				c = format[i];
			}
			if (!IsDigit(c))
			{
				ExceptionUtil.ThrowFormatError();
			}
			do
			{
				num2 = num2 * 10 + c - 48;
				if (++i == length)
				{
					ExceptionUtil.ThrowFormatError();
				}
				c = format[i];
			}
			while (IsDigit(c) && num2 < 1000);
			if (flag)
			{
				num2 *= -1;
			}
		}
		while (i < length && (c = format[i]) == ' ')
		{
			i++;
		}
		ReadOnlySpan<char> formatString = default(ReadOnlySpan<char>);
		switch (c)
		{
		case ':':
		{
			i++;
			int num3 = i;
			while (true)
			{
				if (i == length)
				{
					ExceptionUtil.ThrowFormatError();
				}
				switch (format[i])
				{
				case '{':
					ExceptionUtil.ThrowFormatError();
					goto IL_015b;
				default:
					goto IL_015b;
				case '}':
					break;
				}
				break;
				IL_015b:
				i++;
			}
			if (i > num3)
			{
				formatString = format.AsSpan(num3, i - num3);
			}
			break;
		}
		default:
			ExceptionUtil.ThrowFormatError();
			break;
		case '}':
			break;
		}
		i++;
		return new ParseResult(num, formatString, i, num2);
	}
}
