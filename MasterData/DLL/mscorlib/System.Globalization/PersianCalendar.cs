namespace System.Globalization;

[Serializable]
public class PersianCalendar : Calendar
{
	public static readonly int PersianEra = 1;

	internal static long PersianEpoch = new DateTime(622, 3, 22).Ticks / 864000000000L;

	internal static int[] DaysToMonth = new int[13]
	{
		6, 1, 29, 42352, 0, 2, 17, 42208, 0, 2,
		6, 53856, 5
	};

	internal static DateTime minDate = new DateTime(622, 3, 22);

	internal static DateTime maxDate = DateTime.MaxValue;

	public override DateTime MinSupportedDateTime => minDate;

	public override DateTime MaxSupportedDateTime => maxDate;

	internal override int BaseCalendarID => 1;

	internal override int ID => 22;

	public override int[] Eras => new int[1] { PersianEra };

	public override int TwoDigitYearMax
	{
		get
		{
			if (twoDigitYearMax == -1)
			{
				twoDigitYearMax = Calendar.GetSystemTwoDigitYearSetting(ID, 1410);
			}
			return twoDigitYearMax;
		}
		set
		{
			VerifyWritable();
			if (value < 99 || value > 9378)
			{
				throw new ArgumentOutOfRangeException("value", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 99, 9378));
			}
			twoDigitYearMax = value;
		}
	}

	private long GetAbsoluteDatePersian(int year, int month, int day)
	{
		if (year >= 1 && year <= 9378 && month >= 1 && month <= 12)
		{
			int num = DaysInPreviousMonths(month) + day - 1;
			int num2 = (int)(365.242189 * (double)(year - 1));
			return CalendricalCalculationsHelper.PersianNewYearOnOrBefore(PersianEpoch + num2 + 180) + num;
		}
		throw new ArgumentOutOfRangeException(null, Environment.GetResourceString("Year, Month, and Day parameters describe an un-representable DateTime."));
	}

	internal static void CheckTicksRange(long ticks)
	{
		if (ticks < minDate.Ticks || ticks > maxDate.Ticks)
		{
			throw new ArgumentOutOfRangeException("time", string.Format(CultureInfo.InvariantCulture, Environment.GetResourceString("Specified time is not supported in this calendar. It should be between {0} (Gregorian date) and {1} (Gregorian date), inclusive."), minDate, maxDate));
		}
	}

	internal static void CheckEraRange(int era)
	{
		if (era != 0 && era != PersianEra)
		{
			throw new ArgumentOutOfRangeException("era", Environment.GetResourceString("Era value was not valid."));
		}
	}

	internal static void CheckYearRange(int year, int era)
	{
		CheckEraRange(era);
		if (year < 1 || year > 9378)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, 9378));
		}
	}

	internal static void CheckYearMonthRange(int year, int month, int era)
	{
		CheckYearRange(year, era);
		if (year == 9378 && month > 10)
		{
			throw new ArgumentOutOfRangeException("month", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, 10));
		}
		if (month < 1 || month > 12)
		{
			throw new ArgumentOutOfRangeException("month", Environment.GetResourceString("Month must be between one and twelve."));
		}
	}

	private static int MonthFromOrdinalDay(int ordinalDay)
	{
		int i;
		for (i = 0; ordinalDay > DaysToMonth[i]; i++)
		{
		}
		return i;
	}

	private static int DaysInPreviousMonths(int month)
	{
		month--;
		return DaysToMonth[month];
	}

	internal int GetDatePart(long ticks, int part)
	{
		CheckTicksRange(ticks);
		long num = ticks / 864000000000L + 1;
		int num2 = (int)Math.Floor((double)(CalendricalCalculationsHelper.PersianNewYearOnOrBefore(num) - PersianEpoch) / 365.242189 + 0.5) + 1;
		if (part == 0)
		{
			return num2;
		}
		int num3 = (int)(num - CalendricalCalculationsHelper.GetNumberOfDays(ToDateTime(num2, 1, 1, 0, 0, 0, 0, 1)));
		if (part == 1)
		{
			return num3;
		}
		int num4 = MonthFromOrdinalDay(num3);
		if (part == 2)
		{
			return num4;
		}
		int result = num3 - DaysInPreviousMonths(num4);
		if (part == 3)
		{
			return result;
		}
		throw new InvalidOperationException(Environment.GetResourceString("Internal Error in DateTime and Calendar operations."));
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
		CheckYearMonthRange(year, month, era);
		if (month == 10 && year == 9378)
		{
			return 13;
		}
		int num = DaysToMonth[month] - DaysToMonth[month - 1];
		if (month == 12 && !IsLeapYear(year))
		{
			num--;
		}
		return num;
	}

	public override int GetDaysInYear(int year, int era)
	{
		CheckYearRange(year, era);
		if (year == 9378)
		{
			return DaysToMonth[9] + 13;
		}
		if (!IsLeapYear(year, 0))
		{
			return 365;
		}
		return 366;
	}

	public override int GetEra(DateTime time)
	{
		CheckTicksRange(time.Ticks);
		return PersianEra;
	}

	public override int GetMonth(DateTime time)
	{
		return GetDatePart(time.Ticks, 2);
	}

	public override int GetMonthsInYear(int year, int era)
	{
		CheckYearRange(year, era);
		if (year == 9378)
		{
			return 10;
		}
		return 12;
	}

	public override int GetYear(DateTime time)
	{
		return GetDatePart(time.Ticks, 0);
	}

	public override bool IsLeapYear(int year, int era)
	{
		CheckYearRange(year, era);
		if (year == 9378)
		{
			return false;
		}
		return GetAbsoluteDatePersian(year + 1, 1, 1) - GetAbsoluteDatePersian(year, 1, 1) == 366;
	}

	public override DateTime ToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, int era)
	{
		int daysInMonth = GetDaysInMonth(year, month, era);
		if (day < 1 || day > daysInMonth)
		{
			throw new ArgumentOutOfRangeException("day", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Day must be between 1 and {0} for month {1}."), daysInMonth, month));
		}
		long absoluteDatePersian = GetAbsoluteDatePersian(year, month, day);
		if (absoluteDatePersian >= 0)
		{
			return new DateTime(absoluteDatePersian * 864000000000L + Calendar.TimeToTicks(hour, minute, second, millisecond));
		}
		throw new ArgumentOutOfRangeException(null, Environment.GetResourceString("Year, Month, and Day parameters describe an un-representable DateTime."));
	}

	public override int ToFourDigitYear(int year)
	{
		if (year < 0)
		{
			throw new ArgumentOutOfRangeException("year", Environment.GetResourceString("Non-negative number required."));
		}
		if (year < 100)
		{
			return base.ToFourDigitYear(year);
		}
		if (year > 9378)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, 9378));
		}
		return year;
	}
}
