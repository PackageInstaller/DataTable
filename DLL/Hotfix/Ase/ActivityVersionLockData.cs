using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ActivityVersionLockData : ViewModelBase
{
	private int typeId;

	private DRVersionLock drVersionLock;

	private bool isLock;

	private bool isComplete;

	private List<bool> lockflag;

	private int type;

	private long startTime;

	private bool isTimeLock;

	private TimeDuraSettle timeDuraSettle;

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

	public List<bool> Lockflag => lockflag;

	public bool IsTimeLock => isTimeLock;

	public long StartTime => startTime;

	public DRVersionLock DrVersionLock => drVersionLock;

	public static ActivityVersionLockData Create(DRVersionLock versionLock, int typeId)
	{
		try
		{
			ActivityVersionLockData activityVersionLockData = new ActivityVersionLockData();
			activityVersionLockData.typeId = typeId;
			activityVersionLockData.lockflag = new List<bool>();
			for (int i = 0; i < versionLock.UnlockType.Count; i++)
			{
				activityVersionLockData.lockflag.Add(item: true);
			}
			activityVersionLockData.drVersionLock = versionLock;
			activityVersionLockData.isLock = false;
			return activityVersionLockData;
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
			for (int i = 0; i < drVersionLock.UnlockType.Count; i++)
			{
				if (drVersionLock.UnlockType[i] == 1)
				{
					ActivityVersionData versionDataById = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetVersionDataById(drVersionLock.ActivityId, drVersionLock.UnlockTarget[i]);
					if (versionDataById == null)
					{
						lockflag[i] = false;
					}
					else
					{
						lockflag[i] = !versionDataById.IsComplete;
					}
				}
				if (drVersionLock.UnlockType[i] == 2)
				{
					int acumCount = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetAcumCount(drVersionLock.UnlockTarget[i]);
					if (acumCount == 0)
					{
						lockflag[i] = true;
					}
					else if (acumCount >= drVersionLock.UnlockNum[i])
					{
						lockflag[i] = false;
					}
				}
				if (drVersionLock.UnlockType[i] != 3)
				{
					continue;
				}
				DRTimeLimit dataRow = GameEntry.DataTable.GetDataRow<DRTimeLimit>(drVersionLock.UnlockTarget[i]);
				if (dataRow == null)
				{
					startTime = 0L;
					lockflag[i] = false;
				}
				else
				{
					startTime = Utility.DateTime.GetSeverRefreshTimeSpan(dataRow.StartTime);
					long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
					lockflag[i] = startTime >= curServerTime;
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
			if (isTimeLock && timeDuraSettle == null)
			{
				timeDuraSettle = TimeDuraSettle.Create(GroupTagEnum.ActivtiyVersion, num, num2);
				timeDuraSettle.AddValidChangedAction(OnValidTimeChanged);
				Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddTimeDuraSettle(timeDuraSettle);
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
			Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().UpdateActivityVersionTime(typeId);
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
		for (int i = 0; i < drVersionLock.UnlockType.Count; i++)
		{
			if (drVersionLock.UnlockType[i] == 1 && lockflag[i])
			{
				Toast.ShowInfo("完成上一关后解锁");
				return;
			}
		}
		for (int j = 0; j < drVersionLock.UnlockType.Count; j++)
		{
			if (drVersionLock.UnlockType[j] == 2 && lockflag[j])
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(drVersionLock.UnlockTarget[j]);
				if (dataRow != null)
				{
					Toast.ShowInfo($"累计获得{drVersionLock.UnlockNum[j]}{dataRow.Name}后解锁");
				}
				break;
			}
		}
	}

	public void SetComplete()
	{
		isComplete = true;
		IsLock = false;
		startTime = 0L;
	}
}
