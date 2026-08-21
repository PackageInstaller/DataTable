using System.Collections.Generic;

namespace Ase;

public class UpgradeSuccessViewModel : OptionBase
{
	private int levelOld;

	private List<PropertyData> propertyDatas;

	private int levelNew;

	private string iconPath;

	private bool isHero;

	public int LevelOld
	{
		get
		{
			return levelOld;
		}
		private set
		{
			Set(ref levelOld, value, "LevelOld");
		}
	}

	public List<PropertyData> PropertyDatas => propertyDatas;

	public int LevelNew
	{
		get
		{
			return levelNew;
		}
		private set
		{
			Set(ref levelNew, value, "LevelNew");
		}
	}

	public string IconPath
	{
		get
		{
			return iconPath;
		}
		private set
		{
			Set(ref iconPath, value, "IconPath");
		}
	}

	public override void ItemOnClick(object obj)
	{
	}

	public UpgradeSuccessViewModel()
	{
	}

	public UpgradeSuccessViewModel(OptionBase parent, HeroModel heroModel, int levelOld, List<PropertyData> propertyDatas)
	{
		base.parent = parent;
		this.levelOld = levelOld;
		this.propertyDatas = propertyDatas;
		levelNew = heroModel.Level;
		iconPath = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.Upgrade, heroModel);
		isHero = true;
	}
}
