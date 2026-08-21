using Ase.ECS;

namespace Ase;

public class SkillTabItemViewModel : OptionBase
{
	private int index;

	private bool isSelf;

	private bool isSelect;

	private HeroSkillData data;

	private BattleHeroData heroData;

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

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		private set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public HeroSkillData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public BattleHeroData HeroData
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

	public int Index => index;

	public override void ItemOnClick(object obj)
	{
	}

	public SkillTabItemViewModel()
	{
	}

	public SkillTabItemViewModel(OptionBase parent, BattleHeroData heroData, bool isSelf, int index)
	{
		base.parent = parent;
		this.heroData = heroData;
		isSelect = isSelf;
		this.isSelf = isSelf;
		this.index = index;
	}

	public void UpdateSkillData(HeroSkillData data)
	{
		Data = data;
	}

	public void UpdateHeroData(BattleHeroData data)
	{
		HeroData = data;
	}

	public void OnSelect()
	{
		IsSelect = true;
		parent.ItemOnClick(this);
	}

	public void SetSelect(bool isSel)
	{
		IsSelect = isSel;
	}
}
