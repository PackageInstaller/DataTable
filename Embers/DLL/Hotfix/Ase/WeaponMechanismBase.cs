using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public abstract class WeaponMechanismBase
{
	protected BattleSystem battleSystem;

	protected WeaponMechanismViewModel viewModel;

	protected BaseEntity ownerEntity;

	protected DRHero heroCfg;

	private HeroIndicatorRingComponent indicatorRingComp;

	public WeaponMechanismViewModel WeaponMechanismData => viewModel;

	public static WeaponMechanismBase Create(ObservableDictionary<string, Ase.ECS.PropertyData> propertyList)
	{
		WeaponMechanismViewModel weaponMechanismViewModel = new WeaponMechanismViewModel(WeaponEnum.None, propertyList);
		return new WeaponMechanismEmpty(null, null, weaponMechanismViewModel);
	}

	public static WeaponMechanismBase Create(WeaponEnum weaponEnum, BaseEntity entity, DRHero heroCfg, ObservableDictionary<string, Ase.ECS.PropertyData> propertyList)
	{
		WeaponMechanismBase weaponMechanismBase = null;
		switch (weaponEnum)
		{
		case WeaponEnum.Sword:
		{
			WeaponMechanismSwordViewModel weaponMechanismSwordViewModel = new WeaponMechanismSwordViewModel(weaponEnum, propertyList);
			weaponMechanismBase = new WeaponMechanismSword(entity, heroCfg, weaponMechanismSwordViewModel);
			break;
		}
		case WeaponEnum.Gloves:
		{
			WeaponMechanismGlovesViewModel weaponMechanismGlovesViewModel = new WeaponMechanismGlovesViewModel(weaponEnum, propertyList);
			weaponMechanismBase = new WeaponMechanismGloves(entity, heroCfg, weaponMechanismGlovesViewModel);
			break;
		}
		case WeaponEnum.Gun:
		{
			WeaponMechanismGunViewModel weaponMechanismGunViewModel = new WeaponMechanismGunViewModel(weaponEnum, propertyList);
			weaponMechanismBase = new WeaponMechanismGun(entity, heroCfg, weaponMechanismGunViewModel);
			break;
		}
		case WeaponEnum.Bow:
		{
			WeaponMechanismBowViewModel weaponMechanismBowViewModel = new WeaponMechanismBowViewModel(weaponEnum, propertyList);
			weaponMechanismBase = new WeaponMechanismBow(entity, heroCfg, weaponMechanismBowViewModel);
			break;
		}
		case WeaponEnum.Hammer:
		{
			WeaponMechanismHammerViewModel weaponMechanismHammerViewModel = new WeaponMechanismHammerViewModel(weaponEnum, propertyList);
			weaponMechanismBase = new WeaponMechanismHammer(entity, heroCfg, weaponMechanismHammerViewModel);
			break;
		}
		case WeaponEnum.Lance:
		{
			WeaponMechanismLanceViewModel weaponMechanismLanceViewModel = new WeaponMechanismLanceViewModel(weaponEnum, propertyList);
			weaponMechanismBase = new WeaponMechanismLance(entity, heroCfg, weaponMechanismLanceViewModel);
			break;
		}
		default:
		{
			WeaponMechanismViewModel weaponMechanismViewModel = new WeaponMechanismViewModel(weaponEnum, propertyList);
			weaponMechanismBase = new WeaponMechanismEmpty(entity, heroCfg, weaponMechanismViewModel);
			break;
		}
		}
		weaponMechanismBase.battleSystem = entity.GetSystem<BattleSystem>();
		return weaponMechanismBase;
	}

	public virtual void OnStart()
	{
	}

	protected WeaponMechanismBase(BaseEntity entity, DRHero heroCfg, WeaponMechanismViewModel viewModel)
	{
		ownerEntity = entity;
		this.heroCfg = heroCfg;
		this.viewModel = viewModel;
		if (ownerEntity != null)
		{
			indicatorRingComp = ownerEntity.GetComponent<HeroIndicatorRingComponent>();
		}
	}

	public void FixedUpdate(float deltaTime, float timeScaleDeltaTime)
	{
		OnUpdate(deltaTime, timeScaleDeltaTime);
		viewModel?.OnUpdate(deltaTime);
	}

	protected abstract void OnUpdate(float deltaTime, float timeScaleDeltaTime);

	public virtual void SetLayer(int layer)
	{
	}

	public virtual void AddLayer(int layer)
	{
	}

	public virtual void ReduceLayer(int layer)
	{
	}

	public virtual void AddWeaponValueByDamageProgress(DamageProgressBase damageProgress, string property, float value)
	{
		ownerEntity.ChangeProperty(property, value);
	}

	protected virtual void OnLayerChanged(int layer)
	{
	}

	public virtual void SendReleaseSkill(BaseEntity entity, HeroSkillTypeEnum skillType)
	{
	}

	public virtual void OnSkillCharge(int skillId)
	{
		viewModel.OnSkillCharge(skillId);
	}

	public virtual void OnHammerSkillChargeRelease(int skillId)
	{
		viewModel.OnHammerSkillChargeRelease(skillId);
	}

	public virtual void OnSkillStart(int skillId)
	{
	}

	public virtual void OnSkillEnd(int skillId)
	{
		viewModel.OnSkillEndCharge(skillId);
	}

	protected void OnWeaponDataChangeStat(WeaponStatEnum weaponStatEnum, params object[] values)
	{
		battleSystem?.OnWeaponChangeStat(ownerEntity.Id, weaponStatEnum, values);
	}

	public void PlayWeaponIndicatorRing()
	{
		if (indicatorRingComp != null)
		{
			indicatorRingComp.PlayIndicatorRing(IndicatorDisPlayEnum.Weapon);
		}
	}

	public virtual void OnDispose()
	{
		ownerEntity = null;
		viewModel = null;
		battleSystem = null;
	}
}
