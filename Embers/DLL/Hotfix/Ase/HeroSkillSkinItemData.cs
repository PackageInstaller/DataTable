namespace Ase;

public class HeroSkillSkinItemData : OptionBase
{
	private string skinName;

	private bool isSelected;

	private bool isLocked;

	private bool isUse;

	private string skinImgPath;

	private DRHeroSkillSkin cfs;

	private SkillSkinToHaveStateEnum state;

	public DRHeroSkillSkin Cfs => cfs;

	public string SkinName
	{
		get
		{
			return skinName;
		}
		set
		{
			Set(ref skinName, value, "SkinName");
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

	public bool IsLocked
	{
		get
		{
			return isLocked;
		}
		set
		{
			Set(ref isLocked, value, "IsLocked");
		}
	}

	public bool IsUse
	{
		get
		{
			return isUse;
		}
		set
		{
			Set(ref isUse, value, "IsUse");
		}
	}

	public string SkinImgPath
	{
		get
		{
			return skinImgPath;
		}
		set
		{
			Set(ref skinImgPath, value, "SkinImgPath");
		}
	}

	public SkillSkinToHaveStateEnum State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public HeroSkillSkinItemData()
	{
	}

	public HeroSkillSkinItemData(OptionBase parent, DRHeroSkillSkin cfs)
	{
		base.parent = parent;
		this.cfs = cfs;
		SkinName = cfs.SkillSkinName;
		SkinImgPath = cfs.SkillSkinIcon;
	}

	public void ChangeState(SkillSkinToHaveStateEnum state)
	{
		State = state;
		switch (state)
		{
		case SkillSkinToHaveStateEnum.Locked:
			IsLocked = false;
			IsUse = false;
			break;
		case SkillSkinToHaveStateEnum.Change:
			IsLocked = true;
			IsUse = false;
			break;
		case SkillSkinToHaveStateEnum.Use:
			IsLocked = true;
			IsUse = true;
			break;
		}
	}

	public void OnClick()
	{
		parent?.ItemOnClick(this);
	}
}
