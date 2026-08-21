using System.Collections;
using System.Globalization;
using System.Runtime.CompilerServices;

namespace System;

[Serializable]
[Obsolete("System.CurrentSystemTimeZone has been deprecated.  Please investigate the use of System.TimeZoneInfo.Local instead.")]
internal class CurrentSystemTimeZone : TimeZone
{
	private long m_ticksOffset;

	private string m_standardName;

	private string m_daylightName;

	private readonly Hashtable m_CachedDaylightChanges = new Hashtable();

	public override string StandardName => m_standardName;

	public override string DaylightName => m_daylightName;

	internal CurrentSystemTimeZone()
	{
		TimeZoneInfo local = TimeZoneInfo.Local;
		m_ticksOffset = local.BaseUtcOffset.Ticks;
		m_standardName = local.StandardName;
		m_daylightName = local.DaylightName;
	}

	internal long GetUtcOffsetFromUniversalTime(DateTime time, ref bool isAmbiguousLocalDst)
	{
		TimeSpan timeSpan = new TimeSpan(m_ticksOffset);
		DaylightTime daylightChanges = GetDaylightChanges(time.Year);
		isAmbiguousLocalDst = false;
		if (daylightChanges == null || daylightChanges.Delta.Ticks == 0L)
		{
			return timeSpan.Ticks;
		}
		DateTime dateTime = daylightChanges.Start - timeSpan;
		DateTime dateTime2 = daylightChanges.End - timeSpan - daylightChanges.Delta;
		DateTime dateTime3;
		DateTime dateTime4;
		if (daylightChanges.Delta.Ticks > 0)
		{
			dateTime3 = dateTime2 - daylightChanges.Delta;
			dateTime4 = dateTime2;
		}
		else
		{
			dateTime3 = dateTime;
			dateTime4 = dateTime - daylightChanges.Delta;
		}
		bool flag = false;
		if ((!(dateTime > dateTime2)) ? (time >= dateTime && time < dateTime2) : (time < dateTime2 || time >= dateTime))
		{
			timeSpan += daylightChanges.Delta;
			if (time >= dateTime3 && time < dateTime4)
			{
				isAmbiguousLocalDst = true;
			}
		}
		return timeSpan.Ticks;
	}

	public override DateTime ToLocalTime(DateTime time)
	{
		if (time.Kind == DateTimeKind.Local)
		{
			return time;
		}
		bool isAmbiguousLocalDst = false;
		long utcOffsetFromUniversalTime = GetUtcOffsetFromUniversalTime(time, ref isAmbiguousLocalDst);
		long num = time.Ticks + utcOffsetFromUniversalTime;
		if (num > 3155378975999999999L)
		{
			return new DateTime(3155378975999999999L, DateTimeKind.Local);
		}
		if (num < 0)
		{
			return new DateTime(0L, DateTimeKind.Local);
		}
		return new DateTime(num, DateTimeKind.Local, isAmbiguousLocalDst);
	}

	public override DaylightTime GetDaylightChanges(int year)
	{
		if (year < 1 || year > 9999)
		{
			throw new ArgumentOutOfRangeException("year", SR.Format("Valid values are between {0} and {1}, inclusive.", 1, 9999));
		}
		return GetCachedDaylightChanges(year);
	}

	private static DaylightTime CreateDaylightChanges(int year)
	{
		DaylightTime daylightTime = null;
		if (TimeZoneInfo.Local.SupportsDaylightSavingTime)
		{
			TimeZoneInfo.AdjustmentRule[] adjustmentRules = TimeZoneInfo.Local.GetAdjustmentRules();
			foreach (TimeZoneInfo.AdjustmentRule adjustmentRule in adjustmentRules)
			{
				if (adjustmentRule.DateStart.Year <= year && adjustmentRule.DateEnd.Year >= year && adjustmentRule.DaylightDelta != TimeSpan.Zero)
				{
					DateTime start = TimeZoneInfo.TransitionTimeToDateTime(year, adjustmentRule.DaylightTransitionStart);
					DateTime end = TimeZoneInfo.TransitionTimeToDateTime(year, adjustmentRule.DaylightTransitionEnd);
					TimeSpan daylightDelta = adjustmentRule.DaylightDelta;
					daylightTime = new DaylightTime(start, end, daylightDelta);
					break;
				}
			}
		}
		if (daylightTime == null)
		{
			daylightTime = new DaylightTime(DateTime.MinValue, DateTime.MinValue, TimeSpan.Zero);
		}
		return daylightTime;
	}

	public override TimeSpan GetUtcOffset(DateTime time)
	{
		if (time.Kind == DateTimeKind.Utc)
		{
			return TimeSpan.Zero;
		}
		return new TimeSpan(TimeZone.CalculateUtcOffset(time, GetDaylightChanges(time.Year)).Ticks + m_ticksOffset);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool GetTimeZoneData(int year, out long[] data, out string[] names, out bool daylight_inverted);

	private DaylightTime GetCachedDaylightChanges(int year)
	{
		object key = year;
		if (!m_CachedDaylightChanges.Contains(key))
		{
			DaylightTime value = CreateDaylightChanges(year);
			lock (m_CachedDaylightChanges)
			{
				if (!m_CachedDaylightChanges.Contains(key))
				{
					m_CachedDaylightChanges.Add(key, value);
				}
			}
		}
		return (DaylightTime)m_CachedDaylightChanges[key];
	}
}
