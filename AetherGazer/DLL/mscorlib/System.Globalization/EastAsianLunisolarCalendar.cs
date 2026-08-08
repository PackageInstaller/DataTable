using System.Runtime.InteropServices;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public abstract class EastAsianLunisolarCalendar : Calendar
{
	internal static readonly int[] DaysToMonth365 = new int[12]
	{
		947, 953, 967, 971, 977, 983, 991, 997, 1009, 1013,
		1019, 1021
	};

	internal static readonly int[] DaysToMonth366 = new int[12]
	{
		0, 2, 1, 44368, 2, 1, 22, 19880, 0, 2,
		10, 19296
	};

	internal abstract int MinCalendarYear { get; }

	internal abstract int MaxCalendarYear { get; }

	internal abstract EraInfo[] CalEraInfo { get; }

	internal abstract DateTime MinDate { get; }

	internal abstract DateTime MaxDate { get; }

	public override int TwoDigitYearMax
	{
		get
		{
			if (twoDigitYearMax == -1)
			{
				twoDigitYearMax = Calendar.GetSystemTwoDigitYearSetting(BaseCalendarID, GetYear(new DateTime(2029, 1, 1)));
			}
			return twoDigitYearMax;
		}
		set
		{
			VerifyWritable();
			if (value < 99 || value > MaxCalendarYear)
			{
				throw new ArgumentOutOfRangeException("value", Environment.GetResourceString("Valid values are between {0} and {1}, inclusive.", 99, MaxCalendarYear));
			}
			twoDigitYearMax = value;
		}
	}

	internal abstract int GetYearInfo(int LunarYear, int Index);

	internal abstract int GetYear(int year, DateTime time);

	internal abstract int GetGregorianYear(int year, int era);

	internal int MinEraCalendarYear(int era)
	{
		EraInfo[] calEraInfo = CalEraInfo;
		if (calEraInfo == null)
		{
			return MinCalendarYear;
		}
		if (era == 0)
		{
			era = CurrentEraValue;
		}
		if (era == GetEra(MinDate))
		{
			return GetYear(MinCalendarYear, MinDate);
		}
		for (int i = 0; i < calEraInfo.Length; i++)
		{
			if (era == calEraInfo[i].era)
			{
				return calEraInfo[i].minEraYear;
			}
		}
		throw new ArgumentOutOfRangeException("era", Environment.GetResourceString("Era value was not valid."));
	}

	internal int MaxEraCalendarYear(int era)
	{
		EraInfo[] calEraInfo = CalEraInfo;
		if (calEraInfo == null)
		{
			return MaxCalendarYear;
		}
		if (era == 0)
		{
			era = CurrentEraValue;
		}
		if (era == GetEra(MaxDate))
		{
			return GetYear(MaxCalendarYear, MaxDate);
		}
		for (int i = 0; i < calEraInfo.Length; i++)
		{
			if (era == calEraInfo[i].era)
			{
				return calEraInfo[i].maxEraYear;
			}
		}
		throw new ArgumentOutOfRangeException("era", Environment.GetResourceString("Era value was not valid."));
	}

	internal EastAsianLunisolarCalendar()
	{
	}

	internal void CheckTicksRange(long ticks)
	{
		if (ticks < MinSupportedDateTime.Ticks || ticks > MaxSupportedDateTime.Ticks)
		{
			throw new ArgumentOutOfRangeException("time", string.Format(CultureInfo.InvariantCulture, Environment.GetResourceString("Specified time is not supported in this calendar. It should be between {0} (Gregorian date) and {1} (Gregorian date), inclusive."), MinSupportedDateTime, MaxSupportedDateTime));
		}
	}

	internal void CheckEraRange(int era)
	{
		if (era == 0)
		{
			era = CurrentEraValue;
		}
		if (era < GetEra(MinDate) || era > GetEra(MaxDate))
		{
			throw new ArgumentOutOfRangeException("era", Environment.GetResourceString("Era value was not valid."));
		}
	}

	internal int CheckYearRange(int year, int era)
	{
		CheckEraRange(era);
		year = GetGregorianYear(year, era);
		if (year < MinCalendarYear || year > MaxCalendarYear)
		{
			throw new ArgumentOutOfRangeException("year", Environment.GetResourceString("Valid values are between {0} and {1}, inclusive.", MinEraCalendarYear(era), MaxEraCalendarYear(era)));
		}
		return year;
	}

	internal int CheckYearMonthRange(int year, int month, int era)
	{
		year = CheckYearRange(year, era);
		if (month == 13 && GetYearInfo(year, 0) == 0)
		{
			throw new ArgumentOutOfRangeException("month", Environment.GetResourceString("Month must be between one and twelve."));
		}
		if (month < 1 || month > 13)
		{
			throw new ArgumentOutOfRangeException("month", Environment.GetResourceString("Month must be between one and twelve."));
		}
		return year;
	}

	internal int InternalGetDaysInMonth(int year, int month)
	{
		int num = 32768;
		num >>= month - 1;
		if ((GetYearInfo(year, 3) & num) == 0)
		{
			return 29;
		}
		return 30;
	}

	public override int GetDaysInMonth(int year, int month, int era)
	{
		year = CheckYearMonthRange(year, month, era);
		return InternalGetDaysInMonth(year, month);
	}

	private static int GregorianIsLeapYear(int y)
	{
		if (y % 4 == 0)
		{
			if (y % 100 == 0)
			{
				if (y % 400 == 0)
				{
					return 1;
				}
				return 0;
			}
			return 1;
		}
		return 0;
	}

	public override DateTime ToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, int era)
	{
		year = CheckYearMonthRange(year, month, era);
		int num = InternalGetDaysInMonth(year, month);
		if (day < 1 || day > num)
		{
			throw new ArgumentOutOfRangeException("day", Environment.GetResourceString("Day must be between 1 and {0} for month {1}.", num, month));
		}
		int nSolarYear = 0;
		int nSolarMonth = 0;
		int nSolarDay = 0;
		if (LunarToGregorian(year, month, day, ref nSolarYear, ref nSolarMonth, ref nSolarDay))
		{
			return new DateTime(nSolarYear, nSolarMonth, nSolarDay, hour, minute, second, millisecond);
		}
		throw new ArgumentOutOfRangeException(null, Environment.GetResourceString("Year, Month, and Day parameters describe an un-representable DateTime."));
	}

	internal void GregorianToLunar(int nSYear, int nSMonth, int nSDate, ref int nLYear, ref int nLMonth, ref int nLDate)
	{
		int num = ((GregorianIsLeapYear(nSYear) == 1) ? DaysToMonth366[nSMonth - 1] : DaysToMonth365[nSMonth - 1]) + nSDate;
		nLYear = nSYear;
		int yearInfo;
		int yearInfo2;
		if (nLYear == MaxCalendarYear + 1)
		{
			nLYear--;
			num += ((GregorianIsLeapYear(nLYear) == 1) ? 366 : 365);
			yearInfo = GetYearInfo(nLYear, 1);
			yearInfo2 = GetYearInfo(nLYear, 2);
		}
		else
		{
			yearInfo = GetYearInfo(nLYear, 1);
			yearInfo2 = GetYearInfo(nLYear, 2);
			if (nSMonth < yearInfo || (nSMonth == yearInfo && nSDate < yearInfo2))
			{
				nLYear--;
				num += ((GregorianIsLeapYear(nLYear) == 1) ? 366 : 365);
				yearInfo = GetYearInfo(nLYear, 1);
				yearInfo2 = GetYearInfo(nLYear, 2);
			}
		}
		num -= DaysToMonth365[yearInfo - 1];
		num -= yearInfo2 - 1;
		int num2 = 32768;
		int yearInfo3 = GetYearInfo(nLYear, 3);
		int num3 = (((yearInfo3 & num2) != 0) ? 30 : 29);
		nLMonth = 1;
		while (num > num3)
		{
			num -= num3;
			nLMonth++;
			num2 >>= 1;
			num3 = (((yearInfo3 & num2) != 0) ? 30 : 29);
		}
		nLDate = num;
	}

	internal bool LunarToGregorian(int nLYear, int nLMonth, int nLDate, ref int nSolarYear, ref int nSolarMonth, ref int nSolarDay)
	{
		if (nLDate < 1 || nLDate > 30)
		{
			return false;
		}
		int num = nLDate - 1;
		for (int i = 1; i < nLMonth; i++)
		{
			num += InternalGetDaysInMonth(nLYear, i);
		}
		int yearInfo = GetYearInfo(nLYear, 1);
		int yearInfo2 = GetYearInfo(nLYear, 2);
		int num2 = GregorianIsLeapYear(nLYear);
		int[] array = ((num2 == 1) ? DaysToMonth366 : DaysToMonth365);
		nSolarDay = yearInfo2;
		if (yearInfo > 1)
		{
			nSolarDay += array[yearInfo - 1];
		}
		nSolarDay += num;
		if (nSolarDay > num2 + 365)
		{
			nSolarYear = nLYear + 1;
			nSolarDay -= num2 + 365;
		}
		else
		{
			nSolarYear = nLYear;
		}
		nSolarMonth = 1;
		while (nSolarMonth < 12 && array[nSolarMonth] < nSolarDay)
		{
			nSolarMonth++;
		}
		nSolarDay -= array[nSolarMonth - 1];
		return true;
	}

	internal void TimeToLunar(DateTime time, ref int year, ref int month, ref int day)
	{
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		Calendar defaultInstance = GregorianCalendar.GetDefaultInstance();
		num = defaultInstance.GetYear(time);
		num2 = defaultInstance.GetMonth(time);
		num3 = defaultInstance.GetDayOfMonth(time);
		GregorianToLunar(num, num2, num3, ref year, ref month, ref day);
	}

	public override int GetDayOfMonth(DateTime time)
	{
		CheckTicksRange(time.Ticks);
		int year = 0;
		int month = 0;
		int day = 0;
		TimeToLunar(time, ref year, ref month, ref day);
		return day;
	}

	public override int GetDaysInYear(int year, int era)
	{
		year = CheckYearRange(year, era);
		int num = 0;
		int num2 = (InternalIsLeapYear(year) ? 13 : 12);
		while (num2 != 0)
		{
			num += InternalGetDaysInMonth(year, num2--);
		}
		return num;
	}

	public override int GetMonth(DateTime time)
	{
		CheckTicksRange(time.Ticks);
		int year = 0;
		int month = 0;
		int day = 0;
		TimeToLunar(time, ref year, ref month, ref day);
		return month;
	}

	public override int GetYear(DateTime time)
	{
		CheckTicksRange(time.Ticks);
		int year = 0;
		int month = 0;
		int day = 0;
		TimeToLunar(time, ref year, ref month, ref day);
		return GetYear(year, time);
	}

	public override DayOfWeek GetDayOfWeek(DateTime time)
	{
		CheckTicksRange(time.Ticks);
		return (DayOfWeek)((int)(time.Ticks / 864000000000L + 1) % 7);
	}

	public override int GetMonthsInYear(int year, int era)
	{
		year = CheckYearRange(year, era);
		if (!InternalIsLeapYear(year))
		{
			return 12;
		}
		return 13;
	}

	internal bool InternalIsLeapYear(int year)
	{
		return GetYearInfo(year, 0) != 0;
	}

	public override bool IsLeapYear(int year, int era)
	{
		year = CheckYearRange(year, era);
		return InternalIsLeapYear(year);
	}

	public override int ToFourDigitYear(int year)
	{
		if (year < 0)
		{
			throw new ArgumentOutOfRangeException("year", Environment.GetResourceString("Non-negative number required."));
		}
		year = base.ToFourDigitYear(year);
		CheckYearRange(year, 0);
		return year;
	}
}
