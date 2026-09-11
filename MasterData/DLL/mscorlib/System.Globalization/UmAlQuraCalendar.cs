namespace System.Globalization;

[Serializable]
public class UmAlQuraCalendar : Calendar
{
	internal struct DateMapping
	{
		internal int HijriMonthsLengthFlags;

		internal DateTime GregorianDate;

		internal DateMapping(int MonthsLengthFlags, int GYear, int GMonth, int GDay)
		{
			HijriMonthsLengthFlags = MonthsLengthFlags;
			GregorianDate = new DateTime(GYear, GMonth, GDay);
		}
	}

	private static readonly DateMapping[] HijriYearInfo = InitDateMapping();

	internal static DateTime minDate = new DateTime(1900, 4, 30);

	internal static DateTime maxDate = new DateTime(new DateTime(2077, 11, 16, 23, 59, 59, 999).Ticks + 9999);

	public override DateTime MinSupportedDateTime => minDate;

	public override DateTime MaxSupportedDateTime => maxDate;

	internal override int BaseCalendarID => 6;

	internal override int ID => 23;

	public override int[] Eras => new int[1] { 1 };

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
			if (value != 99 && (value < 1318 || value > 1500))
			{
				throw new ArgumentOutOfRangeException("value", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1318, 1500));
			}
			VerifyWritable();
			twoDigitYearMax = value;
		}
	}

	private static DateMapping[] InitDateMapping()
	{
		short[] array = new short[736]
		{
			-21845, -21846, -21846, 16354, 21845, 21845, 21845, 16357, 0, 0,
			0, 16360, -21845, -21846, -21846, 16362, 0, 0, 24064, 16650,
			0, 0, 24064, 16666, 0, 0, -31616, 16686, 0, 0,
			-10364, 16791, 0, 8192, -24481, 16898, 0, -24064, 6804, 17005,
			0, 0, 4816, 16739, 0, 0, 4816, 16755, 0, 1,
			2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
			12, 13, 14, 15, 16, 17, 18, 19, 20, 21,
			22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
			34, 60, 62, 124, 58, 42, 63, 92, 47, 0,
			0, 0, 20, 0, 32, 0, 20, 0, 12, 0,
			13, 0, 20, 0, 33, 0, 14, 0, 15, 0,
			14, 0, 20, 0, 11, 0, 20, 0, 20, 0,
			20, 0, 20, 0, 11, 0, 20, 0, 26865, -30493,
			-1867, -16652, 4249, 18803, 30421, 16179, -23387, -24185, -13867, 16281,
			-1632, -17508, 12125, -16441, 10150, -3796, -19840, 16353, -16467, 37,
			-27393, -16405, 31008, 20711, -21882, 16357, 17289, -28618, 13870, -16437,
			-22749, -22749, -22747, -22747, -22745, -22745, -22743, -22743, -22741, -22741,
			-22739, -22739, -22737, -22737, -22736, -22735, -22733, -22733, -22731, -22731,
			-22729, -22729, -22727, -22727, -22725, -22725, -22723, -22723, -22721, -22721,
			-22719, -22719, -22717, -22717, -22715, -22715, -22713, -22713, -22711, -22711,
			-22709, -22709, -22707, -22707, -22705, -22705, -22703, -22703, -22701, -22701,
			-22699, -22699, -22697, -22697, -22695, -22695, -22693, -22693, -22691, -22691,
			-22689, -22689, -22687, -22687, -22685, -22685, -22683, -22683, -22681, -22681,
			-22679, -22679, -22677, -22677, -22675, -22675, -22673, -22673, -22672, -22671,
			-22670, -22669, -22668, -22667, -22666, -22665, -22664, -22662, -22662, -22660,
			-22660, 7545, -22657, -22657, -22655, -22655, -22653, -22653, -22651, -22651,
			-22649, -22649, -22648, -22647, -22646, -22644, 0, 0, 24906, 110,
			25926, 98, 24909, 114, 28737, 114, 24909, 121, 30026, 110,
			30026, 108, 30017, 103, 25939, 112, 25423, 116, 28494, 118,
			25924, 99, -15099, 12687, 22647, 16502, -16672, -25586, -27679, 16609,
			25070, -12918, 28450, -16604, 26923, 10660, 6955, -16736, 0, 0,
			0, 0, 0, 0, 64, 0, 0, 0, 16384, 0,
			0, 0, 16448, 0, 0, 0, 0, 64, 0, 0,
			64, 64, 0, 0, 16384, 64, 0, 0, 16448, 64,
			0, 0, 0, 16384, 0, 0, 64, 16384, 0, 0,
			16384, 16384, 0, 0, 16448, 16384, 0, 0, 0, 16448,
			0, 0, 64, 16448, 0, 0, 16384, 16448, 0, 0,
			16448, 16448, 0, 0, 0, 0, 64, 0, 0, 0,
			16384, 0, 0, 0, 16448, 0, 0, 0, 0, 64,
			0, 0, 64, 64, 0, 0, 16384, 64, 0, 0,
			16448, 64, 0, 0, 0, 16384, 0, 0, 64, 16384,
			0, 0, 16384, 16384, 0, 0, 16448, 16384, 0, 0,
			0, 16448, 0, 0, 64, 16448, 0, 0, 16384, 16448,
			0, 0, 16448, 16448, 0, 0, 0, 0, 0, 0,
			0, 0, 16, 0, 0, 0, 4096, 0, 0, 0,
			4112, 0, 0, 0, 0, 16, 0, 0, 16, 16,
			0, 0, 4096, 16, 0, 0, 4112, 16, 0, 0,
			0, 4096, 0, 0, 16, 4096, 0, 0, 4096, 4096,
			0, 0, 4112, 4096, 0, 0, 0, 4112, 0, 0,
			16, 4112, 0, 0, 4096, 4112, 0, 0, 4112, 4112,
			0, 0, 0, 0, 16, 0, 0, 0, 4096, 0,
			0, 0, 4112, 0, 0, 0, 0, 16, 0, 0,
			16, 16, 0, 0, 4096, 16, 0, 0, 4112, 16,
			0, 0, 0, 4096, 0, 0, 16, 4096, 0, 0,
			4096, 4096, 0, 0, 4112, 4096, 0, 0, 0, 4112,
			0, 0, 16, 4112, 0, 0, 4096, 4112, 0, 0,
			4112, 4112, 0, 0, 0, 0, 0, 0, 0, 0,
			4, 0, 0, 0, 1024, 0, 0, 0, 1028, 0,
			0, 0, 0, 4, 0, 0, 4, 4, 0, 0,
			1024, 4, 0, 0, 1028, 4, 0, 0, 0, 1024,
			0, 0, 4, 1024, 0, 0, 1024, 1024, 0, 0,
			1028, 1024, 0, 0, 0, 1028, 0, 0, 4, 1028,
			0, 0, 1024, 1028, 0, 0, 1028, 1028, 0, 0,
			0, 0, 4, 0, 0, 0, 1024, 0, 0, 0,
			1028, 0, 0, 0, 0, 4, 0, 0, 4, 4,
			0, 0, 1024, 4, 0, 0, 1028, 4, 0, 0,
			0, 1024, 0, 0, 4, 1024, 0, 0, 1024, 1024,
			0, 0, 1028, 1024, 0, 0, 0, 1028, 0, 0,
			4, 1028, 0, 0, 1024, 1028, 0, 0, 1028, 1028,
			0, 0, 0, 0, 0, 0, 0, 0, 1, 0,
			0, 0, 256, 0, 0, 0, 257, 0, 0, 0,
			0, 1, 0, 0, 1, 1, 0, 0, 256, 1,
			0, 0, 257, 1, 0, 0, 0, 256, 0, 0,
			1, 256, 0, 0, 256, 256
		};
		DateMapping[] array2 = new DateMapping[array.Length / 4];
		for (int i = 0; i < array2.Length; i++)
		{
			array2[i] = new DateMapping(array[i * 4], array[i * 4 + 1], array[i * 4 + 2], array[i * 4 + 3]);
		}
		return array2;
	}

	private static void ConvertHijriToGregorian(int HijriYear, int HijriMonth, int HijriDay, ref int yg, ref int mg, ref int dg)
	{
		int num = HijriDay - 1;
		int num2 = HijriYear - 1318;
		DateTime gregorianDate = HijriYearInfo[num2].GregorianDate;
		int num3 = HijriYearInfo[num2].HijriMonthsLengthFlags;
		for (int i = 1; i < HijriMonth; i++)
		{
			num += 29 + (num3 & 1);
			num3 >>= 1;
		}
		gregorianDate = gregorianDate.AddDays(num);
		yg = gregorianDate.Year;
		mg = gregorianDate.Month;
		dg = gregorianDate.Day;
	}

	private static long GetAbsoluteDateUmAlQura(int year, int month, int day)
	{
		int yg = 0;
		int mg = 0;
		int dg = 0;
		ConvertHijriToGregorian(year, month, day, ref yg, ref mg, ref dg);
		return GregorianCalendar.GetAbsoluteDate(yg, mg, dg);
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
		if (era != 0 && era != 1)
		{
			throw new ArgumentOutOfRangeException("era", Environment.GetResourceString("Era value was not valid."));
		}
	}

	internal static void CheckYearRange(int year, int era)
	{
		CheckEraRange(era);
		if (year < 1318 || year > 1500)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1318, 1500));
		}
	}

	internal static void CheckYearMonthRange(int year, int month, int era)
	{
		CheckYearRange(year, era);
		if (month < 1 || month > 12)
		{
			throw new ArgumentOutOfRangeException("month", Environment.GetResourceString("Month must be between one and twelve."));
		}
	}

	private static void ConvertGregorianToHijri(DateTime time, ref int HijriYear, ref int HijriMonth, ref int HijriDay)
	{
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = (int)((time.Ticks - minDate.Ticks) / 864000000000L) / 355;
		while (time.CompareTo(HijriYearInfo[++num4].GregorianDate) > 0)
		{
		}
		if (time.CompareTo(HijriYearInfo[num4].GregorianDate) != 0)
		{
			num4--;
		}
		TimeSpan timeSpan = time.Subtract(HijriYearInfo[num4].GregorianDate);
		num = num4 + 1318;
		num2 = 1;
		num3 = 1;
		double num5 = timeSpan.TotalDays;
		int num6 = HijriYearInfo[num4].HijriMonthsLengthFlags;
		int num7 = 29 + (num6 & 1);
		while (num5 >= (double)num7)
		{
			num5 -= (double)num7;
			num6 >>= 1;
			num7 = 29 + (num6 & 1);
			num2++;
		}
		num3 += (int)num5;
		HijriDay = num3;
		HijriMonth = num2;
		HijriYear = num;
	}

	internal virtual int GetDatePart(DateTime time, int part)
	{
		int HijriYear = 0;
		int HijriMonth = 0;
		int HijriDay = 0;
		CheckTicksRange(time.Ticks);
		ConvertGregorianToHijri(time, ref HijriYear, ref HijriMonth, ref HijriDay);
		return part switch
		{
			0 => HijriYear, 
			2 => HijriMonth, 
			3 => HijriDay, 
			1 => (int)(GetAbsoluteDateUmAlQura(HijriYear, HijriMonth, HijriDay) - GetAbsoluteDateUmAlQura(HijriYear, 1, 1) + 1), 
			_ => throw new InvalidOperationException(Environment.GetResourceString("Internal Error in DateTime and Calendar operations.")), 
		};
	}

	public override int GetDayOfMonth(DateTime time)
	{
		return GetDatePart(time, 3);
	}

	public override DayOfWeek GetDayOfWeek(DateTime time)
	{
		return (DayOfWeek)((int)(time.Ticks / 864000000000L + 1) % 7);
	}

	public override int GetDaysInMonth(int year, int month, int era)
	{
		CheckYearMonthRange(year, month, era);
		if ((HijriYearInfo[year - 1318].HijriMonthsLengthFlags & (1 << month - 1)) == 0)
		{
			return 29;
		}
		return 30;
	}

	internal static int RealGetDaysInYear(int year)
	{
		int num = 0;
		int num2 = HijriYearInfo[year - 1318].HijriMonthsLengthFlags;
		for (int i = 1; i <= 12; i++)
		{
			num += 29 + (num2 & 1);
			num2 >>= 1;
		}
		return num;
	}

	public override int GetDaysInYear(int year, int era)
	{
		CheckYearRange(year, era);
		return RealGetDaysInYear(year);
	}

	public override int GetEra(DateTime time)
	{
		CheckTicksRange(time.Ticks);
		return 1;
	}

	public override int GetMonth(DateTime time)
	{
		return GetDatePart(time, 2);
	}

	public override int GetMonthsInYear(int year, int era)
	{
		CheckYearRange(year, era);
		return 12;
	}

	public override int GetYear(DateTime time)
	{
		return GetDatePart(time, 0);
	}

	public override bool IsLeapYear(int year, int era)
	{
		CheckYearRange(year, era);
		if (RealGetDaysInYear(year) == 355)
		{
			return true;
		}
		return false;
	}

	public override DateTime ToDateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, int era)
	{
		if (day >= 1 && day <= 29)
		{
			CheckYearMonthRange(year, month, era);
		}
		else
		{
			int daysInMonth = GetDaysInMonth(year, month, era);
			if (day < 1 || day > daysInMonth)
			{
				throw new ArgumentOutOfRangeException("day", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Day must be between 1 and {0} for month {1}."), daysInMonth, month));
			}
		}
		long absoluteDateUmAlQura = GetAbsoluteDateUmAlQura(year, month, day);
		if (absoluteDateUmAlQura >= 0)
		{
			return new DateTime(absoluteDateUmAlQura * 864000000000L + Calendar.TimeToTicks(hour, minute, second, millisecond));
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
		if (year < 1318 || year > 1500)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1318, 1500));
		}
		return year;
	}
}
