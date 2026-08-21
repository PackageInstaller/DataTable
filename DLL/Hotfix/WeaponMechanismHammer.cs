#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;

public class WeaponMechanismHammer : WeaponMechanismBase, IPropertyChanged
{
	protected WeaponMechanismHammerViewModel hammerViewModel;

	private Ase.ECS.PropertyData eachChargedEnergyProperty;

	private Ase.ECS.PropertyData heroChargedEnergyProperty;

	private Ase.ECS.PropertyData energyMaxTimeProperty;

	private Ase.ECS.PropertyData energyReduceTimeProperty;

	private Ase.ECS.PropertyData chargedEnergyMaxProperty;

	private float _heroChargedEnergyReduceTime;

	private bool _startCharge;

	public WeaponMechanismHammer(BaseEntity entity, DRHero heroCfg, WeaponMechanismViewModel viewModel)
		: base(entity, heroCfg, viewModel)
	{
		hammerViewModel = viewModel as WeaponMechanismHammerViewModel;
	}

	public override void OnStart()
	{
		if (heroCfg.HammerInit.Count != 4)
		{
			Log.Error("锤斧武器参数错误,请检查Hero表");
			return;
		}
		heroChargedEnergyProperty = viewModel.Property["HeroChargedEnergy"];
		energyMaxTimeProperty = viewModel.Property["ChargedEnergyMaxTime"];
		eachChargedEnergyProperty = viewModel.Property["EachChargedEnergy"];
		energyReduceTimeProperty = viewModel.Property["HeroChargedEnergyReduceTime"];
		chargedEnergyMaxProperty = viewModel.Property["ChargedEnergyMax"];
		heroChargedEnergyProperty.ResetMax(heroCfg.HammerInit[0], isExecuteValueChanged: false);
		energyMaxTimeProperty.ResetUnification(heroCfg.HammerInit[1]);
		eachChargedEnergyProperty.ResetInit(heroCfg.HammerInit[2]);
		eachChargedEnergyProperty.Set(heroCfg.HammerInit[2], isIgnoreMax: false, isExecuteValueChanged: false);
		energyReduceTimeProperty.ResetInit(heroCfg.HammerInit[3]);
		energyReduceTimeProperty.ResetValue(toMax: false, isExecuteValueChanged: false);
		chargedEnergyMaxProperty.ResetInit(heroCfg.HammerInit[0]);
		RefreshTime();
		_startCharge = false;
		eachChargedEnergyProperty.RegisterOnChangedCallback(this);
		heroChargedEnergyProperty.RegisterOnChangedCallback(this);
		hammerViewModel?.OnInitHammer((int)heroChargedEnergyProperty.MaxValue, (int)eachChargedEnergyProperty.CurValue);
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "HeroChargedEnergy")
		{
			hammerViewModel.HammerEnergyMax = (int)heroChargedEnergyProperty.MaxValue;
		}
		else if (propertyName == "EachChargedEnergy")
		{
			hammerViewModel.HammerEnergyEach = (int)eachChargedEnergyProperty.CurValue;
		}
	}

	private void RefreshTime()
	{
		ownerEntity.SetProperty("HammerChargeTime", 0f);
		_heroChargedEnergyReduceTime = energyReduceTimeProperty.CurValue;
	}

	protected override void OnUpdate(float deltaTime, float timeScaleDeltaTime)
	{
		if (!_startCharge)
		{
			if (hammerViewModel.HammerLightYello != heroChargedEnergyProperty.ScaleValue)
			{
				hammerViewModel.HammerLightYello = heroChargedEnergyProperty.ScaleValue;
				if (hammerViewModel.HammerLightYello >= 1f)
				{
					PlayWeaponIndicatorRing();
				}
			}
		}
		else
		{
			hammerViewModel.HammerDeepYello = heroChargedEnergyProperty.ScaleValue;
			_heroChargedEnergyReduceTime -= deltaTime;
			if (_heroChargedEnergyReduceTime <= 0f)
			{
				ExpendProperty();
			}
		}
	}

	public override void OnSkillCharge(int skillId)
	{
		base.OnSkillCharge(skillId);
		_startCharge = true;
		float curValue = heroChargedEnergyProperty.CurValue;
		float curValue2 = eachChargedEnergyProperty.CurValue;
		float num = curValue;
		int num2 = (int)energyMaxTimeProperty.CurValue;
		float num3 = 0f;
		while (num2 > 0 && num - curValue2 >= 0f)
		{
			num2--;
			num3 += curValue2;
			num -= curValue2;
		}
		float num4 = curValue - num3;
		float hammerLightYello = Mathf.Max(0f, num4 / heroChargedEnergyProperty.MaxValue);
		hammerViewModel.HammerLightYello = hammerLightYello;
		hammerViewModel.HammerDeepYello = heroChargedEnergyProperty.ScaleValue;
		RefreshTime();
	}

	public override void OnSkillEnd(int skillId)
	{
		base.OnSkillEnd(skillId);
		hammerViewModel.HammerLightYello = heroChargedEnergyProperty.ScaleValue;
		_heroChargedEnergyReduceTime = energyReduceTimeProperty.CurValue;
		_startCharge = false;
		hammerViewModel.HammerDeepYello = 0f;
	}

	public override void OnHammerSkillChargeRelease(int skillId)
	{
		base.OnHammerSkillChargeRelease(skillId);
		hammerViewModel.HammerLightYello = heroChargedEnergyProperty.ScaleValue;
		_heroChargedEnergyReduceTime = energyReduceTimeProperty.CurValue;
		_startCharge = false;
		hammerViewModel.HammerDeepYello = 0f;
	}

	private void ExpendProperty()
	{
		if (!(energyMaxTimeProperty.CurValue <= 0f) && !(heroChargedEnergyProperty.CurValue < eachChargedEnergyProperty.CurValue))
		{
			heroChargedEnergyProperty.Addition(0f - eachChargedEnergyProperty.CurValue, isIgnoreMax: false);
			OnWeaponDataChangeStat(WeaponStatEnum.Cast, eachChargedEnergyProperty.CurValue);
			hammerViewModel.HammerReduce = (int)eachChargedEnergyProperty.CurValue;
			hammerViewModel.HammerReduce = 0;
			energyMaxTimeProperty.Addition(-1f, isIgnoreMax: false);
			ownerEntity.ChangeProperty("HammerChargeTime", 1f);
			_heroChargedEnergyReduceTime += energyReduceTimeProperty.CurValue;
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		heroChargedEnergyProperty?.RemoveOnChangedCallback(this);
		eachChargedEnergyProperty?.RemoveOnChangedCallback(this);
	}
}
