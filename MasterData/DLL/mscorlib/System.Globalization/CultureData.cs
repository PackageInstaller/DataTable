using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

namespace System.Globalization;

[StructLayout(LayoutKind.Sequential)]
internal class CultureData
{
	internal struct NumberFormatEntryManaged
	{
		internal int currency_decimal_digits;

		internal int currency_decimal_separator;

		internal int currency_group_separator;

		internal int currency_group_sizes0;

		internal int currency_group_sizes1;

		internal int currency_negative_pattern;

		internal int currency_positive_pattern;

		internal int currency_symbol;

		internal int nan_symbol;

		internal int negative_infinity_symbol;

		internal int negative_sign;

		internal int number_decimal_digits;

		internal int number_decimal_separator;

		internal int number_group_separator;

		internal int number_group_sizes0;

		internal int number_group_sizes1;

		internal int number_negative_pattern;

		internal int per_mille_symbol;

		internal int percent_negative_pattern;

		internal int percent_positive_pattern;

		internal int percent_symbol;

		internal int positive_infinity_symbol;

		internal int positive_sign;
	}

	private string sAM1159;

	private string sPM2359;

	private string sTimeSeparator;

	private volatile string[] saLongTimes;

	private volatile string[] saShortTimes;

	private int iFirstDayOfWeek;

	private int iFirstWeekOfYear;

	private volatile int[] waCalendars;

	private CalendarData[] calendars;

	private string sISO639Language;

	private readonly string sRealName;

	private bool bUseOverrides;

	private int calendarId;

	private int numberIndex;

	private int iDefaultAnsiCodePage;

	private int iDefaultOemCodePage;

	private int iDefaultMacCodePage;

	private int iDefaultEbcdicCodePage;

	private bool isRightToLeft;

	private string sListSeparator;

	private static CultureData s_Invariant;

	public static CultureData Invariant
	{
		get
		{
			if (s_Invariant == null)
			{
				CultureData cultureData = new CultureData("");
				cultureData.sISO639Language = "iv";
				cultureData.sAM1159 = "AM";
				cultureData.sPM2359 = "PM";
				cultureData.sTimeSeparator = ":";
				cultureData.saLongTimes = new string[1] { "HH:mm:ss" };
				cultureData.saShortTimes = new string[4] { "HH:mm", "hh:mm tt", "H:mm", "h:mm tt" };
				cultureData.iFirstDayOfWeek = 0;
				cultureData.iFirstWeekOfYear = 0;
				cultureData.waCalendars = new int[1] { 1 };
				cultureData.calendars = new CalendarData[23];
				cultureData.calendars[0] = CalendarData.Invariant;
				cultureData.iDefaultAnsiCodePage = 1252;
				cultureData.iDefaultOemCodePage = 437;
				cultureData.iDefaultMacCodePage = 10000;
				cultureData.iDefaultEbcdicCodePage = 37;
				cultureData.sListSeparator = ",";
				Interlocked.CompareExchange(ref s_Invariant, cultureData, null);
			}
			return s_Invariant;
		}
	}

	internal string[] LongTimes => saLongTimes;

	internal string[] ShortTimes => saShortTimes;

	internal string SISO639LANGNAME => sISO639Language;

	internal int IFIRSTDAYOFWEEK => iFirstDayOfWeek;

	internal int IFIRSTWEEKOFYEAR => iFirstWeekOfYear;

	internal string SAM1159 => sAM1159;

	internal string SPM2359 => sPM2359;

	internal string TimeSeparator => sTimeSeparator;

	internal int[] CalendarIds
	{
		get
		{
			if (waCalendars == null)
			{
				switch (sISO639Language)
				{
				case "ja":
					waCalendars = new int[2] { calendarId, 3 };
					break;
				case "zh":
					waCalendars = new int[2] { calendarId, 4 };
					break;
				case "he":
					waCalendars = new int[2] { calendarId, 8 };
					break;
				default:
					waCalendars = new int[1] { calendarId };
					break;
				}
			}
			return waCalendars;
		}
	}

	internal bool IsInvariantCulture => string.IsNullOrEmpty(sRealName);

	internal string CultureName => sRealName;

	internal string SCOMPAREINFO => "";

	internal string STEXTINFO => sRealName;

	internal int IDEFAULTOEMCODEPAGE => iDefaultOemCodePage;

	internal string SLIST => sListSeparator;

	internal bool UseUserOverride => bUseOverrides;

	private CultureData(string name)
	{
		sRealName = name;
	}

	public static CultureData GetCultureData(string cultureName, bool useUserOverride)
	{
		try
		{
			return new CultureInfo(cultureName, useUserOverride).m_cultureData;
		}
		catch
		{
			return null;
		}
	}

	public static CultureData GetCultureData(string cultureName, bool useUserOverride, int datetimeIndex, int calendarId, int numberIndex, string iso2lang, int ansiCodePage, int oemCodePage, int macCodePage, int ebcdicCodePage, bool rightToLeft, string listSeparator)
	{
		if (string.IsNullOrEmpty(cultureName))
		{
			return Invariant;
		}
		CultureData cultureData = new CultureData(cultureName);
		cultureData.fill_culture_data(datetimeIndex);
		cultureData.bUseOverrides = useUserOverride;
		cultureData.calendarId = calendarId;
		cultureData.numberIndex = numberIndex;
		cultureData.sISO639Language = iso2lang;
		cultureData.iDefaultAnsiCodePage = ansiCodePage;
		cultureData.iDefaultOemCodePage = oemCodePage;
		cultureData.iDefaultMacCodePage = macCodePage;
		cultureData.iDefaultEbcdicCodePage = ebcdicCodePage;
		cultureData.isRightToLeft = rightToLeft;
		cultureData.sListSeparator = listSeparator;
		return cultureData;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void fill_culture_data(int datetimeIndex);

	public CalendarData GetCalendar(int calendarId)
	{
		int num = calendarId - 1;
		if (calendars == null)
		{
			calendars = new CalendarData[23];
		}
		CalendarData calendarData = calendars[num];
		if (calendarData == null)
		{
			calendarData = new CalendarData(sRealName, calendarId, bUseOverrides);
			calendars[num] = calendarData;
		}
		return calendarData;
	}

	internal CalendarId[] GetCalendarIds()
	{
		CalendarId[] array = new CalendarId[CalendarIds.Length];
		for (int i = 0; i < CalendarIds.Length; i++)
		{
			array[i] = (CalendarId)CalendarIds[i];
		}
		return array;
	}

	internal string[] EraNames(int calendarId)
	{
		return GetCalendar(calendarId).saEraNames;
	}

	internal string[] AbbrevEraNames(int calendarId)
	{
		return GetCalendar(calendarId).saAbbrevEraNames;
	}

	internal string[] AbbreviatedEnglishEraNames(int calendarId)
	{
		return GetCalendar(calendarId).saAbbrevEnglishEraNames;
	}

	internal string[] ShortDates(int calendarId)
	{
		return GetCalendar(calendarId).saShortDates;
	}

	internal string[] LongDates(int calendarId)
	{
		return GetCalendar(calendarId).saLongDates;
	}

	internal string[] YearMonths(int calendarId)
	{
		return GetCalendar(calendarId).saYearMonths;
	}

	internal string[] DayNames(int calendarId)
	{
		return GetCalendar(calendarId).saDayNames;
	}

	internal string[] AbbreviatedDayNames(int calendarId)
	{
		return GetCalendar(calendarId).saAbbrevDayNames;
	}

	internal string[] MonthNames(int calendarId)
	{
		return GetCalendar(calendarId).saMonthNames;
	}

	internal string[] GenitiveMonthNames(int calendarId)
	{
		return GetCalendar(calendarId).saMonthGenitiveNames;
	}

	internal string[] AbbreviatedMonthNames(int calendarId)
	{
		return GetCalendar(calendarId).saAbbrevMonthNames;
	}

	internal string[] AbbreviatedGenitiveMonthNames(int calendarId)
	{
		return GetCalendar(calendarId).saAbbrevMonthGenitiveNames;
	}

	internal string[] LeapYearMonthNames(int calendarId)
	{
		return GetCalendar(calendarId).saLeapYearMonthNames;
	}

	internal string MonthDay(int calendarId)
	{
		return GetCalendar(calendarId).sMonthDay;
	}

	internal string DateSeparator(int calendarId)
	{
		if (calendarId == 3 && !AppContextSwitches.EnforceLegacyJapaneseDateParsing)
		{
			return "/";
		}
		return GetDateSeparator(ShortDates(calendarId)[0]);
	}

	private static string GetDateSeparator(string format)
	{
		return GetSeparator(format, "dyM");
	}

	private static string GetSeparator(string format, string timeParts)
	{
		int num = IndexOfTimePart(format, 0, timeParts);
		if (num != -1)
		{
			char c = format[num];
			do
			{
				num++;
			}
			while (num < format.Length && format[num] == c);
			int num2 = num;
			if (num2 < format.Length)
			{
				int num3 = IndexOfTimePart(format, num2, timeParts);
				if (num3 != -1)
				{
					return UnescapeNlsString(format, num2, num3 - 1);
				}
			}
		}
		return string.Empty;
	}

	private static int IndexOfTimePart(string format, int startIndex, string timeParts)
	{
		bool flag = false;
		for (int i = startIndex; i < format.Length; i++)
		{
			if (!flag && timeParts.IndexOf(format[i]) != -1)
			{
				return i;
			}
			switch (format[i])
			{
			case '\\':
				if (i + 1 < format.Length)
				{
					i++;
					char c = format[i];
					if (c != '\'' && c != '\\')
					{
						i--;
					}
				}
				break;
			case '\'':
				flag = !flag;
				break;
			}
		}
		return -1;
	}

	private static string UnescapeNlsString(string str, int start, int end)
	{
		StringBuilder stringBuilder = null;
		for (int i = start; i < str.Length && i <= end; i++)
		{
			switch (str[i])
			{
			case '\'':
				if (stringBuilder == null)
				{
					stringBuilder = new StringBuilder(str, start, i - start, str.Length);
				}
				break;
			case '\\':
				if (stringBuilder == null)
				{
					stringBuilder = new StringBuilder(str, start, i - start, str.Length);
				}
				i++;
				if (i < str.Length)
				{
					stringBuilder.Append(str[i]);
				}
				break;
			default:
				stringBuilder?.Append(str[i]);
				break;
			}
		}
		if (stringBuilder == null)
		{
			return str.Substring(start, end - start + 1);
		}
		return stringBuilder.ToString();
	}

	internal static string[] ReescapeWin32Strings(string[] array)
	{
		return array;
	}

	internal static string ReescapeWin32String(string str)
	{
		return str;
	}

	private unsafe static int strlen(byte* s)
	{
		int i;
		for (i = 0; s[i] != 0; i++)
		{
		}
		return i;
	}

	private unsafe static string idx2string(byte* data, int idx)
	{
		return Encoding.UTF8.GetString(data + idx, strlen(data + idx));
	}

	private int[] create_group_sizes_array(int gs0, int gs1)
	{
		if (gs0 != -1)
		{
			if (gs1 == -1)
			{
				return new int[1] { gs0 };
			}
			return new int[2] { gs0, gs1 };
		}
		return new int[0];
	}

	internal unsafe void GetNFIValues(NumberFormatInfo nfi)
	{
		if (!IsInvariantCulture)
		{
			NumberFormatEntryManaged nfe = default(NumberFormatEntryManaged);
			byte* data = fill_number_data(numberIndex, ref nfe);
			nfi.currencyGroupSizes = create_group_sizes_array(nfe.currency_group_sizes0, nfe.currency_group_sizes1);
			nfi.numberGroupSizes = create_group_sizes_array(nfe.number_group_sizes0, nfe.number_group_sizes1);
			nfi.NaNSymbol = idx2string(data, nfe.nan_symbol);
			nfi.currencyDecimalDigits = nfe.currency_decimal_digits;
			nfi.currencyDecimalSeparator = idx2string(data, nfe.currency_decimal_separator);
			nfi.currencyGroupSeparator = idx2string(data, nfe.currency_group_separator);
			nfi.currencyNegativePattern = nfe.currency_negative_pattern;
			nfi.currencyPositivePattern = nfe.currency_positive_pattern;
			nfi.currencySymbol = idx2string(data, nfe.currency_symbol);
			nfi.negativeInfinitySymbol = idx2string(data, nfe.negative_infinity_symbol);
			nfi.negativeSign = idx2string(data, nfe.negative_sign);
			nfi.numberDecimalDigits = nfe.number_decimal_digits;
			nfi.numberDecimalSeparator = idx2string(data, nfe.number_decimal_separator);
			nfi.numberGroupSeparator = idx2string(data, nfe.number_group_separator);
			nfi.numberNegativePattern = nfe.number_negative_pattern;
			nfi.perMilleSymbol = idx2string(data, nfe.per_mille_symbol);
			nfi.percentNegativePattern = nfe.percent_negative_pattern;
			nfi.percentPositivePattern = nfe.percent_positive_pattern;
			nfi.percentSymbol = idx2string(data, nfe.percent_symbol);
			nfi.positiveInfinitySymbol = idx2string(data, nfe.positive_infinity_symbol);
			nfi.positiveSign = idx2string(data, nfe.positive_sign);
		}
		nfi.percentDecimalDigits = nfi.numberDecimalDigits;
		nfi.percentDecimalSeparator = nfi.numberDecimalSeparator;
		nfi.percentGroupSizes = nfi.numberGroupSizes;
		nfi.percentGroupSeparator = nfi.numberGroupSeparator;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern byte* fill_number_data(int index, ref NumberFormatEntryManaged nfe);
}
