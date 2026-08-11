using GameFramework.Runtime;

namespace Ase;

public class CopyTeamItemViewModel : OptionBase
{
	private SimpleCommand<string> optCommand;

	private int heroId;

	private string heroSkinSuffix;

	private int skinConfigId;

	private int pos;

	private string name;

	private bool isSelect;

	private bool showPos;

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public int Pos
	{
		get
		{
			return pos;
		}
		private set
		{
			Set(ref pos, value, "Pos");
		}
	}

	public int HeroId
	{
		get
		{
			return heroId;
		}
		private set
		{
			Set(ref heroId, value, "HeroId");
		}
	}

	public string HeroSkinSuffix
	{
		get
		{
			return heroSkinSuffix;
		}
		private set
		{
			if (value == null)
			{
				value = "";
			}
			Set(ref heroSkinSuffix, value, "HeroSkinSuffix");
		}
	}

	public int SkinConfigId
	{
		get
		{
			return skinConfigId;
		}
		set
		{
			Set(ref skinConfigId, value, "SkinConfigId");
		}
	}

	public bool ShowPos => showPos;

	public string Name => name;

	public ICommand OptCommand => optCommand;

	public CopyTeamItemViewModel()
	{
	}

	public CopyTeamItemViewModel(OptionBase parent, HeroModel heroData = null)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		if (heroData == null)
		{
			heroId = 0;
			heroSkinSuffix = "";
			SkinConfigId = 0;
		}
		else
		{
			heroId = heroData.Id;
			HeroSkinSuffix = heroData.SkinSuffix;
			SkinConfigId = heroData.SkinConfigId;
		}
	}

	public CopyTeamItemViewModel(OptionBase parent, HeroSkinBind heroSkinBind)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		heroId = heroSkinBind.heroId;
		heroSkinSuffix = heroSkinBind.heroSkinSuffix;
		SkinConfigId = heroSkinBind.skinConfigId;
	}

	public CopyTeamItemViewModel(OptionBase parent, HeroModel heroData, int pos, string name, bool showPos)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		heroId = heroData.Id;
		heroSkinSuffix = heroData.SkinSuffix;
		SkinConfigId = ((!heroData.IsNullOrEmpty()) ? heroData.SkinConfigId : 0);
		this.pos = pos;
		this.name = name;
		this.showPos = showPos;
	}

	public async void OnOpt(string optName)
	{
		parent.ItemOnClick(this);
	}

	public void RefreshData(HeroModel heroData)
	{
		if (heroData == null)
		{
			RefreshData();
			return;
		}
		HeroId = heroData.Id;
		HeroSkinSuffix = heroData.SkinSuffix;
		SkinConfigId = heroData.SkinConfigId;
	}

	public void RefreshData()
	{
		HeroId = 0;
		HeroSkinSuffix = "";
		SkinConfigId = 0;
	}

	public void RefreshData(int heroId, string heroSkinSuffix, int skinConfigId)
	{
		HeroId = heroId;
		HeroSkinSuffix = heroSkinSuffix;
		SkinConfigId = skinConfigId;
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
