#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class TimeDuraSettle
{
	private GroupTagEnum tag;

	public List<TimeDura> timeDuras;

	private Action<TimeValidArg> timeValidAction;

	private bool isDailyRefresh;

	private bool isWeeklyRefresh;

	private int refreshWeekDay;

	private bool isInit;

	private TimeValidArg validArg = new TimeValidArg();

	public bool IsValid
	{
		get
		{
			if (validArg != null)
			{
				return validArg.isValid;
			}
			return false;
		}
	}

	public GroupTagEnum Tag => tag;

	public TimeDuraSettle(GroupTagEnum tag)
	{
		this.tag = tag;
	}

	public void InitCurTime(long curServerTime)
	{
		if (isInit)
		{
			return;
		}
		if (isDailyRefresh)
		{
			long timeStampFromDayStart = Utility.DateTime.GetTimeStampFromDayStart(curServerTime);
			if (timeDuras != null && timeDuras.Count != 0)
			{
				for (int i = 0; i < timeDuras.Count; i++)
				{
					timeDuras[i] = new TimeDura
					{
						startTime = timeDuras[i].startTime + timeStampFromDayStart,
						endTime = timeDuras[i].endTime + timeStampFromDayStart
					};
				}
			}
		}
		if (isWeeklyRefresh && timeDuras != null && timeDuras.Count != 0)
		{
			long num = 0L;
			long num2 = timeDuras[0].startTime;
			long num3;
			(num3, num) = Utility.DateTime.GetNearestWeekday(curServerTime, refreshWeekDay);
			if (num2 < num3)
			{
				num2 = num3;
			}
			timeDuras[0] = new TimeDura
			{
				startTime = num2,
				endTime = num
			};
		}
		CheckCurTimeValid(curServerTime);
		isInit = true;
	}

	public static TimeDuraSettle Create(GroupTagEnum tag, long startTime, long endTime, bool isDailyRefresh = false)
	{
		TimeDuraSettle timeDuraSettle = new TimeDuraSettle(tag);
		try
		{
			List<TimeDura> list = new List<TimeDura>();
			TimeDura item = new TimeDura
			{
				startTime = startTime,
				endTime = endTime
			};
			list.Add(item);
			timeDuraSettle.timeDuras = list;
			timeDuraSettle.isDailyRefresh = isDailyRefresh;
			return timeDuraSettle;
		}
		catch (Exception)
		{
			Log.Error("创建TimeDuraSettle发生异常");
		}
		timeDuraSettle.validArg.isValid = false;
		return timeDuraSettle;
	}

	public static TimeDuraSettle CreateWeekly(GroupTagEnum tag, int refreshWeekDay, long startTime)
	{
		TimeDuraSettle obj = new TimeDuraSettle(tag)
		{
			isWeeklyRefresh = true,
			refreshWeekDay = refreshWeekDay
		};
		List<TimeDura> list = new List<TimeDura>();
		TimeDura item = new TimeDura
		{
			startTime = startTime
		};
		list.Add(item);
		obj.timeDuras = list;
		return obj;
	}

	public static TimeDuraSettle CreateFromGuildCopy(GroupTagEnum tag, string config)
	{
		TimeDuraSettle timeDuraSettle = new TimeDuraSettle(tag);
		try
		{
			List<TimeDura> list = new List<TimeDura>();
			string[] array = config.Split('|');
			for (int i = 0; i < array.Length; i++)
			{
				string[] array2 = array[i].Split(',');
				string[] array3 = array2[0].Split(':');
				string[] array4 = array2[1].Split(':');
				TimeDura item = new TimeDura
				{
					startTime = int.Parse(array3[0]) * 60 * 60 + int.Parse(array3[1]) * 60,
					endTime = int.Parse(array4[0]) * 60 * 60 + int.Parse(array4[1]) * 60
				};
				list.Add(item);
			}
			list.Sort((TimeDura x, TimeDura y) => x.startTime.CompareTo(y.startTime));
			timeDuraSettle.timeDuras = list;
			timeDuraSettle.isDailyRefresh = true;
			return timeDuraSettle;
		}
		catch (Exception)
		{
			Log.Error("GuildCopy解析时间发生异常【" + config + "】");
		}
		timeDuraSettle.validArg.isValid = false;
		return timeDuraSettle;
	}

	public void OnCheckCurTimeValid(long curTime)
	{
		if (timeValidAction != null && validArg.eventType != TimeEventType.End)
		{
			CheckCurTimeValid(curTime);
			timeValidAction(validArg);
		}
	}

	public bool CheckCurTimeValid(long curTime)
	{
		if (validArg.eventType == TimeEventType.End)
		{
			return false;
		}
		if (timeDuras == null || timeDuras.Count == 0)
		{
			validArg.SetEventType(TimeEventType.None, 0L);
			return true;
		}
		bool flag = true;
		long num = -1L;
		for (int i = 0; i < timeDuras.Count; i++)
		{
			if (curTime >= timeDuras[i].startTime && curTime < timeDuras[i].endTime)
			{
				validArg.SetEventType(TimeEventType.GoingOn, timeDuras[i].endTime - curTime);
				return true;
			}
			if (curTime < timeDuras[i].endTime)
			{
				flag = false;
			}
			if (num == -1 && curTime < timeDuras[i].startTime)
			{
				num = timeDuras[i].startTime;
			}
		}
		if (!flag)
		{
			validArg.SetEventType(TimeEventType.NotStart, num - curTime);
			return false;
		}
		validArg.SetEventType(TimeEventType.End, 0L);
		return false;
	}

	public void OnRefreshNextDay(long curTime)
	{
		if (isDailyRefresh && timeDuras != null && timeDuras.Count > 0)
		{
			TimeDura timeDura = timeDuras[0];
			int num = 86400;
			if (Utility.DateTime.GetDayOfWeekWithSplit(curTime) == Utility.DateTime.GetDayOfWeekWithSplit(timeDura.startTime))
			{
				return;
			}
			for (int i = 0; i < timeDuras.Count; i++)
			{
				timeDura = timeDuras[i];
				timeDuras[i] = new TimeDura
				{
					startTime = timeDura.startTime + num,
					endTime = timeDura.endTime + num
				};
			}
			validArg.eventType = TimeEventType.NotInit;
		}
		if (isWeeklyRefresh && timeDuras != null && timeDuras.Count > 0)
		{
			long num2 = 0L;
			long startTime;
			(startTime, num2) = Utility.DateTime.GetNearestWeekday(curTime, refreshWeekDay);
			timeDuras[0] = new TimeDura
			{
				startTime = startTime,
				endTime = num2
			};
			validArg.eventType = TimeEventType.NotInit;
		}
		OnCheckCurTimeValid(curTime);
	}

	public void AddValidChangedAction(Action<TimeValidArg> action)
	{
		timeValidAction = action;
	}

	public void ClearValidChangedAction()
	{
		timeValidAction = null;
	}
}
