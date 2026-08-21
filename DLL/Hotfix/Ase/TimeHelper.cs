using System;
using System.Globalization;

namespace Ase;

public static class TimeHelper
{
	private static readonly long epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).Ticks;

	public static long ClientNow()
	{
		return (DateTime.UtcNow.Ticks - epoch) / 10000;
	}

	public static long ClientNowSeconds()
	{
		return (DateTime.UtcNow.Ticks - epoch) / 10000000;
	}

	public static DateTime GetDateTimeSeconds(long timeStamp)
	{
		long num = timeStamp * 10000000;
		return new DateTime(epoch + num);
	}

	public static DateTime GetLocalDateTime(long timeStamp)
	{
		return TimeZoneInfo.ConvertTime(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc), TimeZoneInfo.Local).AddSeconds(timeStamp);
	}

	public static long Epoch()
	{
		return 0L;
	}

	public static bool StringToDateTime(string timeStr, string format, out DateTime time)
	{
		time = DateTime.MinValue;
		if (string.IsNullOrEmpty(timeStr))
		{
			return false;
		}
		return DateTime.TryParseExact(timeStr, format, CultureInfo.CurrentCulture, DateTimeStyles.None, out time);
	}

	public static long Now()
	{
		return ClientNow();
	}
}
