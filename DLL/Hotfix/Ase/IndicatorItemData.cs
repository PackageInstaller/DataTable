namespace Ase;

public class IndicatorItemData : ItemOptionBase
{
	private bool isSelected;

	private bool isActive;

	private bool isTimeLimit;

	private bool isUse;

	private int rarity;

	private string icon;

	private int indicatorEffectId;

	private RoleDecorateData data;

	private DRIndicatorRing config;

	public int IndicatorEffectId => indicatorEffectId;

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool IsActive
	{
		get
		{
			return isActive;
		}
		set
		{
			Set(ref isActive, value, "IsActive");
		}
	}

	public bool IsTimeLimit
	{
		get
		{
			return isTimeLimit;
		}
		set
		{
			Set(ref isTimeLimit, value, "IsTimeLimit");
		}
	}

	public bool IsUse
	{
		get
		{
			return isUse;
		}
		set
		{
			Set(ref isUse, value, "IsUse");
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

	public int Rarity
	{
		get
		{
			return rarity;
		}
		set
		{
			Set(ref rarity, value, "Rarity");
		}
	}

	public RoleDecorateData Data
	{
		get
		{
			return data;
		}
		set
		{
			Set(ref data, value, "Data");
		}
	}

	public DRIndicatorRing Config
	{
		get
		{
			return config;
		}
		set
		{
			Set(ref config, value, "Config");
		}
	}

	public IndicatorItemData()
	{
	}

	public IndicatorItemData(OptionBase parent, RoleDecorateData data, bool got, bool isUse)
	{
		base.parent = parent;
		RefreshData(data, got, isUse);
	}

	public void RefreshData(RoleDecorateData data, bool got = false, bool isUse = false)
	{
		Data = data;
		Config = GameEntry.DataTable.GetDataRow<DRIndicatorRing>(data.id);
		if (Config != null)
		{
			IsActive = !got;
			IsTimeLimit = got && data.expireTime > 0;
			IsUse = got & isUse;
			Icon = Config.Icon;
			rarity = config.Quality;
			indicatorEffectId = Config.ResPath;
		}
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
