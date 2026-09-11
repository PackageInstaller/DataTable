using System.Runtime.InteropServices;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public class JapaneseCalendar : Calendar
{
	internal static readonly DateTime calendarMinValue = new DateTime(1868, 9, 8);

	internal static volatile EraInfo[] japaneseEraInfo;

	internal static volatile Calendar s_defaultInstance;

	internal GregorianCalendarHelper helper;

	[ComVisible(false)]
	public override DateTime MinSupportedDateTime => calendarMinValue;

	[ComVisible(false)]
	public override DateTime MaxSupportedDateTime => DateTime.MaxValue;

	internal override int ID => 3;

	public override int[] Eras => helper.Eras;

	public override int TwoDigitYearMax
	{
		get
		{
			if (twoDigitYearMax == -1)
			{
				twoDigitYearMax = Calendar.GetSystemTwoDigitYearSetting(ID, 99);
			}
			return twoDigitYearMax;
		}
		set
		{
			VerifyWritable();
			if (value < 99 || value > helper.MaxYear)
			{
				throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 99, helper.MaxYear));
			}
			twoDigitYearMax = value;
		}
	}

	internal static EraInfo[] GetEraInfo()
	{
		if (japaneseEraInfo == null)
		{
			japaneseEraInfo = GetErasFromRegistry();
			if (japaneseEraInfo == null)
			{
				japaneseEraInfo = new EraInfo[5]
				{
					new EraInfo(5, 2019, 5, 1, 2018, 1, 7981, "令和", "令", "R"),
					new EraInfo(4, 1989, 1, 8, 1988, 1, 31, "平成", "平", "H"),
					new EraInfo(3, 1926, 12, 25, 1925, 1, 64, "昭和", "昭", "S"),
					new EraInfo(2, 1912, 7, 30, 1911, 1, 15, "大正", "大", "T"),
					new EraInfo(1, 1868, 1, 1, 1867, 1, 45, "明治", "明", "M")
				};
			}
		}
		return japaneseEraInfo;
	}

	private static EraInfo[] GetErasFromRegistry()
	{
		return null;
	}

	internal static Calendar GetDefaultInstance()
	{
		if (s_defaultInstance == null)
		{
			s_defaultInstance = new JapaneseCalendar();
		}
		return s_defaultInstance;
	}

	public JapaneseCalendar()
	{
		try
		{
			new CultureInfo("ja-JP");
		}
		catch (ArgumentException innerException)
		{
			throw new TypeInitializationException(GetType().FullName, innerException);
		}
		helper = new GregorianCalendarHelper(this, GetEraInfo());
	}

	public override int GetDaysInMonth(int year, int month, int era)
	{
		return helper.GetDaysInMonth(year, month, era);
	}

	public override int GetDaysInYear(int year, int era)
	{
		return helper.GetDaysInYear(year, era);
	}

	public override int GetDayOfMonth(DateTime time)
	{
		return helper.GetDayOfMonth(time);
	}

	public override DayOfWeek GetDayOfWeek(DateTime time)
	{
		return helper.GetDayOfWeek(time);
	}

	public override int GetMonthsInYear(int year, int era)
	{
		return helper.GetMonthsInYear(year, era);
	}

	public override int GetEra(DateTime time)
	{
		return helper.GetEra(time);
	}

	public override int GetMonth(DateTime time)
	{
		return helper.GetMonth(time);
	}

	public override int GetYear(DateTime time)
	{
		return helper.GetYear(time);
	}

	public override bool IsLeapYear(int year, int era)
	{
		return helper.IsLeapYear(year, era);
	}

	public override DateTime ToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, int era)
	{
		return helper.ToDateTime(year, month, day, hour, minute, second, millisecond, era);
	}

	public override int ToFourDigitYear(int year)
	{
		if (year <= 0)
		{
			throw new ArgumentOutOfRangeException("year", Environment.GetResourceString("Positive number required."));
		}
		if (year > helper.MaxYear)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, helper.MaxYear));
		}
		return year;
	}

	internal static string[] EraNames()
	{
		EraInfo[] eraInfo = GetEraInfo();
		string[] array = new string[eraInfo.Length];
		for (int i = 0; i < eraInfo.Length; i++)
		{
			array[i] = eraInfo[eraInfo.Length - i - 1].eraName;
		}
		return array;
	}

	internal static string[] EnglishEraNames()
	{
		EraInfo[] eraInfo = GetEraInfo();
		string[] array = new string[eraInfo.Length];
		for (int i = 0; i < eraInfo.Length; i++)
		{
			array[i] = eraInfo[eraInfo.Length - i - 1].englishEraName;
		}
		return array;
	}

	internal override bool IsValidYear(int year, int era)
	{
		return helper.IsValidYear(year, era);
	}
}
