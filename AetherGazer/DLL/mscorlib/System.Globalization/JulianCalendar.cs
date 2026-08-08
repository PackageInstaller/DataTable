using System.Runtime.InteropServices;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public class JulianCalendar : Calendar
{
	public static readonly int JulianEra = 1;

	private static readonly int[] DaysToMonth365 = new int[13]
	{
		771751936, 774778414, 774778414, 774778414, 774778414, 774778414, 774778414, 151662126, 774766592, 774778414,
		774778414, 774778414, 774778414
	};

	private static readonly int[] DaysToMonth366 = new int[13]
	{
		0, 2, 5, 22176, 4, 1, 25, 43736, 0, 2,
		13, 9680, 0
	};

	internal int MaxYear = 9999;

	[ComVisible(false)]
	public override DateTime MinSupportedDateTime => DateTime.MinValue;

	[ComVisible(false)]
	public override DateTime MaxSupportedDateTime => DateTime.MaxValue;

	internal override int ID => 13;

	public override int[] Eras => new int[1] { JulianEra };

	public override int TwoDigitYearMax
	{
		get
		{
			return twoDigitYearMax;
		}
		set
		{
			VerifyWritable();
			if (value < 99 || value > MaxYear)
			{
				throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 99, MaxYear));
			}
			twoDigitYearMax = value;
		}
	}

	public JulianCalendar()
	{
		twoDigitYearMax = 2029;
	}

	internal static void CheckEraRange(int era)
	{
		if (era != 0 && era != JulianEra)
		{
			throw new ArgumentOutOfRangeException("era", Environment.GetResourceString("Era value was not valid."));
		}
	}

	internal void CheckYearEraRange(int year, int era)
	{
		CheckEraRange(era);
		if (year <= 0 || year > MaxYear)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, MaxYear));
		}
	}

	internal static void CheckMonthRange(int month)
	{
		if (month < 1 || month > 12)
		{
			throw new ArgumentOutOfRangeException("month", Environment.GetResourceString("Month must be between one and twelve."));
		}
	}

	internal static void CheckDayRange(int year, int month, int day)
	{
		if (year == 1 && month == 1 && day < 3)
		{
			throw new ArgumentOutOfRangeException(null, Environment.GetResourceString("Year, Month, and Day parameters describe an un-representable DateTime."));
		}
		int[] array = ((year % 4 == 0) ? DaysToMonth366 : DaysToMonth365);
		int num = array[month] - array[month - 1];
		if (day < 1 || day > num)
		{
			throw new ArgumentOutOfRangeException("day", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, num));
		}
	}

	internal static int GetDatePart(long ticks, int part)
	{
		int num = (int)((ticks + 1728000000000L) / 864000000000L);
		int num2 = num / 1461;
		num -= num2 * 1461;
		int num3 = num / 365;
		if (num3 == 4)
		{
			num3 = 3;
		}
		if (part == 0)
		{
			return num2 * 4 + num3 + 1;
		}
		num -= num3 * 365;
		if (part == 1)
		{
			return num + 1;
		}
		int[] array = ((num3 == 3) ? DaysToMonth366 : DaysToMonth365);
		int i;
		for (i = num >> 6; num >= array[i]; i++)
		{
		}
		if (part == 2)
		{
			return i;
		}
		return num - array[i - 1] + 1;
	}

	internal static long DateToTicks(int year, int month, int day)
	{
		int[] array = ((year % 4 == 0) ? DaysToMonth366 : DaysToMonth365);
		int num = year - 1;
		return (num * 365 + num / 4 + array[month - 1] + day - 1 - 2) * 864000000000L;
	}

	public override int GetDayOfMonth(DateTime time)
	{
		return GetDatePart(time.Ticks, 3);
	}

	public override DayOfWeek GetDayOfWeek(DateTime time)
	{
		return (DayOfWeek)((int)(time.Ticks / 864000000000L + 1) % 7);
	}

	public override int GetDaysInMonth(int year, int month, int era)
	{
		CheckYearEraRange(year, era);
		CheckMonthRange(month);
		int[] array = ((year % 4 == 0) ? DaysToMonth366 : DaysToMonth365);
		return array[month] - array[month - 1];
	}

	public override int GetDaysInYear(int year, int era)
	{
		if (!IsLeapYear(year, era))
		{
			return 365;
		}
		return 366;
	}

	public override int GetEra(DateTime time)
	{
		return JulianEra;
	}

	public override int GetMonth(DateTime time)
	{
		return GetDatePart(time.Ticks, 2);
	}

	public override int GetMonthsInYear(int year, int era)
	{
		CheckYearEraRange(year, era);
		return 12;
	}

	public override int GetYear(DateTime time)
	{
		return GetDatePart(time.Ticks, 0);
	}

	public override bool IsLeapYear(int year, int era)
	{
		CheckYearEraRange(year, era);
		return year % 4 == 0;
	}

	public override DateTime ToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, int era)
	{
		CheckYearEraRange(year, era);
		CheckMonthRange(month);
		CheckDayRange(year, month, day);
		if (millisecond < 0 || millisecond >= 1000)
		{
			throw new ArgumentOutOfRangeException("millisecond", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 0, 999));
		}
		if (hour >= 0 && hour < 24 && minute >= 0 && minute < 60 && second >= 0 && second < 60)
		{
			return new DateTime(DateToTicks(year, month, day) + new TimeSpan(0, hour, minute, second, millisecond).Ticks);
		}
		throw new ArgumentOutOfRangeException(null, Environment.GetResourceString("Hour, Minute, and Second parameters describe an un-representable DateTime."));
	}

	public override int ToFourDigitYear(int year)
	{
		if (year < 0)
		{
			throw new ArgumentOutOfRangeException("year", Environment.GetResourceString("Non-negative number required."));
		}
		if (year > MaxYear)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Argument must be between {0} and {1}."), 1, MaxYear));
		}
		return base.ToFourDigitYear(year);
	}
}
