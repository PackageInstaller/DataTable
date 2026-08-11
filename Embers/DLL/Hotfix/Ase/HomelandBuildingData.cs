#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class HomelandBuildingData : ViewModelBase
{
	private int id;

	private int level;

	private int levelMax;

	private int upgradeNeedHomelandlevel;

	private int unlockNeedHomelandlevel;

	private string name;

	private string nameIcon;

	private string icon;

	private bool isRed;

	private bool canHarvest;

	private bool isBuildingLock;

	private bool isUpgradeLock;

	public int Level
	{
		get
		{
			return level;
		}
		private set
		{
			Set(ref level, value, "Level");
		}
	}

	public int Id
	{
		get
		{
			return id;
		}
		private set
		{
			Set(ref id, value, "Id");
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

	public string NameIcon
	{
		get
		{
			return nameIcon;
		}
		private set
		{
			Set(ref nameIcon, value, "NameIcon");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public bool IsRed
	{
		get
		{
			return isRed;
		}
		private set
		{
			Set(ref isRed, value, "IsRed");
		}
	}

	public bool CanHarvest
	{
		get
		{
			return canHarvest;
		}
		private set
		{
			Set(ref canHarvest, value, "CanHarvest");
		}
	}

	public bool IsBuildingLock
	{
		get
		{
			return isBuildingLock;
		}
		private set
		{
			Set(ref isBuildingLock, value, "IsBuildingLock");
		}
	}

	public bool IsUpgradeLock
	{
		get
		{
			return isUpgradeLock;
		}
		private set
		{
			Set(ref isUpgradeLock, value, "IsUpgradeLock");
		}
	}

	public int LevelMax
	{
		get
		{
			return levelMax;
		}
		private set
		{
			Set(ref levelMax, value, "LevelMax");
		}
	}

	public int UpgradeNeedHomelandlevel
	{
		get
		{
			return upgradeNeedHomelandlevel;
		}
		private set
		{
			Set(ref upgradeNeedHomelandlevel, value, "UpgradeNeedHomelandlevel");
		}
	}

	public int UnlockNeedHomelandlevel
	{
		get
		{
			return unlockNeedHomelandlevel;
		}
		private set
		{
			Set(ref unlockNeedHomelandlevel, value, "UnlockNeedHomelandlevel");
		}
	}

	public HomelandBuildingData(DRBuildingInfo buildingInfo, int level, int homelandLevel)
	{
		id = buildingInfo.Id;
		icon = buildingInfo.Icon;
		this.level = level;
		levelMax = buildingInfo.MaxLevel;
		name = buildingInfo.Name;
		nameIcon = buildingInfo.IconText;
		unlockNeedHomelandlevel = buildingInfo.NeedHomelandLevel;
		if (homelandLevel < buildingInfo.NeedHomelandLevel)
		{
			isBuildingLock = true;
			isRed = false;
		}
		else
		{
			InitUpgradeInfo(homelandLevel);
		}
	}

	public HomelandBuildingData(DRBuildingInfo buildingInfo, int level, bool isLock)
	{
		id = buildingInfo.Id;
		this.level = level;
		name = buildingInfo.Name;
		isBuildingLock = isLock;
	}

	public void InitUpgradeInfo(int homelandLevel)
	{
		if (level >= levelMax)
		{
			IsRed = false;
			return;
		}
		int nextLevel = level + 1;
		DRBuildingLevelInfo dataRow = GameEntry.DataTable.GetDataRow((DRBuildingLevelInfo p) => p.BuildingId == id && p.Level == nextLevel);
		if (dataRow == null)
		{
			Log.Error($"BuildingLevelInfo，找不到BuildingId【{id}】,Level【{nextLevel}】的数据，请检查！");
			return;
		}
		UpgradeNeedHomelandlevel = dataRow.HomelandLevelNeed;
		IsUpgradeLock = homelandLevel < upgradeNeedHomelandlevel;
		long moneyCount = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.HomelandCoin);
		IsRed = !isBuildingLock && !IsUpgradeLock && dataRow.MoneyNeed <= moneyCount;
		if (!IsRed)
		{
			return;
		}
		if (dataRow.NeedItem.Count != dataRow.NeedItemCount.Count)
		{
			Log.Error($"BuildingLevelInfo，Id【{dataRow.Id}】，道具数量不匹配！");
			IsRed = false;
			return;
		}
		KnapsackViewModel knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		for (int num = 0; num < dataRow.NeedItem.Count; num++)
		{
			KnapsackPropData knapsackPropData = knapsackViewModel.GetProp(dataRow.NeedItem[num]);
			if (knapsackPropData == null)
			{
				knapsackPropData = KnapsackPropData.Create(dataRow.NeedItem[num], 0);
			}
			if (knapsackPropData.Amount < dataRow.NeedItemCount[num])
			{
				IsRed = false;
			}
		}
	}

	public void CheckUnlock(int homelandLevel)
	{
		if (isBuildingLock)
		{
			IsBuildingLock = unlockNeedHomelandlevel > homelandLevel;
			if (!isBuildingLock)
			{
				InitUpgradeInfo(homelandLevel);
			}
		}
		else if (!isBuildingLock && isUpgradeLock)
		{
			InitUpgradeInfo(homelandLevel);
		}
	}

	public void UpgradeLevel(int level, int homelandLevel)
	{
		if (level != this.level)
		{
			Level = level;
			if (level == 0)
			{
				IsBuildingLock = true;
			}
			InitUpgradeInfo(homelandLevel);
		}
	}

	public void UpdateHarvest(bool redPoint)
	{
		if (isBuildingLock)
		{
			CanHarvest = false;
		}
		else
		{
			CanHarvest = redPoint;
		}
	}

	public bool CheckCanUpgrade(int homelandLevel)
	{
		if (level >= levelMax || homelandLevel < unlockNeedHomelandlevel)
		{
			return false;
		}
		int nextLevel = level + 1;
		DRBuildingLevelInfo dataRow = GameEntry.DataTable.GetDataRow((DRBuildingLevelInfo p) => p.BuildingId == id && p.Level == nextLevel);
		if (dataRow == null)
		{
			Log.Error($"BuildingLevelInfo，找不到BuildingId【{id}】,Level【{nextLevel}】的数据，请检查！");
			return false;
		}
		if (homelandLevel < dataRow.HomelandLevelNeed)
		{
			IsRed = false;
			return false;
		}
		if (MoneyDefinition.GetMoneyCount(RoleMoneyEnum.HomelandCoin) < dataRow.MoneyNeed)
		{
			IsRed = false;
			return false;
		}
		if (dataRow.NeedItem.Count != dataRow.NeedItemCount.Count)
		{
			Log.Error($"BuildingLevelInfo，Id【{dataRow.Id}】，道具数量不匹配！");
			IsRed = false;
			return false;
		}
		if (dataRow.NeedItem.Count > 0)
		{
			KnapsackViewModel knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
			for (int num = 0; num < dataRow.NeedItem.Count; num++)
			{
				KnapsackPropData knapsackPropData = knapsackViewModel.GetProp(dataRow.NeedItem[num]);
				if (knapsackPropData == null)
				{
					knapsackPropData = KnapsackPropData.Create(dataRow.NeedItem[num], 0);
				}
				if (knapsackPropData.Amount < dataRow.NeedItemCount[num])
				{
					IsRed = false;
					return false;
				}
			}
		}
		IsRed = true;
		return true;
	}
}
