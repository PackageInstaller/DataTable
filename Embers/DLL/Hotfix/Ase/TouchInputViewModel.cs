using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TouchInputViewModel : OptionBase
{
	private int showUIStatis;

	private HeroEntity heroEntity;

	private BattleHeroData heroData;

	private bool canTouch = true;

	private HeroAttributeEnum heroAttributeEnum;

	private bool touchInputMaskState;

	protected readonly InteractionRequest<bool> hidePanelRequest = new InteractionRequest<bool>();

	private Dictionary<HeroSkillTypeEnum, HeroSkill> _heroSkills;

	private TouchLayout touchLayout;

	private Dictionary<string, OptionBase> childVMs = new Dictionary<string, OptionBase>();

	private BuffDescViewModel buffDescViewModel;

	public bool TouchInputMaskState => touchInputMaskState;

	public bool ShowWindow => showUIStatis >= 0;

	public IInteractionRequest HidePanelRequest => hidePanelRequest;

	public TouchLayout TouchLayout => touchLayout;

	public HeroAttributeEnum HeroAttributeEnum
	{
		get
		{
			return heroAttributeEnum;
		}
		private set
		{
			Set(ref heroAttributeEnum, value, "HeroAttributeEnum");
		}
	}

	public bool CanTouch
	{
		get
		{
			return canTouch;
		}
		set
		{
			Set(ref canTouch, value, "CanTouch");
		}
	}

	public BattleHeroData HeroData
	{
		get
		{
			return heroData;
		}
		set
		{
			Set(ref heroData, value, "HeroData");
		}
	}

	public HeroEntity HeroEntity
	{
		get
		{
			return heroEntity;
		}
		private set
		{
			Set(ref heroEntity, value, "HeroEntity");
		}
	}

	public TouchInputViewModel()
	{
		_heroSkills = new Dictionary<HeroSkillTypeEnum, HeroSkill>();
		_heroSkills.Add(HeroSkillTypeEnum.Attack, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Roll, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Skill1, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Skill2, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Skill3, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Skill4, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Interaction1, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Interaction2, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Interaction3, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Interaction4, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.DeputyPropSkill, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.PropSkill, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Rescue1, HeroSkill.Empty());
		_heroSkills.Add(HeroSkillTypeEnum.Rescue2, HeroSkill.Empty());
		heroAttributeEnum = HeroAttributeEnum.Dark;
	}

	public void ChangeOperationHero(HeroEntity entity)
	{
		HeroEntity = entity;
		HeroData = entity.BattleHeroData;
		HeroAttributeEnum = HeroData.Attribute;
		ObservableDictionary<HeroSkillTypeEnum, HeroSkillData> commandType2HeroData = heroEntity.BattleHeroData.CommandType2HeroData;
		foreach (HeroSkillTypeEnum key in _heroSkills.Keys)
		{
			if (commandType2HeroData.ContainsKey(key))
			{
				_heroSkills[key]?.UpdateData(commandType2HeroData[key]);
				if (_heroSkills.TryGetValue(key, out var value) && value.HideSkillBtn)
				{
					entity.GetComponent<SkillComponent>().SetSkillBtnHide(key, isHide: true);
				}
			}
			else
			{
				_heroSkills[key]?.UpdateData(null);
			}
		}
	}

	public void InitTouchLayout(TouchLayout layout)
	{
		touchLayout = layout;
	}

	public void CanReleaseSkill(bool val)
	{
		using Dictionary<HeroSkillTypeEnum, HeroSkill>.ValueCollection.Enumerator enumerator = _heroSkills.Values.GetEnumerator();
		while (enumerator.MoveNext() && enumerator.Current.CoolingData != null)
		{
		}
	}

	public void CanReleaseSkill(bool val, HeroSkillTypeEnum heroSkillTypeEnum)
	{
		if (_heroSkills.TryGetValue(heroSkillTypeEnum, out var value))
		{
			_ = value.CoolingData;
		}
	}

	public void SetInteractionCooling(float percent, HeroSkillTypeEnum interactionSkillType)
	{
		if (_heroSkills.TryGetValue(interactionSkillType, out var value))
		{
			value.InteractionCooling = percent;
		}
	}

	public void SetRescueCooling(float cur, float max)
	{
	}

	public HeroSkill GetHeroSkill(HeroSkillTypeEnum skillEnum)
	{
		_heroSkills.TryGetValue(skillEnum, out var value);
		return value;
	}

	public void OpenBattleSkillDesc(Dictionary<int, BattleUserViewModel> battleUsers)
	{
	}

	public void UpdateBattleSkillDesc(Dictionary<int, BattleUserViewModel> battleUsers)
	{
	}

	private T GetChildVM<T>() where T : OptionBase
	{
		if (childVMs.ContainsKey(typeof(T).FullName))
		{
			return (T)childVMs[typeof(T).FullName];
		}
		return null;
	}

	private void AddChildVM<T>(T child) where T : OptionBase
	{
		if (!childVMs.ContainsKey(typeof(T).FullName))
		{
			childVMs.Add(typeof(T).FullName, child);
		}
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		_heroSkills.Clear();
		heroEntity = null;
		heroData = null;
		buffDescViewModel = null;
		childVMs.Clear();
	}

	public void SetSkillCooling(HeroSkillTypeEnum skillTypeEnum, float coolingTime)
	{
		if (_heroSkills[skillTypeEnum] != null)
		{
			_heroSkills[skillTypeEnum].CoolingData.CurrentCoolingTime = coolingTime;
		}
	}

	public void HidePanel(bool isShow, bool touchInputMaskState)
	{
		showUIStatis += (isShow ? 1 : (-1));
		this.touchInputMaskState = touchInputMaskState;
		hidePanelRequest.Raise(showUIStatis >= 0);
	}

	public void GetNewBP(BattleProps bpData)
	{
		if (heroEntity == null)
		{
			return;
		}
		int index = heroEntity.BattleHeroData.AddBPDataImmediately(bpData);
		heroEntity.BattleHeroData.AddPropData(bpData, index);
		ObservableDictionary<HeroSkillTypeEnum, HeroSkillData> commandType2HeroData = heroEntity.BattleHeroData.CommandType2HeroData;
		foreach (HeroSkillTypeEnum key in _heroSkills.Keys)
		{
			if (key == HeroSkillTypeEnum.PropSkill || key == HeroSkillTypeEnum.DeputyPropSkill)
			{
				if (commandType2HeroData.ContainsKey(key))
				{
					_heroSkills[key]?.UpdateData(commandType2HeroData[key]);
				}
				else
				{
					_heroSkills[key]?.UpdateData(null);
				}
			}
		}
	}

	public void OpenBuffDesc()
	{
		if (heroData != null && heroData.BuffList != null && heroData.BuffList.Count > 0)
		{
			if (buffDescViewModel == null)
			{
				buffDescViewModel = new BuffDescViewModel(this);
				buffDescViewModel.OnShow(this, heroData.BuffList, new RectTransform());
				buffDescViewModel.IsVisible = true;
				openWindowRequest.Raise(new OpenViewArg(typeof(BuffDescWindow), buffDescViewModel));
			}
			else if (!buffDescViewModel.IsVisible)
			{
				buffDescViewModel.OnShow(this, heroData.BuffList, new RectTransform());
				buffDescViewModel.IsVisible = true;
				showViewRequest.Raise(new ShowViewArg(buffDescViewModel, isShow: true));
			}
		}
	}

	public void EnergyUnenoughEffect()
	{
		if (heroData != null)
		{
			heroData.ReleaseSkillEnergyUnenough();
		}
	}
}
