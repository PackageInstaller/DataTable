#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;

namespace Ase;

public class TimeService : ITimeService
{
	private int dailyUpdateHour;

	private const int RetryUpdateCheckTime = 5;

	private const int ServerTimeSyncDuration = 60;

	private DateTime lastServiceTime;

	private long leftUpdateSecond = -1L;

	private Action dailyUpdateAction;

	private Timer timeSyncTimer;

	private Timer retryUpdateCheckTimer;

	private Timer normalSecondUpdateTimer;

	private Action<long> normalSecondUpdateAction;

	private long curServerTime;

	private Dictionary<GroupTagEnum, List<TimeDuraSettle>> timeDuraGroup = new Dictionary<GroupTagEnum, List<TimeDuraSettle>>();

	public TimeService()
	{
		lastServiceTime = DateTime.MinValue;
		InitTimeDura();
	}

	public static string GetDailyUpdateTimeStr()
	{
		int num = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetDailyUpdateHour() ?? 0;
		string arg = ((num >= 10) ? "" : "0");
		return $"{arg}{num}:00:00";
	}

	public async UniTask<bool> RequestServerRefreshHour()
	{
		GetServerInfoRequest rst = GetServerInfoRequest.Create();
		GetServerInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetServerInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取服务器每日刷新时间") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取服务器每日刷新时间失败"))
			{
				dailyUpdateHour = response.RefreshHour;
				UpdateRealisticTimer();
				Singleton<ServiceSystem>.Instance.GetService<IChatService>().GetChatViewModel().SetWorldChatOpenLevel(response.WorldChatOpenLevel);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public int GetDailyUpdateHour()
	{
		return dailyUpdateHour;
	}

	public static bool StringToDateTime(string str, out DateTime dateTime)
	{
		return TimeHelper.StringToDateTime(str + " " + GetDailyUpdateTimeStr(), "yyyy.MM.dd HH:mm:ss", out dateTime);
	}

	public async Task<long> GetServiceTime()
	{
		GetServerTimeRequest rst = GetServerTimeRequest.Create();
		GetServerTimeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetServerTimeResponse>(rst);
			if (response != null && response.Error.Equals(0))
			{
				curServerTime = response.TimeStamp;
				return response.TimeStamp;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return 0L;
		}
		catch (Exception ex2)
		{
			Log.Error("获取服务器时间异常！" + ex2.Message + " / " + ex2.StackTrace);
			return 0L;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return 0L;
	}

	public async void UpdateRealisticTimer()
	{
		CancelTimers();
		long num = await GetServiceTime();
		if (num <= 0)
		{
			retryUpdateCheckTimer = Timer.Register(5f, UpdateRealisticTimer, null, isLooped: false, useRealTime: true);
			return;
		}
		DateTime value = TimeZoneInfo.ConvertTime(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc), TimeZoneInfo.Local).AddSeconds(num);
		if (lastServiceTime != DateTime.MinValue && lastServiceTime.CompareTo(value) < 0)
		{
			DateTime nextUpdateTime = GetNextUpdateTime();
			if (lastServiceTime.CompareTo(nextUpdateTime) < 0 && value.CompareTo(nextUpdateTime) >= 0)
			{
				dailyUpdateAction?.Invoke();
			}
		}
		lastServiceTime = value;
		leftUpdateSecond = (long)new TimeSpan(GetNextUpdateTime().Ticks - lastServiceTime.Ticks).TotalSeconds;
		timeSyncTimer = Timer.Register(Math.Min(leftUpdateSecond, 60L), UpdateRealisticTimer, null, isLooped: false, useRealTime: true);
		CreateNormalSecondTimer(num);
	}

	public async void GoldFingerForceUpdateRealisticTimer(long goldFingerTime)
	{
		CancelTimers();
		if (goldFingerTime <= 0)
		{
			retryUpdateCheckTimer = Timer.Register(5f, UpdateRealisticTimer, null, isLooped: false, useRealTime: true);
			return;
		}
		DateTime value = TimeZoneInfo.ConvertTime(new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc), TimeZoneInfo.Local).AddSeconds(goldFingerTime);
		if (lastServiceTime != DateTime.MinValue && lastServiceTime.CompareTo(value) < 0)
		{
			DateTime nextUpdateTime = GetNextUpdateTime();
			if (lastServiceTime.CompareTo(nextUpdateTime) < 0 && value.CompareTo(nextUpdateTime) >= 0)
			{
				dailyUpdateAction?.Invoke();
			}
		}
		lastServiceTime = value;
		leftUpdateSecond = (long)new TimeSpan(GetNextUpdateTime().Ticks - lastServiceTime.Ticks).TotalSeconds;
		timeSyncTimer = Timer.Register(Math.Min(leftUpdateSecond, 60L), UpdateRealisticTimer, null, isLooped: false, useRealTime: true);
		CreateNormalSecondTimer(goldFingerTime);
	}

	public long GetLeftUpdateSeconds()
	{
		if (leftUpdateSecond < 0)
		{
			return -1L;
		}
		if (timeSyncTimer != null && !timeSyncTimer.isDone && !timeSyncTimer.isCancelled)
		{
			return leftUpdateSecond - (long)timeSyncTimer.GetTimeElapsed();
		}
		return leftUpdateSecond;
	}

	public TimeSpan GetLeftServiceTime(long targetTimeStamp)
	{
		return TimeHelper.GetLocalDateTime(targetTimeStamp) - TimeHelper.GetLocalDateTime(curServerTime);
	}

	public void AddDailyUpdateAction(Action action)
	{
		dailyUpdateAction = (Action)Delegate.Combine(dailyUpdateAction, action);
	}

	public void RemoveDailyUpdateAction(Action action)
	{
		dailyUpdateAction = (Action)Delegate.Remove(dailyUpdateAction, action);
	}

	private void CancelTimers()
	{
		leftUpdateSecond = -1L;
		if (timeSyncTimer != null)
		{
			timeSyncTimer.Pause();
			timeSyncTimer.Cancel();
			timeSyncTimer = null;
		}
		if (retryUpdateCheckTimer != null)
		{
			retryUpdateCheckTimer.Pause();
			retryUpdateCheckTimer.Cancel();
			retryUpdateCheckTimer = null;
		}
	}

	private DateTime GetNextUpdateTime()
	{
		DateTime dateTime = DateTime.ParseExact(GetDailyUpdateTimeStr(), "HH:mm:ss", CultureInfo.CurrentCulture);
		if (lastServiceTime.Hour > dateTime.Hour || (lastServiceTime.Hour == dateTime.Hour && lastServiceTime.Minute > dateTime.Minute) || (lastServiceTime.Hour == dateTime.Hour && lastServiceTime.Minute == dateTime.Minute && lastServiceTime.Second >= dateTime.Second))
		{
			DateTime dateTime2 = lastServiceTime.AddDays(1.0);
			return new DateTime(dateTime2.Year, dateTime2.Month, dateTime2.Day, dateTime.Hour, dateTime.Minute, dateTime.Second);
		}
		return new DateTime(lastServiceTime.Year, lastServiceTime.Month, lastServiceTime.Day, dateTime.Hour, dateTime.Minute, dateTime.Second);
	}

	public static DateTime GetNextUpdateTime(DateTime st)
	{
		DateTime dateTime = DateTime.ParseExact(GetDailyUpdateTimeStr(), "HH:mm:ss", CultureInfo.CurrentCulture);
		if (st.Hour > dateTime.Hour || (st.Hour == dateTime.Hour && st.Minute > dateTime.Minute) || (st.Hour == dateTime.Hour && st.Minute == dateTime.Minute && st.Second >= dateTime.Second))
		{
			DateTime dateTime2 = st.AddDays(1.0);
			return new DateTime(dateTime2.Year, dateTime2.Month, dateTime2.Day, dateTime.Hour, dateTime.Minute, dateTime.Second);
		}
		return new DateTime(st.Year, st.Month, st.Day, dateTime.Hour, dateTime.Minute, dateTime.Second);
	}

	public int GetCurDayOfWeek()
	{
		return Utility.DateTime.GetDayOfWeekWithSplit(curServerTime, dailyUpdateHour);
	}

	private void InitTimeDura()
	{
		AddDailyUpdateAction(OnCheckTimeDuraSettleByNextDay);
	}

	public void AddTimeDuraSettle(TimeDuraSettle timeDuraSettle)
	{
		List<TimeDuraSettle> list = null;
		if (timeDuraGroup.ContainsKey(timeDuraSettle.Tag))
		{
			list = timeDuraGroup[timeDuraSettle.Tag];
		}
		else
		{
			list = new List<TimeDuraSettle>();
			timeDuraGroup.Add(timeDuraSettle.Tag, list);
		}
		if (!list.Contains(timeDuraSettle))
		{
			list.Add(timeDuraSettle);
			timeDuraSettle.InitCurTime(curServerTime);
		}
	}

	public void RemoveTimeDuraSettle(TimeDuraSettle timeDuraSettle)
	{
		if (timeDuraGroup.ContainsKey(timeDuraSettle.Tag))
		{
			timeDuraSettle.ClearValidChangedAction();
			timeDuraGroup[timeDuraSettle.Tag].Remove(timeDuraSettle);
		}
	}

	public void OnCheckTimeDuraSettleBySecond(long curServerTime)
	{
		foreach (KeyValuePair<GroupTagEnum, List<TimeDuraSettle>> item in timeDuraGroup)
		{
			List<TimeDuraSettle> value = item.Value;
			for (int i = 0; i < value.Count; i++)
			{
				value[i].OnCheckCurTimeValid(curServerTime);
			}
		}
	}

	public void OnCheckTimeDuraSettleByNextDay()
	{
		foreach (KeyValuePair<GroupTagEnum, List<TimeDuraSettle>> item in timeDuraGroup)
		{
			List<TimeDuraSettle> value = item.Value;
			for (int i = 0; i < value.Count; i++)
			{
				value[i].OnRefreshNextDay(curServerTime);
			}
		}
	}

	public void ClearTimeDureByTag(GroupTagEnum tag)
	{
		if (timeDuraGroup.ContainsKey(tag))
		{
			List<TimeDuraSettle> list = timeDuraGroup[tag];
			for (int i = 0; i < list.Count; i++)
			{
				list[i].ClearValidChangedAction();
			}
			timeDuraGroup.Remove(tag);
		}
	}

	private void ClearTimeDure()
	{
		foreach (KeyValuePair<GroupTagEnum, List<TimeDuraSettle>> item in timeDuraGroup)
		{
			List<TimeDuraSettle> value = item.Value;
			for (int i = 0; i < value.Count; i++)
			{
				value[i].ClearValidChangedAction();
			}
			value.Clear();
		}
		timeDuraGroup.Clear();
	}

	private void CreateNormalSecondTimer(long serviceTimeStamp)
	{
		curServerTime = serviceTimeStamp;
		if (normalSecondUpdateTimer != null)
		{
			normalSecondUpdateTimer.Cancel();
			normalSecondUpdateTimer = null;
		}
		normalSecondUpdateTimer = Timer.Register(1f, delegate
		{
			curServerTime++;
			normalSecondUpdateAction?.Invoke(curServerTime);
			OnCheckTimeDuraSettleBySecond(curServerTime);
		}, null, isLooped: true, useRealTime: true);
	}

	public void AddNormalSecondUpdateAction(Action<long> action)
	{
		normalSecondUpdateAction = (Action<long>)Delegate.Combine(normalSecondUpdateAction, action);
	}

	public void RemoveNormalSecondUpdateAction(Action<long> action)
	{
		normalSecondUpdateAction = (Action<long>)Delegate.Remove(normalSecondUpdateAction, action);
	}

	public void SetCurServerTimeGoldenfinger(long testServerTime)
	{
		curServerTime = testServerTime;
	}

	public long GetCurServerTime()
	{
		return curServerTime;
	}

	public DateTime GetCurServerDateTime()
	{
		return Utility.DateTime.UnixTimestampToDateTime(curServerTime);
	}

	public void Dispose()
	{
		dailyUpdateAction = null;
		CancelTimers();
		ClearTimeDure();
	}

	public bool CheckNextDay(long time)
	{
		try
		{
			int num = int.Parse(GetDailyUpdateTimeStr().Split(':')[0]);
			DateTime dateTime = Utility.DateTime.UnixTimestampToDateTime(curServerTime);
			DateTime dateTime2 = Utility.DateTime.UnixTimestampToDateTime(time);
			if ((num == 0 || num == 24) && dateTime2.Day != dateTime.Day)
			{
				return true;
			}
			if (dateTime2.Day == dateTime.Day)
			{
				if (dateTime.Hour >= num && dateTime2.Hour < num)
				{
					return true;
				}
				return false;
			}
			if (dateTime2.Day == dateTime.Day - 1)
			{
				if (dateTime.Hour < num)
				{
					return false;
				}
				return true;
			}
			return dateTime.Day > dateTime2.Day;
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
			return false;
		}
	}
}
