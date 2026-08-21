using GameFramework.Runtime;

namespace Ase;

public class LockTipsData : ViewModelBase
{
	private int lockType;

	private string time = "";

	private string icon = "";

	private int count;

	private int rank;

	private int lockId;

	public string Time
	{
		get
		{
			return time;
		}
		set
		{
			Set(ref time, value, "Time");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int Count
	{
		get
		{
			return count;
		}
		set
		{
			Set(ref count, value, "Count");
		}
	}

	public int LockType
	{
		get
		{
			return lockType;
		}
		set
		{
			Set(ref lockType, value, "LockType");
		}
	}

	public int LockId => lockId;

	public int Rank => rank;

	public LockTipsData()
	{
		LockType = -1;
	}

	public void SetData(string icon, int count)
	{
		Icon = icon;
		Count = count;
	}

	public void SetData(ActivityVersionLockData lockData)
	{
		if (!lockData.IsLock)
		{
			LockType = -1;
			return;
		}
		if (lockData.IsTimeLock)
		{
			LockType = 3;
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			long num = lockData.StartTime - curServerTime;
			string activityLeftTime = Utility.DateTime.GetActivityLeftTime(num);
			if (num < 60)
			{
				Time = activityLeftTime + "解锁";
			}
			else
			{
				Time = activityLeftTime + "后解锁";
			}
			rank = lockData.DrVersionLock.Rank;
			lockId = lockData.DrVersionLock.Id;
			return;
		}
		for (int i = 0; i < lockData.DrVersionLock.UnlockType.Count; i++)
		{
			if (lockData.DrVersionLock.UnlockType[i] == 2 && lockData.Lockflag[i])
			{
				LockType = 2;
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(lockData.DrVersionLock.UnlockTarget[i]);
				if (dataRow != null)
				{
					SetData(dataRow.Icon, lockData.DrVersionLock.UnlockNum[i]);
				}
			}
		}
		rank = lockData.DrVersionLock.Rank;
		lockId = lockData.DrVersionLock.Id;
	}

	public void SetData(ActivityVersionData versionData)
	{
		if (!versionData.IsLock)
		{
			lockType = -1;
			return;
		}
		if (versionData.IsTimeLock)
		{
			lockType = 3;
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			long num = versionData.StartTime - curServerTime;
			string activityLeftTime = Utility.DateTime.GetActivityLeftTime(num);
			if (num < 60)
			{
				Time = activityLeftTime + "解锁";
			}
			else
			{
				Time = activityLeftTime + "后解锁";
			}
			return;
		}
		for (int i = 0; i < versionData.DrVersionActivity.UnlockType.Count; i++)
		{
			if (versionData.DrVersionActivity.UnlockType[i] == 2 && versionData.Lockflag[i])
			{
				LockType = 2;
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(versionData.DrVersionActivity.UnlockTarget[i]);
				SetData(dataRow.Icon, versionData.DrVersionActivity.UnlockNum[i]);
			}
		}
	}
}
