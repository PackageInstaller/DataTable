using System.Buffers.Text;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace System;

internal static class Number
{
	[StructLayout(LayoutKind.Sequential, Pack = 1)]
	internal ref struct NumberBuffer
	{
		[StructLayout(LayoutKind.Sequential, Size = 102)]
		private struct DigitsAndNullTerminator
		{
		}

		public int precision;

		public int scale;

		private int _sign;

		private DigitsAndNullTerminator _digits;

		private unsafe char* _allDigits;

		public bool sign
		{
			get
			{
				return _sign != 0;
			}
			set
			{
				_sign = (value ? 1 : 0);
			}
		}

		public unsafe char* digits => (char*)Unsafe.AsPointer(ref _digits);
	}

	private static readonly string[] s_posCurrencyFormats = new string[4] { "$#", "#$", "$ #", "# $" };

	private static readonly string[] s_negCurrencyFormats = new string[16]
	{
		"($#)", "-$#", "$-#", "$#-", "(#$)", "-#$", "#-$", "#$-", "-# $", "-$ #",
		"# $-", "$ #-", "$ -#", "#- $", "($ #)", "(# $)"
	};

	private static readonly string[] s_posPercentFormats = new string[4] { "# %", "#%", "%#", "% #" };

	private static readonly string[] s_negPercentFormats = new string[12]
	{
		"-# %", "-#%", "-%#", "%-#", "%#-", "#-%", "#%-", "-% #", "# %-", "% #-",
		"% -#", "#- %"
	};

	private static readonly string[] s_negNumberFormats = new string[5] { "(#)", "-#", "- #", "#-", "# -" };

	private static readonly int[] s_charToHexLookup = new int[256]
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

	private static readonly ulong[] s_rgval64Power10 = new ulong[30]
	{
		11529215046068469760uL, 14411518807585587200uL, 18014398509481984000uL, 11258999068426240000uL, 14073748835532800000uL, 17592186044416000000uL, 10995116277760000000uL, 13743895347200000000uL, 17179869184000000000uL, 10737418240000000000uL,
		13421772800000000000uL, 16777216000000000000uL, 10485760000000000000uL, 13107200000000000000uL, 16384000000000000000uL, 14757395258967641293uL, 11805916207174113035uL, 9444732965739290428uL, 15111572745182864686uL, 12089258196146291749uL,
		9671406556917033399uL, 15474250491067253438uL, 12379400392853802751uL, 9903520314283042201uL, 15845632502852867522uL, 12676506002282294018uL, 10141204801825835215uL, 16225927682921336344uL, 12980742146337069075uL, 10384593717069655260uL
	};

	private static readonly sbyte[] s_rgexp64Power10 = new sbyte[15]
	{
		4, 7, 10, 14, 17, 20, 24, 27, 30, 34,
		37, 40, 44, 47, 50
	};

	private static readonly ulong[] s_rgval64Power10By16 = new ulong[42]
	{
		10240000000000000000uL, 11368683772161602974uL, 12621774483536188886uL, 14012984643248170708uL, 15557538194652854266uL, 17272337110188889248uL, 9588073174409622172uL, 10644899600020376798uL, 11818212630765741798uL, 13120851772591970216uL,
		14567071740625403792uL, 16172698447808779622uL, 17955302187076837696uL, 9967194951097567532uL, 11065809325636130658uL, 12285516299433008778uL, 13639663065038175358uL, 15143067982934716296uL, 16812182738118149112uL, 9332636185032188787uL,
		10361307573072618722uL, 16615349947311448416uL, 14965776766268445891uL, 13479973333575319909uL, 12141680576410806707uL, 10936253623915059637uL, 9850501549098619819uL, 17745086042373215136uL, 15983352577617880260uL, 14396524142538228461uL,
		12967236152753103031uL, 11679847981112819795uL, 10520271803096747049uL, 9475818434452569218uL, 17070116948172427008uL, 15375394465392026135uL, 13848924157002783096uL, 12474001934591998882uL, 11235582092889474480uL, 10120112665365530972uL,
		18230774251475056952uL, 16420821625123739930uL
	};

	private static readonly short[] s_rgexp64Power10By16 = new short[21]
	{
		54, 107, 160, 213, 266, 319, 373, 426, 479, 532,
		585, 638, 691, 745, 798, 851, 904, 957, 1010, 1064,
		1117
	};

	public unsafe static string FormatDecimal(decimal value, ReadOnlySpan<char> format, NumberFormatInfo info)
	{
		char c = ParseFormatSpecifier(format, out var digits);
		NumberBuffer number = default(NumberBuffer);
		DecimalToNumber(value, ref number);
		char* pointer = stackalloc char[32];
		ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
		if (c != 0)
		{
			NumberToString(ref sb, ref number, c, digits, info, isDecimal: true);
		}
		else
		{
			NumberToStringFormat(ref sb, ref number, format, info);
		}
		return sb.ToString();
	}

	public unsafe static bool TryFormatDecimal(decimal value, ReadOnlySpan<char> format, NumberFormatInfo info, Span<char> destination, out int charsWritten)
	{
		char c = ParseFormatSpecifier(format, out var digits);
		NumberBuffer number = default(NumberBuffer);
		DecimalToNumber(value, ref number);
		char* pointer = stackalloc char[32];
		ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
		if (c != 0)
		{
			NumberToString(ref sb, ref number, c, digits, info, isDecimal: true);
		}
		else
		{
			NumberToStringFormat(ref sb, ref number, format, info);
		}
		return sb.TryCopyTo(destination, out charsWritten);
	}

	private unsafe static void DecimalToNumber(decimal value, ref NumberBuffer number)
	{
		decimal value2 = value;
		char* digits = number.digits;
		number.precision = 29;
		number.sign = value2.IsNegative;
		char* bufferEnd = digits + 29;
		while ((value2.Mid | value2.High) != 0)
		{
			bufferEnd = UInt32ToDecChars(bufferEnd, decimal.DecDivMod1E9(ref value2), 9);
		}
		bufferEnd = UInt32ToDecChars(bufferEnd, value2.Low, 0);
		int num = (int)(digits + 29 - bufferEnd);
		number.scale = num - value2.Scale;
		char* digits2 = number.digits;
		while (--num >= 0)
		{
			*(digits2++) = *(bufferEnd++);
		}
		*digits2 = '\0';
	}

	public static string FormatDouble(double value, string format, NumberFormatInfo info)
	{
		Span<char> initialBuffer = stackalloc char[32];
		ValueStringBuilder sb = new ValueStringBuilder(initialBuffer);
		return FormatDouble(ref sb, value, format, info) ?? sb.ToString();
	}

	public static bool TryFormatDouble(double value, ReadOnlySpan<char> format, NumberFormatInfo info, Span<char> destination, out int charsWritten)
	{
		Span<char> initialBuffer = stackalloc char[32];
		ValueStringBuilder sb = new ValueStringBuilder(initialBuffer);
		string text = FormatDouble(ref sb, value, format, info);
		if (text == null)
		{
			return sb.TryCopyTo(destination, out charsWritten);
		}
		return TryCopyTo(text, destination, out charsWritten);
	}

	private static string FormatDouble(ref ValueStringBuilder sb, double value, ReadOnlySpan<char> format, NumberFormatInfo info)
	{
		char c = ParseFormatSpecifier(format, out var digits);
		int precision = 15;
		NumberBuffer number = default(NumberBuffer);
		switch (c)
		{
		case 'R':
		case 'r':
			DoubleToNumber(value, 15, ref number);
			if (number.scale == int.MinValue)
			{
				return info.NaNSymbol;
			}
			if (number.scale == int.MaxValue)
			{
				if (!number.sign)
				{
					return info.PositiveInfinitySymbol;
				}
				return info.NegativeInfinitySymbol;
			}
			if (NumberToDouble(ref number) == value)
			{
				NumberToString(ref sb, ref number, 'G', 15, info, isDecimal: false);
			}
			else
			{
				DoubleToNumber(value, 17, ref number);
				NumberToString(ref sb, ref number, 'G', 17, info, isDecimal: false);
			}
			return null;
		case 'E':
		case 'e':
			if (digits > 14)
			{
				precision = 17;
			}
			break;
		case 'G':
		case 'g':
			if (digits > 15)
			{
				precision = 17;
			}
			break;
		}
		DoubleToNumber(value, precision, ref number);
		if (number.scale == int.MinValue)
		{
			return info.NaNSymbol;
		}
		if (number.scale == int.MaxValue)
		{
			if (!number.sign)
			{
				return info.PositiveInfinitySymbol;
			}
			return info.NegativeInfinitySymbol;
		}
		if (c != 0)
		{
			NumberToString(ref sb, ref number, c, digits, info, isDecimal: false);
		}
		else
		{
			NumberToStringFormat(ref sb, ref number, format, info);
		}
		return null;
	}

	public static string FormatSingle(float value, string format, NumberFormatInfo info)
	{
		Span<char> initialBuffer = stackalloc char[32];
		ValueStringBuilder sb = new ValueStringBuilder(initialBuffer);
		return FormatSingle(ref sb, value, format, info) ?? sb.ToString();
	}

	public static bool TryFormatSingle(float value, ReadOnlySpan<char> format, NumberFormatInfo info, Span<char> destination, out int charsWritten)
	{
		Span<char> initialBuffer = stackalloc char[32];
		ValueStringBuilder sb = new ValueStringBuilder(initialBuffer);
		string text = FormatSingle(ref sb, value, format, info);
		if (text == null)
		{
			return sb.TryCopyTo(destination, out charsWritten);
		}
		return TryCopyTo(text, destination, out charsWritten);
	}

	private static string FormatSingle(ref ValueStringBuilder sb, float value, ReadOnlySpan<char> format, NumberFormatInfo info)
	{
		char c = ParseFormatSpecifier(format, out var digits);
		int precision = 7;
		NumberBuffer number = default(NumberBuffer);
		switch (c)
		{
		case 'R':
		case 'r':
			DoubleToNumber(value, 7, ref number);
			if (number.scale == int.MinValue)
			{
				return info.NaNSymbol;
			}
			if (number.scale == int.MaxValue)
			{
				if (!number.sign)
				{
					return info.PositiveInfinitySymbol;
				}
				return info.NegativeInfinitySymbol;
			}
			if ((float)NumberToDouble(ref number) == value)
			{
				NumberToString(ref sb, ref number, 'G', 7, info, isDecimal: false);
			}
			else
			{
				DoubleToNumber(value, 9, ref number);
				NumberToString(ref sb, ref number, 'G', 9, info, isDecimal: false);
			}
			return null;
		case 'E':
		case 'e':
			if (digits > 6)
			{
				precision = 9;
			}
			break;
		case 'G':
		case 'g':
			if (digits > 7)
			{
				precision = 9;
			}
			break;
		}
		DoubleToNumber(value, precision, ref number);
		if (number.scale == int.MinValue)
		{
			return info.NaNSymbol;
		}
		if (number.scale == int.MaxValue)
		{
			if (!number.sign)
			{
				return info.PositiveInfinitySymbol;
			}
			return info.NegativeInfinitySymbol;
		}
		if (c != 0)
		{
			NumberToString(ref sb, ref number, c, digits, info, isDecimal: false);
		}
		else
		{
			NumberToStringFormat(ref sb, ref number, format, info);
		}
		return null;
	}

	private static bool TryCopyTo(string source, Span<char> destination, out int charsWritten)
	{
		if (source.AsSpan().TryCopyTo(destination))
		{
			charsWritten = source.Length;
			return true;
		}
		charsWritten = 0;
		return false;
	}

	public unsafe static string FormatInt32(int value, ReadOnlySpan<char> format, IFormatProvider provider)
	{
		if (value >= 0 && format.Length == 0)
		{
			return UInt32ToDecStr((uint)value, -1);
		}
		char c = ParseFormatSpecifier(format, out var digits);
		NumberFormatInfo instance = NumberFormatInfo.GetInstance(provider);
		char c2 = (char)(c & 0xFFDF);
		if (c2 != 'G' || digits >= 1)
		{
			switch (c2)
			{
			case 'D':
				break;
			case 'X':
				return Int32ToHexStr(value, (char)(c - 33), digits);
			default:
			{
				NumberBuffer number = default(NumberBuffer);
				Int32ToNumber(value, ref number);
				char* pointer = stackalloc char[32];
				ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
				if (c != 0)
				{
					NumberToString(ref sb, ref number, c, digits, instance, isDecimal: false);
				}
				else
				{
					NumberToStringFormat(ref sb, ref number, format, instance);
				}
				return sb.ToString();
			}
			}
		}
		if (value < 0)
		{
			return NegativeInt32ToDecStr(value, digits, instance.NegativeSign);
		}
		return UInt32ToDecStr((uint)value, digits);
	}

	public unsafe static bool TryFormatInt32(int value, ReadOnlySpan<char> format, IFormatProvider provider, Span<char> destination, out int charsWritten)
	{
		if (value >= 0 && format.Length == 0)
		{
			return TryUInt32ToDecStr((uint)value, -1, destination, out charsWritten);
		}
		char c = ParseFormatSpecifier(format, out var digits);
		NumberFormatInfo instance = NumberFormatInfo.GetInstance(provider);
		char c2 = (char)(c & 0xFFDF);
		if (c2 != 'G' || digits >= 1)
		{
			switch (c2)
			{
			case 'D':
				break;
			case 'X':
				return TryInt32ToHexStr(value, (char)(c - 33), digits, destination, out charsWritten);
			default:
			{
				NumberBuffer number = default(NumberBuffer);
				Int32ToNumber(value, ref number);
				char* pointer = stackalloc char[32];
				ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
				if (c != 0)
				{
					NumberToString(ref sb, ref number, c, digits, instance, isDecimal: false);
				}
				else
				{
					NumberToStringFormat(ref sb, ref number, format, instance);
				}
				return sb.TryCopyTo(destination, out charsWritten);
			}
			}
		}
		if (value < 0)
		{
			return TryNegativeInt32ToDecStr(value, digits, instance.NegativeSign, destination, out charsWritten);
		}
		return TryUInt32ToDecStr((uint)value, digits, destination, out charsWritten);
	}

	public unsafe static string FormatUInt32(uint value, ReadOnlySpan<char> format, IFormatProvider provider)
	{
		if (format.Length == 0)
		{
			return UInt32ToDecStr(value, -1);
		}
		char c = ParseFormatSpecifier(format, out var digits);
		NumberFormatInfo instance = NumberFormatInfo.GetInstance(provider);
		char c2 = (char)(c & 0xFFDF);
		if (c2 != 'G' || digits >= 1)
		{
			switch (c2)
			{
			case 'D':
				break;
			case 'X':
				return Int32ToHexStr((int)value, (char)(c - 33), digits);
			default:
			{
				NumberBuffer number = default(NumberBuffer);
				UInt32ToNumber(value, ref number);
				char* pointer = stackalloc char[32];
				ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
				if (c != 0)
				{
					NumberToString(ref sb, ref number, c, digits, instance, isDecimal: false);
				}
				else
				{
					NumberToStringFormat(ref sb, ref number, format, instance);
				}
				return sb.ToString();
			}
			}
		}
		return UInt32ToDecStr(value, digits);
	}

	public unsafe static bool TryFormatUInt32(uint value, ReadOnlySpan<char> format, IFormatProvider provider, Span<char> destination, out int charsWritten)
	{
		if (format.Length == 0)
		{
			return TryUInt32ToDecStr(value, -1, destination, out charsWritten);
		}
		char c = ParseFormatSpecifier(format, out var digits);
		NumberFormatInfo instance = NumberFormatInfo.GetInstance(provider);
		char c2 = (char)(c & 0xFFDF);
		if (c2 != 'G' || digits >= 1)
		{
			switch (c2)
			{
			case 'D':
				break;
			case 'X':
				return TryInt32ToHexStr((int)value, (char)(c - 33), digits, destination, out charsWritten);
			default:
			{
				NumberBuffer number = default(NumberBuffer);
				UInt32ToNumber(value, ref number);
				char* pointer = stackalloc char[32];
				ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
				if (c != 0)
				{
					NumberToString(ref sb, ref number, c, digits, instance, isDecimal: false);
				}
				else
				{
					NumberToStringFormat(ref sb, ref number, format, instance);
				}
				return sb.TryCopyTo(destination, out charsWritten);
			}
			}
		}
		return TryUInt32ToDecStr(value, digits, destination, out charsWritten);
	}

	public unsafe static string FormatInt64(long value, ReadOnlySpan<char> format, IFormatProvider provider)
	{
		if (value >= 0 && format.Length == 0)
		{
			return UInt64ToDecStr((ulong)value, -1);
		}
		char c = ParseFormatSpecifier(format, out var digits);
		NumberFormatInfo instance = NumberFormatInfo.GetInstance(provider);
		char c2 = (char)(c & 0xFFDF);
		if (c2 != 'G' || digits >= 1)
		{
			switch (c2)
			{
			case 'D':
				break;
			case 'X':
				return Int64ToHexStr(value, (char)(c - 33), digits);
			default:
			{
				NumberBuffer number = default(NumberBuffer);
				Int64ToNumber(value, ref number);
				char* pointer = stackalloc char[32];
				ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
				if (c != 0)
				{
					NumberToString(ref sb, ref number, c, digits, instance, isDecimal: false);
				}
				else
				{
					NumberToStringFormat(ref sb, ref number, format, instance);
				}
				return sb.ToString();
			}
			}
		}
		if (value < 0)
		{
			return NegativeInt64ToDecStr(value, digits, instance.NegativeSign);
		}
		return UInt64ToDecStr((ulong)value, digits);
	}

	public unsafe static bool TryFormatInt64(long value, ReadOnlySpan<char> format, IFormatProvider provider, Span<char> destination, out int charsWritten)
	{
		if (value >= 0 && format.Length == 0)
		{
			return TryUInt64ToDecStr((ulong)value, -1, destination, out charsWritten);
		}
		char c = ParseFormatSpecifier(format, out var digits);
		NumberFormatInfo instance = NumberFormatInfo.GetInstance(provider);
		char c2 = (char)(c & 0xFFDF);
		if (c2 != 'G' || digits >= 1)
		{
			switch (c2)
			{
			case 'D':
				break;
			case 'X':
				return TryInt64ToHexStr(value, (char)(c - 33), digits, destination, out charsWritten);
			default:
			{
				NumberBuffer number = default(NumberBuffer);
				Int64ToNumber(value, ref number);
				char* pointer = stackalloc char[32];
				ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
				if (c != 0)
				{
					NumberToString(ref sb, ref number, c, digits, instance, isDecimal: false);
				}
				else
				{
					NumberToStringFormat(ref sb, ref number, format, instance);
				}
				return sb.TryCopyTo(destination, out charsWritten);
			}
			}
		}
		if (value < 0)
		{
			return TryNegativeInt64ToDecStr(value, digits, instance.NegativeSign, destination, out charsWritten);
		}
		return TryUInt64ToDecStr((ulong)value, digits, destination, out charsWritten);
	}

	public unsafe static string FormatUInt64(ulong value, ReadOnlySpan<char> format, IFormatProvider provider)
	{
		if (format.Length == 0)
		{
			return UInt64ToDecStr(value, -1);
		}
		char c = ParseFormatSpecifier(format, out var digits);
		NumberFormatInfo instance = NumberFormatInfo.GetInstance(provider);
		char c2 = (char)(c & 0xFFDF);
		if (c2 != 'G' || digits >= 1)
		{
			switch (c2)
			{
			case 'D':
				break;
			case 'X':
				return Int64ToHexStr((long)value, (char)(c - 33), digits);
			default:
			{
				NumberBuffer number = default(NumberBuffer);
				UInt64ToNumber(value, ref number);
				char* pointer = stackalloc char[32];
				ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
				if (c != 0)
				{
					NumberToString(ref sb, ref number, c, digits, instance, isDecimal: false);
				}
				else
				{
					NumberToStringFormat(ref sb, ref number, format, instance);
				}
				return sb.ToString();
			}
			}
		}
		return UInt64ToDecStr(value, digits);
	}

	public unsafe static bool TryFormatUInt64(ulong value, ReadOnlySpan<char> format, IFormatProvider provider, Span<char> destination, out int charsWritten)
	{
		if (format.Length == 0)
		{
			return TryUInt64ToDecStr(value, -1, destination, out charsWritten);
		}
		char c = ParseFormatSpecifier(format, out var digits);
		NumberFormatInfo instance = NumberFormatInfo.GetInstance(provider);
		char c2 = (char)(c & 0xFFDF);
		if (c2 != 'G' || digits >= 1)
		{
			switch (c2)
			{
			case 'D':
				break;
			case 'X':
				return TryInt64ToHexStr((long)value, (char)(c - 33), digits, destination, out charsWritten);
			default:
			{
				NumberBuffer number = default(NumberBuffer);
				UInt64ToNumber(value, ref number);
				char* pointer = stackalloc char[32];
				ValueStringBuilder sb = new ValueStringBuilder(new Span<char>(pointer, 32));
				if (c != 0)
				{
					NumberToString(ref sb, ref number, c, digits, instance, isDecimal: false);
				}
				else
				{
					NumberToStringFormat(ref sb, ref number, format, instance);
				}
				return sb.TryCopyTo(destination, out charsWritten);
			}
			}
		}
		return TryUInt64ToDecStr(value, digits, destination, out charsWritten);
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe static void Int32ToNumber(int value, ref NumberBuffer number)
	{
		number.precision = 10;
		if (value >= 0)
		{
			number.sign = false;
		}
		else
		{
			number.sign = true;
			value = -value;
		}
		char* digits = number.digits;
		char* ptr = UInt32ToDecChars(digits + 10, (uint)value, 0);
		int num = (number.scale = (int)(digits + 10 - ptr));
		char* digits2 = number.digits;
		while (--num >= 0)
		{
			*(digits2++) = *(ptr++);
		}
		*digits2 = '\0';
	}

	private unsafe static string NegativeInt32ToDecStr(int value, int digits, string sNegative)
	{
		if (digits < 1)
		{
			digits = 1;
		}
		int num = Math.Max(digits, FormattingHelpers.CountDigits((uint)(-value))) + sNegative.Length;
		string text = string.FastAllocateString(num);
		fixed (char* ptr = text)
		{
			char* ptr2 = UInt32ToDecChars(ptr + num, (uint)(-value), digits);
			for (int num2 = sNegative.Length - 1; num2 >= 0; num2--)
			{
				*(--ptr2) = sNegative[num2];
			}
		}
		return text;
	}

	private unsafe static bool TryNegativeInt32ToDecStr(int value, int digits, string sNegative, Span<char> destination, out int charsWritten)
	{
		if (digits < 1)
		{
			digits = 1;
		}
		int num = Math.Max(digits, FormattingHelpers.CountDigits((uint)(-value))) + sNegative.Length;
		if (num > destination.Length)
		{
			charsWritten = 0;
			return false;
		}
		charsWritten = num;
		fixed (char* reference = &MemoryMarshal.GetReference(destination))
		{
			char* ptr = UInt32ToDecChars(reference + num, (uint)(-value), digits);
			for (int num2 = sNegative.Length - 1; num2 >= 0; num2--)
			{
				*(--ptr) = sNegative[num2];
			}
		}
		return true;
	}

	private unsafe static string Int32ToHexStr(int value, char hexBase, int digits)
	{
		if (digits < 1)
		{
			digits = 1;
		}
		int num = Math.Max(digits, FormattingHelpers.CountHexDigits((uint)value));
		string text = string.FastAllocateString(num);
		fixed (char* ptr = text)
		{
			Int32ToHexChars(ptr + num, (uint)value, hexBase, digits);
		}
		return text;
	}

	private unsafe static bool TryInt32ToHexStr(int value, char hexBase, int digits, Span<char> destination, out int charsWritten)
	{
		if (digits < 1)
		{
			digits = 1;
		}
		int num = Math.Max(digits, FormattingHelpers.CountHexDigits((uint)value));
		if (num > destination.Length)
		{
			charsWritten = 0;
			return false;
		}
		charsWritten = num;
		fixed (char* reference = &MemoryMarshal.GetReference(destination))
		{
			Int32ToHexChars(reference + num, (uint)value, hexBase, digits);
		}
		return true;
	}

	private unsafe static char* Int32ToHexChars(char* buffer, uint value, int hexBase, int digits)
	{
		while (--digits >= 0 || value != 0)
		{
			byte b = (byte)(value & 0xF);
			*(--buffer) = (char)(b + ((b < 10) ? 48 : hexBase));
			value >>= 4;
		}
		return buffer;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe static void UInt32ToNumber(uint value, ref NumberBuffer number)
	{
		number.precision = 10;
		number.sign = false;
		char* digits = number.digits;
		char* ptr = UInt32ToDecChars(digits + 10, value, 0);
		int num = (number.scale = (int)(digits + 10 - ptr));
		char* digits2 = number.digits;
		while (--num >= 0)
		{
			*(digits2++) = *(ptr++);
		}
		*digits2 = '\0';
	}

	internal unsafe static char* UInt32ToDecChars(char* bufferEnd, uint value, int digits)
	{
		while (--digits >= 0 || value != 0)
		{
			uint num = value / 10;
			*(--bufferEnd) = (char)(value - num * 10 + 48);
			value = num;
		}
		return bufferEnd;
	}

	private unsafe static string UInt32ToDecStr(uint value, int digits)
	{
		int num = Math.Max(digits, FormattingHelpers.CountDigits(value));
		string text = string.FastAllocateString(num);
		fixed (char* ptr = text)
		{
			char* ptr2 = ptr + num;
			if (digits <= 1)
			{
				do
				{
					uint num2 = value / 10;
					*(--ptr2) = (char)(48 + value - num2 * 10);
					value = num2;
				}
				while (value != 0);
			}
			else
			{
				ptr2 = UInt32ToDecChars(ptr2, value, digits);
			}
		}
		return text;
	}

	private unsafe static bool TryUInt32ToDecStr(uint value, int digits, Span<char> destination, out int charsWritten)
	{
		int num = Math.Max(digits, FormattingHelpers.CountDigits(value));
		if (num > destination.Length)
		{
			charsWritten = 0;
			return false;
		}
		charsWritten = num;
		fixed (char* reference = &MemoryMarshal.GetReference(destination))
		{
			char* ptr = reference + num;
			if (digits <= 1)
			{
				do
				{
					uint num2 = value / 10;
					*(--ptr) = (char)(48 + value - num2 * 10);
					value = num2;
				}
				while (value != 0);
			}
			else
			{
				ptr = UInt32ToDecChars(ptr, value, digits);
			}
		}
		return true;
	}

	private unsafe static void Int64ToNumber(long input, ref NumberBuffer number)
	{
		ulong value = (ulong)input;
		number.sign = input < 0;
		number.precision = 19;
		if (number.sign)
		{
			value = (ulong)(-input);
		}
		char* digits = number.digits;
		char* bufferEnd = digits + 19;
		while (High32(value) != 0)
		{
			bufferEnd = UInt32ToDecChars(bufferEnd, Int64DivMod1E9(ref value), 9);
		}
		bufferEnd = UInt32ToDecChars(bufferEnd, Low32(value), 0);
		int num = (number.scale = (int)(digits + 19 - bufferEnd));
		char* digits2 = number.digits;
		while (--num >= 0)
		{
			*(digits2++) = *(bufferEnd++);
		}
		*digits2 = '\0';
	}

	private unsafe static string NegativeInt64ToDecStr(long input, int digits, string sNegative)
	{
		if (digits < 1)
		{
			digits = 1;
		}
		ulong value = (ulong)(-input);
		int num = Math.Max(digits, FormattingHelpers.CountDigits(value)) + sNegative.Length;
		string text = string.FastAllocateString(num);
		fixed (char* ptr = text)
		{
			char* bufferEnd = ptr + num;
			while (High32(value) != 0)
			{
				bufferEnd = UInt32ToDecChars(bufferEnd, Int64DivMod1E9(ref value), 9);
				digits -= 9;
			}
			bufferEnd = UInt32ToDecChars(bufferEnd, Low32(value), digits);
			for (int num2 = sNegative.Length - 1; num2 >= 0; num2--)
			{
				*(--bufferEnd) = sNegative[num2];
			}
		}
		return text;
	}

	private unsafe static bool TryNegativeInt64ToDecStr(long input, int digits, string sNegative, Span<char> destination, out int charsWritten)
	{
		if (digits < 1)
		{
			digits = 1;
		}
		ulong value = (ulong)(-input);
		int num = Math.Max(digits, FormattingHelpers.CountDigits((ulong)(-input))) + sNegative.Length;
		if (num > destination.Length)
		{
			charsWritten = 0;
			return false;
		}
		charsWritten = num;
		fixed (char* reference = &MemoryMarshal.GetReference(destination))
		{
			char* bufferEnd = reference + num;
			while (High32(value) != 0)
			{
				bufferEnd = UInt32ToDecChars(bufferEnd, Int64DivMod1E9(ref value), 9);
				digits -= 9;
			}
			bufferEnd = UInt32ToDecChars(bufferEnd, Low32(value), digits);
			for (int num2 = sNegative.Length - 1; num2 >= 0; num2--)
			{
				*(--bufferEnd) = sNegative[num2];
			}
		}
		return true;
	}

	private unsafe static string Int64ToHexStr(long value, char hexBase, int digits)
	{
		int num = Math.Max(digits, FormattingHelpers.CountHexDigits((ulong)value));
		string text = string.FastAllocateString(num);
		fixed (char* ptr = text)
		{
			char* buffer = ptr + num;
			if (High32((ulong)value) != 0)
			{
				buffer = Int32ToHexChars(buffer, Low32((ulong)value), hexBase, 8);
				buffer = Int32ToHexChars(buffer, High32((ulong)value), hexBase, digits - 8);
			}
			else
			{
				buffer = Int32ToHexChars(buffer, Low32((ulong)value), hexBase, Math.Max(digits, 1));
			}
		}
		return text;
	}

	private unsafe static bool TryInt64ToHexStr(long value, char hexBase, int digits, Span<char> destination, out int charsWritten)
	{
		int num = Math.Max(digits, FormattingHelpers.CountHexDigits((ulong)value));
		if (num > destination.Length)
		{
			charsWritten = 0;
			return false;
		}
		charsWritten = num;
		fixed (char* reference = &MemoryMarshal.GetReference(destination))
		{
			char* buffer = reference + num;
			if (High32((ulong)value) != 0)
			{
				buffer = Int32ToHexChars(buffer, Low32((ulong)value), hexBase, 8);
				buffer = Int32ToHexChars(buffer, High32((ulong)value), hexBase, digits - 8);
			}
			else
			{
				buffer = Int32ToHexChars(buffer, Low32((ulong)value), hexBase, Math.Max(digits, 1));
			}
		}
		return true;
	}

	private unsafe static void UInt64ToNumber(ulong value, ref NumberBuffer number)
	{
		number.precision = 20;
		number.sign = false;
		char* digits = number.digits;
		char* bufferEnd = digits + 20;
		while (High32(value) != 0)
		{
			bufferEnd = UInt32ToDecChars(bufferEnd, Int64DivMod1E9(ref value), 9);
		}
		bufferEnd = UInt32ToDecChars(bufferEnd, Low32(value), 0);
		int num = (number.scale = (int)(digits + 20 - bufferEnd));
		char* digits2 = number.digits;
		while (--num >= 0)
		{
			*(digits2++) = *(bufferEnd++);
		}
		*digits2 = '\0';
	}

	private unsafe static string UInt64ToDecStr(ulong value, int digits)
	{
		if (digits < 1)
		{
			digits = 1;
		}
		int num = Math.Max(digits, FormattingHelpers.CountDigits(value));
		string text = string.FastAllocateString(num);
		fixed (char* ptr = text)
		{
			char* bufferEnd = ptr + num;
			while (High32(value) != 0)
			{
				bufferEnd = UInt32ToDecChars(bufferEnd, Int64DivMod1E9(ref value), 9);
				digits -= 9;
			}
			bufferEnd = UInt32ToDecChars(bufferEnd, Low32(value), digits);
		}
		return text;
	}

	private unsafe static bool TryUInt64ToDecStr(ulong value, int digits, Span<char> destination, out int charsWritten)
	{
		if (digits < 1)
		{
			digits = 1;
		}
		int num = Math.Max(digits, FormattingHelpers.CountDigits(value));
		if (num > destination.Length)
		{
			charsWritten = 0;
			return false;
		}
		charsWritten = num;
		fixed (char* reference = &MemoryMarshal.GetReference(destination))
		{
			char* bufferEnd = reference + num;
			while (High32(value) != 0)
			{
				bufferEnd = UInt32ToDecChars(bufferEnd, Int64DivMod1E9(ref value), 9);
				digits -= 9;
			}
			bufferEnd = UInt32ToDecChars(bufferEnd, Low32(value), digits);
		}
		return true;
	}

	internal static char ParseFormatSpecifier(ReadOnlySpan<char> format, out int digits)
	{
		char c = '\0';
		if (format.Length > 0)
		{
			c = format[0];
			if ((uint)(c - 65) <= 25u || (uint)(c - 97) <= 25u)
			{
				if (format.Length == 1)
				{
					digits = -1;
					return c;
				}
				if (format.Length == 2)
				{
					int num = format[1] - 48;
					if ((uint)num < 10u)
					{
						digits = num;
						return c;
					}
				}
				else if (format.Length == 3)
				{
					int num2 = format[1] - 48;
					int num3 = format[2] - 48;
					if ((uint)num2 < 10u && (uint)num3 < 10u)
					{
						digits = num2 * 10 + num3;
						return c;
					}
				}
				int num4 = 0;
				int num5 = 1;
				while (num5 < format.Length && (uint)(format[num5] - 48) < 10u && num4 < 10)
				{
					num4 = num4 * 10 + format[num5++] - 48;
				}
				if (num5 == format.Length || format[num5] == '\0')
				{
					digits = num4;
					return c;
				}
			}
		}
		digits = -1;
		if (format.Length != 0 && c != 0)
		{
			return '\0';
		}
		return 'G';
	}

	internal unsafe static void NumberToString(ref ValueStringBuilder sb, ref NumberBuffer number, char format, int nMaxDigits, NumberFormatInfo info, bool isDecimal)
	{
		int num = -1;
		switch (format)
		{
		case 'C':
		case 'c':
			num = ((nMaxDigits >= 0) ? nMaxDigits : info.CurrencyDecimalDigits);
			if (nMaxDigits < 0)
			{
				nMaxDigits = info.CurrencyDecimalDigits;
			}
			RoundNumber(ref number, number.scale + nMaxDigits);
			FormatCurrency(ref sb, ref number, num, nMaxDigits, info);
			break;
		case 'F':
		case 'f':
			if (nMaxDigits < 0)
			{
				nMaxDigits = (num = info.NumberDecimalDigits);
			}
			else
			{
				num = nMaxDigits;
			}
			RoundNumber(ref number, number.scale + nMaxDigits);
			if (number.sign)
			{
				sb.Append(info.NegativeSign);
			}
			FormatFixed(ref sb, ref number, num, nMaxDigits, info, null, info.NumberDecimalSeparator, null);
			break;
		case 'N':
		case 'n':
			if (nMaxDigits < 0)
			{
				nMaxDigits = (num = info.NumberDecimalDigits);
			}
			else
			{
				num = nMaxDigits;
			}
			RoundNumber(ref number, number.scale + nMaxDigits);
			FormatNumber(ref sb, ref number, num, nMaxDigits, info);
			break;
		case 'E':
		case 'e':
			if (nMaxDigits < 0)
			{
				nMaxDigits = (num = 6);
			}
			else
			{
				num = nMaxDigits;
			}
			nMaxDigits++;
			RoundNumber(ref number, nMaxDigits);
			if (number.sign)
			{
				sb.Append(info.NegativeSign);
			}
			FormatScientific(ref sb, ref number, num, nMaxDigits, info, format);
			break;
		case 'G':
		case 'g':
		{
			bool flag = true;
			if (nMaxDigits < 1)
			{
				if (isDecimal && nMaxDigits == -1)
				{
					nMaxDigits = (num = 29);
					flag = false;
				}
				else
				{
					nMaxDigits = (num = number.precision);
				}
			}
			else
			{
				num = nMaxDigits;
			}
			if (flag)
			{
				RoundNumber(ref number, nMaxDigits);
			}
			else if (isDecimal && *number.digits == '\0')
			{
				number.sign = false;
			}
			if (number.sign)
			{
				sb.Append(info.NegativeSign);
			}
			FormatGeneral(ref sb, ref number, num, nMaxDigits, info, (char)(format - 2), !flag);
			break;
		}
		case 'P':
		case 'p':
			if (nMaxDigits < 0)
			{
				nMaxDigits = (num = info.PercentDecimalDigits);
			}
			else
			{
				num = nMaxDigits;
			}
			number.scale += 2;
			RoundNumber(ref number, number.scale + nMaxDigits);
			FormatPercent(ref sb, ref number, num, nMaxDigits, info);
			break;
		default:
			throw new FormatException("Format specifier was invalid.");
		}
	}

	internal unsafe static void NumberToStringFormat(ref ValueStringBuilder sb, ref NumberBuffer number, ReadOnlySpan<char> format, NumberFormatInfo info)
	{
		int num = 0;
		char* digits = number.digits;
		int num2 = FindSection(format, (*digits == '\0') ? 2 : (number.sign ? 1 : 0));
		int num3;
		int num4;
		bool flag;
		bool flag2;
		int num5;
		int num6;
		int num9;
		while (true)
		{
			num3 = 0;
			num4 = -1;
			num5 = int.MaxValue;
			num6 = 0;
			flag = false;
			int num7 = -1;
			flag2 = false;
			int num8 = 0;
			num9 = num2;
			fixed (char* reference = &MemoryMarshal.GetReference(format))
			{
				char c;
				while (num9 < format.Length && (c = reference[num9++]) != 0)
				{
					switch (c)
					{
					case ';':
						break;
					case '#':
						num3++;
						continue;
					case '0':
						if (num5 == int.MaxValue)
						{
							num5 = num3;
						}
						num3++;
						num6 = num3;
						continue;
					case '.':
						if (num4 < 0)
						{
							num4 = num3;
						}
						continue;
					case ',':
						if (num3 <= 0 || num4 >= 0)
						{
							continue;
						}
						if (num7 >= 0)
						{
							if (num7 == num3)
							{
								num++;
								continue;
							}
							flag2 = true;
						}
						num7 = num3;
						num = 1;
						continue;
					case '%':
						num8 += 2;
						continue;
					case '‰':
						num8 += 3;
						continue;
					case '"':
					case '\'':
						while (num9 < format.Length && reference[num9] != 0 && reference[num9++] != c)
						{
						}
						continue;
					case '\\':
						if (num9 < format.Length && reference[num9] != 0)
						{
							num9++;
						}
						continue;
					case 'E':
					case 'e':
						if ((num9 < format.Length && reference[num9] == '0') || (num9 + 1 < format.Length && (reference[num9] == '+' || reference[num9] == '-') && reference[num9 + 1] == '0'))
						{
							while (++num9 < format.Length && reference[num9] == '0')
							{
							}
							flag = true;
						}
						continue;
					default:
						continue;
					}
					break;
				}
			}
			if (num4 < 0)
			{
				num4 = num3;
			}
			if (num7 >= 0)
			{
				if (num7 == num4)
				{
					num8 -= num * 3;
				}
				else
				{
					flag2 = true;
				}
			}
			if (*digits != 0)
			{
				number.scale += num8;
				int pos = (flag ? num3 : (number.scale + num3 - num4));
				RoundNumber(ref number, pos);
				if (*digits != 0)
				{
					break;
				}
				num9 = FindSection(format, 2);
				if (num9 == num2)
				{
					break;
				}
				num2 = num9;
				continue;
			}
			number.sign = false;
			number.scale = 0;
			break;
		}
		num5 = ((num5 < num4) ? (num4 - num5) : 0);
		num6 = ((num6 > num4) ? (num4 - num6) : 0);
		int num10;
		int num11;
		if (flag)
		{
			num10 = num4;
			num11 = 0;
		}
		else
		{
			num10 = ((number.scale > num4) ? number.scale : num4);
			num11 = number.scale - num4;
		}
		num9 = num2;
		Span<int> span = stackalloc int[4];
		int num12 = -1;
		if (flag2 && info.NumberGroupSeparator.Length > 0)
		{
			int[] numberGroupSizes = info.numberGroupSizes;
			int num13 = 0;
			int i = 0;
			int num14 = numberGroupSizes.Length;
			if (num14 != 0)
			{
				i = numberGroupSizes[num13];
			}
			int num15 = i;
			int num16 = num10 + ((num11 < 0) ? num11 : 0);
			for (int num17 = ((num5 > num16) ? num5 : num16); num17 > i; i += num15)
			{
				if (num15 == 0)
				{
					break;
				}
				num12++;
				if (num12 >= span.Length)
				{
					int[] array = new int[span.Length * 2];
					span.CopyTo(array);
					span = array;
				}
				span[num12] = i;
				if (num13 < num14 - 1)
				{
					num13++;
					num15 = numberGroupSizes[num13];
				}
			}
		}
		if (number.sign && num2 == 0)
		{
			sb.Append(info.NegativeSign);
		}
		bool flag3 = false;
		fixed (char* reference2 = &MemoryMarshal.GetReference(format))
		{
			char* ptr = digits;
			char c;
			while (num9 < format.Length && (c = reference2[num9++]) != 0 && c != ';')
			{
				if (num11 > 0 && (c == '#' || c == '.' || c == '0'))
				{
					while (num11 > 0)
					{
						sb.Append((*ptr != 0) ? (*(ptr++)) : '0');
						if (flag2 && num10 > 1 && num12 >= 0 && num10 == span[num12] + 1)
						{
							sb.Append(info.NumberGroupSeparator);
							num12--;
						}
						num10--;
						num11--;
					}
				}
				switch (c)
				{
				case '#':
				case '0':
					if (num11 < 0)
					{
						num11++;
						c = ((num10 <= num5) ? '0' : '\0');
					}
					else
					{
						c = ((*ptr != 0) ? (*(ptr++)) : ((num10 > num6) ? '0' : '\0'));
					}
					if (c != 0)
					{
						sb.Append(c);
						if (flag2 && num10 > 1 && num12 >= 0 && num10 == span[num12] + 1)
						{
							sb.Append(info.NumberGroupSeparator);
							num12--;
						}
					}
					num10--;
					break;
				case '.':
					if (!((num10 != 0) | flag3) && (num6 < 0 || (num4 < num3 && *ptr != 0)))
					{
						sb.Append(info.NumberDecimalSeparator);
						flag3 = true;
					}
					break;
				case '‰':
					sb.Append(info.PerMilleSymbol);
					break;
				case '%':
					sb.Append(info.PercentSymbol);
					break;
				case '"':
				case '\'':
					while (num9 < format.Length && reference2[num9] != 0 && reference2[num9] != c)
					{
						sb.Append(reference2[num9++]);
					}
					if (num9 < format.Length && reference2[num9] != 0)
					{
						num9++;
					}
					break;
				case '\\':
					if (num9 < format.Length && reference2[num9] != 0)
					{
						sb.Append(reference2[num9++]);
					}
					break;
				case 'E':
				case 'e':
				{
					bool positiveSign = false;
					int num18 = 0;
					if (flag)
					{
						if (num9 < format.Length && reference2[num9] == '0')
						{
							num18++;
						}
						else if (num9 + 1 < format.Length && reference2[num9] == '+' && reference2[num9 + 1] == '0')
						{
							positiveSign = true;
						}
						else if (num9 + 1 >= format.Length || reference2[num9] != '-' || reference2[num9 + 1] != '0')
						{
							sb.Append(c);
							break;
						}
						while (++num9 < format.Length && reference2[num9] == '0')
						{
							num18++;
						}
						if (num18 > 10)
						{
							num18 = 10;
						}
						int value = ((*digits != 0) ? (number.scale - num4) : 0);
						FormatExponent(ref sb, info, value, c, num18, positiveSign);
						flag = false;
						break;
					}
					sb.Append(c);
					if (num9 < format.Length)
					{
						if (reference2[num9] == '+' || reference2[num9] == '-')
						{
							sb.Append(reference2[num9++]);
						}
						while (num9 < format.Length && reference2[num9] == '0')
						{
							sb.Append(reference2[num9++]);
						}
					}
					break;
				}
				default:
					sb.Append(c);
					break;
				case ',':
					break;
				}
			}
		}
	}

	private static void FormatCurrency(ref ValueStringBuilder sb, ref NumberBuffer number, int nMinDigits, int nMaxDigits, NumberFormatInfo info)
	{
		string text = (number.sign ? s_negCurrencyFormats[info.CurrencyNegativePattern] : s_posCurrencyFormats[info.CurrencyPositivePattern]);
		foreach (char c in text)
		{
			switch (c)
			{
			case '#':
				FormatFixed(ref sb, ref number, nMinDigits, nMaxDigits, info, info.currencyGroupSizes, info.CurrencyDecimalSeparator, info.CurrencyGroupSeparator);
				break;
			case '-':
				sb.Append(info.NegativeSign);
				break;
			case '$':
				sb.Append(info.CurrencySymbol);
				break;
			default:
				sb.Append(c);
				break;
			}
		}
	}

	private unsafe static void FormatFixed(ref ValueStringBuilder sb, ref NumberBuffer number, int nMinDigits, int nMaxDigits, NumberFormatInfo info, int[] groupDigits, string sDecimal, string sGroup)
	{
		int num = number.scale;
		char* ptr = number.digits;
		if (num > 0)
		{
			if (groupDigits != null)
			{
				int num2 = 0;
				int num3 = num;
				int num4 = 0;
				if (groupDigits.Length != 0)
				{
					int num5 = groupDigits[num2];
					while (num > num5 && groupDigits[num2] != 0)
					{
						num3 += sGroup.Length;
						if (num2 < groupDigits.Length - 1)
						{
							num2++;
						}
						num5 += groupDigits[num2];
						if (num5 < 0 || num3 < 0)
						{
							throw new ArgumentOutOfRangeException();
						}
					}
					num4 = ((num5 != 0) ? groupDigits[0] : 0);
				}
				num2 = 0;
				int num6 = 0;
				int num7 = string.wcslen(ptr);
				int num8 = ((num < num7) ? num : num7);
				fixed (char* reference = &MemoryMarshal.GetReference(sb.AppendSpan(num3)))
				{
					char* ptr2 = reference + num3 - 1;
					for (int num9 = num - 1; num9 >= 0; num9--)
					{
						*(ptr2--) = ((num9 < num8) ? ptr[num9] : '0');
						if (num4 > 0)
						{
							num6++;
							if (num6 == num4 && num9 != 0)
							{
								for (int num10 = sGroup.Length - 1; num10 >= 0; num10--)
								{
									*(ptr2--) = sGroup[num10];
								}
								if (num2 < groupDigits.Length - 1)
								{
									num2++;
									num4 = groupDigits[num2];
								}
								num6 = 0;
							}
						}
					}
					ptr += num8;
				}
			}
			else
			{
				do
				{
					sb.Append((*ptr != 0) ? (*(ptr++)) : '0');
				}
				while (--num > 0);
			}
		}
		else
		{
			sb.Append('0');
		}
		if (nMaxDigits > 0)
		{
			sb.Append(sDecimal);
			if (num < 0 && nMaxDigits > 0)
			{
				int num11 = Math.Min(-num, nMaxDigits);
				sb.Append('0', num11);
				num += num11;
				nMaxDigits -= num11;
			}
			while (nMaxDigits > 0)
			{
				sb.Append((*ptr != 0) ? (*(ptr++)) : '0');
				nMaxDigits--;
			}
		}
	}

	private static void FormatNumber(ref ValueStringBuilder sb, ref NumberBuffer number, int nMinDigits, int nMaxDigits, NumberFormatInfo info)
	{
		string text = (number.sign ? s_negNumberFormats[info.NumberNegativePattern] : "#");
		foreach (char c in text)
		{
			switch (c)
			{
			case '#':
				FormatFixed(ref sb, ref number, nMinDigits, nMaxDigits, info, info.numberGroupSizes, info.NumberDecimalSeparator, info.NumberGroupSeparator);
				break;
			case '-':
				sb.Append(info.NegativeSign);
				break;
			default:
				sb.Append(c);
				break;
			}
		}
	}

	private unsafe static void FormatScientific(ref ValueStringBuilder sb, ref NumberBuffer number, int nMinDigits, int nMaxDigits, NumberFormatInfo info, char expChar)
	{
		char* digits = number.digits;
		sb.Append((*digits != 0) ? (*(digits++)) : '0');
		if (nMaxDigits != 1)
		{
			sb.Append(info.NumberDecimalSeparator);
		}
		while (--nMaxDigits > 0)
		{
			sb.Append((*digits != 0) ? (*(digits++)) : '0');
		}
		int value = ((*number.digits != 0) ? (number.scale - 1) : 0);
		FormatExponent(ref sb, info, value, expChar, 3, positiveSign: true);
	}

	private unsafe static void FormatExponent(ref ValueStringBuilder sb, NumberFormatInfo info, int value, char expChar, int minDigits, bool positiveSign)
	{
		sb.Append(expChar);
		if (value < 0)
		{
			sb.Append(info.NegativeSign);
			value = -value;
		}
		else if (positiveSign)
		{
			sb.Append(info.PositiveSign);
		}
		char* ptr = stackalloc char[10];
		char* ptr2 = UInt32ToDecChars(ptr + 10, (uint)value, minDigits);
		_ = ptr + 10 - ptr2;
		sb.Append(ptr2, (int)(ptr + 10 - ptr2));
	}

	private unsafe static void FormatGeneral(ref ValueStringBuilder sb, ref NumberBuffer number, int nMinDigits, int nMaxDigits, NumberFormatInfo info, char expChar, bool bSuppressScientific)
	{
		int i = number.scale;
		bool flag = false;
		if (!bSuppressScientific && (i > nMaxDigits || i < -3))
		{
			i = 1;
			flag = true;
		}
		char* digits = number.digits;
		if (i > 0)
		{
			do
			{
				sb.Append((*digits != 0) ? (*(digits++)) : '0');
			}
			while (--i > 0);
		}
		else
		{
			sb.Append('0');
		}
		if (*digits != 0 || i < 0)
		{
			sb.Append(info.NumberDecimalSeparator);
			for (; i < 0; i++)
			{
				sb.Append('0');
			}
			while (*digits != 0)
			{
				sb.Append(*(digits++));
			}
		}
		if (flag)
		{
			FormatExponent(ref sb, info, number.scale - 1, expChar, 2, positiveSign: true);
		}
	}

	private static void FormatPercent(ref ValueStringBuilder sb, ref NumberBuffer number, int nMinDigits, int nMaxDigits, NumberFormatInfo info)
	{
		string text = (number.sign ? s_negPercentFormats[info.PercentNegativePattern] : s_posPercentFormats[info.PercentPositivePattern]);
		foreach (char c in text)
		{
			switch (c)
			{
			case '#':
				FormatFixed(ref sb, ref number, nMinDigits, nMaxDigits, info, info.percentGroupSizes, info.PercentDecimalSeparator, info.PercentGroupSeparator);
				break;
			case '-':
				sb.Append(info.NegativeSign);
				break;
			case '%':
				sb.Append(info.PercentSymbol);
				break;
			default:
				sb.Append(c);
				break;
			}
		}
	}

	private unsafe static void RoundNumber(ref NumberBuffer number, int pos)
	{
		char* digits = number.digits;
		int i;
		for (i = 0; i < pos && digits[i] != 0; i++)
		{
		}
		if (i == pos && digits[i] >= '5')
		{
			while (i > 0 && digits[i - 1] == '9')
			{
				i--;
			}
			if (i > 0)
			{
				char* num = digits + (i - 1);
				*num = (char)(*num + 1);
			}
			else
			{
				number.scale++;
				*digits = '1';
				i = 1;
			}
		}
		else
		{
			while (i > 0 && digits[i - 1] == '0')
			{
				i--;
			}
		}
		if (i == 0)
		{
			number.scale = 0;
			number.sign = false;
		}
		digits[i] = '\0';
	}

	private unsafe static int FindSection(ReadOnlySpan<char> format, int section)
	{
		if (section == 0)
		{
			return 0;
		}
		fixed (char* reference = &MemoryMarshal.GetReference(format))
		{
			int num = 0;
			while (true)
			{
				if (num >= format.Length)
				{
					return 0;
				}
				char c2;
				char c = (c2 = reference[num++]);
				if ((uint)c <= 34u)
				{
					if (c == '\0')
					{
						break;
					}
					if (c != '"')
					{
						continue;
					}
				}
				else if (c != '\'')
				{
					switch (c)
					{
					default:
						continue;
					case '\\':
						if (num < format.Length && reference[num] != 0)
						{
							num++;
						}
						continue;
					case ';':
						break;
					}
					if (--section == 0)
					{
						if (num >= format.Length || reference[num] == '\0' || reference[num] == ';')
						{
							break;
						}
						return num;
					}
					continue;
				}
				while (num < format.Length && reference[num] != 0 && reference[num++] != c2)
				{
				}
			}
			return 0;
		}
	}

	private static uint Low32(ulong value)
	{
		return (uint)value;
	}

	private static uint High32(ulong value)
	{
		return (uint)((value & 0xFFFFFFFF00000000uL) >> 32);
	}

	private static uint Int64DivMod1E9(ref ulong value)
	{
		int result = (int)(value % 1000000000);
		value /= 1000000000uL;
		return (uint)result;
	}

	private unsafe static bool NumberToInt32(ref NumberBuffer number, ref int value)
	{
		int num = number.scale;
		if (num > 10 || num < number.precision)
		{
			return false;
		}
		char* digits = number.digits;
		int num2 = 0;
		while (--num >= 0)
		{
			if ((uint)num2 > 214748364u)
			{
				return false;
			}
			num2 *= 10;
			if (*digits != 0)
			{
				num2 += *(digits++) - 48;
			}
		}
		if (number.sign)
		{
			num2 = -num2;
			if (num2 > 0)
			{
				return false;
			}
		}
		else if (num2 < 0)
		{
			return false;
		}
		value = num2;
		return true;
	}

	private unsafe static bool NumberToInt64(ref NumberBuffer number, ref long value)
	{
		int num = number.scale;
		if (num > 19 || num < number.precision)
		{
			return false;
		}
		char* digits = number.digits;
		long num2 = 0L;
		while (--num >= 0)
		{
			if ((ulong)num2 > 922337203685477580uL)
			{
				return false;
			}
			num2 *= 10;
			if (*digits != 0)
			{
				num2 += *(digits++) - 48;
			}
		}
		if (number.sign)
		{
			num2 = -num2;
			if (num2 > 0)
			{
				return false;
			}
		}
		else if (num2 < 0)
		{
			return false;
		}
		value = num2;
		return true;
	}

	private unsafe static bool NumberToUInt32(ref NumberBuffer number, ref uint value)
	{
		int num = number.scale;
		if (num > 10 || num < number.precision || number.sign)
		{
			return false;
		}
		char* digits = number.digits;
		uint num2 = 0u;
		while (--num >= 0)
		{
			if (num2 > 429496729)
			{
				return false;
			}
			num2 *= 10;
			if (*digits != 0)
			{
				uint num3 = num2 + (uint)(*(digits++) - 48);
				if (num3 < num2)
				{
					return false;
				}
				num2 = num3;
			}
		}
		value = num2;
		return true;
	}

	private unsafe static bool NumberToUInt64(ref NumberBuffer number, ref ulong value)
	{
		int num = number.scale;
		if (num > 20 || num < number.precision || number.sign)
		{
			return false;
		}
		char* digits = number.digits;
		ulong num2 = 0uL;
		while (--num >= 0)
		{
			if (num2 > 1844674407370955161L)
			{
				return false;
			}
			num2 *= 10;
			if (*digits != 0)
			{
				ulong num3 = num2 + (ulong)(*(digits++) - 48);
				if (num3 < num2)
				{
					return false;
				}
				num2 = num3;
			}
		}
		value = num2;
		return true;
	}

	internal static int ParseInt32(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info)
	{
		if ((styles & ~NumberStyles.Integer) == 0)
		{
			bool failureIsOverflow = false;
			if (!TryParseInt32IntegerStyle(value, styles, info, out var result, ref failureIsOverflow))
			{
				ThrowOverflowOrFormatException(failureIsOverflow, "Value was either too large or too small for an Int32.");
			}
			return result;
		}
		if ((styles & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			bool failureIsOverflow2 = false;
			if (!TryParseUInt32HexNumberStyle(value, styles, info, out var result2, ref failureIsOverflow2))
			{
				ThrowOverflowOrFormatException(failureIsOverflow2, "Value was either too large or too small for an Int32.");
			}
			return (int)result2;
		}
		NumberBuffer number = default(NumberBuffer);
		int value2 = 0;
		StringToNumber(value, styles, ref number, info, parseDecimal: false);
		if (!NumberToInt32(ref number, ref value2))
		{
			ThrowOverflowOrFormatException(overflow: true, "Value was either too large or too small for an Int32.");
		}
		return value2;
	}

	internal static long ParseInt64(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info)
	{
		if ((styles & ~NumberStyles.Integer) == 0)
		{
			bool failureIsOverflow = false;
			if (!TryParseInt64IntegerStyle(value, styles, info, out var result, ref failureIsOverflow))
			{
				ThrowOverflowOrFormatException(failureIsOverflow, "Value was either too large or too small for an Int64.");
			}
			return result;
		}
		if ((styles & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			bool failureIsOverflow2 = false;
			if (!TryParseUInt64HexNumberStyle(value, styles, info, out var result2, ref failureIsOverflow2))
			{
				ThrowOverflowOrFormatException(failureIsOverflow2, "Value was either too large or too small for an Int64.");
			}
			return (long)result2;
		}
		NumberBuffer number = default(NumberBuffer);
		long value2 = 0L;
		StringToNumber(value, styles, ref number, info, parseDecimal: false);
		if (!NumberToInt64(ref number, ref value2))
		{
			ThrowOverflowOrFormatException(overflow: true, "Value was either too large or too small for an Int64.");
		}
		return value2;
	}

	internal static uint ParseUInt32(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info)
	{
		uint value2 = 0u;
		if ((styles & ~NumberStyles.Integer) == 0)
		{
			bool failureIsOverflow = false;
			if (!TryParseUInt32IntegerStyle(value, styles, info, out value2, ref failureIsOverflow))
			{
				ThrowOverflowOrFormatException(failureIsOverflow, "Value was either too large or too small for a UInt32.");
			}
			return value2;
		}
		if ((styles & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			bool failureIsOverflow2 = false;
			if (!TryParseUInt32HexNumberStyle(value, styles, info, out value2, ref failureIsOverflow2))
			{
				ThrowOverflowOrFormatException(failureIsOverflow2, "Value was either too large or too small for a UInt32.");
			}
			return value2;
		}
		NumberBuffer number = default(NumberBuffer);
		StringToNumber(value, styles, ref number, info, parseDecimal: false);
		if (!NumberToUInt32(ref number, ref value2))
		{
			ThrowOverflowOrFormatException(overflow: true, "Value was either too large or too small for a UInt32.");
		}
		return value2;
	}

	internal static ulong ParseUInt64(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info)
	{
		ulong value2 = 0uL;
		if ((styles & ~NumberStyles.Integer) == 0)
		{
			bool failureIsOverflow = false;
			if (!TryParseUInt64IntegerStyle(value, styles, info, out value2, ref failureIsOverflow))
			{
				ThrowOverflowOrFormatException(failureIsOverflow, "Value was either too large or too small for a UInt64.");
			}
			return value2;
		}
		if ((styles & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			bool failureIsOverflow2 = false;
			if (!TryParseUInt64HexNumberStyle(value, styles, info, out value2, ref failureIsOverflow2))
			{
				ThrowOverflowOrFormatException(failureIsOverflow2, "Value was either too large or too small for a UInt64.");
			}
			return value2;
		}
		NumberBuffer number = default(NumberBuffer);
		StringToNumber(value, styles, ref number, info, parseDecimal: false);
		if (!NumberToUInt64(ref number, ref value2))
		{
			ThrowOverflowOrFormatException(overflow: true, "Value was either too large or too small for a UInt64.");
		}
		return value2;
	}

	private unsafe static bool ParseNumber(ref char* str, char* strEnd, NumberStyles styles, ref NumberBuffer number, NumberFormatInfo info, bool parseDecimal)
	{
		number.scale = 0;
		number.sign = false;
		string text = null;
		bool flag = false;
		string value;
		string value2;
		if ((styles & NumberStyles.AllowCurrencySymbol) != NumberStyles.None)
		{
			text = info.CurrencySymbol;
			value = info.CurrencyDecimalSeparator;
			value2 = info.CurrencyGroupSeparator;
			flag = true;
		}
		else
		{
			value = info.NumberDecimalSeparator;
			value2 = info.NumberGroupSeparator;
		}
		int num = 0;
		char* ptr = str;
		char c = ((ptr < strEnd) ? (*ptr) : '\0');
		while (true)
		{
			if (!IsWhite(c) || (styles & NumberStyles.AllowLeadingWhite) == 0 || ((num & 1) != 0 && (num & 0x20) == 0 && info.NumberNegativePattern != 2))
			{
				char* ptr2;
				if ((styles & NumberStyles.AllowLeadingSign) != NumberStyles.None && (num & 1) == 0 && ((ptr2 = MatchChars(ptr, strEnd, info.PositiveSign)) != null || ((ptr2 = MatchChars(ptr, strEnd, info.NegativeSign)) != null && (number.sign = true))))
				{
					num |= 1;
					ptr = ptr2 - 1;
				}
				else if (c == '(' && (styles & NumberStyles.AllowParentheses) != NumberStyles.None && (num & 1) == 0)
				{
					num |= 3;
					number.sign = true;
				}
				else
				{
					if (text == null || (ptr2 = MatchChars(ptr, strEnd, text)) == null)
					{
						break;
					}
					num |= 0x20;
					text = null;
					ptr = ptr2 - 1;
				}
			}
			c = ((++ptr < strEnd) ? (*ptr) : '\0');
		}
		int num2 = 0;
		int num3 = 0;
		while (true)
		{
			char* ptr2;
			if (IsDigit(c))
			{
				num |= 4;
				if (c != '0' || (num & 8) != 0)
				{
					if (num2 < 50)
					{
						number.digits[num2++] = c;
						if ((c != '0') | parseDecimal)
						{
							num3 = num2;
						}
					}
					if ((num & 0x10) == 0)
					{
						number.scale++;
					}
					num |= 8;
				}
				else if ((num & 0x10) != 0)
				{
					number.scale--;
				}
			}
			else if ((styles & NumberStyles.AllowDecimalPoint) != NumberStyles.None && (num & 0x10) == 0 && ((ptr2 = MatchChars(ptr, strEnd, value)) != null || (flag && (num & 0x20) == 0 && (ptr2 = MatchChars(ptr, strEnd, info.NumberDecimalSeparator)) != null)))
			{
				num |= 0x10;
				ptr = ptr2 - 1;
			}
			else
			{
				if ((styles & NumberStyles.AllowThousands) == 0 || (num & 4) == 0 || (num & 0x10) != 0 || ((ptr2 = MatchChars(ptr, strEnd, value2)) == null && (!flag || (num & 0x20) != 0 || (ptr2 = MatchChars(ptr, strEnd, info.NumberGroupSeparator)) == null)))
				{
					break;
				}
				ptr = ptr2 - 1;
			}
			c = ((++ptr < strEnd) ? (*ptr) : '\0');
		}
		bool flag3 = false;
		number.precision = num3;
		number.digits[num3] = '\0';
		if ((num & 4) != 0)
		{
			if ((c == 'E' || c == 'e') && (styles & NumberStyles.AllowExponent) != NumberStyles.None)
			{
				char* ptr3 = ptr;
				c = ((++ptr < strEnd) ? (*ptr) : '\0');
				char* ptr2;
				if ((ptr2 = MatchChars(ptr, strEnd, info.positiveSign)) != null)
				{
					c = (((ptr = ptr2) < strEnd) ? (*ptr) : '\0');
				}
				else if ((ptr2 = MatchChars(ptr, strEnd, info.negativeSign)) != null)
				{
					c = (((ptr = ptr2) < strEnd) ? (*ptr) : '\0');
					flag3 = true;
				}
				if (IsDigit(c))
				{
					int num4 = 0;
					do
					{
						num4 = num4 * 10 + (c - 48);
						c = ((++ptr < strEnd) ? (*ptr) : '\0');
						if (num4 > 1000)
						{
							num4 = 9999;
							while (IsDigit(c))
							{
								c = ((++ptr < strEnd) ? (*ptr) : '\0');
							}
						}
					}
					while (IsDigit(c));
					if (flag3)
					{
						num4 = -num4;
					}
					number.scale += num4;
				}
				else
				{
					ptr = ptr3;
					c = ((ptr < strEnd) ? (*ptr) : '\0');
				}
			}
			while (true)
			{
				if (!IsWhite(c) || (styles & NumberStyles.AllowTrailingWhite) == 0)
				{
					char* ptr2;
					if ((styles & NumberStyles.AllowTrailingSign) != NumberStyles.None && (num & 1) == 0 && ((ptr2 = MatchChars(ptr, strEnd, info.PositiveSign)) != null || ((ptr2 = MatchChars(ptr, strEnd, info.NegativeSign)) != null && (number.sign = true))))
					{
						num |= 1;
						ptr = ptr2 - 1;
					}
					else if (c == ')' && (num & 2) != 0)
					{
						num &= -3;
					}
					else
					{
						if (text == null || (ptr2 = MatchChars(ptr, strEnd, text)) == null)
						{
							break;
						}
						text = null;
						ptr = ptr2 - 1;
					}
				}
				c = ((++ptr < strEnd) ? (*ptr) : '\0');
			}
			if ((num & 2) == 0)
			{
				if ((num & 8) == 0)
				{
					if (!parseDecimal)
					{
						number.scale = 0;
					}
					if ((num & 0x10) == 0)
					{
						number.sign = false;
					}
				}
				str = ptr;
				return true;
			}
		}
		str = ptr;
		return false;
	}

	internal static bool TryParseInt32(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out int result)
	{
		if ((styles & ~NumberStyles.Integer) == 0)
		{
			bool failureIsOverflow = false;
			return TryParseInt32IntegerStyle(value, styles, info, out result, ref failureIsOverflow);
		}
		result = 0;
		if ((styles & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			bool failureIsOverflow2 = false;
			return TryParseUInt32HexNumberStyle(value, styles, info, out Unsafe.As<int, uint>(ref result), ref failureIsOverflow2);
		}
		NumberBuffer number = default(NumberBuffer);
		if (TryStringToNumber(value, styles, ref number, info, parseDecimal: false))
		{
			return NumberToInt32(ref number, ref result);
		}
		return false;
	}

	private static bool TryParseInt32IntegerStyle(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out int result, ref bool failureIsOverflow)
	{
		bool flag;
		int num;
		int i;
		int num2;
		if ((uint)value.Length >= 1u)
		{
			flag = false;
			num = 1;
			i = 0;
			num2 = value[0];
			if ((styles & NumberStyles.AllowLeadingWhite) == 0 || !IsWhite(num2))
			{
				goto IL_004d;
			}
			while (true)
			{
				i++;
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num2 = value[i];
				if (IsWhite(num2))
				{
					continue;
				}
				goto IL_004d;
			}
		}
		goto IL_0269;
		IL_0185:
		if (IsDigit(num2))
		{
			goto IL_0190;
		}
		goto IL_027f;
		IL_027f:
		if (IsWhite(num2))
		{
			if ((styles & NumberStyles.AllowTrailingWhite) == 0)
			{
				goto IL_0269;
			}
			for (i++; i < value.Length && IsWhite(value[i]); i++)
			{
			}
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_026e;
			}
		}
		if (!TrailingZeros(value, i))
		{
			goto IL_0269;
		}
		goto IL_026e;
		IL_0190:
		int num3 = num2 - 48;
		i++;
		int num4 = 0;
		while (true)
		{
			if (num4 < 8)
			{
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num2 = value[i];
				if (IsDigit(num2))
				{
					i++;
					num3 = 10 * num3 + num2 - 48;
					num4++;
					continue;
				}
			}
			else
			{
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num2 = value[i];
				if (IsDigit(num2))
				{
					i++;
					if (num3 > 214748364)
					{
						flag = true;
					}
					num3 = num3 * 10 + num2 - 48;
					if ((uint)num3 > 2147483647L + (long)((-1 * num + 1) / 2))
					{
						flag = true;
					}
					if ((uint)i >= (uint)value.Length)
					{
						break;
					}
					num2 = value[i];
					while (IsDigit(num2))
					{
						flag = true;
						i++;
						if ((uint)i >= (uint)value.Length)
						{
							goto end_IL_01d7;
						}
						num2 = value[i];
					}
				}
			}
			goto IL_027f;
			continue;
			end_IL_01d7:
			break;
		}
		goto IL_026e;
		IL_026e:
		if (flag)
		{
			failureIsOverflow = true;
			goto IL_0269;
		}
		result = num3 * num;
		return true;
		IL_004d:
		if ((styles & NumberStyles.AllowLeadingSign) != NumberStyles.None)
		{
			string positiveSign = info.PositiveSign;
			string negativeSign = info.NegativeSign;
			if (positiveSign == "+" && negativeSign == "-")
			{
				if (num2 == 45)
				{
					num = -1;
					i++;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0269;
					}
					num2 = value[i];
				}
				else if (num2 == 43)
				{
					i++;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0269;
					}
					num2 = value[i];
				}
			}
			else
			{
				value = value.Slice(i);
				i = 0;
				if (!string.IsNullOrEmpty(positiveSign) && value.StartsWith(positiveSign))
				{
					i += positiveSign.Length;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0269;
					}
					num2 = value[i];
				}
				else if (!string.IsNullOrEmpty(negativeSign) && value.StartsWith(negativeSign))
				{
					num = -1;
					i += negativeSign.Length;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0269;
					}
					num2 = value[i];
				}
			}
		}
		num3 = 0;
		if (!IsDigit(num2))
		{
			goto IL_0269;
		}
		if (num2 != 48)
		{
			goto IL_0190;
		}
		while (true)
		{
			i++;
			if ((uint)i >= (uint)value.Length)
			{
				break;
			}
			num2 = value[i];
			if (num2 == 48)
			{
				continue;
			}
			goto IL_0185;
		}
		goto IL_026e;
		IL_0269:
		result = 0;
		return false;
	}

	private static bool TryParseInt64IntegerStyle(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out long result, ref bool failureIsOverflow)
	{
		bool flag;
		int num;
		int i;
		int num2;
		if ((uint)value.Length >= 1u)
		{
			flag = false;
			num = 1;
			i = 0;
			num2 = value[0];
			if ((styles & NumberStyles.AllowLeadingWhite) == 0 || !IsWhite(num2))
			{
				goto IL_004d;
			}
			while (true)
			{
				i++;
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num2 = value[i];
				if (IsWhite(num2))
				{
					continue;
				}
				goto IL_004d;
			}
		}
		goto IL_0278;
		IL_0186:
		if (IsDigit(num2))
		{
			goto IL_0191;
		}
		goto IL_0290;
		IL_0290:
		if (IsWhite(num2))
		{
			if ((styles & NumberStyles.AllowTrailingWhite) == 0)
			{
				goto IL_0278;
			}
			for (i++; i < value.Length && IsWhite(value[i]); i++)
			{
			}
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_027e;
			}
		}
		if (!TrailingZeros(value, i))
		{
			goto IL_0278;
		}
		goto IL_027e;
		IL_0191:
		long num3 = num2 - 48;
		i++;
		int num4 = 0;
		while (true)
		{
			if (num4 < 17)
			{
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num2 = value[i];
				if (IsDigit(num2))
				{
					i++;
					num3 = 10 * num3 + num2 - 48;
					num4++;
					continue;
				}
			}
			else
			{
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num2 = value[i];
				if (IsDigit(num2))
				{
					i++;
					if (num3 > 922337203685477580L)
					{
						flag = true;
					}
					num3 = num3 * 10 + num2 - 48;
					if ((ulong)num3 > (ulong)(long.MaxValue + (-1 * num + 1) / 2))
					{
						flag = true;
					}
					if ((uint)i >= (uint)value.Length)
					{
						break;
					}
					num2 = value[i];
					while (IsDigit(num2))
					{
						flag = true;
						i++;
						if ((uint)i >= (uint)value.Length)
						{
							goto end_IL_01dc;
						}
						num2 = value[i];
					}
				}
			}
			goto IL_0290;
			continue;
			end_IL_01dc:
			break;
		}
		goto IL_027e;
		IL_027e:
		if (flag)
		{
			failureIsOverflow = true;
			goto IL_0278;
		}
		result = num3 * num;
		return true;
		IL_004d:
		if ((styles & NumberStyles.AllowLeadingSign) != NumberStyles.None)
		{
			string positiveSign = info.PositiveSign;
			string negativeSign = info.NegativeSign;
			if (positiveSign == "+" && negativeSign == "-")
			{
				if (num2 == 45)
				{
					num = -1;
					i++;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0278;
					}
					num2 = value[i];
				}
				else if (num2 == 43)
				{
					i++;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0278;
					}
					num2 = value[i];
				}
			}
			else
			{
				value = value.Slice(i);
				i = 0;
				if (!string.IsNullOrEmpty(positiveSign) && value.StartsWith(positiveSign))
				{
					i += positiveSign.Length;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0278;
					}
					num2 = value[i];
				}
				else if (!string.IsNullOrEmpty(negativeSign) && value.StartsWith(negativeSign))
				{
					num = -1;
					i += negativeSign.Length;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0278;
					}
					num2 = value[i];
				}
			}
		}
		num3 = 0L;
		if (!IsDigit(num2))
		{
			goto IL_0278;
		}
		if (num2 != 48)
		{
			goto IL_0191;
		}
		while (true)
		{
			i++;
			if ((uint)i >= (uint)value.Length)
			{
				break;
			}
			num2 = value[i];
			if (num2 == 48)
			{
				continue;
			}
			goto IL_0186;
		}
		goto IL_027e;
		IL_0278:
		result = 0L;
		return false;
	}

	internal static bool TryParseInt64(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out long result)
	{
		if ((styles & ~NumberStyles.Integer) == 0)
		{
			bool failureIsOverflow = false;
			return TryParseInt64IntegerStyle(value, styles, info, out result, ref failureIsOverflow);
		}
		result = 0L;
		if ((styles & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			bool failureIsOverflow2 = false;
			return TryParseUInt64HexNumberStyle(value, styles, info, out Unsafe.As<long, ulong>(ref result), ref failureIsOverflow2);
		}
		NumberBuffer number = default(NumberBuffer);
		if (TryStringToNumber(value, styles, ref number, info, parseDecimal: false))
		{
			return NumberToInt64(ref number, ref result);
		}
		return false;
	}

	internal static bool TryParseUInt32(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out uint result)
	{
		if ((styles & ~NumberStyles.Integer) == 0)
		{
			bool failureIsOverflow = false;
			return TryParseUInt32IntegerStyle(value, styles, info, out result, ref failureIsOverflow);
		}
		if ((styles & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			bool failureIsOverflow2 = false;
			return TryParseUInt32HexNumberStyle(value, styles, info, out result, ref failureIsOverflow2);
		}
		NumberBuffer number = default(NumberBuffer);
		result = 0u;
		if (TryStringToNumber(value, styles, ref number, info, parseDecimal: false))
		{
			return NumberToUInt32(ref number, ref result);
		}
		return false;
	}

	private static bool TryParseUInt32IntegerStyle(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out uint result, ref bool failureIsOverflow)
	{
		bool flag;
		bool flag2;
		int i;
		int num;
		if ((uint)value.Length >= 1u)
		{
			flag = false;
			flag2 = false;
			i = 0;
			num = value[0];
			if ((styles & NumberStyles.AllowLeadingWhite) == 0 || !IsWhite(num))
			{
				goto IL_004d;
			}
			while (true)
			{
				i++;
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num = value[i];
				if (IsWhite(num))
				{
					continue;
				}
				goto IL_004d;
			}
		}
		goto IL_025b;
		IL_0185:
		if (IsDigit(num))
		{
			goto IL_0190;
		}
		goto IL_0276;
		IL_025b:
		result = 0u;
		return false;
		IL_0190:
		int num2 = num - 48;
		i++;
		int num3 = 0;
		while (true)
		{
			if (num3 < 8)
			{
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num = value[i];
				if (IsDigit(num))
				{
					i++;
					num2 = 10 * num2 + num - 48;
					num3++;
					continue;
				}
			}
			else
			{
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num = value[i];
				if (IsDigit(num))
				{
					i++;
					if ((uint)num2 > 429496729u || (num2 == 429496729 && num > 53))
					{
						flag = true;
					}
					num2 = num2 * 10 + num - 48;
					if ((uint)i >= (uint)value.Length)
					{
						break;
					}
					num = value[i];
					while (IsDigit(num))
					{
						flag = true;
						i++;
						if ((uint)i >= (uint)value.Length)
						{
							goto end_IL_01d7;
						}
						num = value[i];
					}
				}
			}
			goto IL_0276;
			continue;
			end_IL_01d7:
			break;
		}
		goto IL_0260;
		IL_0260:
		if (flag || (flag2 && num2 != 0))
		{
			failureIsOverflow = true;
			goto IL_025b;
		}
		result = (uint)num2;
		return true;
		IL_004d:
		if ((styles & NumberStyles.AllowLeadingSign) != NumberStyles.None)
		{
			string positiveSign = info.PositiveSign;
			string negativeSign = info.NegativeSign;
			if (positiveSign == "+" && negativeSign == "-")
			{
				if (num == 43)
				{
					i++;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_025b;
					}
					num = value[i];
				}
				else if (num == 45)
				{
					flag2 = true;
					i++;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_025b;
					}
					num = value[i];
				}
			}
			else
			{
				value = value.Slice(i);
				i = 0;
				if (!string.IsNullOrEmpty(positiveSign) && value.StartsWith(positiveSign))
				{
					i += positiveSign.Length;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_025b;
					}
					num = value[i];
				}
				else if (!string.IsNullOrEmpty(negativeSign) && value.StartsWith(negativeSign))
				{
					flag2 = true;
					i += negativeSign.Length;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_025b;
					}
					num = value[i];
				}
			}
		}
		num2 = 0;
		if (!IsDigit(num))
		{
			goto IL_025b;
		}
		if (num != 48)
		{
			goto IL_0190;
		}
		while (true)
		{
			i++;
			if ((uint)i >= (uint)value.Length)
			{
				break;
			}
			num = value[i];
			if (num == 48)
			{
				continue;
			}
			goto IL_0185;
		}
		goto IL_0260;
		IL_0276:
		if (IsWhite(num))
		{
			if ((styles & NumberStyles.AllowTrailingWhite) == 0)
			{
				goto IL_025b;
			}
			for (i++; i < value.Length && IsWhite(value[i]); i++)
			{
			}
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_0260;
			}
		}
		if (!TrailingZeros(value, i))
		{
			goto IL_025b;
		}
		goto IL_0260;
	}

	private static bool TryParseUInt32HexNumberStyle(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out uint result, ref bool failureIsOverflow)
	{
		bool flag;
		int i;
		int num;
		int num2;
		if ((uint)value.Length >= 1u)
		{
			flag = false;
			i = 0;
			num = value[0];
			num2 = 0;
			if ((styles & NumberStyles.AllowLeadingWhite) == 0 || !IsWhite(num))
			{
				goto IL_004d;
			}
			while (true)
			{
				i++;
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num = value[i];
				if (IsWhite(num))
				{
					continue;
				}
				goto IL_004d;
			}
		}
		goto IL_0174;
		IL_0188:
		if (IsWhite(num))
		{
			if ((styles & NumberStyles.AllowTrailingWhite) == 0)
			{
				goto IL_0174;
			}
			for (i++; i < value.Length && IsWhite(value[i]); i++)
			{
			}
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_0179;
			}
		}
		if (!TrailingZeros(value, i))
		{
			goto IL_0174;
		}
		goto IL_0179;
		IL_0182:
		int num3;
		result = (uint)num3;
		return true;
		IL_0094:
		int[] array;
		if ((uint)num < (uint)array.Length && array[num] != 255)
		{
			goto IL_00ac;
		}
		goto IL_0188;
		IL_0179:
		if (flag)
		{
			failureIsOverflow = true;
			goto IL_0174;
		}
		goto IL_0182;
		IL_004d:
		num3 = 0;
		array = s_charToHexLookup;
		if ((uint)num >= (uint)array.Length || array[num] == 255)
		{
			goto IL_0174;
		}
		if (num != 48)
		{
			goto IL_00ac;
		}
		while (true)
		{
			i++;
			if ((uint)i >= (uint)value.Length)
			{
				break;
			}
			num = value[i];
			if (num == 48)
			{
				continue;
			}
			goto IL_0094;
		}
		goto IL_0182;
		IL_0174:
		result = 0u;
		return false;
		IL_00ac:
		num3 = array[num];
		i++;
		int num4 = 0;
		while (num4 < 7)
		{
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_0182;
			}
			num = value[i];
			if ((uint)num < (uint)array.Length && (num2 = array[num]) != 255)
			{
				i++;
				num3 = 16 * num3 + num2;
				num4++;
				continue;
			}
			goto IL_0188;
		}
		if ((uint)i >= (uint)value.Length)
		{
			goto IL_0182;
		}
		num = value[i];
		if ((uint)num < (uint)array.Length && (num2 = array[num]) != 255)
		{
			i++;
			flag = true;
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_0179;
			}
			num = value[i];
			while ((uint)num < (uint)array.Length && array[num] != 255)
			{
				i++;
				if ((uint)i < (uint)value.Length)
				{
					num = value[i];
					continue;
				}
				goto IL_0179;
			}
		}
		goto IL_0188;
	}

	internal static bool TryParseUInt64(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out ulong result)
	{
		if ((styles & ~NumberStyles.Integer) == 0)
		{
			bool failureIsOverflow = false;
			return TryParseUInt64IntegerStyle(value, styles, info, out result, ref failureIsOverflow);
		}
		if ((styles & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			bool failureIsOverflow2 = false;
			return TryParseUInt64HexNumberStyle(value, styles, info, out result, ref failureIsOverflow2);
		}
		NumberBuffer number = default(NumberBuffer);
		result = 0uL;
		if (TryStringToNumber(value, styles, ref number, info, parseDecimal: false))
		{
			return NumberToUInt64(ref number, ref result);
		}
		return false;
	}

	private static bool TryParseUInt64IntegerStyle(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out ulong result, ref bool failureIsOverflow)
	{
		bool flag;
		bool flag2;
		int i;
		int num;
		if ((uint)value.Length >= 1u)
		{
			flag = false;
			flag2 = false;
			i = 0;
			num = value[0];
			if ((styles & NumberStyles.AllowLeadingWhite) == 0 || !IsWhite(num))
			{
				goto IL_004d;
			}
			while (true)
			{
				i++;
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num = value[i];
				if (IsWhite(num))
				{
					continue;
				}
				goto IL_004d;
			}
		}
		goto IL_0272;
		IL_0186:
		if (IsDigit(num))
		{
			goto IL_0191;
		}
		goto IL_028e;
		IL_0272:
		result = 0uL;
		return false;
		IL_0191:
		long num2 = num - 48;
		i++;
		int num3 = 0;
		while (true)
		{
			if (num3 < 18)
			{
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num = value[i];
				if (IsDigit(num))
				{
					i++;
					num2 = 10 * num2 + num - 48;
					num3++;
					continue;
				}
			}
			else
			{
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num = value[i];
				if (IsDigit(num))
				{
					i++;
					if ((ulong)num2 > 1844674407370955161uL || (num2 == 1844674407370955161L && num > 53))
					{
						flag = true;
					}
					num2 = num2 * 10 + num - 48;
					if ((uint)i >= (uint)value.Length)
					{
						break;
					}
					num = value[i];
					while (IsDigit(num))
					{
						flag = true;
						i++;
						if ((uint)i >= (uint)value.Length)
						{
							goto end_IL_01dc;
						}
						num = value[i];
					}
				}
			}
			goto IL_028e;
			continue;
			end_IL_01dc:
			break;
		}
		goto IL_0278;
		IL_0278:
		if (flag || (flag2 && num2 != 0L))
		{
			failureIsOverflow = true;
			goto IL_0272;
		}
		result = (ulong)num2;
		return true;
		IL_004d:
		if ((styles & NumberStyles.AllowLeadingSign) != NumberStyles.None)
		{
			string positiveSign = info.PositiveSign;
			string negativeSign = info.NegativeSign;
			if (positiveSign == "+" && negativeSign == "-")
			{
				if (num == 43)
				{
					i++;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0272;
					}
					num = value[i];
				}
				else if (num == 45)
				{
					flag2 = true;
					i++;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0272;
					}
					num = value[i];
				}
			}
			else
			{
				value = value.Slice(i);
				i = 0;
				if (!string.IsNullOrEmpty(positiveSign) && value.StartsWith(positiveSign))
				{
					i += positiveSign.Length;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0272;
					}
					num = value[i];
				}
				else if (!string.IsNullOrEmpty(negativeSign) && value.StartsWith(negativeSign))
				{
					flag2 = true;
					i += negativeSign.Length;
					if ((uint)i >= (uint)value.Length)
					{
						goto IL_0272;
					}
					num = value[i];
				}
			}
		}
		num2 = 0L;
		if (!IsDigit(num))
		{
			goto IL_0272;
		}
		if (num != 48)
		{
			goto IL_0191;
		}
		while (true)
		{
			i++;
			if ((uint)i >= (uint)value.Length)
			{
				break;
			}
			num = value[i];
			if (num == 48)
			{
				continue;
			}
			goto IL_0186;
		}
		goto IL_0278;
		IL_028e:
		if (IsWhite(num))
		{
			if ((styles & NumberStyles.AllowTrailingWhite) == 0)
			{
				goto IL_0272;
			}
			for (i++; i < value.Length && IsWhite(value[i]); i++)
			{
			}
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_0278;
			}
		}
		if (!TrailingZeros(value, i))
		{
			goto IL_0272;
		}
		goto IL_0278;
	}

	private static bool TryParseUInt64HexNumberStyle(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out ulong result, ref bool failureIsOverflow)
	{
		bool flag;
		int i;
		int num;
		int num2;
		if ((uint)value.Length >= 1u)
		{
			flag = false;
			i = 0;
			num = value[0];
			num2 = 0;
			if ((styles & NumberStyles.AllowLeadingWhite) == 0 || !IsWhite(num))
			{
				goto IL_004d;
			}
			while (true)
			{
				i++;
				if ((uint)i >= (uint)value.Length)
				{
					break;
				}
				num = value[i];
				if (IsWhite(num))
				{
					continue;
				}
				goto IL_004d;
			}
		}
		goto IL_0179;
		IL_018e:
		if (IsWhite(num))
		{
			if ((styles & NumberStyles.AllowTrailingWhite) == 0)
			{
				goto IL_0179;
			}
			for (i++; i < value.Length && IsWhite(value[i]); i++)
			{
			}
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_017f;
			}
		}
		if (!TrailingZeros(value, i))
		{
			goto IL_0179;
		}
		goto IL_017f;
		IL_0188:
		long num3;
		result = (ulong)num3;
		return true;
		IL_0095:
		int[] array;
		if ((uint)num < (uint)array.Length && array[num] != 255)
		{
			goto IL_00ad;
		}
		goto IL_018e;
		IL_017f:
		if (flag)
		{
			failureIsOverflow = true;
			goto IL_0179;
		}
		goto IL_0188;
		IL_004d:
		num3 = 0L;
		array = s_charToHexLookup;
		if ((uint)num >= (uint)array.Length || array[num] == 255)
		{
			goto IL_0179;
		}
		if (num != 48)
		{
			goto IL_00ad;
		}
		while (true)
		{
			i++;
			if ((uint)i >= (uint)value.Length)
			{
				break;
			}
			num = value[i];
			if (num == 48)
			{
				continue;
			}
			goto IL_0095;
		}
		goto IL_0188;
		IL_0179:
		result = 0uL;
		return false;
		IL_00ad:
		num3 = array[num];
		i++;
		int num4 = 0;
		while (num4 < 15)
		{
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_0188;
			}
			num = value[i];
			if ((uint)num < (uint)array.Length && (num2 = array[num]) != 255)
			{
				i++;
				num3 = 16 * num3 + num2;
				num4++;
				continue;
			}
			goto IL_018e;
		}
		if ((uint)i >= (uint)value.Length)
		{
			goto IL_0188;
		}
		num = value[i];
		if ((uint)num < (uint)array.Length && (num2 = array[num]) != 255)
		{
			i++;
			flag = true;
			if ((uint)i >= (uint)value.Length)
			{
				goto IL_017f;
			}
			num = value[i];
			while ((uint)num < (uint)array.Length && array[num] != 255)
			{
				i++;
				if ((uint)i < (uint)value.Length)
				{
					num = value[i];
					continue;
				}
				goto IL_017f;
			}
		}
		goto IL_018e;
	}

	internal static decimal ParseDecimal(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info)
	{
		NumberBuffer number = default(NumberBuffer);
		decimal value2 = 0m;
		StringToNumber(value, styles, ref number, info, parseDecimal: true);
		if (!NumberBufferToDecimal(ref number, ref value2))
		{
			ThrowOverflowOrFormatException(overflow: true, "Value was either too large or too small for a Decimal.");
		}
		return value2;
	}

	private unsafe static bool NumberBufferToDecimal(ref NumberBuffer number, ref decimal value)
	{
		char* ptr = number.digits;
		int num = number.scale;
		bool sign = number.sign;
		uint num2 = *ptr;
		if (num2 == 0)
		{
			value = new decimal(0, 0, 0, sign, (byte)Math.Clamp(-num, 0, 28));
			return true;
		}
		if (num > 29)
		{
			return false;
		}
		ulong num3 = 0uL;
		while (num > -28)
		{
			num--;
			num3 *= 10;
			num3 += num2 - 48;
			num2 = *(++ptr);
			if (num3 >= 1844674407370955161L)
			{
				break;
			}
			if (num2 != 0)
			{
				continue;
			}
			while (num > 0)
			{
				num--;
				num3 *= 10;
				if (num3 >= 1844674407370955161L)
				{
					break;
				}
			}
			break;
		}
		uint num4 = 0u;
		while ((num > 0 || (num2 != 0 && num > -28)) && (num4 < 429496729 || (num4 == 429496729 && (num3 < 11068046444225730969uL || (num3 == 11068046444225730969uL && num2 <= 53)))))
		{
			ulong num5 = (ulong)(uint)num3 * 10uL;
			ulong num6 = (ulong)((long)(uint)(num3 >> 32) * 10L) + (num5 >> 32);
			num3 = (uint)num5 + (num6 << 32);
			num4 = (uint)(int)(num6 >> 32) + num4 * 10;
			if (num2 != 0)
			{
				num2 -= 48;
				num3 += num2;
				if (num3 < num2)
				{
					num4++;
				}
				num2 = *(++ptr);
			}
			num--;
		}
		if (num2 >= 53)
		{
			if (num2 == 53 && (num3 & 1) == 0L)
			{
				num2 = *(++ptr);
				int num7 = 20;
				while (num2 == 48 && num7 != 0)
				{
					num2 = *(++ptr);
					num7--;
				}
				if (num2 == 0 || num7 == 0)
				{
					goto IL_01a0;
				}
			}
			if (++num3 == 0L && ++num4 == 0)
			{
				num3 = 11068046444225730970uL;
				num4 = 429496729u;
				num++;
			}
		}
		goto IL_01a0;
		IL_01a0:
		if (num > 0)
		{
			return false;
		}
		if (num <= -29)
		{
			value = new decimal(0, 0, 0, sign, 28);
		}
		else
		{
			value = new decimal((int)num3, (int)(num3 >> 32), (int)num4, sign, (byte)(-num));
		}
		return true;
	}

	internal static double ParseDouble(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info)
	{
		NumberBuffer number = default(NumberBuffer);
		double value2 = 0.0;
		if (!TryStringToNumber(value, styles, ref number, info, parseDecimal: false))
		{
			ReadOnlySpan<char> span = value.Trim();
			if (span.EqualsOrdinal(info.PositiveInfinitySymbol))
			{
				return double.PositiveInfinity;
			}
			if (span.EqualsOrdinal(info.NegativeInfinitySymbol))
			{
				return double.NegativeInfinity;
			}
			if (span.EqualsOrdinal(info.NaNSymbol))
			{
				return double.NaN;
			}
			ThrowOverflowOrFormatException(overflow: false, null);
		}
		if (!NumberBufferToDouble(ref number, ref value2))
		{
			ThrowOverflowOrFormatException(overflow: true, "Value was either too large or too small for a Double.");
		}
		return value2;
	}

	internal static float ParseSingle(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info)
	{
		NumberBuffer number = default(NumberBuffer);
		double value2 = 0.0;
		if (!TryStringToNumber(value, styles, ref number, info, parseDecimal: false))
		{
			ReadOnlySpan<char> span = value.Trim();
			if (span.EqualsOrdinal(info.PositiveInfinitySymbol))
			{
				return float.PositiveInfinity;
			}
			if (span.EqualsOrdinal(info.NegativeInfinitySymbol))
			{
				return float.NegativeInfinity;
			}
			if (span.EqualsOrdinal(info.NaNSymbol))
			{
				return float.NaN;
			}
			ThrowOverflowOrFormatException(overflow: false, null);
		}
		if (!NumberBufferToDouble(ref number, ref value2))
		{
			ThrowOverflowOrFormatException(overflow: true, "Value was either too large or too small for a Single.");
		}
		float num = (float)value2;
		if (float.IsInfinity(num))
		{
			ThrowOverflowOrFormatException(overflow: true, "Value was either too large or too small for a Single.");
		}
		return num;
	}

	internal static bool TryParseDecimal(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out decimal result)
	{
		NumberBuffer number = default(NumberBuffer);
		result = 0m;
		if (!TryStringToNumber(value, styles, ref number, info, parseDecimal: true))
		{
			return false;
		}
		if (!NumberBufferToDecimal(ref number, ref result))
		{
			return false;
		}
		return true;
	}

	internal static bool TryParseDouble(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out double result)
	{
		NumberBuffer number = default(NumberBuffer);
		result = 0.0;
		if (!TryStringToNumber(value, styles, ref number, info, parseDecimal: false))
		{
			return false;
		}
		if (!NumberBufferToDouble(ref number, ref result))
		{
			return false;
		}
		return true;
	}

	internal static bool TryParseSingle(ReadOnlySpan<char> value, NumberStyles styles, NumberFormatInfo info, out float result)
	{
		NumberBuffer number = default(NumberBuffer);
		result = 0f;
		double value2 = 0.0;
		if (!TryStringToNumber(value, styles, ref number, info, parseDecimal: false))
		{
			return false;
		}
		if (!NumberBufferToDouble(ref number, ref value2))
		{
			return false;
		}
		float num = (float)value2;
		if (float.IsInfinity(num))
		{
			return false;
		}
		result = num;
		return true;
	}

	private unsafe static void StringToNumber(ReadOnlySpan<char> value, NumberStyles styles, ref NumberBuffer number, NumberFormatInfo info, bool parseDecimal)
	{
		fixed (char* reference = &MemoryMarshal.GetReference(value))
		{
			char* str = reference;
			if (!ParseNumber(ref str, str + value.Length, styles, ref number, info, parseDecimal) || (str - reference < value.Length && !TrailingZeros(value, (int)(str - reference))))
			{
				ThrowOverflowOrFormatException(overflow: false, null);
			}
		}
	}

	internal unsafe static bool TryStringToNumber(ReadOnlySpan<char> value, NumberStyles styles, ref NumberBuffer number, NumberFormatInfo info, bool parseDecimal)
	{
		fixed (char* reference = &MemoryMarshal.GetReference(value))
		{
			char* str = reference;
			if (!ParseNumber(ref str, str + value.Length, styles, ref number, info, parseDecimal) || (str - reference < value.Length && !TrailingZeros(value, (int)(str - reference))))
			{
				return false;
			}
		}
		return true;
	}

	private static bool TrailingZeros(ReadOnlySpan<char> value, int index)
	{
		for (int i = index; i < value.Length; i++)
		{
			if (value[i] != 0)
			{
				return false;
			}
		}
		return true;
	}

	private unsafe static char* MatchChars(char* p, char* pEnd, string value)
	{
		fixed (char* ptr = value)
		{
			char* ptr2 = ptr;
			if (*ptr2 != 0)
			{
				while (true)
				{
					char c = ((p < pEnd) ? (*p) : '\0');
					if (c != *ptr2 && (*ptr2 != '\u00a0' || c != ' '))
					{
						break;
					}
					p++;
					ptr2++;
					if (*ptr2 == '\0')
					{
						return p;
					}
				}
			}
		}
		return null;
	}

	private static bool IsWhite(int ch)
	{
		if (ch != 32)
		{
			return (uint)(ch - 9) <= 4u;
		}
		return true;
	}

	private static bool IsDigit(int ch)
	{
		return (uint)(ch - 48) <= 9u;
	}

	private static void ThrowOverflowOrFormatException(bool overflow, string overflowResourceKey)
	{
		throw overflow ? ((SystemException)new OverflowException(SR.GetResourceString(overflowResourceKey))) : ((SystemException)new FormatException("Input string was not in a correct format."));
	}

	private static bool NumberBufferToDouble(ref NumberBuffer number, ref double value)
	{
		double num = NumberToDouble(ref number);
		if (!double.IsFinite(num))
		{
			value = 0.0;
			return false;
		}
		if (num == 0.0)
		{
			num = 0.0;
		}
		value = num;
		return true;
	}

	private unsafe static uint DigitsToInt(char* p, int count)
	{
		char* ptr = p + count;
		uint num = (uint)(*p - 48);
		for (p++; p < ptr; p++)
		{
			num = 10 * num + *p - 48;
		}
		return num;
	}

	private static ulong Mul32x32To64(uint a, uint b)
	{
		return (ulong)a * (ulong)b;
	}

	private static ulong Mul64Lossy(ulong a, ulong b, ref int pexp)
	{
		ulong num = Mul32x32To64((uint)(a >> 32), (uint)(b >> 32)) + (Mul32x32To64((uint)(a >> 32), (uint)b) >> 32) + (Mul32x32To64((uint)a, (uint)(b >> 32)) >> 32);
		if ((num & 0x8000000000000000uL) == 0L)
		{
			num <<= 1;
			pexp--;
		}
		return num;
	}

	private static int abs(int value)
	{
		if (value < 0)
		{
			return -value;
		}
		return value;
	}

	private unsafe static double NumberToDouble(ref NumberBuffer number)
	{
		char* ptr = number.digits;
		int num = string.wcslen(ptr);
		int num2 = num;
		for (; *ptr == '0'; ptr++)
		{
			num2--;
		}
		if (num2 == 0)
		{
			return 0.0;
		}
		int num3 = Math.Min(num2, 9);
		num2 -= num3;
		ulong num4 = DigitsToInt(ptr, num3);
		if (num2 > 0)
		{
			num3 = Math.Min(num2, 9);
			num2 -= num3;
			uint b = (uint)(s_rgval64Power10[num3 - 1] >> 64 - s_rgexp64Power10[num3 - 1]);
			num4 = Mul32x32To64((uint)num4, b) + DigitsToInt(ptr + 9, num3);
		}
		int num5 = number.scale - (num - num2);
		int num6 = abs(num5);
		if (num6 >= 352)
		{
			ulong num7 = ((num5 > 0) ? 9218868437227405312uL : 0);
			if (number.sign)
			{
				num7 |= 0x8000000000000000uL;
			}
			return *(double*)(&num7);
		}
		int pexp = 64;
		if ((num4 & 0xFFFFFFFF00000000uL) == 0L)
		{
			num4 <<= 32;
			pexp -= 32;
		}
		if ((num4 & 0xFFFF000000000000uL) == 0L)
		{
			num4 <<= 16;
			pexp -= 16;
		}
		if ((num4 & 0xFF00000000000000uL) == 0L)
		{
			num4 <<= 8;
			pexp -= 8;
		}
		if ((num4 & 0xF000000000000000uL) == 0L)
		{
			num4 <<= 4;
			pexp -= 4;
		}
		if ((num4 & 0xC000000000000000uL) == 0L)
		{
			num4 <<= 2;
			pexp -= 2;
		}
		if ((num4 & 0x8000000000000000uL) == 0L)
		{
			num4 <<= 1;
			pexp--;
		}
		int num8 = num6 & 0xF;
		if (num8 != 0)
		{
			int num9 = s_rgexp64Power10[num8 - 1];
			pexp += ((num5 < 0) ? (-num9 + 1) : num9);
			ulong b2 = s_rgval64Power10[num8 + ((num5 < 0) ? 15 : 0) - 1];
			num4 = Mul64Lossy(num4, b2, ref pexp);
		}
		num8 = num6 >> 4;
		if (num8 != 0)
		{
			int num10 = s_rgexp64Power10By16[num8 - 1];
			pexp += ((num5 < 0) ? (-num10 + 1) : num10);
			ulong b3 = s_rgval64Power10By16[num8 + ((num5 < 0) ? 21 : 0) - 1];
			num4 = Mul64Lossy(num4, b3, ref pexp);
		}
		if (((int)num4 & 0x400) != 0)
		{
			ulong num11 = num4 + 1023 + (ulong)(((int)num4 >> 11) & 1);
			if (num11 < num4)
			{
				num11 = (num11 >> 1) | 0x8000000000000000uL;
				pexp++;
			}
			num4 = num11;
		}
		pexp += 1022;
		num4 = ((pexp <= 0) ? ((pexp == -52 && num4 >= 9223372036854775896uL) ? 1 : ((pexp > -52) ? (num4 >> -pexp + 11 + 1) : 0)) : ((pexp < 2047) ? ((ulong)((long)pexp << 52) + ((num4 >> 11) & 0xFFFFFFFFFFFFFL)) : 9218868437227405312uL));
		if (number.sign)
		{
			num4 |= 0x8000000000000000uL;
		}
		return *(double*)(&num4);
	}

	private unsafe static void DoubleToNumber(double value, int precision, ref NumberBuffer number)
	{
		number.precision = precision;
		if (!double.IsFinite(value))
		{
			number.scale = (double.IsNaN(value) ? int.MinValue : int.MaxValue);
			number.sign = double.IsNegative(value);
			*number.digits = '\0';
			return;
		}
		byte* ptr = stackalloc byte[50];
		char* digits = number.digits;
		number.scale = 0;
		number.sign = double.IsNegative(value);
		*digits = '\0';
		if (BitConverter.DoubleToInt64Bits(value) == 0L)
		{
			for (int i = 0; i < precision; i++)
			{
				digits[i] = '0';
			}
			digits[precision] = '\0';
			return;
		}
		byte* ptr2 = stackalloc byte[6];
		*ptr2 = 37;
		ptr2[1] = 46;
		ptr2[2] = 52;
		ptr2[3] = 48;
		ptr2[4] = 101;
		ptr2[5] = 0;
		int num = Interop.Sys.DoubleToString(value, ptr2, ptr, 50);
		int num2 = num - 1;
		while (ptr[num2] != 101 && num2 > 0)
		{
			num2--;
		}
		int j = num2 + 1;
		int num3 = 1;
		if (ptr[j] == 45)
		{
			num3 = -1;
			j++;
		}
		else if (ptr[j] == 43)
		{
			j++;
		}
		int num4 = 0;
		for (; j < num; j++)
		{
			num4 = num4 * 10 + (ptr[j] - 48);
		}
		num4 *= num3;
		if (num4 == 0)
		{
			number.scale = 1;
		}
		else
		{
			number.scale = num4 + 1;
		}
		j = 0;
		int num5 = 0;
		while (j < precision && num5 < num2)
		{
			if (ptr[num5] >= 48 && ptr[num5] <= 57)
			{
				digits[j] = (char)ptr[num5];
				j++;
			}
			num5++;
		}
		for (; j < precision; j++)
		{
			digits[j] = '0';
		}
		digits[j] = '\0';
		if (num5 < num2 && ptr[num5] >= 53)
		{
			j = precision - 1;
			while (digits[j] == '9' && j > 0)
			{
				digits[j] = '0';
				j--;
			}
			if (j == 0 && digits[j] == '9')
			{
				digits[j] = '1';
				number.scale++;
			}
			else
			{
				char* num6 = digits + j;
				*num6 = (char)(*num6 + 1);
			}
		}
	}
}
