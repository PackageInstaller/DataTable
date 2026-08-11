using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class SkillDescViewModel : OptionBase
{
	private HeroSkillTypeEnum curOpt;

	private BattleHeroData curHero;

	private Dictionary<HeroSkillTypeEnum, HeroSkillData> heroSkillDatas;

	private Dictionary<int, BattleHeroData> battleHeroes;

	private SkillTabItemViewModel curSkill;

	private List<SkillTabItemViewModel> tabVMList;

	private InteractionRequest updateSkillBtnRequest;

	public List<SkillTabItemViewModel> TabVmList => tabVMList;

	public SkillTabItemViewModel CurSkill => curSkill;

	public HeroSkillTypeEnum CurOpt => curOpt;

	public HeroAttributeEnum HeroAttri
	{
		get
		{
			if (curHero != null)
			{
				return curHero.Attribute;
			}
			return HeroAttributeEnum.Wind;
		}
	}

	public int SkillCount
	{
		get
		{
			if (curHero != null)
			{
				return curHero.SkillCount;
			}
			return 0;
		}
	}

	public IInteractionRequest UpdateSkillBtnRequest => updateSkillBtnRequest;

	public override void ItemOnClick(object obj)
	{
		if (obj is SkillTabItemViewModel tab)
		{
			UpdateSelectHero(tab);
		}
	}

	public SkillDescViewModel()
	{
	}

	public SkillDescViewModel(OptionBase parent)
	{
		base.parent = parent;
		updateSkillBtnRequest = new InteractionRequest();
		battleHeroes = new Dictionary<int, BattleHeroData>();
	}

	public void OnOpen(Dictionary<int, BattleUserViewModel> battleHeroes)
	{
		if (tabVMList == null)
		{
			tabVMList = new List<SkillTabItemViewModel>();
		}
		else
		{
			tabVMList.Clear();
			this.battleHeroes.Clear();
			curSkill = null;
			heroSkillDatas = null;
		}
		foreach (BattleUserViewModel value in battleHeroes.Values)
		{
			if (!value.IsEmpty && value.HeroData.SkillCount != 0)
			{
				this.battleHeroes.Add(value.HeroData.MemberId, value.HeroData);
				_ = value.HeroData.IsSelf;
			}
		}
		foreach (SkillTabItemViewModel tabVM in tabVMList)
		{
			if (tabVM.IsSelect)
			{
				if (tabVM.Data == null)
				{
					curOpt = HeroSkillTypeEnum.Attack;
				}
				if (!heroSkillDatas.ContainsKey(curOpt))
				{
					return;
				}
				curHero = tabVM.HeroData;
				tabVM.UpdateSkillData(heroSkillDatas[curOpt]);
				if (curSkill == null)
				{
					curSkill = new SkillTabItemViewModel(this, curHero, isSelf: true, 0);
				}
				else
				{
					curSkill.UpdateHeroData(curHero);
				}
				curSkill.UpdateSkillData(heroSkillDatas[curOpt]);
			}
		}
		int num;
		if (curHero != null)
		{
			BattleHeroData battleHeroData = curHero;
			num = ((battleHeroData != null && battleHeroData.SkillCount > 0) ? 1 : 0);
		}
		else
		{
			num = 0;
		}
		base.IsVisible = (byte)num != 0;
	}

	public void UpdateHero()
	{
		updateSkillBtnRequest.Raise();
	}

	public void UpdateSelectSkill(HeroSkillTypeEnum btnKey)
	{
		curOpt = btnKey;
		curSkill.UpdateSkillData(heroSkillDatas[CurOpt]);
	}

	public void UpdateSelectHero(SkillTabItemViewModel tab)
	{
		for (int i = 0; i < tabVMList.Count; i++)
		{
			if (tabVMList[i].IsSelect && tabVMList[i] != tab)
			{
				tabVMList[i].SetSelect(isSel: false);
			}
		}
		curHero = tab.HeroData;
		curSkill.UpdateHeroData(tab.HeroData);
		curSkill.UpdateSkillData(heroSkillDatas[curOpt]);
		updateSkillBtnRequest.Raise();
	}

	public string GetIconName(HeroSkillTypeEnum optionEnum)
	{
		if (heroSkillDatas.ContainsKey(optionEnum))
		{
			return heroSkillDatas[optionEnum].Icon;
		}
		return "";
	}

	public string GetTagName(HeroSkillTypeEnum optionEnum)
	{
		if (heroSkillDatas.ContainsKey(optionEnum))
		{
			return heroSkillDatas[optionEnum].SkillTag;
		}
		return "";
	}

	public bool IsOptRole(int index)
	{
		foreach (KeyValuePair<int, BattleHeroData> battleHero in battleHeroes)
		{
			if (battleHero.Key == index + 1)
			{
				return battleHero.Value.IsSelf;
			}
		}
		return false;
	}
}
