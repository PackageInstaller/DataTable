namespace Ase;

public class EquipWearerItemData : OptionBase
{
	private bool isEmpty;

	private string heroImg;

	private string heroName;

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public string HeroImg
	{
		get
		{
			return heroImg;
		}
		set
		{
			Set(ref heroImg, value, "HeroImg");
		}
	}

	public string HeroName
	{
		get
		{
			return heroName;
		}
		set
		{
			Set(ref heroName, value, "HeroName");
		}
	}

	public EquipWearerItemData(int heroId)
	{
		SetHeroId(heroId);
	}

	public void SetHeroId(int heroId)
	{
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroId);
		HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroId);
		if (heroById != null)
		{
			HeroImg = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.SquareSmall, heroById);
		}
		else
		{
			HeroImg = string.Empty;
		}
		if (dataRow != null)
		{
			IsEmpty = false;
			HeroName = dataRow.Name + "已装备";
		}
		else
		{
			IsEmpty = true;
			HeroName = string.Empty;
		}
	}
}
