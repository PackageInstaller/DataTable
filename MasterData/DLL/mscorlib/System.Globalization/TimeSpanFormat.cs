using System.Text;

namespace System.Globalization;

internal static class TimeSpanFormat
{
	internal enum Pattern
	{
		None,
		Minimum,
		Full
	}

	internal struct FormatLiterals
	{
		internal string AppCompatLiteral;

		internal int dd;

		internal int hh;

		internal int mm;

		internal int ss;

		internal int ff;

		private string[] _literals;

		internal string Start => _literals[0];

		internal string DayHourSep => _literals[1];

		internal string HourMinuteSep => _literals[2];

		internal string MinuteSecondSep => _literals[3];

		internal string SecondFractionSep => _literals[4];

		internal string End => _literals[5];

		internal static FormatLiterals InitInvariant(bool isNegative)
		{
			FormatLiterals result = new FormatLiterals
			{
				_literals = new string[6]
			};
			result._literals[0] = (isNegative ? "-" : string.Empty);
			result._literals[1] = ".";
			result._literals[2] = ":";
			result._literals[3] = ":";
			result._literals[4] = ".";
			result._literals[5] = string.Empty;
			result.AppCompatLiteral = ":.";
			result.dd = 2;
			result.hh = 2;
			result.mm = 2;
			result.ss = 2;
			result.ff = 7;
			return result;
		}

		internal void Init(ReadOnlySpan<char> format, bool useInvariantFieldLengths)
		{
			dd = (hh = (mm = (ss = (ff = 0))));
			_literals = new string[6];
			for (int i = 0; i < _literals.Length; i++)
			{
				_literals[i] = string.Empty;
			}
			StringBuilder stringBuilder = StringBuilderCache.Acquire();
			bool flag = false;
			char c = '\'';
			int num = 0;
			for (int j = 0; j < format.Length; j++)
			{
				switch (format[j])
				{
				case '"':
				case '\'':
					if (flag && c == format[j])
					{
						if (num < 0 || num > 5)
						{
							return;
						}
						_literals[num] = stringBuilder.ToString();
						stringBuilder.Length = 0;
						flag = false;
					}
					else if (!flag)
					{
						c = format[j];
						flag = true;
					}
					continue;
				case '\\':
					if (!flag)
					{
						j++;
						continue;
					}
					break;
				case 'd':
					if (!flag)
					{
						num = 1;
						dd++;
					}
					continue;
				case 'h':
					if (!flag)
					{
						num = 2;
						hh++;
					}
					continue;
				case 'm':
					if (!flag)
					{
						num = 3;
						mm++;
					}
					continue;
				case 's':
					if (!flag)
					{
						num = 4;
						ss++;
					}
					continue;
				case 'F':
				case 'f':
					if (!flag)
					{
						num = 5;
						ff++;
					}
					continue;
				}
				stringBuilder.Append(format[j]);
			}
			AppCompatLiteral = MinuteSecondSep + SecondFractionSep;
			if (useInvariantFieldLengths)
			{
				dd = 2;
				hh = 2;
				mm = 2;
				ss = 2;
				ff = 7;
			}
			else
			{
				if (dd < 1 || dd > 2)
				{
					dd = 2;
				}
				if (hh < 1 || hh > 2)
				{
					hh = 2;
				}
				if (mm < 1 || mm > 2)
				{
					mm = 2;
				}
				if (ss < 1 || ss > 2)
				{
					ss = 2;
				}
				if (ff < 1 || ff > 7)
				{
					ff = 7;
				}
			}
			StringBuilderCache.Release(stringBuilder);
		}
	}

	internal static readonly FormatLiterals PositiveInvariantFormatLiterals = FormatLiterals.InitInvariant(isNegative: false);

	internal static readonly FormatLiterals NegativeInvariantFormatLiterals = FormatLiterals.InitInvariant(isNegative: true);

	private unsafe static void AppendNonNegativeInt32(StringBuilder sb, int n, int digits)
	{
		uint num = (uint)n;
		char* ptr = stackalloc char[10];
		int num2 = 0;
		do
		{
			uint num3 = num / 10;
			ptr[num2++] = (char)(num - num3 * 10 + 48);
			num = num3;
		}
		while (num != 0);
		for (int num4 = digits - num2; num4 > 0; num4--)
		{
			sb.Append('0');
		}
		for (int num5 = num2 - 1; num5 >= 0; num5--)
		{
			sb.Append(ptr[num5]);
		}
	}

	internal static string Format(TimeSpan value, string format, IFormatProvider formatProvider)
	{
		return StringBuilderCache.GetStringAndRelease(FormatToBuilder(value, format, formatProvider));
	}

	internal static bool TryFormat(TimeSpan value, Span<char> destination, out int charsWritten, ReadOnlySpan<char> format, IFormatProvider formatProvider)
	{
		StringBuilder stringBuilder = FormatToBuilder(value, format, formatProvider);
		if (stringBuilder.Length <= destination.Length)
		{
			charsWritten = stringBuilder.Length;
			stringBuilder.CopyTo(0, destination, stringBuilder.Length);
			StringBuilderCache.Release(stringBuilder);
			return true;
		}
		StringBuilderCache.Release(stringBuilder);
		charsWritten = 0;
		return false;
	}

	private static StringBuilder FormatToBuilder(TimeSpan value, ReadOnlySpan<char> format, IFormatProvider formatProvider)
	{
		if (format.Length == 0)
		{
			format = "c";
		}
		if (format.Length == 1)
		{
			char c = format[0];
			switch (c)
			{
			case 'T':
			case 'c':
			case 't':
				return FormatStandard(value, isInvariant: true, format, Pattern.Minimum);
			case 'G':
			case 'g':
			{
				DateTimeFormatInfo instance = DateTimeFormatInfo.GetInstance(formatProvider);
				return FormatStandard(value, isInvariant: false, (value.Ticks < 0) ? instance.FullTimeSpanNegativePattern : instance.FullTimeSpanPositivePattern, (c == 'g') ? Pattern.Minimum : Pattern.Full);
			}
			default:
				throw new FormatException("Input string was not in a correct format.");
			}
		}
		return FormatCustomized(value, format, DateTimeFormatInfo.GetInstance(formatProvider), null);
	}

	private static StringBuilder FormatStandard(TimeSpan value, bool isInvariant, ReadOnlySpan<char> format, Pattern pattern)
	{
		StringBuilder stringBuilder = StringBuilderCache.Acquire();
		int num = (int)(value.Ticks / 864000000000L);
		long num2 = value.Ticks % 864000000000L;
		if (value.Ticks < 0)
		{
			num = -num;
			num2 = -num2;
		}
		int n = (int)(num2 / 36000000000L % 24);
		int n2 = (int)(num2 / 600000000 % 60);
		int n3 = (int)(num2 / 10000000 % 60);
		int num3 = (int)(num2 % 10000000);
		FormatLiterals formatLiterals;
		if (isInvariant)
		{
			formatLiterals = ((value.Ticks < 0) ? NegativeInvariantFormatLiterals : PositiveInvariantFormatLiterals);
		}
		else
		{
			formatLiterals = default(FormatLiterals);
			formatLiterals.Init(format, pattern == Pattern.Full);
		}
		if (num3 != 0)
		{
			num3 = (int)(num3 / TimeSpanParse.Pow10(7 - formatLiterals.ff));
		}
		stringBuilder.Append(formatLiterals.Start);
		if (pattern == Pattern.Full || num != 0)
		{
			stringBuilder.Append(num);
			stringBuilder.Append(formatLiterals.DayHourSep);
		}
		AppendNonNegativeInt32(stringBuilder, n, formatLiterals.hh);
		stringBuilder.Append(formatLiterals.HourMinuteSep);
		AppendNonNegativeInt32(stringBuilder, n2, formatLiterals.mm);
		stringBuilder.Append(formatLiterals.MinuteSecondSep);
		AppendNonNegativeInt32(stringBuilder, n3, formatLiterals.ss);
		if (!isInvariant && pattern == Pattern.Minimum)
		{
			int num4 = formatLiterals.ff;
			while (num4 > 0 && num3 % 10 == 0)
			{
				num3 /= 10;
				num4--;
			}
			if (num4 > 0)
			{
				stringBuilder.Append(formatLiterals.SecondFractionSep);
				stringBuilder.Append(num3.ToString(DateTimeFormat.fixedNumberFormats[num4 - 1], CultureInfo.InvariantCulture));
			}
		}
		else if (pattern == Pattern.Full || num3 != 0)
		{
			stringBuilder.Append(formatLiterals.SecondFractionSep);
			AppendNonNegativeInt32(stringBuilder, num3, formatLiterals.ff);
		}
		stringBuilder.Append(formatLiterals.End);
		return stringBuilder;
	}

	private unsafe static StringBuilder FormatCustomized(TimeSpan value, ReadOnlySpan<char> format, DateTimeFormatInfo dtfi, StringBuilder result)
	{
		bool flag = false;
		if (result == null)
		{
			result = StringBuilderCache.Acquire();
			flag = true;
		}
		int num = (int)(value.Ticks / 864000000000L);
		long num2 = value.Ticks % 864000000000L;
		if (value.Ticks < 0)
		{
			num = -num;
			num2 = -num2;
		}
		int value2 = (int)(num2 / 36000000000L % 24);
		int value3 = (int)(num2 / 600000000 % 60);
		int value4 = (int)(num2 / 10000000 % 60);
		int num3 = (int)(num2 % 10000000);
		long num4 = 0L;
		int num6;
		for (int i = 0; i < format.Length; i += num6)
		{
			char c = format[i];
			switch (c)
			{
			case 'h':
				num6 = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (num6 <= 2)
				{
					DateTimeFormat.FormatDigits(result, value2, num6);
					continue;
				}
				break;
			case 'm':
				num6 = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (num6 <= 2)
				{
					DateTimeFormat.FormatDigits(result, value3, num6);
					continue;
				}
				break;
			case 's':
				num6 = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (num6 <= 2)
				{
					DateTimeFormat.FormatDigits(result, value4, num6);
					continue;
				}
				break;
			case 'f':
				num6 = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (num6 <= 7)
				{
					num4 = num3;
					result.Append((num4 / TimeSpanParse.Pow10(7 - num6)).ToString(DateTimeFormat.fixedNumberFormats[num6 - 1], CultureInfo.InvariantCulture));
					continue;
				}
				break;
			case 'F':
				num6 = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (num6 <= 7)
				{
					num4 = num3;
					num4 /= TimeSpanParse.Pow10(7 - num6);
					int num7 = num6;
					while (num7 > 0 && num4 % 10 == 0L)
					{
						num4 /= 10;
						num7--;
					}
					if (num7 > 0)
					{
						result.Append(num4.ToString(DateTimeFormat.fixedNumberFormats[num7 - 1], CultureInfo.InvariantCulture));
					}
					continue;
				}
				break;
			case 'd':
				num6 = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (num6 <= 8)
				{
					DateTimeFormat.FormatDigits(result, num, num6, overrideLengthLimit: true);
					continue;
				}
				break;
			case '"':
			case '\'':
				num6 = DateTimeFormat.ParseQuoteString(format, i, result);
				continue;
			case '%':
			{
				int num5 = DateTimeFormat.ParseNextChar(format, i);
				if (num5 >= 0 && num5 != 37)
				{
					char c2 = (char)num5;
					FormatCustomized(format: new ReadOnlySpan<char>(&c2, 1), value: value, dtfi: dtfi, result: result);
					num6 = 2;
					continue;
				}
				break;
			}
			case '\\':
			{
				int num5 = DateTimeFormat.ParseNextChar(format, i);
				if (num5 >= 0)
				{
					result.Append((char)num5);
					num6 = 2;
					continue;
				}
				break;
			}
			}
			if (flag)
			{
				StringBuilderCache.Release(result);
			}
			throw new FormatException("Input string was not in a correct format.");
		}
		return result;
	}
}
