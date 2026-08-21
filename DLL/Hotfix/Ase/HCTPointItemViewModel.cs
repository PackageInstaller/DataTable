using System.Collections.Generic;

namespace Ase;

public class HCTPointItemViewModel : OptionBase
{
	private bool isSelf;

	private string icon;

	private string oriIcon;

	private int skillId;

	private int order;

	private int curProgress;

	private int totalProgress;

	private HCSPointType pointType;

	private bool isSkinIcon;

	private StateEnumConfig pointState;

	private List<TextItemViewModel> upgradeDataList;

	private bool isSelect;

	private bool isLackGold;

	private DRHeroTalentBig talentBig;

	private DRHeroTalentSmall talentSmall;

	private string disableDesc;

	private string skillName;

	private List<int> propNeedIds;

	private List<int> propNeedNums;

	private int goldCount;

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

	public StateEnumConfig PointState
	{
		get
		{
			return pointState;
		}
		private set
		{
			Set(ref pointState, value, "PointState");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public bool IsSkinIcon
	{
		get
		{
			return isSkinIcon;
		}
		private set
		{
			Set(ref isSkinIcon, value, "IsSkinIcon");
		}
	}

	public string SkillName
	{
		get
		{
			return skillName;
		}
		private set
		{
			Set(ref skillName, value, "SkillName");
		}
	}

	public int SkillId => skillId;

	public int CurProgress
	{
		get
		{
			return curProgress;
		}
		private set
		{
			Set(ref curProgress, value, "CurProgress");
		}
	}

	public bool IsLackGold
	{
		get
		{
			return isLackGold;
		}
		private set
		{
			Set(ref isLackGold, value, "IsLackGold");
		}
	}

	public int TotalProgress
	{
		get
		{
			return totalProgress;
		}
		private set
		{
			Set(ref totalProgress, value, "TotalProgress");
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

	public int Order => order;

	public HCSPointType PointType => pointType;

	public DRHeroTalentBig TalentBig => talentBig;

	public DRHeroTalentSmall TalentSmall => talentSmall;

	public List<TextItemViewModel> UpgradeDataList => upgradeDataList;

	public List<int> PropNeedIds => propNeedIds;

	public List<int> PropNeedNums => propNeedNums;

	public int GoldCount => goldCount;

	public string DisableDesc => disableDesc;

	public HCTPointItemViewModel()
	{
	}

	public HCTPointItemViewModel(OptionBase parent, DRHeroTalentBig talentBig, string skillName, string oriIcon, string icon, int totalProgress, bool isSelf = true)
	{
		base.parent = parent;
		pointType = HCSPointType.Big;
		skillId = talentBig.SkillId;
		this.oriIcon = oriIcon;
		this.icon = icon;
		order = talentBig.Order;
		this.skillName = skillName;
		curProgress = talentBig.Level;
		this.totalProgress = totalProgress;
		this.talentBig = talentBig;
		propNeedIds = talentBig.NeedId;
		propNeedNums = talentBig.NeedNum;
		goldCount = talentBig.NeedGold;
		IsSelf = isSelf;
		IsSkinIcon = !string.IsNullOrEmpty(icon) && icon != this.oriIcon;
	}

	public HCTPointItemViewModel(OptionBase parent, DRHeroTalentSmall talentSmall, bool isSelf = true)
	{
		base.parent = parent;
		pointType = HCSPointType.Small;
		skillId = talentSmall.SkillId;
		order = talentSmall.Order;
		this.talentSmall = talentSmall;
		propNeedIds = talentSmall.NeedId;
		propNeedNums = talentSmall.NeedNum;
		goldCount = talentSmall.NeedGold;
		IsSelf = isSelf;
	}

	public void OnClick()
	{
		parent.ItemOnClick(this);
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	public void UpgradeBig(DRHeroTalentBig talentBig)
	{
		CurProgress = talentBig.Level;
		this.talentBig = talentBig;
		propNeedIds = talentBig.NeedId;
		propNeedNums = talentBig.NeedNum;
		goldCount = talentBig.NeedGold;
	}

	public void SetPointState(StateEnumConfig stateEnumConfig, string disableDesc = "", bool isLackGold = false)
	{
		PointState = stateEnumConfig;
		this.disableDesc = disableDesc;
		IsLackGold = isLackGold;
	}

	public void RefreshIcon(string icon)
	{
		Icon = icon;
		IsSkinIcon = !string.IsNullOrEmpty(icon) && icon != oriIcon;
	}

	private int GetActiveState(int skillLevel, int curLevel)
	{
		if (curLevel > skillLevel)
		{
			return 0;
		}
		if (curLevel == skillLevel)
		{
			return 1;
		}
		if (curLevel < skillLevel)
		{
			return 2;
		}
		return 0;
	}
}
