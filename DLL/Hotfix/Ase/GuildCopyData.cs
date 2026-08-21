#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class GuildCopyData : ViewModelBase
{
	private CopyData copyData;

	private GAECopyShowTypeEnum copyShowTypeEnum;

	private string bossName;

	private int id;

	private int unlockId;

	private int maxBeatCount;

	private int curBeatCount;

	private bool isPass;

	private bool isReward;

	private bool isPreviousLock;

	private bool isTimeLock;

	private bool isLock;

	private List<int> rewardIds;

	private List<int> rewardTypes;

	private List<int> rewardAmounts;

	public CopyData CopyData
	{
		get
		{
			return copyData;
		}
		private set
		{
			Set(ref copyData, value, "CopyData");
		}
	}

	public int MaxBeatCount
	{
		get
		{
			return maxBeatCount;
		}
		private set
		{
			Set(ref maxBeatCount, value, "MaxBeatCount");
		}
	}

	public int CurBeatCount
	{
		get
		{
			return curBeatCount;
		}
		private set
		{
			Set(ref curBeatCount, value, "CurBeatCount");
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

	public bool IsPass
	{
		get
		{
			return isPass;
		}
		private set
		{
			Set(ref isPass, value, "IsPass");
		}
	}

	public bool IsReward
	{
		get
		{
			return isReward;
		}
		private set
		{
			Set(ref isReward, value, "IsReward");
		}
	}

	public GAECopyShowTypeEnum CopyShowTypeEnum
	{
		get
		{
			return copyShowTypeEnum;
		}
		private set
		{
			Set(ref copyShowTypeEnum, value, "CopyShowTypeEnum");
		}
	}

	public string BossName
	{
		get
		{
			return bossName;
		}
		private set
		{
			Set(ref bossName, value, "BossName");
		}
	}

	public bool IsPreviousLock => isPreviousLock;

	public int UnlockId => unlockId;

	public int Id => id;

	public List<int> RewardIds => rewardIds;

	public List<int> RewardTypes => rewardTypes;

	public List<int> RewardAmounts => rewardAmounts;

	public static GuildCopyData CreateForShow(bool isFinal)
	{
		return new GuildCopyData
		{
			id = (isFinal ? (-1) : (-2))
		};
	}

	public static GuildCopyData Create(DRGuildCopy guildCopy)
	{
		GuildCopyData guildCopyData = new GuildCopyData();
		guildCopyData.id = guildCopy.Id;
		guildCopyData.rewardIds = guildCopy.RewardId;
		guildCopyData.rewardTypes = guildCopy.RewardType;
		guildCopyData.rewardAmounts = guildCopy.RewardNum;
		guildCopyData.bossName = "";
		DRCopy dataRow = GameEntry.DataTable.GetDataRow((DRCopy p) => p.Id == guildCopy.GuildCopyId);
		if (dataRow != null)
		{
			CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
			CopyData copyById = copyVM.GetCopyById(dataRow.Id);
			if (copyById != null)
			{
				guildCopyData.copyData = copyById;
			}
			else
			{
				guildCopyData.copyData = CopyData.CreateTemp(dataRow);
				copyVM.AddGuildCopy(guildCopyData.copyData);
			}
			if (guildCopyData.copyData.BossTypes != null && guildCopyData.copyData.BossTypes.Count > 0)
			{
				DRMonsterInfo dataRow2 = GameEntry.DataTable.GetDataRow((DRMonsterInfo p) => p.Id == guildCopyData.copyData.BossTypes[0]);
				if (dataRow2 != null)
				{
					guildCopyData.bossName = dataRow2.Name;
				}
			}
		}
		else
		{
			Log.Error($"Copy表找不到配置GuildCopy GuildCopyId{guildCopy.GuildCopyId}");
		}
		guildCopyData.copyShowTypeEnum = ((guildCopy.CopyType != 1) ? GAECopyShowTypeEnum.Final : GAECopyShowTypeEnum.Normal);
		guildCopyData.maxBeatCount = guildCopy.BeatNum;
		guildCopyData.unlockId = guildCopy.Unlock;
		return guildCopyData;
	}

	public void SetScore(long score)
	{
		copyData.SetCurScore(score);
	}

	public void Reset()
	{
	}

	public void SetPreviousLock(bool isPreviousLock)
	{
		this.isPreviousLock = isPreviousLock;
		IsLock = this.isPreviousLock || isTimeLock;
	}

	public void SetTimeLock(bool isTimeLock)
	{
		this.isTimeLock = isTimeLock;
		IsLock = isPreviousLock || this.isTimeLock;
	}

	public void RefreshGuildCopyData(int curBeatCount, bool isPass, bool isReward)
	{
		CurBeatCount = curBeatCount;
		IsPass = isPass;
		IsReward = isReward;
	}
}
