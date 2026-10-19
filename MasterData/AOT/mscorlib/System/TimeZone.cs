using System.Globalization;
using System.Threading;

namespace System;

[Serializable]
[Obsolete("System.TimeZone has been deprecated.  Please investigate the use of System.TimeZoneInfo instead.")]
public abstract class TimeZone
{
	private static volatile TimeZone currentTimeZone;

	private static object s_InternalSyncObject;

	private static object InternalSyncObject
	{
		get
		{
			if (s_InternalSyncObject == null)
			{
				object value = new object();
				Interlocked.CompareExchange<object>(ref s_InternalSyncObject, value, (object)null);
			}
			return s_InternalSyncObject;
		}
	}

	public static TimeZone CurrentTimeZone
	{
		get
		{
			TimeZone timeZone = currentTimeZone;
			if (timeZone == null)
			{
				lock (InternalSyncObject)
				{
					if (currentTimeZone == null)
					{
						currentTimeZone = new CurrentSystemTimeZone();
					}
					timeZone = currentTimeZone;
				}
			}
			return timeZone;
		}
	}

	public abstract string StandardName { get; }

	public abstract string DaylightName { get; }

	internal static void ResetTimeZone()
	{
		if (currentTimeZone != null)
		{
			lock (InternalSyncObject)
			{
				currentTimeZone = null;
			}
		}
	}

	public abstract TimeSpan GetUtcOffset(DateTime time);

	public virtual DateTime ToUniversalTime(DateTime time)
	{
		if (time.Kind == DateTimeKind.Utc)
		{
			return time;
		}
		long num = time.Ticks - GetUtcOffset(time).Ticks;
		if (num > 3155378975999999999L)
		{
			return new DateTime(3155378975999999999L, DateTimeKind.Utc);
		}
		if (num < 0)
		{
			return new DateTime(0L, DateTimeKind.Utc);
		}
		return new DateTime(num, DateTimeKind.Utc);
	}

	public virtual DateTime ToLocalTime(DateTime time)
	{
		if (time.Kind == DateTimeKind.Local)
		{
			return time;
		}
		bool isAmbiguousLocalDst = false;
		long utcOffsetFromUniversalTime = ((CurrentSystemTimeZone)CurrentTimeZone).GetUtcOffsetFromUniversalTime(time, ref isAmbiguousLocalDst);
		return new DateTime(time.Ticks + utcOffsetFromUniversalTime, DateTimeKind.Local, isAmbiguousLocalDst);
	}

	public abstract DaylightTime GetDaylightChanges(int year);

	public virtual bool IsDaylightSavingTime(DateTime time)
	{
		return IsDaylightSavingTime(time, GetDaylightChanges(time.Year));
	}

	public static bool IsDaylightSavingTime(DateTime time, DaylightTime daylightTimes)
	{
		return CalculateUtcOffset(time, daylightTimes) != TimeSpan.Zero;
	}

	internal static TimeSpan CalculateUtcOffset(DateTime time, DaylightTime daylightTimes)
	{
		if (daylightTimes == null)
		{
			return TimeSpan.Zero;
		}
		if (time.Kind == DateTimeKind.Utc)
		{
			return TimeSpan.Zero;
		}
		DateTime dateTime = daylightTimes.Start + daylightTimes.Delta;
		DateTime end = daylightTimes.End;
		DateTime dateTime2;
		DateTime dateTime3;
		if (daylightTimes.Delta.Ticks > 0)
		{
			dateTime2 = end - daylightTimes.Delta;
			dateTime3 = end;
		}
		else
		{
			dateTime2 = dateTime;
			dateTime3 = dateTime - daylightTimes.Delta;
		}
		bool flag = false;
		if (dateTime > end)
		{
			if (time >= dateTime || time < end)
			{
				flag = true;
			}
		}
		else if (time >= dateTime && time < end)
		{
			flag = true;
		}
		if (flag && time >= dateTime2 && time < dateTime3)
		{
			flag = time.IsAmbiguousDaylightSavingTime();
		}
		if (flag)
		{
			return daylightTimes.Delta;
		}
		return TimeSpan.Zero;
	}

	internal static void ClearCachedData()
	{
		currentTimeZone = null;
	}
}
