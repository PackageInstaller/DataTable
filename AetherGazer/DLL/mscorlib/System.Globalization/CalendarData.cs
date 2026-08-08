using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Globalization;

[StructLayout(LayoutKind.Sequential)]
internal class CalendarData
{
	internal const int MAX_CALENDARS = 23;

	internal string sNativeName;

	internal string[] saShortDates;

	internal string[] saYearMonths;

	internal string[] saLongDates;

	internal string sMonthDay;

	internal string[] saEraNames;

	internal string[] saAbbrevEraNames;

	internal string[] saAbbrevEnglishEraNames;

	internal string[] saDayNames;

	internal string[] saAbbrevDayNames;

	internal string[] saSuperShortDayNames;

	internal string[] saMonthNames;

	internal string[] saAbbrevMonthNames;

	internal string[] saMonthGenitiveNames;

	internal string[] saAbbrevMonthGenitiveNames;

	internal string[] saLeapYearMonthNames;

	internal int iTwoDigitYearMax = 2029;

	internal int iCurrentEra;

	internal bool bUseUserOverrides;

	internal static CalendarData Invariant;

	private static string[] HEBREW_MONTH_NAMES;

	private static string[] HEBREW_LEAP_MONTH_NAMES;

	private CalendarData()
	{
	}

	static CalendarData()
	{
		HEBREW_MONTH_NAMES = new string[13]
		{
			"תשרי", "חשון", "כסלו", "טבת", "שבט", "אדר", "אדר ב", "ניסן", "אייר", "סיון",
			"תמוז", "אב", "אלול"
		};
		HEBREW_LEAP_MONTH_NAMES = new string[13]
		{
			"תשרי", "חשון", "כסלו", "טבת", "שבט", "אדר א", "אדר ב", "ניסן", "אייר", "סיון",
			"תמוז", "אב", "אלול"
		};
		CalendarData calendarData = new CalendarData();
		calendarData.sNativeName = "Gregorian Calendar";
		calendarData.iTwoDigitYearMax = 2029;
		calendarData.iCurrentEra = 1;
		calendarData.saShortDates = new string[2] { "MM/dd/yyyy", "yyyy-MM-dd" };
		calendarData.saLongDates = new string[1] { "dddd, dd MMMM yyyy" };
		calendarData.saYearMonths = new string[1] { "yyyy MMMM" };
		calendarData.sMonthDay = "MMMM dd";
		calendarData.saEraNames = new string[1] { "A.D." };
		calendarData.saAbbrevEraNames = new string[1] { "AD" };
		calendarData.saAbbrevEnglishEraNames = new string[1] { "AD" };
		calendarData.saDayNames = new string[7] { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
		calendarData.saAbbrevDayNames = new string[7] { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" };
		calendarData.saSuperShortDayNames = new string[7] { "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa" };
		calendarData.saMonthNames = new string[13]
		{
			"January",
			"February",
			"March",
			"April",
			"May",
			"June",
			"July",
			"August",
			"September",
			"October",
			"November",
			"December",
			string.Empty
		};
		calendarData.saAbbrevMonthNames = new string[13]
		{
			"Jan",
			"Feb",
			"Mar",
			"Apr",
			"May",
			"Jun",
			"Jul",
			"Aug",
			"Sep",
			"Oct",
			"Nov",
			"Dec",
			string.Empty
		};
		calendarData.saMonthGenitiveNames = calendarData.saMonthNames;
		calendarData.saAbbrevMonthGenitiveNames = calendarData.saAbbrevMonthNames;
		calendarData.saLeapYearMonthNames = calendarData.saMonthNames;
		calendarData.bUseUserOverrides = false;
		Invariant = calendarData;
	}

	internal CalendarData(string localeName, int calendarId, bool bUseUserOverrides)
	{
		this.bUseUserOverrides = bUseUserOverrides;
		if (!nativeGetCalendarData(this, localeName, calendarId))
		{
			if (sNativeName == null)
			{
				sNativeName = string.Empty;
			}
			if (saShortDates == null)
			{
				saShortDates = Invariant.saShortDates;
			}
			if (saYearMonths == null)
			{
				saYearMonths = Invariant.saYearMonths;
			}
			if (saLongDates == null)
			{
				saLongDates = Invariant.saLongDates;
			}
			if (sMonthDay == null)
			{
				sMonthDay = Invariant.sMonthDay;
			}
			if (saEraNames == null)
			{
				saEraNames = Invariant.saEraNames;
			}
			if (saAbbrevEraNames == null)
			{
				saAbbrevEraNames = Invariant.saAbbrevEraNames;
			}
			if (saAbbrevEnglishEraNames == null)
			{
				saAbbrevEnglishEraNames = Invariant.saAbbrevEnglishEraNames;
			}
			if (saDayNames == null)
			{
				saDayNames = Invariant.saDayNames;
			}
			if (saAbbrevDayNames == null)
			{
				saAbbrevDayNames = Invariant.saAbbrevDayNames;
			}
			if (saSuperShortDayNames == null)
			{
				saSuperShortDayNames = Invariant.saSuperShortDayNames;
			}
			if (saMonthNames == null)
			{
				saMonthNames = Invariant.saMonthNames;
			}
			if (saAbbrevMonthNames == null)
			{
				saAbbrevMonthNames = Invariant.saAbbrevMonthNames;
			}
		}
		saShortDates = CultureData.ReescapeWin32Strings(saShortDates);
		saLongDates = CultureData.ReescapeWin32Strings(saLongDates);
		saYearMonths = CultureData.ReescapeWin32Strings(saYearMonths);
		sMonthDay = CultureData.ReescapeWin32String(sMonthDay);
		if ((ushort)calendarId == 4)
		{
			if (CultureInfo.IsTaiwanSku)
			{
				sNativeName = "中華民國曆";
			}
			else
			{
				sNativeName = string.Empty;
			}
		}
		if (saMonthGenitiveNames == null || string.IsNullOrEmpty(saMonthGenitiveNames[0]))
		{
			saMonthGenitiveNames = saMonthNames;
		}
		if (saAbbrevMonthGenitiveNames == null || string.IsNullOrEmpty(saAbbrevMonthGenitiveNames[0]))
		{
			saAbbrevMonthGenitiveNames = saAbbrevMonthNames;
		}
		if (saLeapYearMonthNames == null || string.IsNullOrEmpty(saLeapYearMonthNames[0]))
		{
			saLeapYearMonthNames = saMonthNames;
		}
		InitializeEraNames(localeName, calendarId);
		InitializeAbbreviatedEraNames(localeName, calendarId);
		if (!GlobalizationMode.Invariant && calendarId == 3)
		{
			saAbbrevEnglishEraNames = GetJapaneseEnglishEraNames();
		}
		else
		{
			saAbbrevEnglishEraNames = new string[1] { "" };
		}
		iCurrentEra = saEraNames.Length;
	}

	private void InitializeEraNames(string localeName, int calendarId)
	{
		switch ((CalendarId)(ushort)calendarId)
		{
		case CalendarId.GREGORIAN:
			if (saEraNames == null || saEraNames.Length == 0 || string.IsNullOrEmpty(saEraNames[0]))
			{
				saEraNames = new string[1] { "A.D." };
			}
			break;
		case CalendarId.GREGORIAN_US:
		case CalendarId.JULIAN:
			saEraNames = new string[1] { "A.D." };
			break;
		case CalendarId.HEBREW:
			saEraNames = new string[1] { "C.E." };
			break;
		case CalendarId.HIJRI:
		case CalendarId.UMALQURA:
			if (localeName == "dv-MV")
			{
				saEraNames = new string[1] { "ހ\u07a8ޖ\u07b0ރ\u07a9" };
			}
			else
			{
				saEraNames = new string[1] { "بعد الهجرة" };
			}
			break;
		case CalendarId.GREGORIAN_ARABIC:
		case CalendarId.GREGORIAN_XLIT_ENGLISH:
		case CalendarId.GREGORIAN_XLIT_FRENCH:
			saEraNames = new string[1] { "م" };
			break;
		case CalendarId.GREGORIAN_ME_FRENCH:
			saEraNames = new string[1] { "ap. J.-C." };
			break;
		case CalendarId.TAIWAN:
			if (CultureInfo.IsTaiwanSku)
			{
				saEraNames = new string[1] { "中華民國" };
			}
			else
			{
				saEraNames = new string[1] { string.Empty };
			}
			break;
		case CalendarId.KOREA:
			saEraNames = new string[1] { "단기" };
			break;
		case CalendarId.THAI:
			saEraNames = new string[1] { "พ.ศ." };
			break;
		case CalendarId.JAPAN:
		case CalendarId.JAPANESELUNISOLAR:
			saEraNames = GetJapaneseEraNames();
			break;
		case CalendarId.PERSIAN:
			if (saEraNames == null || saEraNames.Length == 0 || string.IsNullOrEmpty(saEraNames[0]))
			{
				saEraNames = new string[1] { "ه.ش" };
			}
			break;
		default:
			saEraNames = Invariant.saEraNames;
			break;
		}
	}

	private static string[] GetJapaneseEraNames()
	{
		if (GlobalizationMode.Invariant)
		{
			throw new PlatformNotSupportedException();
		}
		return JapaneseCalendar.EraNames();
	}

	private static string[] GetJapaneseEnglishEraNames()
	{
		if (GlobalizationMode.Invariant)
		{
			throw new PlatformNotSupportedException();
		}
		return JapaneseCalendar.EnglishEraNames();
	}

	private void InitializeAbbreviatedEraNames(string localeName, int calendarId)
	{
		switch ((CalendarId)(ushort)calendarId)
		{
		case CalendarId.GREGORIAN:
			if (saAbbrevEraNames == null || saAbbrevEraNames.Length == 0 || string.IsNullOrEmpty(saAbbrevEraNames[0]))
			{
				saAbbrevEraNames = new string[1] { "AD" };
			}
			break;
		case CalendarId.GREGORIAN_US:
		case CalendarId.JULIAN:
			saAbbrevEraNames = new string[1] { "AD" };
			break;
		case CalendarId.JAPAN:
		case CalendarId.JAPANESELUNISOLAR:
			if (GlobalizationMode.Invariant)
			{
				throw new PlatformNotSupportedException();
			}
			saAbbrevEraNames = saEraNames;
			break;
		case CalendarId.HIJRI:
		case CalendarId.UMALQURA:
			if (localeName == "dv-MV")
			{
				saAbbrevEraNames = new string[1] { "ހ." };
			}
			else
			{
				saAbbrevEraNames = new string[1] { "هـ" };
			}
			break;
		case CalendarId.TAIWAN:
			saAbbrevEraNames = new string[1];
			if (saEraNames[0].Length == 4)
			{
				saAbbrevEraNames[0] = saEraNames[0].Substring(2, 2);
			}
			else
			{
				saAbbrevEraNames[0] = saEraNames[0];
			}
			break;
		case CalendarId.PERSIAN:
			if (saAbbrevEraNames == null || saAbbrevEraNames.Length == 0 || string.IsNullOrEmpty(saAbbrevEraNames[0]))
			{
				saAbbrevEraNames = saEraNames;
			}
			break;
		default:
			saAbbrevEraNames = saEraNames;
			break;
		}
	}

	internal static CalendarData GetCalendarData(int calendarId)
	{
		return CultureInfo.GetCultureInfo(CalendarIdToCultureName(calendarId)).m_cultureData.GetCalendar(calendarId);
	}

	private static string CalendarIdToCultureName(int calendarId)
	{
		switch (calendarId)
		{
		case 2:
			return "fa-IR";
		case 3:
			return "ja-JP";
		case 4:
			return "zh-TW";
		case 5:
			return "ko-KR";
		case 6:
		case 10:
		case 23:
			return "ar-SA";
		case 7:
			return "th-TH";
		case 8:
			return "he-IL";
		case 9:
			return "ar-DZ";
		case 11:
		case 12:
			return "ar-IQ";
		default:
			return "en-US";
		}
	}

	public static int nativeGetTwoDigitYearMax(int calID)
	{
		return -1;
	}

	private static bool nativeGetCalendarData(CalendarData data, string localeName, int calendarId)
	{
		if (data.fill_calendar_data(localeName.ToLowerInvariant(), calendarId))
		{
			if ((ushort)calendarId == 8)
			{
				data.saMonthNames = HEBREW_MONTH_NAMES;
				data.saLeapYearMonthNames = HEBREW_LEAP_MONTH_NAMES;
			}
			return true;
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool fill_calendar_data(string localeName, int datetimeIndex);
}
