using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinDamageCD : BaseAbilityMixin
{
	private ConfigMixinDamageCD m_ConfigMixinDamageCD;

	private float m_CD;

	private bool m_Flag;

	public AbilityMixinDamageCD(ConfigMixinDamageCD config, Ability ab, byte index)
		: base(ab, index)
	{
		m_ConfigMixinDamageCD = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_ConfigMixinDamageCD = (ConfigMixinDamageCD)config;
	}

	internal override void ResetForPool()
	{
		m_ConfigMixinDamageCD = null;
		m_CD = 0f;
		m_Flag = false;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		m_ConfigMixinDamageCD.cd = Mathf.Max(m_ConfigMixinDamageCD.cd, 0.01f);
		owner.GetCompAbility().AddListener(typeof(EvtAttackeeModifyDamage), this);
		m_CD = m_ConfigMixinDamageCD.cd;
	}

	internal override void OnEvt(BaseEvt evt)
	{
		EvtAttackeeModifyDamage evtAttackeeModifyDamage = (EvtAttackeeModifyDamage)evt;
		if (m_CD < m_ConfigMixinDamageCD.cd)
		{
			evtAttackeeModifyDamage.attackData.finalPhaseMul = 0f;
			evtAttackeeModifyDamage.attackData.actualDamage = 0;
		}
		else
		{
			m_Flag = true;
		}
	}

	internal override void FixedUpdate()
	{
		if (m_Flag)
		{
			m_CD -= owner.GetCompTime()?.fixedDeltaTime ?? Time.fixedDeltaTime;
		}
		if (m_CD <= 0f)
		{
			m_Flag = false;
			m_CD = m_ConfigMixinDamageCD.cd;
		}
	}

	internal override void OnRemove()
	{
		RemoveListener();
	}

	private void RemoveListener()
	{
		owner.GetCompAbility()?.RemoveListener(typeof(EvtAttackeeModifyDamage), this);
	}
}
