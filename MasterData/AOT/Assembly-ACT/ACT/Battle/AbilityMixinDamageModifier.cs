using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinDamageModifier : BaseAbilityMixin, IDamageModifier
{
	private ConfigMixinDamageModifier config;

	private bool _registered;

	private static readonly DamageModifierEvt s_SharedEvt = new DamageModifierEvt();

	public int Priority => config.priority;

	public DamageModifierSide Side => config.side;

	public bool IsValid
	{
		get
		{
			if (isActive)
			{
				return _registered;
			}
			return false;
		}
	}

	public AbilityMixinDamageModifier(ConfigMixinDamageModifier config, Ability ab, byte index)
		: base(ab, index)
	{
		this.config = config;
		m_Priority = config.priority;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinDamageModifier)configMixin;
		m_Priority = config.priority;
	}

	internal override void ResetForPool()
	{
		_registered = false;
		config = null;
		base.ResetForPool();
	}

	public void Modify(AttackData attackData, Ability sourceAbility)
	{
		s_SharedEvt.attackData = attackData;
		ActionMemory memory = new ActionMemory(caster, owner, FindTargetResult.EntityOnly(owner), s_SharedEvt, ability);
		if (config.condition != null)
		{
			bool flag = config.condition.Check(memory);
			if (config.condition.Inverse ? flag : (!flag))
			{
				return;
			}
		}
		float num = config.modifyValue.Return(memory);
		switch (config.modifyType)
		{
		case ModifyDamageType.BaseDamagePhase:
			attackData.basePhaseAdd += num;
			break;
		case ModifyDamageType.FinalPhaseMul:
			attackData.finalPhaseMul *= num;
			break;
		case ModifyDamageType.ElementPhase:
			attackData.elementPhaseAdd += num;
			break;
		case ModifyDamageType.MultiPowerPhase:
			attackData.AddMultiPower += num;
			break;
		case ModifyDamageType.TenacityAtkPhase:
			attackData.attackerTenacityAtk *= num;
			break;
		case ModifyDamageType.criticalPhaseAdd:
			attackData.criticalPhaseAdd += num;
			if (config.overrideValue)
			{
				attackData.criticalChance = 0f;
			}
			break;
		case ModifyDamageType.defPenetrationPhaseAdd:
			attackData.defPenetrationPhaseAdd += num;
			if (config.overrideValue)
			{
				attackData.defPenetration = 0f;
			}
			break;
		case ModifyDamageType.criticalMulPhaseAdd:
			attackData.criticalMulPhaseAdd += num;
			if (config.overrideValue)
			{
				attackData.criticalMul = 0f;
			}
			break;
		case ModifyDamageType.weakPhaseAdd:
			attackData.weakPhaseAdd += num;
			break;
		case ModifyDamageType.extraMulPhaseAdd:
			attackData.finalPhaseAdd += num;
			break;
		case ModifyDamageType.postureBaseAdd:
			attackData.postureBaseAdd += num;
			break;
		case ModifyDamageType.MultiPosturePhase:
			attackData.multiPosturePhase += num;
			break;
		case ModifyDamageType.FinalPhaseAdd:
			attackData.finalPhaseAdd += num;
			if (config.overrideValue)
			{
				float damageMulAdd = owner.GetCompAbility().DamageMulAdd;
				attackData.finalPhaseAdd -= damageMulAdd;
			}
			break;
		case ModifyDamageType.MannerDamagePhase:
			attackData.MannerPhaseAdd += num;
			break;
		case ModifyDamageType.ForceWeakElement:
			attackData.isWeakElement = num > 0f;
			attackData.isWeakElementOverridden = true;
			break;
		case ModifyDamageType.ForceStrongWeakElement:
			attackData.isStrongWeakElement = num > 0f;
			attackData.isStrongWeakElementOverridden = true;
			break;
		case ModifyDamageType.PartWeakPhaseAdd:
			attackData.partWeakPhaseAdd = num;
			break;
		}
		s_SharedEvt.attackData = null;
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddDamageModifier(this);
		_registered = true;
	}

	internal override void OnRemove()
	{
		if (_registered)
		{
			owner.GetCompAbility().RemoveDamageModifier(this);
			_registered = false;
		}
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}
}
