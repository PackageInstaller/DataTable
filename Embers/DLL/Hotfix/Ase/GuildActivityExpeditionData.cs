#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class GuildActivityExpeditionData : ViewModelBase
{
	private GAECopyShowTypeEnum curCopyTypeEnum;

	private int gaId;

	private string name = "";

	private int curCopyId;

	private string curCopyName;

	private int curChallengeCount;

	private int maxChallengeCount;

	private int timeEnd;

	private long finalScore;

	private bool isEveryTimeLock;

	private bool isEntireTimeLock;

	private string leftTime;

	private int refreshWeekDay;

	private string refreshTime;

	private string openTimeConfig;

	private string openTimeString;

	private long startTime;

	private long endTime;

	private bool isLock;

	private List<string> openTimeSettle;

	private TimeDuraSettle timeDuraEveryDay;

	private TimeDuraSettle timeDuraEntire;

	private TimeDuraSettle timeDuraEveryWeek;

	private List<GuildCopyData> guildCopyDatas = new List<GuildCopyData>();

	private Action lockStateChangeAction;

	public int CurChallengeCount
	{
		get
		{
			return curChallengeCount;
		}
		private set
		{
			Set(ref curChallengeCount, value, "CurChallengeCount");
		}
	}

	public int MaxChallengeCount
	{
		get
		{
			return maxChallengeCount;
		}
		private set
		{
			Set(ref maxChallengeCount, value, "MaxChallengeCount");
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string OpenTimeString
	{
		get
		{
			return openTimeString;
		}
		private set
		{
			Set(ref openTimeString, value, "OpenTimeString");
		}
	}

	public string LeftTime
	{
		get
		{
			return leftTime;
		}
		private set
		{
			Set(ref leftTime, value, "LeftTime");
		}
	}

	public string CurCopyName
	{
		get
		{
			return curCopyName;
		}
		private set
		{
			Set(ref curCopyName, value, "CurCopyName");
		}
	}

	public GAECopyShowTypeEnum CurCopyTypeEnum
	{
		get
		{
			return curCopyTypeEnum;
		}
		private set
		{
			Set(ref curCopyTypeEnum, value, "CurCopyTypeEnum");
		}
	}

	public long FinalScore
	{
		get
		{
			return finalScore;
		}
		private set
		{
			Set(ref finalScore, value, "FinalScore");
		}
	}

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public int CurCopyId => curCopyId;

	public List<GuildCopyData> GuildCopyDatas => guildCopyDatas;

	public bool IsEveryTimeLock => isEveryTimeLock;

	public bool IsEntireTimeLock => isEntireTimeLock;

	public static GuildActivityExpeditionData Create(int configId)
	{
		DRGuildFunction dataRow = GameEntry.DataTable.GetDataRow<DRGuildFunction>(configId);
		if (dataRow == null)
		{
			Log.Error($"GuildFunction表找不到配置Id {configId}");
			return new GuildActivityExpeditionData();
		}
		return Create(dataRow);
	}

	public static GuildActivityExpeditionData Create(DRGuildFunction config)
	{
		GuildActivityExpeditionData guildActivityExpeditionData = new GuildActivityExpeditionData();
		guildActivityExpeditionData.name = config.Name;
		guildActivityExpeditionData.gaId = config.Id;
		guildActivityExpeditionData.maxChallengeCount = config.TryNumLimit;
		guildActivityExpeditionData.guildCopyDatas = new List<GuildCopyData>();
		DRGuildCopy[] dataRows = GameEntry.DataTable.GetDataRows((DRGuildCopy p) => p.Function == config.Id);
		if (dataRows != null && dataRows.Length != 0)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				guildActivityExpeditionData.guildCopyDatas.Add(GuildCopyData.Create(dataRows[num]));
			}
		}
		guildActivityExpeditionData.RefreshExpeditionData(0, 0L);
		guildActivityExpeditionData.startTime = Utility.DateTime.GetSeverRefreshTimeSpan(config.StartTime);
		guildActivityExpeditionData.endTime = Utility.DateTime.GetSeverRefreshTimeSpan(config.EndTime);
		guildActivityExpeditionData.refreshWeekDay = config.RefreshTime;
		guildActivityExpeditionData.openTimeConfig = config.OpenTime;
		guildActivityExpeditionData.openTimeString = guildActivityExpeditionData.SettleOpenTime(config.OpenTime);
		return guildActivityExpeditionData;
	}

	public void RefreshExpeditionData(int curChallengeCount, long score)
	{
		FinalScore = score;
		CurChallengeCount = curChallengeCount;
		curCopyId = 0;
		for (int i = 0; i < guildCopyDatas.Count; i++)
		{
			guildCopyDatas[i].SetTimeLock(isEntireTimeLock);
			if (guildCopyDatas[i].UnlockId == 0)
			{
				guildCopyDatas[i].SetPreviousLock(isPreviousLock: false);
			}
			else
			{
				GuildCopyData guildCopyDataById = GetGuildCopyDataById(guildCopyDatas[i].UnlockId);
				if (guildCopyDataById != null)
				{
					guildCopyDatas[i].SetPreviousLock(!guildCopyDataById.IsPass);
				}
			}
			if (!guildCopyDatas[i].IsPreviousLock && !guildCopyDatas[i].IsPass)
			{
				curCopyId = guildCopyDatas[i].CopyData.Id;
				CurCopyName = guildCopyDatas[i].CopyData.Name;
				CurCopyTypeEnum = guildCopyDatas[i].CopyShowTypeEnum;
			}
		}
		if (curCopyId == 0)
		{
			int index = guildCopyDatas.Count - 1;
			curCopyId = guildCopyDatas[index].CopyData.Id;
			CurCopyName = guildCopyDatas[index].CopyData.Name;
			CurCopyTypeEnum = guildCopyDatas[index].CopyShowTypeEnum;
		}
		for (int j = 0; j < guildCopyDatas.Count; j++)
		{
			if (guildCopyDatas[j].CopyShowTypeEnum == GAECopyShowTypeEnum.Final)
			{
				guildCopyDatas[j].SetScore(score);
			}
		}
	}

	public GuildCopyData GetGuildCopyDataById(int id)
	{
		for (int i = 0; i < guildCopyDatas.Count; i++)
		{
			if (guildCopyDatas[i].Id == id)
			{
				return guildCopyDatas[i];
			}
		}
		return null;
	}

	public GuildCopyData GetGuildCopyDataByCopyId(int copyId)
	{
		for (int i = 0; i < guildCopyDatas.Count; i++)
		{
			if (guildCopyDatas[i].CopyData.Id == copyId)
			{
				return guildCopyDatas[i];
			}
		}
		return null;
	}

	private string SettleOpenTime(string oriConfigString)
	{
		try
		{
			return oriConfigString.Replace(',', '-').Replace('：', ':');
		}
		catch (Exception ex)
		{
			Log.Error("处理时间字符串发生异常 【" + oriConfigString + "】 " + ex.Message + " / " + ex.StackTrace);
		}
		return "";
	}

	private bool CheckIsFullDayOpenTime(string config)
	{
		if (string.IsNullOrWhiteSpace(config))
		{
			return false;
		}
		string text = config.Replace('：', ':').Replace(" ", "");
		if (!(text == "00:00,24:00"))
		{
			return text == "00:00,23:59";
		}
		return true;
	}

	private void OnEveryDayTimeChanged(TimeValidArg validArg)
	{
		if (isEntireTimeLock)
		{
			return;
		}
		bool flag = isLock;
		isEveryTimeLock = !validArg.isValid;
		if (guildCopyDatas != null && guildCopyDatas.Count > 0)
		{
			for (int i = 0; i < guildCopyDatas.Count; i++)
			{
				guildCopyDatas[i].SetTimeLock(isEntireTimeLock);
			}
		}
		IsLock = isEntireTimeLock || isEveryTimeLock;
		if (flag != isLock)
		{
			OnLockStateChange();
		}
	}

	private void OnEntireTimeChanged(TimeValidArg validArg)
	{
		if (isEntireTimeLock && !validArg.isValid)
		{
			return;
		}
		bool flag = isLock;
		isEntireTimeLock = !validArg.isValid;
		if (guildCopyDatas != null && guildCopyDatas.Count > 0)
		{
			for (int i = 0; i < guildCopyDatas.Count; i++)
			{
				guildCopyDatas[i].SetTimeLock(isEntireTimeLock);
			}
		}
		if (!validArg.isValid && validArg.eventType == TimeEventType.End)
		{
			LeftTime = "已结束";
		}
		if (!validArg.isValid && validArg.eventType == TimeEventType.NotStart)
		{
			LeftTime = "未开始";
		}
		IsLock = isEntireTimeLock || isEveryTimeLock;
		if (flag != isLock)
		{
			OnLockStateChange();
		}
	}

	private void OnWeeklyTimeChanged(TimeValidArg validArg)
	{
		if (!isEntireTimeLock)
		{
			string activityTimeText = OpActivityDefinition.GetActivityTimeText(validArg.leftSecond);
			LeftTime = (string.IsNullOrEmpty(activityTimeText) ? activityTimeText : (activityTimeText ?? ""));
		}
	}

	public void AddTimeDuraValid()
	{
		if (!CheckIsFullDayOpenTime(openTimeConfig))
		{
			timeDuraEveryDay = TimeDuraSettle.CreateFromGuildCopy(GroupTagEnum.GuildActivtiy, openTimeConfig);
			timeDuraEveryDay.AddValidChangedAction(OnEveryDayTimeChanged);
			Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddTimeDuraSettle(timeDuraEveryDay);
		}
		timeDuraEntire = TimeDuraSettle.Create(GroupTagEnum.GuildActivtiy, startTime, endTime);
		timeDuraEntire.AddValidChangedAction(OnEntireTimeChanged);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddTimeDuraSettle(timeDuraEntire);
		timeDuraEveryWeek = TimeDuraSettle.CreateWeekly(GroupTagEnum.GuildActivtiy, refreshWeekDay, startTime);
		timeDuraEveryWeek.AddValidChangedAction(OnWeeklyTimeChanged);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddTimeDuraSettle(timeDuraEveryWeek);
	}

	private void OnLockStateChange()
	{
		lockStateChangeAction?.Invoke();
	}

	public void AddLockStateChange(Action action)
	{
		lockStateChangeAction = action;
	}

	public void RemoveLockStateChange()
	{
		lockStateChangeAction = null;
	}

	public bool HasGuildCopyReward()
	{
		if (guildCopyDatas == null || guildCopyDatas.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < guildCopyDatas.Count; i++)
		{
			if (!guildCopyDatas[i].IsLock && guildCopyDatas[i].CopyShowTypeEnum == GAECopyShowTypeEnum.Normal && guildCopyDatas[i].IsPass && !guildCopyDatas[i].IsReward)
			{
				return true;
			}
		}
		return false;
	}

	public new void Dispose()
	{
		OnLockStateChange();
		timeDuraEveryDay = null;
		timeDuraEntire = null;
		timeDuraEveryWeek = null;
		for (int i = 0; i < guildCopyDatas.Count; i++)
		{
			guildCopyDatas[i].Reset();
		}
		Singleton<ServiceSystem>.Instance?.GetService<ITimeService>()?.ClearTimeDureByTag(GroupTagEnum.GuildActivtiy);
	}
}
