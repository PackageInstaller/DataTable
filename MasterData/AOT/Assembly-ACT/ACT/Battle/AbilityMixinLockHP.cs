using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinLockHP : BaseAbilityMixin
{
	private ConfigMixinLockHP m_Config;

	private int m_PhaseIndex;

	public AbilityMixinLockHP(ConfigMixinLockHP config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		m_Priority = config.priority;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinLockHP)config;
		m_Priority = m_Config.priority;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_PhaseIndex = 0;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		CompAbility compAbility = owner.GetCompAbility();
		m_PhaseIndex = 0;
		while (m_PhaseIndex < m_Config.phases.Length && ShouldSkipPhaseOnAdd(m_Config.phases[m_PhaseIndex], compAbility.hp, compAbility.maxHP))
		{
			m_PhaseIndex++;
		}
		if (m_PhaseIndex == m_Config.phases.Length)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("none sense");
			}
		}
		else
		{
			compAbility.AddListener(typeof(EvtSetActualDamage), this);
		}
	}

	private bool ShouldSkipPhaseOnAdd(ConfigMixinLockHP.Phase phase, int hp, int maxHP)
	{
		if (phase.lockHPType == ConfigMixinLockHP.Phase.LockHPType.percent)
		{
			return phase.percent >= (float)hp / (float)maxHP;
		}
		return false;
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (m_Config.predicates != null)
		{
			ActionMemory memory = new ActionMemory(owner, owner, owner, null, ability);
			ConfigPredicate[] predicates = m_Config.predicates;
			foreach (ConfigPredicate configPredicate in predicates)
			{
				if (!(configPredicate.Inverse ? (!configPredicate.Check(memory)) : configPredicate.Check(memory)))
				{
					return;
				}
			}
		}
		if (!(evt is EvtSetActualDamage evtSetActualDamage) || m_PhaseIndex >= m_Config.phases.Length)
		{
			return;
		}
		CompAbility compAbility = owner.GetCompAbility();
		int actualDamage = evtSetActualDamage.attackData.actualDamage;
		int num = Mathf.Max(compAbility.hp - actualDamage, 0);
		bool flag = false;
		ConfigMixinLockHP.Phase phase = m_Config.phases[m_PhaseIndex];
		switch (phase.lockHPType)
		{
		case ConfigMixinLockHP.Phase.LockHPType.hpValue:
			if (num <= phase.hp)
			{
				num = phase.hp;
				flag = true;
			}
			break;
		case ConfigMixinLockHP.Phase.LockHPType.percent:
			if ((float)num / (float)compAbility.maxHP <= phase.percent)
			{
				num = Mathf.CeilToInt((float)compAbility.maxHP * phase.percent);
				flag = true;
			}
			break;
		case ConfigMixinLockHP.Phase.LockHPType.lethalDamage:
			if (num <= 0)
			{
				num = phase.hp;
				flag = true;
			}
			break;
		}
		if (flag)
		{
			switch (phase.phaseType)
			{
			case ConfigMixinLockHP.Phase.PhaseType.dontReduceDamage:
				DoActions(owner, evtSetActualDamage, phase.actions);
				break;
			case ConfigMixinLockHP.Phase.PhaseType.autoReduceDamage:
				actualDamage = compAbility.hp - num;
				evtSetActualDamage.attackData.actualDamage = actualDamage;
				DoActions(owner, evtSetActualDamage, phase.actions);
				break;
			case ConfigMixinLockHP.Phase.PhaseType.zeroThisDamage:
				evtSetActualDamage.attackData.actualDamage = 0;
				DoActions(owner, evtSetActualDamage, phase.actions);
				break;
			}
			if (m_Config.phases.Length > 1 && m_Config.doLockHPType == ConfigMixinLockHP.DoLockHPType.once)
			{
				m_PhaseIndex++;
			}
		}
	}

	internal override void OnRemove()
	{
		if (owner.TryGetCompAbility(out CompAbility component))
		{
			component.RemoveListener(typeof(EvtSetActualDamage), this);
		}
	}

	internal override void OnSilentRemove()
	{
		if (owner.TryGetCompAbility(out CompAbility component))
		{
			component.RemoveListener(typeof(EvtSetActualDamage), this);
		}
	}
}
