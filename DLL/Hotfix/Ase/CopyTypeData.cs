using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CopyTypeData : ViewModelBase
{
	private int copyTypeId;

	private int copyMainId;

	private string copyTypeName;

	private string copyTypeIcon;

	private string copyTypeIconPath;

	private bool isLock;

	private bool isLockCondition;

	private bool isLockTime;

	private bool isLockPrevious;

	private int copyDailyNumber;

	private int openType;

	private int openCondition;

	private int taskComplete;

	private int maxRewardCount;

	private List<int> zoneEnvironIds;

	private int zone;

	private bool hasNew;

	private long totalScore;

	private long curScore;

	private long startTime;

	private long endTime;

	private bool hasPlayUnlock;

	private List<CopyData> copyDataList;

	public int CopyTypeId
	{
		get
		{
			return copyTypeId;
		}
		private set
		{
			Set(ref copyTypeId, value, "CopyTypeId");
		}
	}

	public string CopyTypeName
	{
		get
		{
			return copyTypeName;
		}
		private set
		{
			Set(ref copyTypeName, value, "CopyTypeName");
		}
	}

	public string CopyTypeIcon
	{
		get
		{
			return copyTypeIcon;
		}
		private set
		{
			Set(ref copyTypeIcon, value, "CopyTypeIcon");
		}
	}

	public int CopyMainId => copyMainId;

	public string CopyTypeIconPath
	{
		get
		{
			if (!string.IsNullOrEmpty(copyTypeIconPath))
			{
				return copyTypeIconPath;
			}
			return GetCopyTypeIconPath(copyMainId);
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

	public bool HasPlayUnlock
	{
		get
		{
			return hasPlayUnlock;
		}
		private set
		{
			Set(ref hasPlayUnlock, value, "HasPlayUnlock");
		}
	}

	public bool IsLockCondition => isLockCondition;

	public bool IsLockPrevious => isLockPrevious;

	public bool IsLockTime
	{
		get
		{
			return isLockTime;
		}
		private set
		{
			Set(ref isLockTime, value, "IsLockTime");
		}
	}

	public bool HasNew
	{
		get
		{
			return hasNew;
		}
		private set
		{
			Set(ref hasNew, value, "HasNew");
		}
	}

	public int CopyDailyNumber
	{
		get
		{
			return copyDailyNumber;
		}
		private set
		{
			Set(ref copyDailyNumber, value, "CopyDailyNumber");
		}
	}

	public int OpenType
	{
		get
		{
			return openType;
		}
		private set
		{
			Set(ref openType, value, "OpenType");
		}
	}

	public int OpenCondition
	{
		get
		{
			return openCondition;
		}
		private set
		{
			Set(ref openCondition, value, "OpenCondition");
		}
	}

	public int TaskComplete
	{
		get
		{
			return taskComplete;
		}
		private set
		{
			Set(ref taskComplete, value, "TaskComplete");
		}
	}

	public List<int> ZoneEnvironIds
	{
		get
		{
			return zoneEnvironIds;
		}
		private set
		{
			Set(ref zoneEnvironIds, value, "ZoneEnvironIds");
		}
	}

	public int Zone
	{
		get
		{
			return zone;
		}
		private set
		{
			Set(ref zone, value, "Zone");
		}
	}

	public long TotalScore
	{
		get
		{
			return totalScore;
		}
		private set
		{
			Set(ref totalScore, value, "TotalScore");
		}
	}

	public long CurScore
	{
		get
		{
			return curScore;
		}
		private set
		{
			Set(ref curScore, value, "CurScore");
		}
	}

	public long StartTime => startTime;

	public long EndTime => endTime;

	public int MaxRewardCount => maxRewardCount;

	public List<CopyData> CopyDataList => copyDataList;

	public static CopyTypeData Create(DRCopyType copyType, int playerLevel, int permitLevel, long copyOpenIndex, long curServerTime)
	{
		CopyTypeData copyTypeData = new CopyTypeData();
		copyTypeData.copyTypeId = copyType.Id;
		copyTypeData.copyTypeName = copyType.Name;
		copyTypeData.copyTypeIcon = copyType.Icon;
		copyTypeData.copyMainId = copyType.MainCopyId;
		copyTypeData.copyTypeIconPath = GetCopyTypeIconPath(copyTypeData.copyMainId);
		copyTypeData.copyDailyNumber = copyType.CopyNumber;
		copyTypeData.openType = copyType.OpenType;
		copyTypeData.openCondition = copyType.Open;
		copyTypeData.zoneEnvironIds = copyType.ZoneBuff;
		copyTypeData.zone = copyType.Zone;
		copyTypeData.taskComplete = copyType.TaskCompleted;
		copyTypeData.maxRewardCount = copyType.RewardCountMax;
		copyTypeData.startTime = Utility.DateTime.GetSeverRefreshTimeSpan(copyType.StartTime);
		copyTypeData.endTime = Utility.DateTime.GetSeverRefreshTimeSpan(copyType.EndTime);
		if (copyTypeData.startTime > 0)
		{
			copyTypeData.isLockTime = curServerTime < copyTypeData.startTime;
		}
		if (copyTypeData.openType == 1)
		{
			copyTypeData.isLockCondition = copyOpenIndex < copyTypeData.openCondition;
		}
		else if (copyTypeData.openType == 2)
		{
			copyTypeData.isLockCondition = permitLevel < copyTypeData.openCondition;
		}
		else if (copyTypeData.openType == 3)
		{
			copyTypeData.isLockCondition = playerLevel < copyTypeData.openCondition;
		}
		copyTypeData.isLock = copyTypeData.isLockCondition || copyTypeData.isLockTime;
		return copyTypeData;
	}

	public void UpdateTaskProgress(long copyOpenIndex)
	{
		if (openType == 1)
		{
			isLockCondition = copyOpenIndex < openCondition;
			IsLock = isLockCondition || isLockTime || isLockPrevious;
		}
	}

	public void UpdatePermitLevel(int permitLevel)
	{
		if (openType == 2)
		{
			isLockCondition = permitLevel < openCondition;
			IsLock = isLockCondition || isLockTime || isLockPrevious;
		}
	}

	public void UpdatePlayerLevel(int playerLevel)
	{
		if (openType == 3)
		{
			bool flag = isLock;
			isLockCondition = playerLevel < openCondition;
			IsLock = isLockCondition || isLockTime || isLockPrevious;
			if (IsLock != flag)
			{
				CheckCopyTypeRed();
			}
		}
	}

	public void UpdateServerTime(long curServerTime)
	{
		if (startTime > 0)
		{
			bool flag = isLock;
			IsLockTime = curServerTime < startTime;
			IsLock = isLockCondition || isLockTime || isLockPrevious;
			if (IsLock != flag)
			{
				CheckCopyTypeRed();
			}
		}
	}

	public void UpdateAccessCopy(int maxOpenRankPass)
	{
		if (copyMainId != 2)
		{
			return;
		}
		isLockPrevious = true;
		for (int i = 0; i < copyDataList.Count; i++)
		{
			if (copyDataList[i].CopyRank == 1 || copyDataList[i].CopyRank <= maxOpenRankPass)
			{
				isLockPrevious = false;
			}
		}
		IsLock = isLockCondition || isLockTime || isLockPrevious;
	}

	public void Type4SetLockPrevious(bool isLock)
	{
		if (copyMainId == 4)
		{
			isLockPrevious = isLock;
			IsLock = isLockCondition || isLockTime || isLockPrevious;
		}
	}

	public void PlayUnlockEffect()
	{
		HasPlayUnlock = true;
	}

	public void ResetPlayUnlockEffect()
	{
		HasPlayUnlock = false;
	}

	public void SetPlayUnlockEffect(bool playEffect)
	{
		HasPlayUnlock = playEffect;
	}

	private void CheckCopyTypeRed()
	{
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().UpdateSingleCopyTypeRed(this);
	}

	public void SetRed(bool hasNew)
	{
		HasNew = hasNew;
	}

	public void SetCurScore(long val)
	{
		if (val > curScore)
		{
			CurScore = val;
		}
		SetTotalScore(val);
	}

	public void ResetCurScore(long val)
	{
		CurScore = val;
		SetTotalScore(val);
	}

	public void SetTotalScore(long val)
	{
		if (val > totalScore)
		{
			TotalScore = val;
		}
	}

	private static string GetCopyTypeIconPath(int mainId)
	{
		if (mainId != 1 && mainId != 99 && mainId != 98 && mainId != 97)
		{
			return "CopySceneImgOther";
		}
		return "CopySceneImgType1";
	}

	public void AddCopyData(List<CopyData> copyDatas, int passRank)
	{
		copyDataList = copyDatas;
		UpdateAccessCopy(passRank);
	}
}
