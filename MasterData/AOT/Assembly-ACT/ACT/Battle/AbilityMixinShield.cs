using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinShield : BaseAbilityMixin
{
	private int m_TotalShieldHp;

	private int m_ConsumedShieldHp;

	private ConfigMixinShield m_Config;

	public AbilityMixinShield(ConfigMixinShield configMixinShield, Ability ab, byte index)
		: base(ab, index)
	{
		BindConfig(configMixinShield, calculateTotalShield: true);
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		ConfigMixinShield configMixinShield = (ConfigMixinShield)config;
		BindConfig(configMixinShield, m_Config != configMixinShield);
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_TotalShieldHp = 0;
		m_ConsumedShieldHp = 0;
		base.ResetForPool();
	}

	private void BindConfig(ConfigMixinShield config, bool calculateTotalShield)
	{
		m_Config = config;
		if (calculateTotalShield)
		{
			ActionMemory memory = new ActionMemory(owner, owner, owner, null, ability);
			m_TotalShieldHp = Mathf.CeilToInt(config.shield_HP.Return(memory));
			m_ConsumedShieldHp = 0;
		}
		m_Priority = config.priority;
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtBeforeShieldConsume evtBeforeShieldConsume)
		{
			int num = m_TotalShieldHp - m_ConsumedShieldHp;
			if (num > 0 && evtBeforeShieldConsume.attackData.shieldMixinRemainingDamage > 0)
			{
				int num2 = Mathf.Min(num, evtBeforeShieldConsume.attackData.shieldMixinRemainingDamage);
				m_ConsumedShieldHp += num2;
				evtBeforeShieldConsume.attackData.shieldMixinRemainingDamage -= num2;
			}
		}
	}

	internal override void OnRemove()
	{
		if (owner.TryGetCompAbility(out CompAbility component))
		{
			component.RemoveListener(typeof(EvtBeforeShieldConsume), this);
		}
	}

	internal override void OnInheritRemove()
	{
		OnRemove();
	}

	internal override void OnInheritAdd()
	{
		if (m_ConsumedShieldHp > 0 && owner.TryGetCompAbility(out CompAbility component))
		{
			component.ServerSetShield(component.shield - m_ConsumedShieldHp);
		}
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtBeforeShieldConsume), this);
	}
}
