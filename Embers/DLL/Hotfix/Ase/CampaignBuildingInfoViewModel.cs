using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CampaignBuildingInfoViewModel : OptionBase
{
	private CampaignBuildingData _data;

	private string _buildingIcon = "";

	private string _name;

	private string _description;

	private string _level;

	private bool _unlock;

	private bool _isMaxLevel;

	private List<PropDataBase> _materials = new List<PropDataBase>();

	private List<(int, long)> _materialInfos = new List<(int, long)>();

	private List<PropDataBase> _rewards = new List<PropDataBase>();

	private InteractionRequest _areaDataRefreshRst = new InteractionRequest();

	public CampaignBuildingData Data => _data;

	public string BuildingIcon
	{
		get
		{
			return _buildingIcon;
		}
		set
		{
			Set(ref _buildingIcon, value, "BuildingIcon");
		}
	}

	public string Name
	{
		get
		{
			return _name;
		}
		set
		{
			Set(ref _name, value, "Name");
		}
	}

	public string Description
	{
		get
		{
			return _description;
		}
		set
		{
			Set(ref _description, value, "Description");
		}
	}

	public string Level
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

	public bool Unlock
	{
		get
		{
			return _unlock;
		}
		set
		{
			Set(ref _unlock, value, "Unlock");
		}
	}

	public bool IsMaxLevel
	{
		get
		{
			return _isMaxLevel;
		}
		set
		{
			Set(ref _isMaxLevel, value, "IsMaxLevel");
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

	public InteractionRequest AreaDataRefreshRst => _areaDataRefreshRst;

	public CampaignBuildingInfoViewModel()
	{
	}

	public CampaignBuildingInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void RefreshAreaData(CampaignBuildingData areaData)
	{
		_data = areaData;
		Name = areaData.Name;
		Description = areaData.Desc;
		Level = $"{areaData.Level}/{areaData.MaxLevel}";
		BuildingIcon = areaData.Icon;
		Unlock = areaData.IsUnlock;
		IsMaxLevel = areaData.Level >= areaData.MaxLevel;
		Materials = areaData.Materials;
		MaterialInfos = areaData.MaterialInfos;
		Rewards = areaData.Rewards;
		_areaDataRefreshRst.Raise();
	}

	public void OnUpgradeClick()
	{
		parent?.ItemOnClick(this);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel obj2)
		{
			parent.ItemOnClick(obj2);
		}
	}
}
