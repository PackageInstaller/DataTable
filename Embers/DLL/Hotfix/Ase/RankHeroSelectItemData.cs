namespace Ase;

public class RankHeroSelectItemData : OptionBase
{
	private string heroImg = "";

	private string heroName;

	private bool showMyScore;

	private string rank;

	private bool selected;

	private RankDefinition.HeroChallengeData data;

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

	public bool ShowMyScore
	{
		get
		{
			return showMyScore;
		}
		set
		{
			Set(ref showMyScore, value, "ShowMyScore");
		}
	}

	public string Rank
	{
		get
		{
			return rank;
		}
		set
		{
			Set(ref rank, value, "Rank");
		}
	}

	public bool Selected
	{
		get
		{
			return selected;
		}
		set
		{
			Set(ref selected, value, "Selected");
		}
	}

	public RankDefinition.HeroChallengeData Data => data;

	public RankHeroSelectItemData()
	{
	}

	public RankHeroSelectItemData(OptionBase parent, RankDefinition.HeroChallengeData data)
	{
		base.parent = parent;
		this.data = data;
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(data.HeroId);
		if (dataRow != null)
		{
			HeroName = dataRow.Name;
		}
		HeroImg = HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.CardHorizontal, data.HeroId);
		ShowMyScore = data.Score > 0 || data.Rank > 0;
		Rank = ((data.Rank > 0) ? data.Rank.ToString() : "未上榜");
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
