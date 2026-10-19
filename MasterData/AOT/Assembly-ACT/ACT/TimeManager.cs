using System;
using System.Collections;
using ACT.Battle;
using UnityEngine;

namespace ACT;

public static class TimeManager
{
	public abstract class TimeZone
	{
		protected long mStartTimeTicks;

		public long StartTimeTicks => mStartTimeTicks;

		public abstract long NowTimestamp { get; }

		public abstract int NowTimestampSecond { get; }

		public abstract DateTime Now { get; }

		public TimeZone(long nStartTimeTicks)
		{
			mStartTimeTicks = nStartTimeTicks;
		}

		public DateTime GetDateTime(long nTimestamp)
		{
			return new DateTime(mStartTimeTicks + nTimestamp * 10000, DateTimeKind.Unspecified);
		}

		public long GetTimestamp(DateTime rDateTime)
		{
			return (rDateTime.Ticks - mStartTimeTicks) / 10000;
		}

		public string GetDateTimeString(long nTimestamp, string rFormat = "yyyy/MM/dd")
		{
			return TimeManager.GetDateTimeString(GetDateTime(nTimestamp), rFormat);
		}
	}

	public class ServerTimeZone : TimeZone
	{
		private long mNowTimestamp;

		public long EnterGameTimestamp { get; private set; }

		public override long NowTimestamp => mNowTimestamp;

		public override int NowTimestampSecond => (int)(NowTimestamp / 1000);

		public override DateTime Now => TimeStampToDateTime(mNowTimestamp, inMilli: true);

		public ServerTimeZone(long nStartTimeTicks)
			: base(nStartTimeTicks)
		{
		}

		public void SetTimestampOffset(long nServerTimestampOffset)
		{
			mStartTimeTicks = StartDateTimeTicks + nServerTimestampOffset * 10000;
		}

		public void SetTimestamp(long nServerTimestamp)
		{
			mNowTimestamp = nServerTimestamp;
		}

		public void SetEnterGameStamp()
		{
			EnterGameTimestamp = mNowTimestamp;
		}
	}

	public class LocalTimeZone : TimeZone
	{
		public override long NowTimestamp => GetTimestamp(Now);

		public override int NowTimestampSecond => (int)(NowTimestamp / 1000);

		public override DateTime Now => DateTime.Now;

		public LocalTimeZone(long nStartTimeTicks)
			: base(nStartTimeTicks)
		{
		}
	}

	public class UtcTimeZone : TimeZone
	{
		public override long NowTimestamp => GetTimestamp(Now);

		public override int NowTimestampSecond => (int)(NowTimestamp / 1000);

		public override DateTime Now => DateTime.UtcNow;

		public UtcTimeZone(long nStartTimeTicks)
			: base(nStartTimeTicks)
		{
		}
	}

	public static readonly long StartDateTimeTicks = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).Ticks;

	public const string DateTime_yyMMdd = "yyyy/MM/dd";

	public const string DateTime_yyMMdd_hhmm = "yyyy/MM/dd  hh:mm";

	public const string DateTime_yyMMdd_HHmm = "yyyy/MM/dd  HH:mm";

	public const string DateTime_yyMMdd_hhmmss = "yyyy/MM/dd  hh:mm:ss";

	public const string DateTime_yyMMdd_HHmmss = "yyyy/MM/dd  HH:mm:ss";

	public const string DateTime_HHmm = "HH:mm";

	public static readonly ServerTimeZone ServerTime = new ServerTimeZone(StartDateTimeTicks);

	public static readonly LocalTimeZone LocalTime = new LocalTimeZone(StartDateTimeTicks + TimeZoneInfo.Local.BaseUtcOffset.Ticks);

	public static readonly UtcTimeZone UtcTime = new UtcTimeZone(StartDateTimeTicks);

	private static Action _onServerTimeChange;

	private static Coroutine _AutoTimer;

	public static event Action OnServerTimeChange
	{
		add
		{
			_onServerTimeChange = (Action)Delegate.Combine(_onServerTimeChange, value);
		}
		remove
		{
			_onServerTimeChange = (Action)Delegate.Remove(_onServerTimeChange, value);
		}
	}

	public static void StartGame(long nServerTimestamp)
	{
		ServerTime.SetTimestamp(nServerTimestamp);
		if (LuminApplication.LogEnabled)
		{
			DateTimeOffset dateTimeOffset = DateTimeOffset.FromUnixTimeMilliseconds(nServerTimestamp).ToOffset(TimeSpan.FromHours(8.0));
			Debug.Log($"[拍脸] 进游戏服务器时间：{nServerTimestamp} ms，UTC+8 {dateTimeOffset:yyyy-MM-dd HH:mm:ss}");
		}
		_AutoTimer = MonoECS.instance.StartCoroutine(AutoTimer());
	}

	public static void EndGame()
	{
		if (_AutoTimer != null)
		{
			MonoECS.instance.StopCoroutine(_AutoTimer);
		}
	}

	private static IEnumerator AutoTimer()
	{
		while (true)
		{
			ServerTime.SetTimestamp(ServerTime.NowTimestamp + (long)(Time.unscaledDeltaTime * 1000f));
			_onServerTimeChange?.Invoke();
			yield return null;
		}
	}

	public static string GetTimeSpanString(long nTimestampSpan, ETimeSpanFormatType rFormatType)
	{
		if (nTimestampSpan < 0)
		{
			nTimestampSpan = 0L;
		}
		return TimeSpanToString(GetTimeSpan(nTimestampSpan), rFormatType);
	}

	public static string GetTimeStampString(long EndStamp, ETimeSpanFormatType rFormatType)
	{
		if (EndStamp < 0)
		{
			EndStamp = 0L;
		}
		if (EndStamp.ToString().Length <= 10)
		{
			EndStamp *= 1000;
		}
		long num = EndStamp - ServerTime.NowTimestamp;
		if (num < 0)
		{
			num = 0L;
		}
		return TimeSpanToString(GetTimeSpan(num), rFormatType);
	}

	public static string GetMailTimeSpanString(long nTimestampSpan)
	{
		if (nTimestampSpan < 0)
		{
			nTimestampSpan = 0L;
		}
		return MailTimeSpanToString(GetTimeSpan(nTimestampSpan));
	}

	public static string TimeSpanToString(TimeSpan rTimeSpan, ETimeSpanFormatType rFormatType)
	{
		return rFormatType switch
		{
			ETimeSpanFormatType.Type_HMS => $"{(int)rTimeSpan.TotalHours:D2}:{rTimeSpan.Minutes:D2}:{rTimeSpan.Seconds:D2}", 
			ETimeSpanFormatType.Type_DH_Ch => $"{rTimeSpan.Days:D2}天{rTimeSpan.Hours:D2}小时", 
			ETimeSpanFormatType.Type_HM_Ch => $"{(int)rTimeSpan.TotalHours:D2}小时{rTimeSpan.Minutes:D2}分", 
			ETimeSpanFormatType.Type_D_Ch => $"{rTimeSpan.Days:D2}天", 
			ETimeSpanFormatType.Type_DHM_Ch => $"{rTimeSpan.Days:D2}/{rTimeSpan.Hours:D2}/{rTimeSpan.Minutes:D2}", 
			ETimeSpanFormatType.Type_DHM => $"{rTimeSpan.Days:D2}天{rTimeSpan.Hours:D2}小时{rTimeSpan.Minutes:D2}分", 
			ETimeSpanFormatType.Type_HM => $"{(int)rTimeSpan.TotalHours:D2}:{rTimeSpan.Minutes:D2}", 
			_ => "Invalid Time Format", 
		};
	}

	private static string MailTimeSpanToString(TimeSpan rTimeSpan)
	{
		return string.Format($"{rTimeSpan.Days}");
	}

	public static TimeSpan GetTimeSpan(long nTimestampSpan)
	{
		return new TimeSpan(nTimestampSpan * 10000);
	}

	public static TimeSpan GetTimeSpanByStamp(long nTimestampSpan)
	{
		return new TimeSpan(nTimestampSpan * 10000000);
	}

	public static string GetCountdownFriendly(long endStamp)
	{
		if (endStamp < 0)
		{
			endStamp = 0L;
		}
		long num = endStamp - ServerTime.NowTimestamp;
		if (num < 0)
		{
			num = 0L;
		}
		TimeSpan timeSpan = GetTimeSpan(num);
		if (timeSpan.Days > 0)
		{
			return $"{timeSpan.Days:D2}天{timeSpan.Hours:D2}小时";
		}
		if (timeSpan.Hours > 0)
		{
			return $"{timeSpan.Hours:D2}小时{timeSpan.Minutes:D2}分";
		}
		return $"{timeSpan.Minutes:D2}分{timeSpan.Seconds:D2}秒";
	}

	public static string GetDateTimeString(DateTime rDateTime, string rFormat = "yyyy/MM/dd")
	{
		return rDateTime.ToString(rFormat);
	}

	public static string GetDateTimeString(long timeStamp, string rFormat = "yyyy/MM/dd")
	{
		return TimeStampToDateTime(timeStamp).ToString(rFormat);
	}

	public static bool IsSameDay(DateTime today, DateTime toCheck)
	{
		if (today.Year == toCheck.Year && today.Month == toCheck.Month)
		{
			return today.Day == toCheck.Day;
		}
		return false;
	}

	public static DateTime TimeStampToDateTime(long timeStamp, bool inMilli = false)
	{
		return (inMilli ? DateTimeOffset.FromUnixTimeMilliseconds(timeStamp) : DateTimeOffset.FromUnixTimeSeconds(timeStamp)).LocalDateTime;
	}

	public static bool IsInTimeRange(long start, long end, bool isMilliseconds = true)
	{
		long currentTimestamp = GetCurrentTimestamp(start >= 10000000000L || start <= -1000000000);
		if (start <= end)
		{
			if (currentTimestamp >= start)
			{
				return currentTimestamp <= end;
			}
			return false;
		}
		if (currentTimestamp < start)
		{
			return currentTimestamp <= end;
		}
		return true;
	}

	private static long GetCurrentTimestamp(bool isMilliseconds)
	{
		if (!isMilliseconds)
		{
			return ServerTime.NowTimestampSecond;
		}
		return ServerTime.NowTimestamp;
	}
}
