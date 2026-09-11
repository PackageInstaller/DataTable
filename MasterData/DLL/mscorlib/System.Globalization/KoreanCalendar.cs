using System.Runtime.InteropServices;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public class KoreanCalendar : Calendar
{
	internal static EraInfo[] koreanEraInfo = new EraInfo[1]
	{
		new EraInfo(1, 1, 1, 1, -2333, 2334, 12332)
	};

	internal GregorianCalendarHelper helper;

	[ComVisible(false)]
	public override DateTime MinSupportedDateTime => DateTime.MinValue;

	[ComVisible(false)]
	public override DateTime MaxSupportedDateTime => DateTime.MaxValue;

	internal override int ID => 5;

	public override int[] Eras => helper.Eras;

	public override int TwoDigitYearMax
	{
		get
		{
			if (twoDigitYearMax == -1)
			{
				twoDigitYearMax = Calendar.GetSystemTwoDigitYearSetting(ID, 4362);
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

	public KoreanCalendar()
	{
		try
		{
			new CultureInfo("ko-KR");
		}
		catch (ArgumentException innerException)
		{
			throw new TypeInitializationException(GetType().FullName, innerException);
		}
		helper = new GregorianCalendarHelper(this, koreanEraInfo);
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
		if (year < 0)
		{
			throw new ArgumentOutOfRangeException("year", Environment.GetResourceString("Non-negative number required."));
		}
		return helper.ToFourDigitYear(year, TwoDigitYearMax);
	}
}
