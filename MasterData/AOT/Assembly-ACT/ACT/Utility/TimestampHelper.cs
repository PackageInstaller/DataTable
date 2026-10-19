using System;

namespace ACT.Utility;

public static class TimestampHelper
{
	private static readonly DateTime ZeroTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);

	public static long CurrentUnixTimestamp(bool milliseconds = true)
	{
		TimeSpan timeSpan = DateTime.UtcNow - ZeroTime;
		return Convert.ToInt64(milliseconds ? timeSpan.TotalMilliseconds : timeSpan.TotalSeconds);
	}

	public static DateTime ToDatetime(this long timestamp, bool milliseconds = true)
	{
		DateTime zeroTime = ZeroTime;
		if (milliseconds)
		{
			return zeroTime.AddMilliseconds(timestamp).ToLocalTime();
		}
		return zeroTime.AddSeconds(timestamp).ToLocalTime();
	}

	public static long ToUnixTimestamp(this DateTime time, bool milliseconds = true)
	{
		DateTime zeroTime = ZeroTime;
		if (milliseconds)
		{
			return (long)(time - zeroTime.ToLocalTime()).TotalMilliseconds;
		}
		return (long)(time - zeroTime.ToLocalTime()).TotalSeconds;
	}
}
