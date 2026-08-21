using System.Collections.Generic;

namespace Ase;

public class BreakoutSuccessViewModel : OptionBase
{
	private int starLevel;

	private string tips;

	private string iconPath;

	private List<PropertyData> propertyDatas;

	public List<PropertyData> PropertyDatas => propertyDatas;

	public int StarLevel
	{
		get
		{
			return starLevel;
		}
		private set
		{
			Set(ref starLevel, value, "StarLevel");
		}
	}

	public string Tips
	{
		get
		{
			return tips;
		}
		private set
		{
			Set(ref tips, value, "Tips");
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

	public BreakoutSuccessViewModel()
	{
	}

	public BreakoutSuccessViewModel(OptionBase parent, HeroModel heroModel, string tips, List<PropertyData> propertyDatas)
	{
		base.parent = parent;
		this.propertyDatas = propertyDatas;
		IconPath = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.Upgrade, heroModel);
		Tips = tips;
		StarLevel = heroModel.StarLevel - 1;
	}
}
