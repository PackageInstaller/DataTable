using System.Runtime.CompilerServices;

namespace System.Globalization;

[Serializable]
public sealed class DateTimeFormatInfo : IFormatProvider, ICloneable
{
	internal class TokenHashValue
	{
		internal string tokenString;

		internal TokenType tokenType;

		internal int tokenValue;

		internal TokenHashValue(string tokenString, TokenType tokenType, int tokenValue)
		{
			this.tokenString = tokenString;
			this.tokenType = tokenType;
			this.tokenValue = tokenValue;
		}
	}

	private static volatile DateTimeFormatInfo s_invariantInfo;

	[NonSerialized]
	private CultureData _cultureData;

	private string _name;

	[NonSerialized]
	private string _langName;

	[NonSerialized]
	private CompareInfo _compareInfo;

	[NonSerialized]
	private CultureInfo _cultureInfo;

	private string amDesignator;

	private string pmDesignator;

	private string dateSeparator;

	private string generalShortTimePattern;

	private string generalLongTimePattern;

	private string timeSeparator;

	private string monthDayPattern;

	private string dateTimeOffsetPattern;

	private const string rfc1123Pattern = "ddd, dd MMM yyyy HH':'mm':'ss 'GMT'";

	private const string sortableDateTimePattern = "yyyy'-'MM'-'dd'T'HH':'mm':'ss";

	private const string universalSortableDateTimePattern = "yyyy'-'MM'-'dd HH':'mm':'ss'Z'";

	private Calendar calendar;

	private int firstDayOfWeek = -1;

	private int calendarWeekRule = -1;

	private string fullDateTimePattern;

	private string[] abbreviatedDayNames;

	private string[] m_superShortDayNames;

	private string[] dayNames;

	private string[] abbreviatedMonthNames;

	private string[] monthNames;

	private string[] genitiveMonthNames;

	private string[] m_genitiveAbbreviatedMonthNames;

	private string[] leapYearMonthNames;

	private string longDatePattern;

	private string shortDatePattern;

	private string yearMonthPattern;

	private string longTimePattern;

	private string shortTimePattern;

	private string[] allYearMonthPatterns;

	private string[] allShortDatePatterns;

	private string[] allLongDatePatterns;

	private string[] allShortTimePatterns;

	private string[] allLongTimePatterns;

	private string[] m_eraNames;

	private string[] m_abbrevEraNames;

	private string[] m_abbrevEnglishEraNames;

	private CalendarId[] optionalCalendars;

	private const int DEFAULT_ALL_DATETIMES_SIZE = 132;

	internal bool _isReadOnly;

	private DateTimeFormatFlags formatFlags = DateTimeFormatFlags.NotInitialized;

	private static readonly char[] s_monthSpaces = new char[2] { ' ', '\u00a0' };

	internal const string RoundtripFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffffK";

	internal const string RoundtripDateTimeUnfixed = "yyyy'-'MM'-'ddTHH':'mm':'ss zzz";

	private string _fullTimeSpanPositivePattern;

	private string _fullTimeSpanNegativePattern;

	internal const DateTimeStyles InvalidDateTimeStyles = ~(DateTimeStyles.AllowWhiteSpaces | DateTimeStyles.NoCurrentDateDefault | DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeLocal | DateTimeStyles.AssumeUniversal | DateTimeStyles.RoundtripKind);

	[NonSerialized]
	private TokenHashValue[] _dtfiTokenHash;

	private const int TOKEN_HASH_SIZE = 199;

	private const int SECOND_PRIME = 197;

	private const string dateSeparatorOrTimeZoneOffset = "-";

	private const string invariantDateSeparator = "/";

	private const string invariantTimeSeparator = ":";

	internal const string IgnorablePeriod = ".";

	internal const string IgnorableComma = ",";

	internal const string CJKYearSuff = "年";

	internal const string CJKMonthSuff = "月";

	internal const string CJKDaySuff = "日";

	internal const string KoreanYearSuff = "년";

	internal const string KoreanMonthSuff = "월";

	internal const string KoreanDaySuff = "일";

	internal const string KoreanHourSuff = "시";

	internal const string KoreanMinuteSuff = "분";

	internal const string KoreanSecondSuff = "초";

	internal const string CJKHourSuff = "時";

	internal const string ChineseHourSuff = "时";

	internal const string CJKMinuteSuff = "分";

	internal const string CJKSecondSuff = "秒";

	internal const string JapaneseEraStart = "元";

	internal const string LocalTimeMark = "T";

	internal const string GMTName = "GMT";

	internal const string ZuluName = "Z";

	internal const string KoreanLangName = "ko";

	internal const string JapaneseLangName = "ja";

	internal const string EnglishLangName = "en";

	private static volatile DateTimeFormatInfo s_jajpDTFI;

	private static volatile DateTimeFormatInfo s_zhtwDTFI;

	private string CultureName
	{
		get
		{
			if (_name == null)
			{
				_name = _cultureData.CultureName;
			}
			return _name;
		}
	}

	private CultureInfo Culture
	{
		get
		{
			if (_cultureInfo == null)
			{
				_cultureInfo = CultureInfo.GetCultureInfo(CultureName);
			}
			return _cultureInfo;
		}
	}

	private string LanguageName
	{
		get
		{
			if (_langName == null)
			{
				_langName = _cultureData.SISO639LANGNAME;
			}
			return _langName;
		}
	}

	public static DateTimeFormatInfo InvariantInfo
	{
		get
		{
			if (s_invariantInfo == null)
			{
				DateTimeFormatInfo dateTimeFormatInfo = new DateTimeFormatInfo();
				dateTimeFormatInfo.Calendar.SetReadOnlyState(readOnly: true);
				dateTimeFormatInfo._isReadOnly = true;
				s_invariantInfo = dateTimeFormatInfo;
			}
			return s_invariantInfo;
		}
	}

	public static DateTimeFormatInfo CurrentInfo
	{
		get
		{
			CultureInfo currentCulture = CultureInfo.CurrentCulture;
			if (!currentCulture._isInherited)
			{
				DateTimeFormatInfo dateTimeInfo = currentCulture.dateTimeInfo;
				if (dateTimeInfo != null)
				{
					return dateTimeInfo;
				}
			}
			return (DateTimeFormatInfo)currentCulture.GetFormat(typeof(DateTimeFormatInfo));
		}
	}

	public string AMDesignator
	{
		get
		{
			if (amDesignator == null)
			{
				amDesignator = _cultureData.SAM1159;
			}
			return amDesignator;
		}
	}

	public Calendar Calendar
	{
		get
		{
			return calendar;
		}
		set
		{
			if (GlobalizationMode.Invariant)
			{
				throw new PlatformNotSupportedException();
			}
			if (IsReadOnly)
			{
				throw new InvalidOperationException("Instance is read-only.");
			}
			if (value == null)
			{
				throw new ArgumentNullException("value", "Object cannot be null.");
			}
			if (value == calendar)
			{
				return;
			}
			for (int i = 0; i < OptionalCalendars.Length; i++)
			{
				if ((uint)OptionalCalendars[i] == (ushort)value.ID)
				{
					if (calendar != null)
					{
						m_eraNames = null;
						m_abbrevEraNames = null;
						m_abbrevEnglishEraNames = null;
						monthDayPattern = null;
						dayNames = null;
						abbreviatedDayNames = null;
						m_superShortDayNames = null;
						monthNames = null;
						abbreviatedMonthNames = null;
						genitiveMonthNames = null;
						m_genitiveAbbreviatedMonthNames = null;
						leapYearMonthNames = null;
						formatFlags = DateTimeFormatFlags.NotInitialized;
						allShortDatePatterns = null;
						allLongDatePatterns = null;
						allYearMonthPatterns = null;
						dateTimeOffsetPattern = null;
						longDatePattern = null;
						shortDatePattern = null;
						yearMonthPattern = null;
						fullDateTimePattern = null;
						generalShortTimePattern = null;
						generalLongTimePattern = null;
						dateSeparator = null;
						ClearTokenHashTable();
					}
					calendar = value;
					InitializeOverridableProperties(_cultureData, calendar.ID);
					return;
				}
			}
			throw new ArgumentOutOfRangeException("value", "Not a valid calendar for the given culture.");
		}
	}

	private CalendarId[] OptionalCalendars
	{
		get
		{
			if (optionalCalendars == null)
			{
				optionalCalendars = _cultureData.GetCalendarIds();
			}
			return optionalCalendars;
		}
	}

	internal string[] EraNames
	{
		get
		{
			if (m_eraNames == null)
			{
				m_eraNames = _cultureData.EraNames(Calendar.ID);
			}
			return m_eraNames;
		}
	}

	internal string[] AbbreviatedEraNames
	{
		get
		{
			if (m_abbrevEraNames == null)
			{
				m_abbrevEraNames = _cultureData.AbbrevEraNames(Calendar.ID);
			}
			return m_abbrevEraNames;
		}
	}

	internal string[] AbbreviatedEnglishEraNames
	{
		get
		{
			if (m_abbrevEnglishEraNames == null)
			{
				m_abbrevEnglishEraNames = _cultureData.AbbreviatedEnglishEraNames(Calendar.ID);
			}
			return m_abbrevEnglishEraNames;
		}
	}

	public string DateSeparator
	{
		get
		{
			if (dateSeparator == null)
			{
				dateSeparator = _cultureData.DateSeparator(Calendar.ID);
			}
			return dateSeparator;
		}
	}

	public string FullDateTimePattern
	{
		get
		{
			if (fullDateTimePattern == null)
			{
				fullDateTimePattern = LongDatePattern + " " + LongTimePattern;
			}
			return fullDateTimePattern;
		}
	}

	public string LongDatePattern
	{
		get
		{
			if (longDatePattern == null)
			{
				longDatePattern = UnclonedLongDatePatterns[0];
			}
			return longDatePattern;
		}
	}

	public string LongTimePattern
	{
		get
		{
			if (longTimePattern == null)
			{
				longTimePattern = UnclonedLongTimePatterns[0];
			}
			return longTimePattern;
		}
	}

	public string MonthDayPattern
	{
		get
		{
			if (monthDayPattern == null)
			{
				monthDayPattern = _cultureData.MonthDay(Calendar.ID);
			}
			return monthDayPattern;
		}
	}

	public string PMDesignator
	{
		get
		{
			if (pmDesignator == null)
			{
				pmDesignator = _cultureData.SPM2359;
			}
			return pmDesignator;
		}
	}

	public string RFC1123Pattern => "ddd, dd MMM yyyy HH':'mm':'ss 'GMT'";

	public string ShortDatePattern
	{
		get
		{
			if (shortDatePattern == null)
			{
				shortDatePattern = UnclonedShortDatePatterns[0];
			}
			return shortDatePattern;
		}
	}

	public string ShortTimePattern
	{
		get
		{
			if (shortTimePattern == null)
			{
				shortTimePattern = UnclonedShortTimePatterns[0];
			}
			return shortTimePattern;
		}
	}

	public string SortableDateTimePattern => "yyyy'-'MM'-'dd'T'HH':'mm':'ss";

	internal string GeneralShortTimePattern
	{
		get
		{
			if (generalShortTimePattern == null)
			{
				generalShortTimePattern = ShortDatePattern + " " + ShortTimePattern;
			}
			return generalShortTimePattern;
		}
	}

	internal string GeneralLongTimePattern
	{
		get
		{
			if (generalLongTimePattern == null)
			{
				generalLongTimePattern = ShortDatePattern + " " + LongTimePattern;
			}
			return generalLongTimePattern;
		}
	}

	internal string DateTimeOffsetPattern
	{
		get
		{
			if (dateTimeOffsetPattern == null)
			{
				string text = ShortDatePattern + " " + LongTimePattern;
				bool flag = false;
				bool flag2 = false;
				char c = '\'';
				int num = 0;
				while (!flag && num < LongTimePattern.Length)
				{
					switch (LongTimePattern[num])
					{
					case 'z':
						flag = !flag2;
						break;
					case '"':
					case '\'':
						if (flag2 && c == LongTimePattern[num])
						{
							flag2 = false;
						}
						else if (!flag2)
						{
							c = LongTimePattern[num];
							flag2 = true;
						}
						break;
					case '%':
					case '\\':
						num++;
						break;
					}
					num++;
				}
				if (!flag)
				{
					text += " zzz";
				}
				dateTimeOffsetPattern = text;
			}
			return dateTimeOffsetPattern;
		}
	}

	public string TimeSeparator
	{
		get
		{
			if (timeSeparator == null)
			{
				timeSeparator = _cultureData.TimeSeparator;
			}
			return timeSeparator;
		}
	}

	public string UniversalSortableDateTimePattern => "yyyy'-'MM'-'dd HH':'mm':'ss'Z'";

	public string YearMonthPattern
	{
		get
		{
			if (yearMonthPattern == null)
			{
				yearMonthPattern = UnclonedYearMonthPatterns[0];
			}
			return yearMonthPattern;
		}
	}

	public string[] AbbreviatedDayNames => (string[])internalGetAbbreviatedDayOfWeekNames().Clone();

	public string[] DayNames => (string[])internalGetDayOfWeekNames().Clone();

	public string[] AbbreviatedMonthNames => (string[])internalGetAbbreviatedMonthNames().Clone();

	public string[] MonthNames => (string[])internalGetMonthNames().Clone();

	internal bool HasSpacesInMonthNames => (FormatFlags & DateTimeFormatFlags.UseSpacesInMonthNames) != 0;

	internal bool HasSpacesInDayNames => (FormatFlags & DateTimeFormatFlags.UseSpacesInDayNames) != 0;

	private string[] AllYearMonthPatterns => GetMergedPatterns(UnclonedYearMonthPatterns, YearMonthPattern);

	private string[] AllShortDatePatterns => GetMergedPatterns(UnclonedShortDatePatterns, ShortDatePattern);

	private string[] AllShortTimePatterns => GetMergedPatterns(UnclonedShortTimePatterns, ShortTimePattern);

	private string[] AllLongDatePatterns => GetMergedPatterns(UnclonedLongDatePatterns, LongDatePattern);

	private string[] AllLongTimePatterns => GetMergedPatterns(UnclonedLongTimePatterns, LongTimePattern);

	private string[] UnclonedYearMonthPatterns
	{
		get
		{
			if (allYearMonthPatterns == null)
			{
				allYearMonthPatterns = _cultureData.YearMonths(Calendar.ID);
			}
			return allYearMonthPatterns;
		}
	}

	private string[] UnclonedShortDatePatterns
	{
		get
		{
			if (allShortDatePatterns == null)
			{
				allShortDatePatterns = _cultureData.ShortDates(Calendar.ID);
			}
			return allShortDatePatterns;
		}
	}

	private string[] UnclonedLongDatePatterns
	{
		get
		{
			if (allLongDatePatterns == null)
			{
				allLongDatePatterns = _cultureData.LongDates(Calendar.ID);
			}
			return allLongDatePatterns;
		}
	}

	private string[] UnclonedShortTimePatterns
	{
		get
		{
			if (allShortTimePatterns == null)
			{
				allShortTimePatterns = _cultureData.ShortTimes;
			}
			return allShortTimePatterns;
		}
	}

	private string[] UnclonedLongTimePatterns
	{
		get
		{
			if (allLongTimePatterns == null)
			{
				allLongTimePatterns = _cultureData.LongTimes;
			}
			return allLongTimePatterns;
		}
	}

	public bool IsReadOnly
	{
		get
		{
			if (!GlobalizationMode.Invariant)
			{
				return _isReadOnly;
			}
			return true;
		}
	}

	public string[] MonthGenitiveNames => (string[])internalGetGenitiveMonthNames(abbreviated: false).Clone();

	internal string FullTimeSpanPositivePattern
	{
		get
		{
			if (_fullTimeSpanPositivePattern == null)
			{
				CultureData cultureData = ((!_cultureData.UseUserOverride) ? _cultureData : CultureData.GetCultureData(_cultureData.CultureName, useUserOverride: false));
				string numberDecimalSeparator = new NumberFormatInfo(cultureData).NumberDecimalSeparator;
				_fullTimeSpanPositivePattern = "d':'h':'mm':'ss'" + numberDecimalSeparator + "'FFFFFFF";
			}
			return _fullTimeSpanPositivePattern;
		}
	}

	internal string FullTimeSpanNegativePattern
	{
		get
		{
			if (_fullTimeSpanNegativePattern == null)
			{
				_fullTimeSpanNegativePattern = "'-'" + FullTimeSpanPositivePattern;
			}
			return _fullTimeSpanNegativePattern;
		}
	}

	internal CompareInfo CompareInfo
	{
		get
		{
			if (_compareInfo == null)
			{
				_compareInfo = CompareInfo.GetCompareInfo(_cultureData.SCOMPAREINFO);
			}
			return _compareInfo;
		}
	}

	internal DateTimeFormatFlags FormatFlags
	{
		get
		{
			if (formatFlags == DateTimeFormatFlags.NotInitialized)
			{
				return InitializeFormatFlags();
			}
			return formatFlags;
		}
	}

	internal bool HasForceTwoDigitYears
	{
		get
		{
			CalendarId calendarId = (CalendarId)calendar.ID;
			if (calendarId - 3 <= CalendarId.GREGORIAN)
			{
				return true;
			}
			return false;
		}
	}

	internal bool HasYearMonthAdjustment => (FormatFlags & DateTimeFormatFlags.UseHebrewRule) != 0;

	private string[] internalGetAbbreviatedDayOfWeekNames()
	{
		return abbreviatedDayNames ?? internalGetAbbreviatedDayOfWeekNamesCore();
	}

	[MethodImpl((MethodImplOptions)8)]
	private string[] internalGetAbbreviatedDayOfWeekNamesCore()
	{
		abbreviatedDayNames = _cultureData.AbbreviatedDayNames(Calendar.ID);
		return abbreviatedDayNames;
	}

	private string[] internalGetDayOfWeekNames()
	{
		return dayNames ?? internalGetDayOfWeekNamesCore();
	}

	[MethodImpl((MethodImplOptions)8)]
	private string[] internalGetDayOfWeekNamesCore()
	{
		dayNames = _cultureData.DayNames(Calendar.ID);
		return dayNames;
	}

	private string[] internalGetAbbreviatedMonthNames()
	{
		return abbreviatedMonthNames ?? internalGetAbbreviatedMonthNamesCore();
	}

	[MethodImpl((MethodImplOptions)8)]
	private string[] internalGetAbbreviatedMonthNamesCore()
	{
		abbreviatedMonthNames = _cultureData.AbbreviatedMonthNames(Calendar.ID);
		return abbreviatedMonthNames;
	}

	private string[] internalGetMonthNames()
	{
		return monthNames ?? internalGetMonthNamesCore();
	}

	[MethodImpl((MethodImplOptions)8)]
	private string[] internalGetMonthNamesCore()
	{
		monthNames = _cultureData.MonthNames(Calendar.ID);
		return monthNames;
	}

	public DateTimeFormatInfo()
	{
		_cultureData = CultureInfo.InvariantCulture._cultureData;
		calendar = GregorianCalendar.GetDefaultInstance();
		InitializeOverridableProperties(_cultureData, calendar.ID);
	}

	internal DateTimeFormatInfo(CultureData cultureData, Calendar cal)
	{
		_cultureData = cultureData;
		Calendar = cal;
	}

	private void InitializeOverridableProperties(CultureData cultureData, int calendarId)
	{
		if (firstDayOfWeek == -1)
		{
			firstDayOfWeek = cultureData.IFIRSTDAYOFWEEK;
		}
		if (calendarWeekRule == -1)
		{
			calendarWeekRule = cultureData.IFIRSTWEEKOFYEAR;
		}
		if (amDesignator == null)
		{
			amDesignator = cultureData.SAM1159;
		}
		if (pmDesignator == null)
		{
			pmDesignator = cultureData.SPM2359;
		}
		if (timeSeparator == null)
		{
			timeSeparator = cultureData.TimeSeparator;
		}
		if (dateSeparator == null)
		{
			dateSeparator = cultureData.DateSeparator(calendarId);
		}
		allLongTimePatterns = _cultureData.LongTimes;
		allShortTimePatterns = _cultureData.ShortTimes;
		allLongDatePatterns = cultureData.LongDates(calendarId);
		allShortDatePatterns = cultureData.ShortDates(calendarId);
		allYearMonthPatterns = cultureData.YearMonths(calendarId);
	}

	public static DateTimeFormatInfo GetInstance(IFormatProvider provider)
	{
		if (provider != null)
		{
			if (!(provider is CultureInfo { _isInherited: false } cultureInfo))
			{
				if (!(provider is DateTimeFormatInfo result))
				{
					if (!(provider.GetFormat(typeof(DateTimeFormatInfo)) is DateTimeFormatInfo result2))
					{
						return CurrentInfo;
					}
					return result2;
				}
				return result;
			}
			return cultureInfo.DateTimeFormat;
		}
		return CurrentInfo;
	}

	public object GetFormat(Type formatType)
	{
		if (!(formatType == typeof(DateTimeFormatInfo)))
		{
			return null;
		}
		return this;
	}

	public object Clone()
	{
		DateTimeFormatInfo obj = (DateTimeFormatInfo)MemberwiseClone();
		obj.calendar = (Calendar)Calendar.Clone();
		obj._isReadOnly = false;
		return obj;
	}

	public string GetEraName(int era)
	{
		if (era == 0)
		{
			era = Calendar.CurrentEraValue;
		}
		if (--era < EraNames.Length && era >= 0)
		{
			return m_eraNames[era];
		}
		throw new ArgumentOutOfRangeException("era", "Era value was not valid.");
	}

	public string GetAbbreviatedEraName(int era)
	{
		if (AbbreviatedEraNames.Length == 0)
		{
			return GetEraName(era);
		}
		if (era == 0)
		{
			era = Calendar.CurrentEraValue;
		}
		if (--era < m_abbrevEraNames.Length && era >= 0)
		{
			return m_abbrevEraNames[era];
		}
		throw new ArgumentOutOfRangeException("era", "Era value was not valid.");
	}

	internal string internalGetMonthName(int month, MonthNameStyles style, bool abbreviated)
	{
		string[] array = null;
		array = style switch
		{
			MonthNameStyles.Genitive => internalGetGenitiveMonthNames(abbreviated), 
			MonthNameStyles.LeapYear => internalGetLeapYearMonthNames(), 
			_ => abbreviated ? internalGetAbbreviatedMonthNames() : internalGetMonthNames(), 
		};
		if (month < 1 || month > array.Length)
		{
			throw new ArgumentOutOfRangeException("month", SR.Format("Valid values are between {0} and {1}, inclusive.", 1, array.Length));
		}
		return array[month - 1];
	}

	private string[] internalGetGenitiveMonthNames(bool abbreviated)
	{
		if (abbreviated)
		{
			if (m_genitiveAbbreviatedMonthNames == null)
			{
				m_genitiveAbbreviatedMonthNames = _cultureData.AbbreviatedGenitiveMonthNames(Calendar.ID);
			}
			return m_genitiveAbbreviatedMonthNames;
		}
		if (genitiveMonthNames == null)
		{
			genitiveMonthNames = _cultureData.GenitiveMonthNames(Calendar.ID);
		}
		return genitiveMonthNames;
	}

	internal string[] internalGetLeapYearMonthNames()
	{
		if (leapYearMonthNames == null)
		{
			leapYearMonthNames = _cultureData.LeapYearMonthNames(Calendar.ID);
		}
		return leapYearMonthNames;
	}

	public string GetAbbreviatedDayName(DayOfWeek dayofweek)
	{
		if (dayofweek < DayOfWeek.Sunday || dayofweek > DayOfWeek.Saturday)
		{
			throw new ArgumentOutOfRangeException("dayofweek", SR.Format("Valid values are between {0} and {1}, inclusive.", DayOfWeek.Sunday, DayOfWeek.Saturday));
		}
		return internalGetAbbreviatedDayOfWeekNames()[(int)dayofweek];
	}

	private static string[] GetCombinedPatterns(string[] patterns1, string[] patterns2, string connectString)
	{
		string[] array = new string[patterns1.Length * patterns2.Length];
		int num = 0;
		for (int i = 0; i < patterns1.Length; i++)
		{
			for (int j = 0; j < patterns2.Length; j++)
			{
				array[num++] = patterns1[i] + connectString + patterns2[j];
			}
		}
		return array;
	}

	public string[] GetAllDateTimePatterns(char format)
	{
		string[] array = null;
		switch (format)
		{
		case 'd':
			return AllShortDatePatterns;
		case 'D':
			return AllLongDatePatterns;
		case 'f':
			return GetCombinedPatterns(AllLongDatePatterns, AllShortTimePatterns, " ");
		case 'F':
		case 'U':
			return GetCombinedPatterns(AllLongDatePatterns, AllLongTimePatterns, " ");
		case 'g':
			return GetCombinedPatterns(AllShortDatePatterns, AllShortTimePatterns, " ");
		case 'G':
			return GetCombinedPatterns(AllShortDatePatterns, AllLongTimePatterns, " ");
		case 'M':
		case 'm':
			return new string[1] { MonthDayPattern };
		case 'O':
		case 'o':
			return new string[1] { "yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffffK" };
		case 'R':
		case 'r':
			return new string[1] { "ddd, dd MMM yyyy HH':'mm':'ss 'GMT'" };
		case 's':
			return new string[1] { "yyyy'-'MM'-'dd'T'HH':'mm':'ss" };
		case 't':
			return AllShortTimePatterns;
		case 'T':
			return AllLongTimePatterns;
		case 'u':
			return new string[1] { UniversalSortableDateTimePattern };
		case 'Y':
		case 'y':
			return AllYearMonthPatterns;
		default:
			throw new ArgumentException(SR.Format("Format specifier '{0}' was invalid.", format), "format");
		}
	}

	public string GetDayName(DayOfWeek dayofweek)
	{
		if (dayofweek < DayOfWeek.Sunday || dayofweek > DayOfWeek.Saturday)
		{
			throw new ArgumentOutOfRangeException("dayofweek", SR.Format("Valid values are between {0} and {1}, inclusive.", DayOfWeek.Sunday, DayOfWeek.Saturday));
		}
		return internalGetDayOfWeekNames()[(int)dayofweek];
	}

	public string GetAbbreviatedMonthName(int month)
	{
		if (month < 1 || month > 13)
		{
			throw new ArgumentOutOfRangeException("month", SR.Format("Valid values are between {0} and {1}, inclusive.", 1, 13));
		}
		return internalGetAbbreviatedMonthNames()[month - 1];
	}

	public string GetMonthName(int month)
	{
		if (month < 1 || month > 13)
		{
			throw new ArgumentOutOfRangeException("month", SR.Format("Valid values are between {0} and {1}, inclusive.", 1, 13));
		}
		return internalGetMonthNames()[month - 1];
	}

	private static string[] GetMergedPatterns(string[] patterns, string defaultPattern)
	{
		if (defaultPattern == patterns[0])
		{
			return (string[])patterns.Clone();
		}
		int i;
		for (i = 0; i < patterns.Length && !(defaultPattern == patterns[i]); i++)
		{
		}
		string[] array;
		if (i < patterns.Length)
		{
			array = (string[])patterns.Clone();
			array[i] = array[0];
		}
		else
		{
			array = new string[patterns.Length + 1];
			Array.Copy(patterns, 0, array, 1, patterns.Length);
		}
		array[0] = defaultPattern;
		return array;
	}

	public static DateTimeFormatInfo ReadOnly(DateTimeFormatInfo dtfi)
	{
		if (dtfi == null)
		{
			throw new ArgumentNullException("dtfi", "Object cannot be null.");
		}
		if (dtfi.IsReadOnly)
		{
			return dtfi;
		}
		DateTimeFormatInfo obj = (DateTimeFormatInfo)dtfi.MemberwiseClone();
		obj.calendar = Calendar.ReadOnly(dtfi.Calendar);
		obj._isReadOnly = true;
		return obj;
	}

	internal static void ValidateStyles(DateTimeStyles style, string parameterName)
	{
		if ((style & ~(DateTimeStyles.AllowWhiteSpaces | DateTimeStyles.NoCurrentDateDefault | DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeLocal | DateTimeStyles.AssumeUniversal | DateTimeStyles.RoundtripKind)) != DateTimeStyles.None)
		{
			throw new ArgumentException("An undefined DateTimeStyles value is being used.", parameterName);
		}
		if ((style & DateTimeStyles.AssumeLocal) != DateTimeStyles.None && (style & DateTimeStyles.AssumeUniversal) != DateTimeStyles.None)
		{
			throw new ArgumentException("The DateTimeStyles values AssumeLocal and AssumeUniversal cannot be used together.", parameterName);
		}
		if ((style & DateTimeStyles.RoundtripKind) != DateTimeStyles.None && (style & (DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeLocal | DateTimeStyles.AssumeUniversal)) != DateTimeStyles.None)
		{
			throw new ArgumentException("The DateTimeStyles value RoundtripKind cannot be used with the values AssumeLocal, AssumeUniversal or AdjustToUniversal.", parameterName);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private DateTimeFormatFlags InitializeFormatFlags()
	{
		formatFlags = (DateTimeFormatFlags)(DateTimeFormatInfoScanner.GetFormatFlagGenitiveMonth(MonthNames, internalGetGenitiveMonthNames(abbreviated: false), AbbreviatedMonthNames, internalGetGenitiveMonthNames(abbreviated: true)) | DateTimeFormatInfoScanner.GetFormatFlagUseSpaceInMonthNames(MonthNames, internalGetGenitiveMonthNames(abbreviated: false), AbbreviatedMonthNames, internalGetGenitiveMonthNames(abbreviated: true)) | DateTimeFormatInfoScanner.GetFormatFlagUseSpaceInDayNames(DayNames, AbbreviatedDayNames) | DateTimeFormatInfoScanner.GetFormatFlagUseHebrewCalendar(Calendar.ID));
		return formatFlags;
	}

	internal bool YearMonthAdjustment(ref int year, ref int month, bool parsedMonthName)
	{
		if ((FormatFlags & DateTimeFormatFlags.UseHebrewRule) != DateTimeFormatFlags.None)
		{
			if (year < 1000)
			{
				year += 5000;
			}
			if (year < Calendar.GetYear(Calendar.MinSupportedDateTime) || year > Calendar.GetYear(Calendar.MaxSupportedDateTime))
			{
				return false;
			}
			if (parsedMonthName && !Calendar.IsLeapYear(year))
			{
				if (month >= 8)
				{
					month--;
				}
				else if (month == 7)
				{
					return false;
				}
			}
		}
		return true;
	}

	internal static DateTimeFormatInfo GetJapaneseCalendarDTFI()
	{
		DateTimeFormatInfo dateTimeFormat = s_jajpDTFI;
		if (dateTimeFormat == null && !GlobalizationMode.Invariant)
		{
			dateTimeFormat = new CultureInfo("ja-JP", useUserOverride: false).DateTimeFormat;
			dateTimeFormat.Calendar = JapaneseCalendar.GetDefaultInstance();
			s_jajpDTFI = dateTimeFormat;
		}
		return dateTimeFormat;
	}

	internal static DateTimeFormatInfo GetTaiwanCalendarDTFI()
	{
		DateTimeFormatInfo dateTimeFormat = s_zhtwDTFI;
		if (dateTimeFormat == null && !GlobalizationMode.Invariant)
		{
			dateTimeFormat = new CultureInfo("zh-TW", useUserOverride: false).DateTimeFormat;
			dateTimeFormat.Calendar = TaiwanCalendar.GetDefaultInstance();
			s_zhtwDTFI = dateTimeFormat;
		}
		return dateTimeFormat;
	}

	private void ClearTokenHashTable()
	{
		_dtfiTokenHash = null;
		formatFlags = DateTimeFormatFlags.NotInitialized;
	}

	internal TokenHashValue[] CreateTokenHashTable()
	{
		TokenHashValue[] array = _dtfiTokenHash;
		if (array == null)
		{
			array = new TokenHashValue[199];
			if (!GlobalizationMode.Invariant)
			{
				LanguageName.Equals("ko");
			}
			else
				_ = 0;
			string text = TimeSeparator.Trim();
			if ("," != text)
			{
				InsertHash(array, ",", TokenType.IgnorableSymbol, 0);
			}
			if ("." != text)
			{
				InsertHash(array, ".", TokenType.IgnorableSymbol, 0);
			}
			if (!GlobalizationMode.Invariant && "시" != text && "時" != text && "时" != text)
			{
				InsertHash(array, TimeSeparator, TokenType.SEP_Time, 0);
			}
			InsertHash(array, AMDesignator, (TokenType)1027, 0);
			InsertHash(array, PMDesignator, (TokenType)1284, 1);
			bool useDateSepAsIgnorableSymbol = false;
			if (!GlobalizationMode.Invariant)
			{
				PopulateSpecialTokenHashTable(array, ref useDateSepAsIgnorableSymbol);
			}
			if (!GlobalizationMode.Invariant && LanguageName.Equals("ky"))
			{
				InsertHash(array, "-", TokenType.IgnorableSymbol, 0);
			}
			else
			{
				InsertHash(array, "-", TokenType.SEP_DateOrOffset, 0);
			}
			if (!useDateSepAsIgnorableSymbol)
			{
				InsertHash(array, DateSeparator, TokenType.SEP_Date, 0);
			}
			AddMonthNames(array, null);
			for (int i = 1; i <= 13; i++)
			{
				InsertHash(array, GetAbbreviatedMonthName(i), TokenType.MonthToken, i);
			}
			if ((FormatFlags & DateTimeFormatFlags.UseGenitiveMonth) != DateTimeFormatFlags.None)
			{
				for (int j = 1; j <= 13; j++)
				{
					string str = internalGetMonthName(j, MonthNameStyles.Genitive, abbreviated: false);
					InsertHash(array, str, TokenType.MonthToken, j);
				}
			}
			if ((FormatFlags & DateTimeFormatFlags.UseLeapYearMonth) != DateTimeFormatFlags.None)
			{
				for (int k = 1; k <= 13; k++)
				{
					string str2 = internalGetMonthName(k, MonthNameStyles.LeapYear, abbreviated: false);
					InsertHash(array, str2, TokenType.MonthToken, k);
				}
			}
			for (int l = 0; l < 7; l++)
			{
				string dayName = GetDayName((DayOfWeek)l);
				InsertHash(array, dayName, TokenType.DayOfWeekToken, l);
				dayName = GetAbbreviatedDayName((DayOfWeek)l);
				InsertHash(array, dayName, TokenType.DayOfWeekToken, l);
			}
			int[] eras = calendar.Eras;
			for (int m = 1; m <= eras.Length; m++)
			{
				InsertHash(array, GetEraName(m), TokenType.EraToken, m);
				InsertHash(array, GetAbbreviatedEraName(m), TokenType.EraToken, m);
			}
			InsertHash(array, InvariantInfo.AMDesignator, (TokenType)1027, 0);
			InsertHash(array, InvariantInfo.PMDesignator, (TokenType)1284, 1);
			for (int n = 1; n <= 12; n++)
			{
				string monthName = InvariantInfo.GetMonthName(n);
				InsertHash(array, monthName, TokenType.MonthToken, n);
				monthName = InvariantInfo.GetAbbreviatedMonthName(n);
				InsertHash(array, monthName, TokenType.MonthToken, n);
			}
			for (int num = 0; num < 7; num++)
			{
				string dayName2 = InvariantInfo.GetDayName((DayOfWeek)num);
				InsertHash(array, dayName2, TokenType.DayOfWeekToken, num);
				dayName2 = InvariantInfo.GetAbbreviatedDayName((DayOfWeek)num);
				InsertHash(array, dayName2, TokenType.DayOfWeekToken, num);
			}
			for (int num2 = 0; num2 < AbbreviatedEnglishEraNames.Length; num2++)
			{
				InsertHash(array, AbbreviatedEnglishEraNames[num2], TokenType.EraToken, num2 + 1);
			}
			InsertHash(array, "T", TokenType.SEP_LocalTimeMark, 0);
			InsertHash(array, "GMT", TokenType.TimeZoneToken, 0);
			InsertHash(array, "Z", TokenType.TimeZoneToken, 0);
			InsertHash(array, "/", TokenType.SEP_Date, 0);
			InsertHash(array, ":", TokenType.SEP_Time, 0);
			_dtfiTokenHash = array;
		}
		return array;
	}

	private void PopulateSpecialTokenHashTable(TokenHashValue[] temp, ref bool useDateSepAsIgnorableSymbol)
	{
		if (LanguageName.Equals("sq"))
		{
			InsertHash(temp, "." + AMDesignator, (TokenType)1027, 0);
			InsertHash(temp, "." + PMDesignator, (TokenType)1284, 1);
		}
		InsertHash(temp, "年", TokenType.SEP_YearSuff, 0);
		InsertHash(temp, "년", TokenType.SEP_YearSuff, 0);
		InsertHash(temp, "月", TokenType.SEP_MonthSuff, 0);
		InsertHash(temp, "월", TokenType.SEP_MonthSuff, 0);
		InsertHash(temp, "日", TokenType.SEP_DaySuff, 0);
		InsertHash(temp, "일", TokenType.SEP_DaySuff, 0);
		InsertHash(temp, "時", TokenType.SEP_HourSuff, 0);
		InsertHash(temp, "时", TokenType.SEP_HourSuff, 0);
		InsertHash(temp, "分", TokenType.SEP_MinuteSuff, 0);
		InsertHash(temp, "秒", TokenType.SEP_SecondSuff, 0);
		if (!AppContextSwitches.EnforceLegacyJapaneseDateParsing && Calendar.ID == 3)
		{
			InsertHash(temp, "元", TokenType.YearNumberToken, 1);
			InsertHash(temp, "(", TokenType.IgnorableSymbol, 0);
			InsertHash(temp, ")", TokenType.IgnorableSymbol, 0);
		}
		if (LanguageName.Equals("ko"))
		{
			InsertHash(temp, "시", TokenType.SEP_HourSuff, 0);
			InsertHash(temp, "분", TokenType.SEP_MinuteSuff, 0);
			InsertHash(temp, "초", TokenType.SEP_SecondSuff, 0);
		}
		string[] dateWordsOfDTFI = new DateTimeFormatInfoScanner().GetDateWordsOfDTFI(this);
		_ = FormatFlags;
		string text = null;
		if (dateWordsOfDTFI != null)
		{
			for (int i = 0; i < dateWordsOfDTFI.Length; i++)
			{
				switch (dateWordsOfDTFI[i][0])
				{
				case '\ue000':
					text = dateWordsOfDTFI[i].Substring(1);
					AddMonthNames(temp, text);
					break;
				case '\ue001':
				{
					string text2 = dateWordsOfDTFI[i].Substring(1);
					InsertHash(temp, text2, TokenType.IgnorableSymbol, 0);
					if (DateSeparator.Trim(null).Equals(text2))
					{
						useDateSepAsIgnorableSymbol = true;
					}
					break;
				}
				default:
					InsertHash(temp, dateWordsOfDTFI[i], TokenType.DateWordToken, 0);
					if (LanguageName.Equals("eu"))
					{
						InsertHash(temp, "." + dateWordsOfDTFI[i], TokenType.DateWordToken, 0);
					}
					break;
				}
			}
		}
		if (LanguageName.Equals("ja"))
		{
			for (int j = 0; j < 7; j++)
			{
				string str = "(" + GetAbbreviatedDayName((DayOfWeek)j) + ")";
				InsertHash(temp, str, TokenType.DayOfWeekToken, j);
			}
			if (!IsJapaneseCalendar(Calendar))
			{
				DateTimeFormatInfo japaneseCalendarDTFI = GetJapaneseCalendarDTFI();
				for (int k = 1; k <= japaneseCalendarDTFI.Calendar.Eras.Length; k++)
				{
					InsertHash(temp, japaneseCalendarDTFI.GetEraName(k), TokenType.JapaneseEraToken, k);
					InsertHash(temp, japaneseCalendarDTFI.GetAbbreviatedEraName(k), TokenType.JapaneseEraToken, k);
					InsertHash(temp, japaneseCalendarDTFI.AbbreviatedEnglishEraNames[k - 1], TokenType.JapaneseEraToken, k);
				}
			}
		}
		else
		{
			if (!CultureName.Equals("zh-TW"))
			{
				return;
			}
			DateTimeFormatInfo taiwanCalendarDTFI = GetTaiwanCalendarDTFI();
			for (int l = 1; l <= taiwanCalendarDTFI.Calendar.Eras.Length; l++)
			{
				if (taiwanCalendarDTFI.GetEraName(l).Length > 0)
				{
					InsertHash(temp, taiwanCalendarDTFI.GetEraName(l), TokenType.TEraToken, l);
				}
			}
		}
	}

	private static bool IsJapaneseCalendar(Calendar calendar)
	{
		if (GlobalizationMode.Invariant)
		{
			throw new PlatformNotSupportedException();
		}
		return calendar.GetType() == typeof(JapaneseCalendar);
	}

	private void AddMonthNames(TokenHashValue[] temp, string monthPostfix)
	{
		for (int i = 1; i <= 13; i++)
		{
			string monthName = GetMonthName(i);
			if (monthName.Length > 0)
			{
				if (monthPostfix != null)
				{
					InsertHash(temp, monthName + monthPostfix, TokenType.MonthToken, i);
				}
				else
				{
					InsertHash(temp, monthName, TokenType.MonthToken, i);
				}
			}
			monthName = GetAbbreviatedMonthName(i);
			InsertHash(temp, monthName, TokenType.MonthToken, i);
		}
	}

	private static bool TryParseHebrewNumber(ref __DTString str, out bool badFormat, out int number)
	{
		number = -1;
		badFormat = false;
		int index = str.Index;
		if (!HebrewNumber.IsDigit(str.Value[index]))
		{
			return false;
		}
		HebrewNumberParsingContext context = new HebrewNumberParsingContext(0);
		HebrewNumberParsingState hebrewNumberParsingState;
		do
		{
			hebrewNumberParsingState = HebrewNumber.ParseByChar(str.Value[index++], ref context);
			if ((uint)hebrewNumberParsingState <= 1u)
			{
				return false;
			}
		}
		while (index < str.Value.Length && hebrewNumberParsingState != HebrewNumberParsingState.FoundEndOfHebrewNumber);
		if (hebrewNumberParsingState != HebrewNumberParsingState.FoundEndOfHebrewNumber)
		{
			return false;
		}
		str.Advance(index - str.Index);
		number = context.result;
		return true;
	}

	private static bool IsHebrewChar(char ch)
	{
		if (ch >= '\u0590')
		{
			return ch <= '\u05ff';
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private bool IsAllowedJapaneseTokenFollowedByNonSpaceLetter(string tokenString, char nextCh)
	{
		if (!AppContextSwitches.EnforceLegacyJapaneseDateParsing && Calendar.ID == 3 && (nextCh == "元"[0] || (tokenString == "元" && nextCh == "年"[0])))
		{
			return true;
		}
		return false;
	}

	internal bool Tokenize(TokenType TokenMask, out TokenType tokenType, out int tokenValue, ref __DTString str)
	{
		tokenType = TokenType.UnknownToken;
		tokenValue = 0;
		char c = str.m_current;
		bool flag = char.IsLetter(c);
		if (flag)
		{
			c = Culture.TextInfo.ToLower(c);
			if (!GlobalizationMode.Invariant && IsHebrewChar(c) && TokenMask == TokenType.RegularTokenMask && TryParseHebrewNumber(ref str, out var badFormat, out tokenValue))
			{
				if (badFormat)
				{
					tokenType = TokenType.UnknownToken;
					return false;
				}
				tokenType = TokenType.HebrewNumber;
				return true;
			}
		}
		int num = c % 199;
		int num2 = 1 + c % 197;
		int num3 = str.Length - str.Index;
		int num4 = 0;
		TokenHashValue[] array = _dtfiTokenHash;
		if (array == null)
		{
			array = CreateTokenHashTable();
		}
		do
		{
			TokenHashValue tokenHashValue = array[num];
			if (tokenHashValue == null)
			{
				break;
			}
			if ((tokenHashValue.tokenType & TokenMask) > (TokenType)0 && tokenHashValue.tokenString.Length <= num3)
			{
				bool flag2 = true;
				if (flag)
				{
					int num5 = str.Index + tokenHashValue.tokenString.Length;
					if (num5 > str.Length)
					{
						flag2 = false;
					}
					else if (num5 < str.Length)
					{
						char c2 = str.Value[num5];
						flag2 = !char.IsLetter(c2) || IsAllowedJapaneseTokenFollowedByNonSpaceLetter(tokenHashValue.tokenString, c2);
					}
				}
				if (flag2 && ((tokenHashValue.tokenString.Length == 1 && str.Value[str.Index] == tokenHashValue.tokenString[0]) || Culture.CompareInfo.Compare(str.Value.Slice(str.Index, tokenHashValue.tokenString.Length), tokenHashValue.tokenString, CompareOptions.IgnoreCase) == 0))
				{
					tokenType = tokenHashValue.tokenType & TokenMask;
					tokenValue = tokenHashValue.tokenValue;
					str.Advance(tokenHashValue.tokenString.Length);
					return true;
				}
				if ((tokenHashValue.tokenType == TokenType.MonthToken && HasSpacesInMonthNames) || (tokenHashValue.tokenType == TokenType.DayOfWeekToken && HasSpacesInDayNames))
				{
					int matchLength = 0;
					if (str.MatchSpecifiedWords(tokenHashValue.tokenString, checkWordBoundary: true, ref matchLength))
					{
						tokenType = tokenHashValue.tokenType & TokenMask;
						tokenValue = tokenHashValue.tokenValue;
						str.Advance(matchLength);
						return true;
					}
				}
			}
			num4++;
			num += num2;
			if (num >= 199)
			{
				num -= 199;
			}
		}
		while (num4 < 199);
		return false;
	}

	private void InsertAtCurrentHashNode(TokenHashValue[] hashTable, string str, char ch, TokenType tokenType, int tokenValue, int pos, int hashcode, int hashProbe)
	{
		TokenHashValue tokenHashValue = hashTable[hashcode];
		hashTable[hashcode] = new TokenHashValue(str, tokenType, tokenValue);
		while (++pos < 199)
		{
			hashcode += hashProbe;
			if (hashcode >= 199)
			{
				hashcode -= 199;
			}
			TokenHashValue tokenHashValue2 = hashTable[hashcode];
			if (tokenHashValue2 == null || Culture.TextInfo.ToLower(tokenHashValue2.tokenString[0]) == ch)
			{
				hashTable[hashcode] = tokenHashValue;
				if (tokenHashValue2 == null)
				{
					break;
				}
				tokenHashValue = tokenHashValue2;
			}
		}
	}

	private void InsertHash(TokenHashValue[] hashTable, string str, TokenType tokenType, int tokenValue)
	{
		if (str == null || str.Length == 0)
		{
			return;
		}
		int num = 0;
		if (char.IsWhiteSpace(str[0]) || char.IsWhiteSpace(str[str.Length - 1]))
		{
			str = str.Trim(null);
			if (str.Length == 0)
			{
				return;
			}
		}
		char c = Culture.TextInfo.ToLower(str[0]);
		int num2 = c % 199;
		int num3 = 1 + c % 197;
		do
		{
			TokenHashValue tokenHashValue = hashTable[num2];
			if (tokenHashValue == null)
			{
				hashTable[num2] = new TokenHashValue(str, tokenType, tokenValue);
				break;
			}
			if (str.Length >= tokenHashValue.tokenString.Length && CompareStringIgnoreCaseOptimized(str, 0, tokenHashValue.tokenString.Length, tokenHashValue.tokenString, 0, tokenHashValue.tokenString.Length))
			{
				if (str.Length > tokenHashValue.tokenString.Length)
				{
					InsertAtCurrentHashNode(hashTable, str, c, tokenType, tokenValue, num, num2, num3);
					break;
				}
				int tokenType2 = (int)tokenHashValue.tokenType;
				if (((tokenType2 & 0xFF) == 0 && (tokenType & TokenType.RegularTokenMask) != 0) || ((tokenType2 & 0xFF00) == 0 && (tokenType & TokenType.SeparatorTokenMask) != 0))
				{
					tokenHashValue.tokenType |= tokenType;
					if (tokenValue != 0)
					{
						tokenHashValue.tokenValue = tokenValue;
					}
				}
				break;
			}
			num++;
			num2 += num3;
			if (num2 >= 199)
			{
				num2 -= 199;
			}
		}
		while (num < 199);
	}

	private bool CompareStringIgnoreCaseOptimized(string string1, int offset1, int length1, string string2, int offset2, int length2)
	{
		if (length1 == 1 && length2 == 1 && string1[offset1] == string2[offset2])
		{
			return true;
		}
		return Culture.CompareInfo.Compare(string1, offset1, length1, string2, offset2, length2, CompareOptions.IgnoreCase) == 0;
	}
}
