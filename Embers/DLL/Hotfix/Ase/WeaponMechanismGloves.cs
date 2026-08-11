#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class WeaponMechanismGloves : WeaponMechanismBase, IPropertyChanged
{
	protected WeaponMechanismGlovesViewModel glovesViewModel;

	protected Ase.ECS.PropertyData angerProperty;

	protected Ase.ECS.PropertyData angerSwitchProperty;

	protected Ase.ECS.PropertyData heroEnergyProperty;

	public WeaponMechanismGloves(BaseEntity entity, DRHero heroCfg, WeaponMechanismViewModel viewModel)
		: base(entity, heroCfg, viewModel)
	{
		glovesViewModel = viewModel as WeaponMechanismGlovesViewModel;
	}

	public override void OnStart()
	{
		glovesViewModel.EachEnergyLayerMax = heroCfg.EnergyCellValue;
		angerProperty = ownerEntity.GetPropertyData("HeroAnger");
		if (angerProperty == null)
		{
			Log.Error("获取属性错误:HeroAnger");
			return;
		}
		angerProperty.RegisterOnChangedCallback(this);
		angerSwitchProperty = ownerEntity.GetPropertyData("HeroAngerSwitch");
		if (angerSwitchProperty == null)
		{
			Log.Error("获取属性错误:HeroAngerSwitch");
		}
		heroEnergyProperty = ownerEntity.GetPropertyData("HeroEnergy");
		if (heroEnergyProperty == null)
		{
			Log.Error("获取属性错误:HeroEnergy");
		}
		heroEnergyProperty.RegisterOnChangedCallback(this);
		glovesViewModel.AddHeroAngerChanged(OnHeroAngerChanged);
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "HeroEnergy")
		{
			if (delta < 0f)
			{
				OnWeaponDataChangeStat(WeaponStatEnum.Fight, delta);
			}
			else if (delta > 0f && changedEnum == PropertyChangedEnum.CurValue)
			{
				PlayWeaponIndicatorRing();
			}
		}
		else if (propertyName == "HeroAnger" && delta > 0f)
		{
			OnWeaponDataChangeStat(WeaponStatEnum.Anger, delta);
		}
	}

	protected override void OnUpdate(float deltaTime, float timeScaleDeltaTime)
	{
	}

	public override void AddWeaponValueByDamageProgress(DamageProgressBase damageProgress, string property, float value)
	{
		if (angerSwitchProperty == null || !angerSwitchProperty.CurValue.FloatEquals(0f) || !(property == "HeroAnger"))
		{
			base.AddWeaponValueByDamageProgress(damageProgress, property, value);
		}
	}

	public override void AddLayer(int layer)
	{
		if (angerProperty != null)
		{
			angerProperty.Addition(layer, isIgnoreMax: false);
		}
	}

	public override void SetLayer(int layer)
	{
		if (angerProperty != null)
		{
			angerProperty.Set(layer);
		}
	}

	private void OnHeroAngerChanged()
	{
		ownerEntity.GetComponent<HeroAngerComponent>()?.RefreshHeroAngerLifeTime();
	}

	public override void SendReleaseSkill(BaseEntity entity, HeroSkillTypeEnum skillType)
	{
	}

	public override void OnDispose()
	{
		base.OnDispose();
		angerProperty?.RemoveOnChangedCallback(this);
		heroEnergyProperty?.RemoveOnChangedCallback(this);
	}
}
