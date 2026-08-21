using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class HeroSkill : ViewModelBase
{
	private bool isEmpty;

	private bool isShow;

	private int specialCooling;

	private float interactionCooling;

	private float rescueCooling;

	private bool canTouchWhenInteraction = true;

	private string iconBattle;

	private string skillTag;

	private bool iconChangeEffect;

	private HeroSkillData skillData;

	private SkillCoolingData skillCoolingData;

	private SkillDeriveData _skillDeriveData;

	private bool hideSkillBtn;

	private bool showTeachClickEffect;

	private bool canRelease = true;

	private InteractionRequest skillDataUpdateRequest = new InteractionRequest();

	public string IconBattle
	{
		get
		{
			return iconBattle;
		}
		set
		{
			Set(ref iconBattle, value, "IconBattle");
		}
	}

	public bool IconChangeEffect
	{
		get
		{
			return iconChangeEffect;
		}
		set
		{
			Set(ref iconChangeEffect, value, "IconChangeEffect");
		}
	}

	public string SkillTag
	{
		get
		{
			return skillTag;
		}
		set
		{
			Set(ref skillTag, value, "SkillTag");
		}
	}

	public HeroSkillData SkillData
	{
		get
		{
			return skillData;
		}
		set
		{
			Set(ref skillData, value, "SkillData");
		}
	}

	public SkillCoolingData CoolingData
	{
		get
		{
			return skillCoolingData;
		}
		set
		{
			Set(ref skillCoolingData, value, "CoolingData");
		}
	}

	public SkillDeriveData SkillDeriveData
	{
		get
		{
			return _skillDeriveData;
		}
		set
		{
			_skillDeriveData = value;
		}
	}

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

	public bool IsShow
	{
		get
		{
			return isShow;
		}
		set
		{
			Set(ref isShow, value, "IsShow");
		}
	}

	public float InteractionCooling
	{
		get
		{
			return interactionCooling;
		}
		set
		{
			Set(ref interactionCooling, value, "InteractionCooling");
		}
	}

	public float RescueCooling
	{
		get
		{
			return rescueCooling;
		}
		set
		{
			Set(ref rescueCooling, value, "RescueCooling");
		}
	}

	public bool HideSkillBtn
	{
		get
		{
			return hideSkillBtn;
		}
		set
		{
			hideSkillBtn = value;
		}
	}

	public bool ShowTeachClickEffect
	{
		get
		{
			return showTeachClickEffect;
		}
		private set
		{
			showTeachClickEffect = value;
		}
	}

	public bool CanRelease
	{
		get
		{
			return canRelease;
		}
		set
		{
			Set(ref canRelease, value, "CanRelease");
		}
	}

	public InteractionRequest SkillDataUpdateRequest => skillDataUpdateRequest;

	public static HeroSkill Empty()
	{
		HeroSkill heroSkill = new HeroSkill();
		heroSkill.UpdateData(null);
		return heroSkill;
	}

	public void UpdateData(HeroSkillData heroSkillData)
	{
		SkillData = heroSkillData;
		CoolingData = heroSkillData?.SkillCoolingData;
		SkillDeriveData = heroSkillData?.SkillDeriveData;
		if (SkillData == null)
		{
			IsEmpty = true;
			IsShow = false;
			IconBattle = "empty";
			SkillTag = "empty";
		}
		else
		{
			IsEmpty = false;
			IsShow = true;
			if (IconBattle != SkillData.IconBattle)
			{
				IconChangeEffect = false;
				IconChangeEffect = true;
			}
			IconBattle = SkillData.IconBattle;
			SkillTag = SkillData.SkillTag;
		}
		skillDataUpdateRequest.Raise();
	}

	public void SetSkillBtnHide(HeroSkillTypeEnum skillTypeEnum, bool isHide)
	{
		HideSkillBtn = isHide;
		if (skillData != null)
		{
			skillData.SetSkillBtnHide(skillTypeEnum, isHide);
		}
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		skillData = null;
		skillCoolingData = null;
	}

	public void SetSkillCantRelease(HeroSkillTypeEnum skillType, bool canRelease)
	{
		CanRelease = canRelease;
		if (skillData != null)
		{
			skillData.SetSkillBtnHide(skillType, canRelease);
		}
	}

	public void SetTeachClickEffect(bool showEffect)
	{
		ShowTeachClickEffect = showEffect;
	}
}
