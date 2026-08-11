#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class CampaignBuildingData : CampaignAreaData
{
	private int _groupId;

	private string _desc;

	private int _level;

	private int _maxLevel;

	private List<(int, long)> _materialInfos = new List<(int, long)>();

	private bool _isUnlock;

	private bool _upgrade;

	private List<PropDataBase> _materials;

	private List<PropDataBase> _rewards;

	public int GroupId
	{
		get
		{
			return _groupId;
		}
		set
		{
			Set(ref _groupId, value, "GroupId");
		}
	}

	public string Desc
	{
		get
		{
			return _desc;
		}
		set
		{
			Set(ref _desc, value, "Desc");
		}
	}

	public int Level
	{
		get
		{
			return _level;
		}
		set
		{
			Set(ref _level, value, "Level");
		}
	}

	public int MaxLevel
	{
		get
		{
			return _maxLevel;
		}
		set
		{
			Set(ref _maxLevel, value, "MaxLevel");
		}
	}

	public List<(int, long)> MaterialInfos
	{
		get
		{
			return _materialInfos;
		}
		set
		{
			Set(ref _materialInfos, value, "MaterialInfos");
		}
	}

	public bool IsUnlock
	{
		get
		{
			return _isUnlock;
		}
		set
		{
			Set(ref _isUnlock, value, "IsUnlock");
		}
	}

	public bool Upgrade
	{
		get
		{
			return _upgrade;
		}
		set
		{
			Set(ref _upgrade, value, "Upgrade");
		}
	}

	public List<PropDataBase> Materials
	{
		get
		{
			return _materials;
		}
		set
		{
			Set(ref _materials, value, "Materials");
		}
	}

	public List<PropDataBase> Rewards
	{
		get
		{
			return _rewards;
		}
		set
		{
			Set(ref _rewards, value, "Rewards");
		}
	}

	public static CampaignBuildingData CreateByServerData(OptionBase parent, CampaignServiceData.BuildingInfo buildingInfo)
	{
		if (buildingInfo == null)
		{
			return null;
		}
		DRCampaignBuilding dataRow = GameEntry.DataTable.GetDataRow((DRCampaignBuilding p) => p.Group.Equals(buildingInfo.BuildingId) && p.Level.Equals(buildingInfo.BuildingLevel));
		if (dataRow == null)
		{
			Log.Error($"创建战役建筑数据失败：CampaignBuilding表 Group:{buildingInfo.BuildingId} Level:{buildingInfo.BuildingLevel}不存在");
			return null;
		}
		DRCampaignClass dataRow2 = GameEntry.DataTable.GetDataRow<DRCampaignClass>(buildingInfo.PointId);
		if (dataRow2 == null)
		{
			Log.Error($"创建战役建筑数据失败：CampaignClass表 Id:{buildingInfo.PointId}不存在");
			return null;
		}
		return new CampaignBuildingData(parent)
		{
			Type = CampaignAreaType.Building,
			PositionId = buildingInfo.PointId,
			Name = dataRow.Name,
			Icon = dataRow.Icon,
			Desc = dataRow.Builddesc,
			ClickRange = dataRow2.ActRange,
			GroupId = dataRow.Group,
			Level = dataRow.Level,
			MaxLevel = GetMaxLevelByConfig(dataRow),
			MaterialInfos = buildingInfo.MaterialInfos,
			IsUnlock = buildingInfo.IsUnlock,
			Upgrade = buildingInfo.Upgraded,
			Materials = PropHelper.AnalyzePropListByConfig(dataRow.UpgradeMatType, dataRow.UpgradeMatId, dataRow.UpgradeMatNum),
			Rewards = PropHelper.AnalyzePropListByConfig(dataRow.UpgradRewardDescType, dataRow.UpgradRewardDescId, dataRow.UpgradRewardDescNum)
		};
	}

	private static int GetMaxLevelByConfig(DRCampaignBuilding config)
	{
		if (config == null)
		{
			return 0;
		}
		List<DRCampaignBuilding> list = GameEntry.DataTable.GetDataRows((DRCampaignBuilding p) => p.Group == config.Group)?.ToList();
		if (list == null)
		{
			return 0;
		}
		int maxLevel = 0;
		list.ForEach(delegate(DRCampaignBuilding p)
		{
			maxLevel = Mathf.Max(maxLevel, p.Level);
		});
		return maxLevel;
	}

	public CampaignBuildingData()
	{
	}

	public CampaignBuildingData(OptionBase parent)
		: base(parent)
	{
	}
}
