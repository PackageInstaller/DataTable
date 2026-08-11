using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ActivityVersionData : ViewModelBase
{
	private DRVersionActivity drVersionActivity;

	private bool isLock;

	private bool isNew;

	private bool isComplete;

	private int curStarCount;

	private int maxStarCount;

	private List<bool> lockflag;

	private int type;

	private string name;

	private long startTime;

	private bool isTimeLock;

	private TimeDuraSettle timeDuraSettle;

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

	public int CurStarCount
	{
		get
		{
			return curStarCount;
		}
		private set
		{
			Set(ref curStarCount, value, "CurStarCount");
		}
	}

	public int MaxStarCount
	{
		get
		{
			return maxStarCount;
		}
		private set
		{
			Set(ref maxStarCount, value, "MaxStarCount");
		}
	}

	public int Type
	{
		get
		{
			return type;
		}
		private set
		{
			Set(ref type, value, "Type");
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

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		private set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public bool IsComplete
	{
		get
		{
			return isComplete;
		}
		private set
		{
			Set(ref isComplete, value, "IsComplete");
		}
	}

	public bool IsTimeLock => isTimeLock;

	public long StartTime => startTime;

	public List<bool> Lockflag => lockflag;

	public DRVersionActivity DrVersionActivity => drVersionActivity;

	public static ActivityVersionData Create(int id)
	{
		DRVersionActivity dataRow = GameEntry.DataTable.GetDataRow<DRVersionActivity>(id);
		if (dataRow == null)
		{
			return null;
		}
		return Create(dataRow);
	}

	public static ActivityVersionData Create(DRVersionActivity activityVersion)
	{
		try
		{
			ActivityVersionData activityVersionData = new ActivityVersionData();
			activityVersionData.lockflag = new List<bool>();
			for (int i = 0; i < activityVersion.UnlockType.Count; i++)
			{
				activityVersionData.lockflag.Add(item: true);
			}
			activityVersionData.drVersionActivity = activityVersion;
			activityVersionData.name = activityVersion.Name;
			activityVersionData.isLock = true;
			activityVersionData.type = activityVersion.Type;
			return activityVersionData;
		}
		catch (Exception)
		{
		}
		return null;
	}

	public void CheckLock()
	{
		try
		{
			isTimeLock = false;
			long num = -1L;
			long num2 = -1L;
			for (int i = 0; i < drVersionActivity.UnlockType.Count; i++)
			{
				if (drVersionActivity.UnlockType[i] == 1)
				{
					ActivityVersionData versionDataById = GetVersionDataById(drVersionActivity.UnlockTarget[i]);
					if (versionDataById == null)
					{
						lockflag[i] = false;
					}
					else
					{
						lockflag[i] = !versionDataById.isComplete;
					}
				}
				if (drVersionActivity.UnlockType[i] == 2)
				{
					int acumCount = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetAcumCount(drVersionActivity.UnlockTarget[i]);
					if (acumCount == 0)
					{
						lockflag[i] = true;
					}
					else if (acumCount >= drVersionActivity.UnlockNum[i])
					{
						lockflag[i] = false;
					}
				}
				if (drVersionActivity.UnlockType[i] != 3)
				{
					continue;
				}
				DRTimeLimit dataRow = GameEntry.DataTable.GetDataRow<DRTimeLimit>(drVersionActivity.UnlockTarget[i]);
				if (dataRow == null)
				{
					startTime = 0L;
					lockflag[i] = false;
				}
				else
				{
					startTime = Utility.DateTime.GetSeverRefreshTimeSpan(dataRow.StartTime);
					long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
					lockflag[i] = curServerTime < startTime;
					if (lockflag[i])
					{
						long severRefreshTimeSpan = Utility.DateTime.GetSeverRefreshTimeSpan(dataRow.EndTime);
						if (num == -1)
						{
							num = startTime;
							num2 = severRefreshTimeSpan;
						}
						else
						{
							num = Math.Min(num, startTime);
							num2 = Math.Min(num2, severRefreshTimeSpan);
						}
					}
				}
				isTimeLock = isTimeLock || lockflag[i];
			}
			if (isTimeLock)
			{
				if (timeDuraSettle == null && num > 0 && num2 > 0)
				{
					timeDuraSettle = TimeDuraSettle.Create(GroupTagEnum.ActivtiyVersion, num, num2);
					timeDuraSettle.AddValidChangedAction(OnValidTimeChanged);
					Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddTimeDuraSettle(timeDuraSettle);
				}
			}
			else if (timeDuraSettle != null)
			{
				Singleton<ServiceSystem>.Instance.GetService<ITimeService>().RemoveTimeDuraSettle(timeDuraSettle);
				timeDuraSettle = null;
			}
		}
		catch (Exception)
		{
		}
		bool flag = false;
		for (int j = 0; j < lockflag.Count; j++)
		{
			flag = flag || lockflag[j];
		}
		IsLock = flag;
	}

	private void OnValidTimeChanged(TimeValidArg timeValidArg)
	{
		if (isTimeLock)
		{
			if (timeValidArg.isValid)
			{
				Singleton<ServiceSystem>.Instance.GetService<ITimeService>().RemoveTimeDuraSettle(timeDuraSettle);
				timeDuraSettle = null;
				CheckLock();
			}
			Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().UpdateActivityVersionTime(drVersionActivity.ActivityId);
		}
	}

	public void CheckTimeLock(long curServerTime)
	{
		if (isTimeLock && startTime != 0L)
		{
			isTimeLock = curServerTime < startTime;
			if (!isTimeLock)
			{
				CheckLock();
			}
		}
	}

	public void OnClickLockItem()
	{
		if (isTimeLock)
		{
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			long num = startTime - curServerTime;
			string activityLeftTime = Utility.DateTime.GetActivityLeftTime(num);
			if (num < 60)
			{
				Toast.ShowInfo(activityLeftTime + "解锁");
			}
			else
			{
				Toast.ShowInfo(activityLeftTime + "后解锁");
			}
			return;
		}
		for (int i = 0; i < drVersionActivity.UnlockType.Count; i++)
		{
			if (drVersionActivity.UnlockType[i] == 1 && lockflag[i])
			{
				Toast.ShowInfo("完成上一关后解锁");
				return;
			}
		}
		for (int j = 0; j < drVersionActivity.UnlockType.Count; j++)
		{
			if (drVersionActivity.UnlockType[j] == 2 && lockflag[j])
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(drVersionActivity.UnlockTarget[j]);
				if (dataRow != null)
				{
					Toast.ShowInfo($"累计获得{drVersionActivity.UnlockNum[j]}{dataRow.Name}后解锁");
				}
				break;
			}
		}
	}

	public bool IsLevelLock()
	{
		if (!isLock)
		{
			return false;
		}
		if (isTimeLock)
		{
			return true;
		}
		for (int i = 0; i < drVersionActivity.UnlockType.Count; i++)
		{
			if (drVersionActivity.UnlockType[i] == 2 && lockflag[i])
			{
				return true;
			}
		}
		return false;
	}

	private ActivityVersionData GetVersionDataById(int id)
	{
		return Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetVersionDataById(drVersionActivity.ActivityId, id);
	}

	public void SetRed(bool value)
	{
		IsNew = value;
	}

	public void SetCopyMaxStar(int max)
	{
		MaxStarCount = max;
	}

	public void SetComplete(int curStar)
	{
		IsComplete = true;
		IsLock = false;
		startTime = 0L;
		isTimeLock = false;
		if (timeDuraSettle != null)
		{
			Singleton<ServiceSystem>.Instance.GetService<ITimeService>().RemoveTimeDuraSettle(timeDuraSettle);
			timeDuraSettle = null;
		}
		CurStarCount = curStar;
	}
}
