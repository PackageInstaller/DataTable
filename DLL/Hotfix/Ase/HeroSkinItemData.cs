using System.Collections.Generic;

namespace Ase;

public class HeroSkinItemData : OptionBase
{
	private int _configId;

	private DRUIHeroSkin _drConfig;

	private string _heroSkinAssetPath;

	private string _icon;

	private string _skinTagIcon = "";

	private string _skinName;

	private string _heroName;

	private string _skinDesc;

	private string _qualityIcon;

	private string _headIcon;

	private string _achieve;

	private string _targetWindow;

	private List<int> _windowParams;

	private int _sort;

	private bool _selected;

	private bool _inActiveMask;

	public int ConfigId
	{
		get
		{
			return _configId;
		}
		protected set
		{
			Set(ref _configId, value, "ConfigId");
		}
	}

	public string Icon
	{
		get
		{
			return _icon;
		}
		protected set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public string SkinTagIcon
	{
		get
		{
			return _skinTagIcon;
		}
		set
		{
			Set(ref _skinTagIcon, value, "SkinTagIcon");
		}
	}

	public string SkinName
	{
		get
		{
			return _skinName;
		}
		protected set
		{
			Set(ref _skinName, value, "SkinName");
		}
	}

	public string HeroName
	{
		get
		{
			return _heroName;
		}
		protected set
		{
			Set(ref _heroName, value, "HeroName");
		}
	}

	public string SkinDesc
	{
		get
		{
			return _skinDesc;
		}
		protected set
		{
			Set(ref _skinDesc, value, "SkinDesc");
		}
	}

	public string HeadIcon
	{
		get
		{
			return _headIcon;
		}
		protected set
		{
			Set(ref _headIcon, value, "HeadIcon");
		}
	}

	public string QualityIcon
	{
		get
		{
			return _qualityIcon;
		}
		protected set
		{
			Set(ref _qualityIcon, value, "QualityIcon");
		}
	}

	public int Sort
	{
		get
		{
			return _sort;
		}
		protected set
		{
			Set(ref _sort, value, "Sort");
		}
	}

	public string Achieve
	{
		get
		{
			return _achieve;
		}
		protected set
		{
			Set(ref _achieve, value, "Achieve");
		}
	}

	public string TargetWindow
	{
		get
		{
			return _targetWindow;
		}
		protected set
		{
			Set(ref _targetWindow, value, "TargetWindow");
		}
	}

	public List<int> WindowParams
	{
		get
		{
			return _windowParams;
		}
		protected set
		{
			Set(ref _windowParams, value, "WindowParams");
		}
	}

	public string HeroSkinAssetPath
	{
		get
		{
			return _heroSkinAssetPath;
		}
		protected set
		{
			Set(ref _heroSkinAssetPath, value, "HeroSkinAssetPath");
		}
	}

	public bool Selected
	{
		get
		{
			return _selected;
		}
		set
		{
			Set(ref _selected, value, "Selected");
		}
	}

	public bool InActiveMask
	{
		get
		{
			return _inActiveMask;
		}
		set
		{
			Set(ref _inActiveMask, value, "InActiveMask");
		}
	}

	public DRUIHeroSkin DrConfig => _drConfig;

	public HeroSkinItemData()
	{
	}

	public HeroSkinItemData(OptionBase parent)
	{
		base.parent = parent;
	}

	public HeroSkinItemData(OptionBase parent, int skinConfigId)
	{
		base.parent = parent;
		RefreshData(GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(skinConfigId));
	}

	public HeroSkinItemData(OptionBase parent, DRUIHeroSkin drConfig)
	{
		base.parent = parent;
		RefreshData(drConfig);
	}

	private void RefreshData(DRUIHeroSkin drConfig)
	{
		_drConfig = drConfig;
		ConfigId = 0;
		if (drConfig != null)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(drConfig.HeroID);
			ConfigId = drConfig.Id;
			Icon = StreamerMode.GetHeroSkinIcon(drConfig);
			SkinTagIcon = drConfig.TagShow;
			SkinName = drConfig.SkinName;
			HeroName = dataRow?.Name ?? "";
			SkinDesc = drConfig.SkinDesc;
			HeadIcon = GameEntry.DataTable.GetDataRow<DRHeadAvatar>(drConfig.SkinHead)?.Icon ?? "";
			QualityIcon = $"skin_rarity_{drConfig.SkinRarity}";
			Achieve = drConfig.Achieve;
			TargetWindow = drConfig.TargetWindow;
			WindowParams = drConfig.WindowParams;
			Sort = drConfig.Sort;
			HeroSkinAssetPath = dataRow?.Original + drConfig.Suffix;
		}
	}

	public virtual void OnItemClick()
	{
		parent.ItemOnClick(this);
	}

	public void SetEmptyItem(int sortId = 0)
	{
		Icon = "empty";
		HeadIcon = "empty";
		Sort = sortId;
	}

	public void SetSelect(bool value)
	{
		Selected = value;
	}
}
