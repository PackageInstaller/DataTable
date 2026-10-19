using System;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinIntervalDoAction : BaseAbilityMixin
{
	private ConfigMixinIntervalDoAction m_Config;

	public bool toRemove;

	private float m_Interval;

	public AbilityMixinIntervalDoAction(ConfigMixinIntervalDoAction config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinIntervalDoAction)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		toRemove = false;
		m_Interval = 0f;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		if (toRemove || !owner.IsAlive())
		{
			return;
		}
		if (m_Config.removeMotion != null)
		{
			CompMotion compMotion = owner.GetCompMotion();
			MotionState[] removeMotion = m_Config.removeMotion;
			foreach (MotionState motionState in removeMotion)
			{
				if (compMotion.curMotionState == motionState)
				{
					toRemove = true;
					ability.RemoveStack(ability.stack);
					return;
				}
			}
		}
		m_Interval -= owner.GetCompTime().fixedDeltaTime;
		if (m_Interval < 0f)
		{
			m_Interval = m_Config.interval;
			if ((owner.GetCompCharacter() == null || m_Config.inactiveRoleDoActions || !(owner != MonoECS.instance.mainEntity)) && m_Config.intervalDoActions != null)
			{
				DoActions(owner, null, m_Config.intervalDoActions);
			}
		}
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().onDie += new Action<Entity>(OnDie);
	}

	internal override void OnRemove()
	{
		RemoveListener();
		if (!toRemove && owner.IsAlive() && (ability == null || !ability.casterDieRemove || m_Config.casterDieRemoveDo))
		{
			DoActions(owner, null, m_Config.toRemoveActions);
		}
	}

	private void RemoveListener()
	{
		if (owner.TryGetCompAbility(out CompAbility component))
		{
			component.onDie -= new Action<Entity>(OnDie);
		}
	}

	private void OnDie(Entity entityBehave)
	{
		if (m_Config.onDieActions != null)
		{
			DoActions(entityBehave, null, m_Config.onDieActions);
		}
	}
}
