using System.Collections.Generic;

namespace Ase;

public class BattleStatisticHeroData : OptionBase
{
	private HeroModel heroData;

	private string name;

	private bool showLine = true;

	private bool isSelfPlayer;

	private List<BattleStatisticDetailViewModel> statisticDatas;

	public HeroModel HeroData
	{
		get
		{
			return heroData;
		}
		private set
		{
			Set(ref heroData, value, "HeroData");
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

	public bool ShowLine
	{
		get
		{
			return showLine;
		}
		set
		{
			Set(ref showLine, value, "ShowLine");
		}
	}

	public bool IsSelfPlayer
	{
		get
		{
			return isSelfPlayer;
		}
		private set
		{
			Set(ref isSelfPlayer, value, "IsSelfPlayer");
		}
	}

	public List<BattleStatisticDetailViewModel> StatisticDatas => statisticDatas;

	public BattleStatisticHeroData()
	{
	}

	public BattleStatisticHeroData(OptionBase parent, HeroModel heroModel, List<BattleStatisticDetailViewModel> statisticDatas, string name = null, bool isSelfPlayer = false)
	{
		base.parent = parent;
		if (name == null)
		{
			this.name = heroModel.Name;
		}
		else
		{
			this.name = name;
		}
		heroData = heroModel;
		this.statisticDatas = statisticDatas;
		foreach (BattleStatisticDetailViewModel statisticData in this.statisticDatas)
		{
			statisticData.HeroName = this.name;
		}
		this.isSelfPlayer = isSelfPlayer;
	}

	public void OnDetailClick()
	{
		parent.ItemOnClick(this);
	}
}
