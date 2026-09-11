using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace System;

internal static class DateTimeFormat
{
	internal static readonly TimeSpan NullOffset = TimeSpan.MinValue;

	internal static char[] allStandardFormats = new char[19]
	{
		'c', '\0', '|', '\0', 'w', '\0', '{', '\0', 'ò', '\0',
		'k', '\0', 'o', '\0', 'Å', '\0', '0', '\0', '\u0001'
	};

	internal static readonly DateTimeFormatInfo InvariantFormatInfo = CultureInfo.InvariantCulture.DateTimeFormat;

	internal static readonly string[] InvariantAbbreviatedMonthNames = InvariantFormatInfo.AbbreviatedMonthNames;

	internal static readonly string[] InvariantAbbreviatedDayNames = InvariantFormatInfo.AbbreviatedDayNames;

	internal static string[] fixedNumberFormats = new string[7] { "0", "00", "000", "0000", "00000", "000000", "0000000" };

	internal static void FormatDigits(StringBuilder outputBuffer, int value, int len)
	{
		FormatDigits(outputBuffer, value, len, overrideLengthLimit: false);
	}

	internal unsafe static void FormatDigits(StringBuilder outputBuffer, int value, int len, bool overrideLengthLimit)
	{
		if (!overrideLengthLimit && len > 2)
		{
			len = 2;
		}
		char* ptr = stackalloc char[16];
		char* ptr2 = ptr + 16;
		int num = value;
		do
		{
			*(--ptr2) = (char)(num % 10 + 48);
			num /= 10;
		}
		while (num != 0 && ptr2 > ptr);
		int i;
		for (i = (int)(ptr + 16 - ptr2); i < len; i++)
		{
			if (ptr2 <= ptr)
			{
				break;
			}
			*(--ptr2) = '0';
		}
		outputBuffer.Append(ptr2, i);
	}

	private static void HebrewFormatDigits(StringBuilder outputBuffer, int digits)
	{
		outputBuffer.Append(HebrewNumber.ToString(digits));
	}

	internal static int ParseRepeatPattern(ReadOnlySpan<char> format, int pos, char patternChar)
	{
		int length = format.Length;
		int i;
		for (i = pos + 1; i < length && format[i] == patternChar; i++)
		{
		}
		return i - pos;
	}

	private static string FormatDayOfWeek(int dayOfWeek, int repeat, DateTimeFormatInfo dtfi)
	{
		if (repeat == 3)
		{
			return dtfi.GetAbbreviatedDayName((DayOfWeek)dayOfWeek);
		}
		return dtfi.GetDayName((DayOfWeek)dayOfWeek);
	}

	private static string FormatMonth(int month, int repeatCount, DateTimeFormatInfo dtfi)
	{
		if (repeatCount == 3)
		{
			return dtfi.GetAbbreviatedMonthName(month);
		}
		return dtfi.GetMonthName(month);
	}

	private static string FormatHebrewMonthName(DateTime time, int month, int repeatCount, DateTimeFormatInfo dtfi)
	{
		if (dtfi.Calendar.IsLeapYear(dtfi.Calendar.GetYear(time)))
		{
			return dtfi.internalGetMonthName(month, MonthNameStyles.LeapYear, repeatCount == 3);
		}
		if (month >= 7)
		{
			month++;
		}
		if (repeatCount == 3)
		{
			return dtfi.GetAbbreviatedMonthName(month);
		}
		return dtfi.GetMonthName(month);
	}

	internal static int ParseQuoteString(ReadOnlySpan<char> format, int pos, StringBuilder result)
	{
		int length = format.Length;
		int num = pos;
		char c = format[pos++];
		bool flag = false;
		while (pos < length)
		{
			char c2 = format[pos++];
			if (c2 == c)
			{
				flag = true;
				break;
			}
			if (c2 == '\\')
			{
				if (pos >= length)
				{
					throw new FormatException("Input string was not in a correct format.");
				}
				result.Append(format[pos++]);
			}
			else
			{
				result.Append(c2);
			}
		}
		if (!flag)
		{
			throw new FormatException(string.Format(CultureInfo.CurrentCulture, "Cannot find a matching quote character for the character '{0}'.", c));
		}
		return pos - num;
	}

	internal static int ParseNextChar(ReadOnlySpan<char> format, int pos)
	{
		if (pos >= format.Length - 1)
		{
			return -1;
		}
		return format[pos + 1];
	}

	private static bool IsUseGenitiveForm(ReadOnlySpan<char> format, int index, int tokenLen, char patternToMatch)
	{
		int num = 0;
		int num2 = index - 1;
		while (num2 >= 0 && format[num2] != patternToMatch)
		{
			num2--;
		}
		if (num2 >= 0)
		{
			while (--num2 >= 0 && format[num2] == patternToMatch)
			{
				num++;
			}
			if (num <= 1)
			{
				return true;
			}
		}
		for (num2 = index + tokenLen; num2 < format.Length && format[num2] != patternToMatch; num2++)
		{
		}
		if (num2 < format.Length)
		{
			num = 0;
			while (++num2 < format.Length && format[num2] == patternToMatch)
			{
				num++;
			}
			if (num <= 1)
			{
				return true;
			}
		}
		return false;
	}

	private static StringBuilder FormatCustomized(DateTime dateTime, ReadOnlySpan<char> format, DateTimeFormatInfo dtfi, TimeSpan offset, StringBuilder result)
	{
		Calendar calendar = dtfi.Calendar;
		bool flag = false;
		if (result == null)
		{
			flag = true;
			result = StringBuilderCache.Acquire();
		}
		bool flag2 = !GlobalizationMode.Invariant && (ushort)calendar.ID == 8;
		bool flag3 = !GlobalizationMode.Invariant && (ushort)calendar.ID == 3;
		bool timeOnly = true;
		int num;
		for (int i = 0; i < format.Length; i += num)
		{
			char c = format[i];
			switch (c)
			{
			case 'g':
				num = ParseRepeatPattern(format, i, c);
				result.Append(dtfi.GetEraName(calendar.GetEra(dateTime)));
				break;
			case 'h':
			{
				num = ParseRepeatPattern(format, i, c);
				int num5 = dateTime.Hour % 12;
				if (num5 == 0)
				{
					num5 = 12;
				}
				FormatDigits(result, num5, num);
				break;
			}
			case 'H':
				num = ParseRepeatPattern(format, i, c);
				FormatDigits(result, dateTime.Hour, num);
				break;
			case 'm':
				num = ParseRepeatPattern(format, i, c);
				FormatDigits(result, dateTime.Minute, num);
				break;
			case 's':
				num = ParseRepeatPattern(format, i, c);
				FormatDigits(result, dateTime.Second, num);
				break;
			case 'F':
			case 'f':
				num = ParseRepeatPattern(format, i, c);
				if (num <= 7)
				{
					long num3 = dateTime.Ticks % 10000000;
					num3 /= (long)Math.Pow(10.0, 7 - num);
					if (c == 'f')
					{
						result.Append(((int)num3).ToString(fixedNumberFormats[num - 1], CultureInfo.InvariantCulture));
						break;
					}
					int num4 = num;
					while (num4 > 0 && num3 % 10 == 0L)
					{
						num3 /= 10;
						num4--;
					}
					if (num4 > 0)
					{
						result.Append(((int)num3).ToString(fixedNumberFormats[num4 - 1], CultureInfo.InvariantCulture));
					}
					else if (result.Length > 0 && result[result.Length - 1] == '.')
					{
						result.Remove(result.Length - 1, 1);
					}
					break;
				}
				if (flag)
				{
					StringBuilderCache.Release(result);
				}
				throw new FormatException("Input string was not in a correct format.");
			case 't':
				num = ParseRepeatPattern(format, i, c);
				if (num == 1)
				{
					if (dateTime.Hour < 12)
					{
						if (dtfi.AMDesignator.Length >= 1)
						{
							result.Append(dtfi.AMDesignator[0]);
						}
					}
					else if (dtfi.PMDesignator.Length >= 1)
					{
						result.Append(dtfi.PMDesignator[0]);
					}
				}
				else
				{
					result.Append((dateTime.Hour < 12) ? dtfi.AMDesignator : dtfi.PMDesignator);
				}
				break;
			case 'd':
				num = ParseRepeatPattern(format, i, c);
				if (num <= 2)
				{
					int dayOfMonth = calendar.GetDayOfMonth(dateTime);
					if (flag2 && !GlobalizationMode.Invariant)
					{
						HebrewFormatDigits(result, dayOfMonth);
					}
					else
					{
						FormatDigits(result, dayOfMonth, num);
					}
				}
				else
				{
					int dayOfWeek = (int)calendar.GetDayOfWeek(dateTime);
					result.Append(FormatDayOfWeek(dayOfWeek, num, dtfi));
				}
				timeOnly = false;
				break;
			case 'M':
			{
				num = ParseRepeatPattern(format, i, c);
				int month = calendar.GetMonth(dateTime);
				if (num <= 2)
				{
					if (flag2 && !GlobalizationMode.Invariant)
					{
						HebrewFormatDigits(result, month);
					}
					else
					{
						FormatDigits(result, month, num);
					}
				}
				else if (flag2 && !GlobalizationMode.Invariant)
				{
					result.Append(FormatHebrewMonthName(dateTime, month, num, dtfi));
				}
				else if ((dtfi.FormatFlags & DateTimeFormatFlags.UseGenitiveMonth) != DateTimeFormatFlags.None && num >= 4)
				{
					result.Append(dtfi.internalGetMonthName(month, IsUseGenitiveForm(format, i, num, 'd') ? MonthNameStyles.Genitive : MonthNameStyles.Regular, abbreviated: false));
				}
				else
				{
					result.Append(FormatMonth(month, num, dtfi));
				}
				timeOnly = false;
				break;
			}
			case 'y':
			{
				int year = calendar.GetYear(dateTime);
				num = ParseRepeatPattern(format, i, c);
				if (flag3 && !AppContextSwitches.FormatJapaneseFirstYearAsANumber && year == 1 && i + num < format.Length - 1 && format[i + num] == '\'' && format[i + num + 1] == "年"[0])
				{
					result.Append("元"[0]);
				}
				else if (dtfi.HasForceTwoDigitYears)
				{
					FormatDigits(result, year, (num <= 2) ? num : 2);
				}
				else if (flag2 && !GlobalizationMode.Invariant)
				{
					HebrewFormatDigits(result, year);
				}
				else if (num <= 2)
				{
					FormatDigits(result, year % 100, num);
				}
				else
				{
					string text = "D" + num;
					result.Append(year.ToString(text, CultureInfo.InvariantCulture));
				}
				timeOnly = false;
				break;
			}
			case 'z':
				num = ParseRepeatPattern(format, i, c);
				FormatCustomizedTimeZone(dateTime, offset, format, num, timeOnly, result);
				break;
			case 'K':
				num = 1;
				FormatCustomizedRoundripTimeZone(dateTime, offset, result);
				break;
			case ':':
				result.Append(dtfi.TimeSeparator);
				num = 1;
				break;
			case '/':
				result.Append(dtfi.DateSeparator);
				num = 1;
				break;
			case '"':
			case '\'':
				num = ParseQuoteString(format, i, result);
				break;
			case '%':
			{
				int num2 = ParseNextChar(format, i);
				if (num2 >= 0 && num2 != 37)
				{
					char reference = (char)num2;
					FormatCustomized(dateTime, MemoryMarshal.CreateReadOnlySpan(ref reference, 1), dtfi, offset, result);
					num = 2;
					break;
				}
				if (flag)
				{
					StringBuilderCache.Release(result);
				}
				throw new FormatException("Input string was not in a correct format.");
			}
			case '\\':
			{
				int num2 = ParseNextChar(format, i);
				if (num2 >= 0)
				{
					result.Append((char)num2);
					num = 2;
					break;
				}
				if (flag)
				{
					StringBuilderCache.Release(result);
				}
				throw new FormatException("Input string was not in a correct format.");
			}
			default:
				result.Append(c);
				num = 1;
				break;
			}
		}
		return result;
	}

	private static void FormatCustomizedTimeZone(DateTime dateTime, TimeSpan offset, ReadOnlySpan<char> format, int tokenLen, bool timeOnly, StringBuilder result)
	{
		if (offset == NullOffset)
		{
			offset = ((timeOnly && dateTime.Ticks < 864000000000L) ? TimeZoneInfo.GetLocalUtcOffset(DateTime.Now, TimeZoneInfoOptions.NoThrowOnInvalidTime) : ((dateTime.Kind != DateTimeKind.Utc) ? TimeZoneInfo.GetLocalUtcOffset(dateTime, TimeZoneInfoOptions.NoThrowOnInvalidTime) : TimeSpan.Zero));
		}
		if (offset >= TimeSpan.Zero)
		{
			result.Append('+');
		}
		else
		{
			result.Append('-');
			offset = offset.Negate();
		}
		if (tokenLen <= 1)
		{
			result.AppendFormat(CultureInfo.InvariantCulture, "{0:0}", offset.Hours);
			return;
		}
		result.AppendFormat(CultureInfo.InvariantCulture, "{0:00}", offset.Hours);
		if (tokenLen >= 3)
		{
			result.AppendFormat(CultureInfo.InvariantCulture, ":{0:00}", offset.Minutes);
		}
	}

	private static void FormatCustomizedRoundripTimeZone(DateTime dateTime, TimeSpan offset, StringBuilder result)
	{
		if (offset == NullOffset)
		{
			switch (dateTime.Kind)
			{
			case DateTimeKind.Local:
				break;
			case DateTimeKind.Utc:
				result.Append("Z");
				return;
			default:
				return;
			}
			offset = TimeZoneInfo.GetLocalUtcOffset(dateTime, TimeZoneInfoOptions.NoThrowOnInvalidTime);
		}
		if (offset >= TimeSpan.Zero)
		{
			result.Append('+');
		}
		else
		{
			result.Append('-');
			offset = offset.Negate();
		}
		Append2DigitNumber(result, offset.Hours);
		result.Append(':');
		Append2DigitNumber(result, offset.Minutes);
	}

	private static void Append2DigitNumber(StringBuilder result, int val)
	{
		result.Append((char)(48 + val / 10));
		result.Append((char)(48 + val % 10));
	}

	internal static string GetRealFormat(ReadOnlySpan<char> format, DateTimeFormatInfo dtfi)
	{
		string text = null;
		switch (format[0])
		{
		case 'd':
			return dtfi.ShortDatePattern;
		case 'D':
			return dtfi.LongDatePattern;
		case 'f':
			return dtfi.LongDatePattern + " " + dtfi.ShortTimePattern;
		case 'F':
			return dtfi.FullDateTimePattern;
		case 'g':
			return dtfi.GeneralShortTimePattern;
		case 'G':
			return dtfi.GeneralLongTimePattern;
		case 'M':
		case 'm':
			return dtfi.MonthDayPattern;
		case 'O':
		case 'o':
			return "yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffffK";
		case 'R':
		case 'r':
			return dtfi.RFC1123Pattern;
		case 's':
			return dtfi.SortableDateTimePattern;
		case 't':
			return dtfi.ShortTimePattern;
		case 'T':
			return dtfi.LongTimePattern;
		case 'u':
			return dtfi.UniversalSortableDateTimePattern;
		case 'U':
			return dtfi.FullDateTimePattern;
		case 'Y':
		case 'y':
			return dtfi.YearMonthPattern;
		default:
			throw new FormatException("Input string was not in a correct format.");
		}
	}

	private static string ExpandPredefinedFormat(ReadOnlySpan<char> format, ref DateTime dateTime, ref DateTimeFormatInfo dtfi, ref TimeSpan offset)
	{
		switch (format[0])
		{
		case 'O':
		case 'o':
			dtfi = DateTimeFormatInfo.InvariantInfo;
			break;
		case 'R':
		case 'r':
			if (offset != NullOffset)
			{
				dateTime -= offset;
			}
			else if (dateTime.Kind == DateTimeKind.Local)
			{
				InvalidFormatForLocal(format, dateTime);
			}
			dtfi = DateTimeFormatInfo.InvariantInfo;
			break;
		case 's':
			dtfi = DateTimeFormatInfo.InvariantInfo;
			break;
		case 'u':
			if (offset != NullOffset)
			{
				dateTime -= offset;
			}
			else if (dateTime.Kind == DateTimeKind.Local)
			{
				InvalidFormatForLocal(format, dateTime);
			}
			dtfi = DateTimeFormatInfo.InvariantInfo;
			break;
		case 'U':
			if (offset != NullOffset)
			{
				throw new FormatException("Input string was not in a correct format.");
			}
			dtfi = (DateTimeFormatInfo)dtfi.Clone();
			if (dtfi.Calendar.GetType() != typeof(GregorianCalendar))
			{
				dtfi.Calendar = GregorianCalendar.GetDefaultInstance();
			}
			dateTime = dateTime.ToUniversalTime();
			break;
		}
		return GetRealFormat(format, dtfi);
	}

	internal static string Format(DateTime dateTime, string format, IFormatProvider provider)
	{
		return Format(dateTime, format, provider, NullOffset);
	}

	internal static string Format(DateTime dateTime, string format, IFormatProvider provider, TimeSpan offset)
	{
		if (format != null && format.Length == 1)
		{
			switch (format[0])
			{
			case 'O':
			case 'o':
			{
				Span<char> destination = stackalloc char[33];
				TryFormatO(dateTime, offset, destination, out var charsWritten2);
				return destination.Slice(0, charsWritten2).ToString();
			}
			case 'R':
			case 'r':
			{
				string text = string.FastAllocateString(29);
				TryFormatR(dateTime, offset, new Span<char>(ref text.GetRawStringData(), text.Length), out var _);
				return text;
			}
			}
		}
		DateTimeFormatInfo instance = DateTimeFormatInfo.GetInstance(provider);
		return StringBuilderCache.GetStringAndRelease(FormatStringBuilder(dateTime, format, instance, offset));
	}

	internal static bool TryFormat(DateTime dateTime, Span<char> destination, out int charsWritten, ReadOnlySpan<char> format, IFormatProvider provider)
	{
		return TryFormat(dateTime, destination, out charsWritten, format, provider, NullOffset);
	}

	internal static bool TryFormat(DateTime dateTime, Span<char> destination, out int charsWritten, ReadOnlySpan<char> format, IFormatProvider provider, TimeSpan offset)
	{
		if (format.Length == 1)
		{
			switch (format[0])
			{
			case 'O':
			case 'o':
				return TryFormatO(dateTime, offset, destination, out charsWritten);
			case 'R':
			case 'r':
				return TryFormatR(dateTime, offset, destination, out charsWritten);
			}
		}
		DateTimeFormatInfo instance = DateTimeFormatInfo.GetInstance(provider);
		StringBuilder stringBuilder = FormatStringBuilder(dateTime, format, instance, offset);
		bool num = stringBuilder.Length <= destination.Length;
		if (num)
		{
			stringBuilder.CopyTo(0, destination, stringBuilder.Length);
			charsWritten = stringBuilder.Length;
		}
		else
		{
			charsWritten = 0;
		}
		StringBuilderCache.Release(stringBuilder);
		return num;
	}

	private static StringBuilder FormatStringBuilder(DateTime dateTime, ReadOnlySpan<char> format, DateTimeFormatInfo dtfi, TimeSpan offset)
	{
		if (format.Length == 0)
		{
			bool flag = false;
			if (dateTime.Ticks < 864000000000L)
			{
				switch ((CalendarId)(ushort)dtfi.Calendar.ID)
				{
				case CalendarId.JAPAN:
				case CalendarId.TAIWAN:
				case CalendarId.HIJRI:
				case CalendarId.HEBREW:
				case CalendarId.JULIAN:
				case CalendarId.PERSIAN:
				case CalendarId.UMALQURA:
					flag = true;
					dtfi = DateTimeFormatInfo.InvariantInfo;
					break;
				}
			}
			format = ((!(offset == NullOffset)) ? ((ReadOnlySpan<char>)(flag ? "yyyy'-'MM'-'ddTHH':'mm':'ss zzz" : dtfi.DateTimeOffsetPattern)) : ((ReadOnlySpan<char>)(flag ? "s" : "G")));
		}
		if (format.Length == 1)
		{
			format = ExpandPredefinedFormat(format, ref dateTime, ref dtfi, ref offset);
		}
		return FormatCustomized(dateTime, format, dtfi, offset, null);
	}

	private static bool TryFormatO(DateTime dateTime, TimeSpan offset, Span<char> destination, out int charsWritten)
	{
		int num = 27;
		DateTimeKind dateTimeKind = DateTimeKind.Local;
		if (offset == NullOffset)
		{
			dateTimeKind = dateTime.Kind;
			switch (dateTimeKind)
			{
			case DateTimeKind.Local:
				offset = TimeZoneInfo.Local.GetUtcOffset(dateTime);
				num += 6;
				break;
			case DateTimeKind.Utc:
				num++;
				break;
			}
		}
		else
		{
			num += 6;
		}
		if (destination.Length < num)
		{
			charsWritten = 0;
			return false;
		}
		charsWritten = num;
		_ = ref destination[26];
		WriteFourDecimalDigits((uint)dateTime.Year, destination);
		destination[4] = '-';
		WriteTwoDecimalDigits((uint)dateTime.Month, destination, 5);
		destination[7] = '-';
		WriteTwoDecimalDigits((uint)dateTime.Day, destination, 8);
		destination[10] = 'T';
		WriteTwoDecimalDigits((uint)dateTime.Hour, destination, 11);
		destination[13] = ':';
		WriteTwoDecimalDigits((uint)dateTime.Minute, destination, 14);
		destination[16] = ':';
		WriteTwoDecimalDigits((uint)dateTime.Second, destination, 17);
		destination[19] = '.';
		WriteDigits((uint)((ulong)dateTime.Ticks % 10000000uL), destination.Slice(20, 7));
		switch (dateTimeKind)
		{
		case DateTimeKind.Local:
		{
			char c;
			if (offset < default(TimeSpan))
			{
				c = '-';
				offset = TimeSpan.FromTicks(-offset.Ticks);
			}
			else
			{
				c = '+';
			}
			WriteTwoDecimalDigits((uint)offset.Minutes, destination, 31);
			destination[30] = ':';
			WriteTwoDecimalDigits((uint)offset.Hours, destination, 28);
			destination[27] = c;
			break;
		}
		case DateTimeKind.Utc:
			destination[27] = 'Z';
			break;
		}
		return true;
	}

	private static bool TryFormatR(DateTime dateTime, TimeSpan offset, Span<char> destination, out int charsWritten)
	{
		if (28u >= (uint)destination.Length)
		{
			charsWritten = 0;
			return false;
		}
		if (offset != NullOffset)
		{
			dateTime -= offset;
		}
		dateTime.GetDatePart(out var year, out var month, out var day);
		string text = InvariantAbbreviatedDayNames[(int)dateTime.DayOfWeek];
		string text2 = InvariantAbbreviatedMonthNames[month - 1];
		destination[0] = text[0];
		destination[1] = text[1];
		destination[2] = text[2];
		destination[3] = ',';
		destination[4] = ' ';
		WriteTwoDecimalDigits((uint)day, destination, 5);
		destination[7] = ' ';
		destination[8] = text2[0];
		destination[9] = text2[1];
		destination[10] = text2[2];
		destination[11] = ' ';
		WriteFourDecimalDigits((uint)year, destination, 12);
		destination[16] = ' ';
		WriteTwoDecimalDigits((uint)dateTime.Hour, destination, 17);
		destination[19] = ':';
		WriteTwoDecimalDigits((uint)dateTime.Minute, destination, 20);
		destination[22] = ':';
		WriteTwoDecimalDigits((uint)dateTime.Second, destination, 23);
		destination[25] = ' ';
		destination[26] = 'G';
		destination[27] = 'M';
		destination[28] = 'T';
		charsWritten = 29;
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void WriteTwoDecimalDigits(uint value, Span<char> destination, int offset)
	{
		uint num = 48 + value;
		value /= 10;
		destination[offset + 1] = (char)(num - value * 10);
		destination[offset] = (char)(48 + value);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void WriteFourDecimalDigits(uint value, Span<char> buffer, int startingIndex = 0)
	{
		uint num = 48 + value;
		value /= 10;
		buffer[startingIndex + 3] = (char)(num - value * 10);
		num = 48 + value;
		value /= 10;
		buffer[startingIndex + 2] = (char)(num - value * 10);
		num = 48 + value;
		value /= 10;
		buffer[startingIndex + 1] = (char)(num - value * 10);
		buffer[startingIndex] = (char)(48 + value);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void WriteDigits(ulong value, Span<char> buffer)
	{
		for (int num = buffer.Length - 1; num >= 1; num--)
		{
			ulong num2 = 48 + value;
			value /= 10;
			buffer[num] = (char)(num2 - value * 10);
		}
		buffer[0] = (char)(48 + value);
	}

	internal static string[] GetAllDateTimes(DateTime dateTime, char format, DateTimeFormatInfo dtfi)
	{
		string[] array = null;
		string[] array2 = null;
		switch (format)
		{
		case 'D':
		case 'F':
		case 'G':
		case 'M':
		case 'T':
		case 'Y':
		case 'd':
		case 'f':
		case 'g':
		case 'm':
		case 't':
		case 'y':
		{
			array = dtfi.GetAllDateTimePatterns(format);
			array2 = new string[array.Length];
			for (int j = 0; j < array.Length; j++)
			{
				array2[j] = Format(dateTime, array[j], dtfi);
			}
			break;
		}
		case 'U':
		{
			DateTime dateTime2 = dateTime.ToUniversalTime();
			array = dtfi.GetAllDateTimePatterns(format);
			array2 = new string[array.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array2[i] = Format(dateTime2, array[i], dtfi);
			}
			break;
		}
		case 'O':
		case 'R':
		case 'o':
		case 'r':
		case 's':
		case 'u':
			array2 = new string[1] { Format(dateTime, new string(format, 1), dtfi) };
			break;
		default:
			throw new FormatException("Input string was not in a correct format.");
		}
		return array2;
	}

	internal static string[] GetAllDateTimes(DateTime dateTime, DateTimeFormatInfo dtfi)
	{
		List<string> list = new List<string>(132);
		for (int i = 0; i < allStandardFormats.Length; i++)
		{
			string[] allDateTimes = GetAllDateTimes(dateTime, allStandardFormats[i], dtfi);
			for (int j = 0; j < allDateTimes.Length; j++)
			{
				list.Add(allDateTimes[j]);
			}
		}
		string[] array = new string[list.Count];
		list.CopyTo(0, array, 0, list.Count);
		return array;
	}

	internal static void InvalidFormatForLocal(ReadOnlySpan<char> format, DateTime dateTime)
	{
	}
}
