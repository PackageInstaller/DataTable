using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinDelayTime : BaseAbilityMixin
{
	private ConfigMixinDelayTime m_config;

	public List<float> timers = new List<float>();

	public AbilityMixinDelayTime(ConfigMixinDelayTime config, Ability ab, byte index)
		: base(ab, index)
	{
		m_config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_config = (ConfigMixinDelayTime)config;
	}

	internal override void ResetForPool()
	{
		timers.Clear();
		m_config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		timers.Add(m_config.delayTime);
	}

	internal override void TriggerAbility()
	{
		timers.Add(m_config.delayTime);
	}

	internal override void FixedUpdate()
	{
		if (timers.Count <= 0)
		{
			return;
		}
		CompTime compTime = owner.GetCompTime();
		for (int i = 0; i < timers.Count; i++)
		{
			timers[i] -= compTime.fixedDeltaTime;
			if (timers[i] <= 0f)
			{
				timers.RemoveAt(i);
				i--;
				if (!owner.IsValid)
				{
					break;
				}
				SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, m_config.OnDelay);
			}
		}
	}
}
