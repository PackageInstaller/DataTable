namespace Ase;

public class HeroSkillItemData : OptionBase
{
	private string skillIconPath;

	private string skillName;

	private bool isSelected;

	private DRSkillSkinList cfs;

	private DRHeroSKillConfig cf;

	public int SkillId => cfs.Id;

	public string SkillIconPath
	{
		get
		{
			return skillIconPath;
		}
		set
		{
			Set(ref skillIconPath, value, "SkillIconPath");
		}
	}

	public string SkillName
	{
		get
		{
			return skillName;
		}
		set
		{
			Set(ref skillName, value, "SkillName");
		}
	}

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

	public HeroSkillItemData()
	{
	}

	public HeroSkillItemData(OptionBase parent, DRSkillSkinList cfs)
	{
		base.parent = parent;
		this.cfs = cfs;
		cf = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig p) => p.Id == cfs.Id);
		SkillIconPath = cf.Icon;
		SkillName = cfs.SkillName;
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}
}
