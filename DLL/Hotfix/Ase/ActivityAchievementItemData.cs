namespace Ase;

public class ActivityAchievementItemData : OptionBase
{
	private int id;

	private bool isSelected;

	private bool isActive;

	private int rarity;

	private string icon;

	private string nameTxt;

	private ActivityAchievementData config;

	public int Id => id;

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

	public string NameTxt
	{
		get
		{
			return nameTxt;
		}
		set
		{
			Set(ref nameTxt, value, "NameTxt");
		}
	}

	public ActivityAchievementData Config
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

	public ActivityAchievementItemData()
	{
	}

	public ActivityAchievementItemData(OptionBase parent, ActivityAchievementData config)
	{
		base.parent = parent;
		this.config = config;
		id = config.id;
		Rarity = config.quality;
		Icon = config.iconPath;
		NameTxt = config.name;
		RefreshState();
	}

	private void RefreshState()
	{
		switch (config.state)
		{
		case ActivityAchievementState.UnSeen:
			NameTxt = "???";
			IsActive = true;
			break;
		case ActivityAchievementState.Seen:
		case ActivityAchievementState.UnCollected:
			IsActive = true;
			break;
		case ActivityAchievementState.Collected:
			IsActive = false;
			break;
		}
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}
}
