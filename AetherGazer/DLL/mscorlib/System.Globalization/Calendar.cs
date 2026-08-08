using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public abstract class Calendar : ICloneable
{
	internal const long TicksPerMillisecond = 10000L;

	internal const long TicksPerSecond = 10000000L;

	internal const long TicksPerMinute = 600000000L;

	internal const long TicksPerHour = 36000000000L;

	internal const long TicksPerDay = 864000000000L;

	internal const int MillisPerSecond = 1000;

	internal const int MillisPerMinute = 60000;

	internal const int MillisPerHour = 3600000;

	internal const int MillisPerDay = 86400000;

	internal const int DaysPerYear = 365;

	internal const int DaysPer4Years = 1461;

	internal const int DaysPer100Years = 36524;

	internal const int DaysPer400Years = 146097;

	internal const int DaysTo10000 = 3652059;

	internal const long MaxMillis = 315537897600000L;

	internal const int CAL_GREGORIAN = 1;

	internal const int CAL_GREGORIAN_US = 2;

	internal const int CAL_JAPAN = 3;

	internal const int CAL_TAIWAN = 4;

	internal const int CAL_KOREA = 5;

	internal const int CAL_HIJRI = 6;

	internal const int CAL_THAI = 7;

	internal const int CAL_HEBREW = 8;

	internal const int CAL_GREGORIAN_ME_FRENCH = 9;

	internal const int CAL_GREGORIAN_ARABIC = 10;

	internal const int CAL_GREGORIAN_XLIT_ENGLISH = 11;

	internal const int CAL_GREGORIAN_XLIT_FRENCH = 12;

	internal const int CAL_JULIAN = 13;

	internal const int CAL_JAPANESELUNISOLAR = 14;

	internal const int CAL_CHINESELUNISOLAR = 15;

	internal const int CAL_SAKA = 16;

	internal const int CAL_LUNAR_ETO_CHN = 17;

	internal const int CAL_LUNAR_ETO_KOR = 18;

	internal const int CAL_LUNAR_ETO_ROKUYOU = 19;

	internal const int CAL_KOREANLUNISOLAR = 20;

	internal const int CAL_TAIWANLUNISOLAR = 21;

	internal const int CAL_PERSIAN = 22;

	internal const int CAL_UMALQURA = 23;

	internal int m_currentEraValue = -1;

	[OptionalField(VersionAdded = 2)]
	private bool m_isReadOnly;

	public const int CurrentEra = 0;

	internal int twoDigitYearMax = -1;

	[ComVisible(false)]
	public virtual DateTime MinSupportedDateTime => DateTime.MinValue;

	[ComVisible(false)]
	public virtual DateTime MaxSupportedDateTime => DateTime.MaxValue;

	internal virtual int ID => -1;

	internal virtual int BaseCalendarID => ID;

	[ComVisible(false)]
	public bool IsReadOnly => m_isReadOnly;

	internal virtual int CurrentEraValue
	{
		get
		{
			if (m_currentEraValue == -1)
			{
				m_currentEraValue = CalendarData.GetCalendarData(BaseCalendarID).iCurrentEra;
			}
			return m_currentEraValue;
		}
	}

	public abstract int[] Eras { get; }

	public virtual int TwoDigitYearMax
	{
		get
		{
			return twoDigitYearMax;
		}
		set
		{
			VerifyWritable();
			twoDigitYearMax = value;
		}
	}

	[ComVisible(false)]
	public virtual object Clone()
	{
		object obj = MemberwiseClone();
		((Calendar)obj).SetReadOnlyState(readOnly: false);
		return obj;
	}

	[ComVisible(false)]
	public static Calendar ReadOnly(Calendar calendar)
	{
		if (calendar == null)
		{
			throw new ArgumentNullException("calendar");
		}
		if (calendar.IsReadOnly)
		{
			return calendar;
		}
		Calendar obj = (Calendar)calendar.MemberwiseClone();
		obj.SetReadOnlyState(readOnly: true);
		return obj;
	}

	internal void VerifyWritable()
	{
		if (m_isReadOnly)
		{
			throw new InvalidOperationException(Environment.GetResourceString("Instance is read-only."));
		}
	}

	internal void SetReadOnlyState(bool readOnly)
	{
		m_isReadOnly = readOnly;
	}

	public abstract int GetDayOfMonth(DateTime time);

	public abstract DayOfWeek GetDayOfWeek(DateTime time);

	public abstract int GetDaysInMonth(int year, int month, int era);

	public abstract int GetDaysInYear(int year, int era);

	public abstract int GetEra(DateTime time);

	public abstract int GetMonth(DateTime time);

	public abstract int GetMonthsInYear(int year, int era);

	public abstract int GetYear(DateTime time);

	public virtual bool IsLeapYear(int year)
	{
		return IsLeapYear(year, 0);
	}

	public abstract bool IsLeapYear(int year, int era);

	public virtual DateTime ToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond)
	{
		return ToDateTime(year, month, day, hour, minute, second, millisecond, 0);
	}

	public abstract DateTime ToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, int era);

	internal virtual bool TryToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, int era, out DateTime result)
	{
		result = DateTime.MinValue;
		try
		{
			result = ToDateTime(year, month, day, hour, minute, second, millisecond, era);
			return true;
		}
		catch (ArgumentException)
		{
			return false;
		}
	}

	internal virtual bool IsValidYear(int year, int era)
	{
		if (year >= GetYear(MinSupportedDateTime))
		{
			return year <= GetYear(MaxSupportedDateTime);
		}
		return false;
	}

	internal virtual bool IsValidMonth(int year, int month, int era)
	{
		if (IsValidYear(year, era) && month >= 1)
		{
			return month <= GetMonthsInYear(year, era);
		}
		return false;
	}

	internal virtual bool IsValidDay(int year, int month, int day, int era)
	{
		if (IsValidMonth(year, month, era) && day >= 1)
		{
			return day <= GetDaysInMonth(year, month, era);
		}
		return false;
	}

	public virtual int ToFourDigitYear(int year)
	{
		if (year < 0)
		{
			throw new ArgumentOutOfRangeException("year", Environment.GetResourceString("Non-negative number required."));
		}
		if (year < 100)
		{
			return (TwoDigitYearMax / 100 - ((year > TwoDigitYearMax % 100) ? 1 : 0)) * 100 + year;
		}
		return year;
	}

	internal static long TimeToTicks(int hour, int minute, int second, int millisecond)
	{
		if (hour >= 0 && hour < 24 && minute >= 0 && minute < 60 && second >= 0 && second < 60)
		{
			if (millisecond < 0 || millisecond >= 1000)
			{
				throw new ArgumentOutOfRangeException("millisecond", string.Format(CultureInfo.InvariantCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 0, 999));
			}
			return TimeSpan.TimeToTicks(hour, minute, second) + (long)millisecond * 10000L;
		}
		throw new ArgumentOutOfRangeException(null, Environment.GetResourceString("Hour, Minute, and Second parameters describe an un-representable DateTime."));
	}

	internal static int GetSystemTwoDigitYearSetting(int CalID, int defaultYearValue)
	{
		int num = CalendarData.nativeGetTwoDigitYearMax(CalID);
		if (num < 0)
		{
			num = defaultYearValue;
		}
		return num;
	}
}
