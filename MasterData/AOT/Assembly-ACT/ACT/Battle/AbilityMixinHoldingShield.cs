using ACT.Battle.Configs;
using ACT.Core;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinHoldingShield : BaseAbilityMixin
{
	private ConfigMixinHoldingShield m_ConfigMixinHoldingShield;

	private bool m_isForwardAttack;

	private bool m_isReduseShieldValue;

	private float m_attackerTenacity;

	public AbilityMixinHoldingShield(ConfigMixinHoldingShield config, Ability ab, byte index)
		: base(ab, index)
	{
		m_ConfigMixinHoldingShield = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_ConfigMixinHoldingShield = (ConfigMixinHoldingShield)config;
	}

	internal override void ResetForPool()
	{
		m_ConfigMixinHoldingShield = null;
		m_isForwardAttack = false;
		m_isReduseShieldValue = false;
		m_attackerTenacity = 0f;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		CompAbility? compAbility = owner.GetCompAbility();
		compAbility.AddListener(typeof(EvtAttackeeModifyTenacitied), this);
		compAbility.AddListener(typeof(EvtAttackeeModifyDamage), this);
		DynamicValue orCreateDynamicVar = compAbility.GetOrCreateDynamicVar(m_ConfigMixinHoldingShield.dynamicName);
		orCreateDynamicVar.id = m_ConfigMixinHoldingShield.id;
		orCreateDynamicVar.min = m_ConfigMixinHoldingShield.minValue.GetFloat(ability);
		orCreateDynamicVar.max = m_ConfigMixinHoldingShield.maxValue.GetFloat(ability);
		orCreateDynamicVar.value = m_ConfigMixinHoldingShield.value.GetFloat(ability);
		compAbility.dynamicNames.Add(m_ConfigMixinHoldingShield.id, m_ConfigMixinHoldingShield.dynamicName);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtAttackeeModifyTenacitied)
		{
			EvtAttackeeModifyTenacitied evtAttackeeModifyTenacitied = (EvtAttackeeModifyTenacitied)evt;
			m_attackerTenacity = evtAttackeeModifyTenacitied.attackData.attackerTenacityAtk;
		}
		if (!(evt is EvtAttackeeModifyDamage))
		{
			return;
		}
		AttackData attackData = ((EvtAttackeeModifyDamage)evt).attackData;
		m_isForwardAttack = attackData.attacker.GetFaceDir() != owner.GetFaceDir();
		if (!m_isForwardAttack)
		{
			return;
		}
		m_isReduseShieldValue = true;
		ConfigPredicate[] predicates = m_ConfigMixinHoldingShield.predicates;
		for (int i = 0; i < predicates.Length; i++)
		{
			if (predicates[i].Check(new ActionMemory(caster, owner, owner, evt, ability)))
			{
				m_isReduseShieldValue = false;
			}
		}
		if (m_isReduseShieldValue)
		{
			CompAbility compAbility = owner.GetCompAbility();
			DynamicValue orCreateDynamicVar = compAbility.GetOrCreateDynamicVar(m_ConfigMixinHoldingShield.dynamicName);
			orCreateDynamicVar.value -= m_attackerTenacity;
			if (orCreateDynamicVar.value > 0f)
			{
				attackData.finalPhaseMul = 0f;
				compAbility.ServerSetTenacity(compAbility.maxTenacity);
			}
		}
		DoActions(owner, evt, m_ConfigMixinHoldingShield.configActions);
	}

	internal override void OnRemove()
	{
		if (owner.TryGetCompAbility(out CompAbility component))
		{
			component.RemoveListener(typeof(EvtAttackeeModifyTenacitied), this);
			component.RemoveListener(typeof(EvtAttackeeModifyDamage), this);
		}
	}
}
