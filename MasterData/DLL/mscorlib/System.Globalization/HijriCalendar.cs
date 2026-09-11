using System.Runtime.InteropServices;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public class HijriCalendar : Calendar
{
	public static readonly int HijriEra = 1;

	internal static readonly int[] HijriMonthDays = new int[13]
	{
		5308497, 5308497, 5308497, 5308824, 5308825, 13828177, 26870170, 26870170, 26870170, 26870170,
		26870170, 26870170, 26870170
	};

	private int m_HijriAdvance = int.MinValue;

	internal static readonly DateTime calendarMinValue = new DateTime(622, 7, 18);

	internal static readonly DateTime calendarMaxValue = DateTime.MaxValue;

	[ComVisible(false)]
	public override DateTime MinSupportedDateTime => calendarMinValue;

	[ComVisible(false)]
	public override DateTime MaxSupportedDateTime => calendarMaxValue;

	internal override int ID => 6;

	public int HijriAdjustment
	{
		get
		{
			if (m_HijriAdvance == int.MinValue)
			{
				m_HijriAdvance = GetAdvanceHijriDate();
			}
			return m_HijriAdvance;
		}
	}

	public override int[] Eras => new int[1] { HijriEra };

	public override int TwoDigitYearMax
	{
		get
		{
			if (twoDigitYearMax == -1)
			{
				twoDigitYearMax = Calendar.GetSystemTwoDigitYearSetting(ID, 1451);
			}
			return twoDigitYearMax;
		}
		set
		{
			VerifyWritable();
			if (value < 99 || value > 9666)
			{
				throw new ArgumentOutOfRangeException("value", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 99, 9666));
			}
			twoDigitYearMax = value;
		}
	}

	private long GetAbsoluteDateHijri(int y, int m, int d)
	{
		return DaysUpToHijriYear(y) + HijriMonthDays[m - 1] + d - 1 - HijriAdjustment;
	}

	private long DaysUpToHijriYear(int HijriYear)
	{
		int num = (HijriYear - 1) / 30 * 30;
		int num2 = HijriYear - num - 1;
		long num3 = (long)num * 10631L / 30 + 227013;
		while (num2 > 0)
		{
			num3 += 354 + (IsLeapYear(num2, 0) ? 1 : 0);
			num2--;
		}
		return num3;
	}

	private static int GetAdvanceHijriDate()
	{
		return 0;
	}

	internal static void CheckTicksRange(long ticks)
	{
		if (ticks < calendarMinValue.Ticks || ticks > calendarMaxValue.Ticks)
		{
			throw new ArgumentOutOfRangeException("time", string.Format(CultureInfo.InvariantCulture, Environment.GetResourceString("Specified time is not supported in this calendar. It should be between {0} (Gregorian date) and {1} (Gregorian date), inclusive."), calendarMinValue, calendarMaxValue));
		}
	}

	internal static void CheckEraRange(int era)
	{
		if (era != 0 && era != HijriEra)
		{
			throw new ArgumentOutOfRangeException("era", Environment.GetResourceString("Era value was not valid."));
		}
	}

	internal static void CheckYearRange(int year, int era)
	{
		CheckEraRange(era);
		if (year < 1 || year > 9666)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, 9666));
		}
	}

	internal static void CheckYearMonthRange(int year, int month, int era)
	{
		CheckYearRange(year, era);
		if (year == 9666 && month > 4)
		{
			throw new ArgumentOutOfRangeException("month", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, 4));
		}
		if (month < 1 || month > 12)
		{
			throw new ArgumentOutOfRangeException("month", Environment.GetResourceString("Month must be between one and twelve."));
		}
	}

	internal virtual int GetDatePart(long ticks, int part)
	{
		CheckTicksRange(ticks);
		long num = ticks / 864000000000L + 1;
		num += HijriAdjustment;
		int num2 = (int)((num - 227013) * 30 / 10631) + 1;
		long num3 = DaysUpToHijriYear(num2);
		long num4 = GetDaysInYear(num2, 0);
		if (num < num3)
		{
			num3 -= num4;
			num2--;
		}
		else if (num == num3)
		{
			num2--;
			num3 -= GetDaysInYear(num2, 0);
		}
		else if (num > num3 + num4)
		{
			num3 += num4;
			num2++;
		}
		if (part == 0)
		{
			return num2;
		}
		int i = 1;
		num -= num3;
		if (part == 1)
		{
			return (int)num;
		}
		for (; i <= 12 && num > HijriMonthDays[i - 1]; i++)
		{
		}
		i--;
		if (part == 2)
		{
			return i;
		}
		int result = (int)(num - HijriMonthDays[i - 1]);
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
		if (month == 12)
		{
			if (!IsLeapYear(year, 0))
			{
				return 29;
			}
			return 30;
		}
		if (month % 2 != 1)
		{
			return 29;
		}
		return 30;
	}

	public override int GetDaysInYear(int year, int era)
	{
		CheckYearRange(year, era);
		if (!IsLeapYear(year, 0))
		{
			return 354;
		}
		return 355;
	}

	public override int GetEra(DateTime time)
	{
		CheckTicksRange(time.Ticks);
		return HijriEra;
	}

	public override int GetMonth(DateTime time)
	{
		return GetDatePart(time.Ticks, 2);
	}

	public override int GetMonthsInYear(int year, int era)
	{
		CheckYearRange(year, era);
		return 12;
	}

	public override int GetYear(DateTime time)
	{
		return GetDatePart(time.Ticks, 0);
	}

	public override bool IsLeapYear(int year, int era)
	{
		CheckYearRange(year, era);
		return (year * 11 + 14) % 30 < 11;
	}

	public override DateTime ToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, int era)
	{
		int daysInMonth = GetDaysInMonth(year, month, era);
		if (day < 1 || day > daysInMonth)
		{
			throw new ArgumentOutOfRangeException("day", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Day must be between 1 and {0} for month {1}."), daysInMonth, month));
		}
		long absoluteDateHijri = GetAbsoluteDateHijri(year, month, day);
		if (absoluteDateHijri >= 0)
		{
			return new DateTime(absoluteDateHijri * 864000000000L + Calendar.TimeToTicks(hour, minute, second, millisecond));
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
		if (year > 9666)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1, 9666));
		}
		return year;
	}
}
