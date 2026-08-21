namespace Ase;

public class ActivityAchievementDescData : OptionBase
{
	private string lvTxt;

	private string descTxt;

	private ActivityAchievementData config;

	public string LvTxt
	{
		get
		{
			return lvTxt;
		}
		set
		{
			Set(ref lvTxt, value, "LvTxt");
		}
	}

	public string DescTxt
	{
		get
		{
			return descTxt;
		}
		set
		{
			Set(ref descTxt, value, "DescTxt");
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

	public ActivityAchievementDescData()
	{
	}

	public ActivityAchievementDescData(OptionBase parent, string lv, string desc, ActivityAchievementData config)
	{
		base.parent = parent;
		this.config = config;
		LvTxt = lv;
		RefreshTxt(desc);
	}

	public void Refresh(OptionBase parent, string lv, string desc, ActivityAchievementData config)
	{
		base.parent = parent;
		this.config = config;
		LvTxt = lv;
		RefreshTxt(desc);
	}

	private void RefreshTxt(string desc)
	{
		switch (config.state)
		{
		case ActivityAchievementState.UnSeen:
			DescTxt = "? ? ? ? ? ? ? ? ? ?";
			break;
		case ActivityAchievementState.Seen:
		case ActivityAchievementState.UnCollected:
		case ActivityAchievementState.Collected:
			DescTxt = desc;
			break;
		}
	}
}
