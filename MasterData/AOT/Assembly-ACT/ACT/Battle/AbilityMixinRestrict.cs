using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinRestrict : BaseAbilityMixin
{
	private ConfigMixinRestrict m_Config;

	private int m_Frame;

	private int startFrame;

	public AbilityMixinRestrict(ConfigMixinRestrict config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinRestrict)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_Frame = 0;
		startFrame = 0;
		base.ResetForPool();
	}

	internal override void FixedUpdate()
	{
		CompTime compTime = owner.GetCompTime();
		if (compTime != null && !compTime.isMotionTimeScale)
		{
			m_Frame++;
			if (m_Frame >= startFrame)
			{
				compTime.motionScale = 0f;
				m_Frame = 0;
			}
		}
	}

	internal override void OnAdd()
	{
		int num = Random.Range((int)m_Config.randomRange.x, (int)m_Config.randomRange.y);
		startFrame = ((num == 4) ? 5 : num);
		if (num == 0)
		{
			owner.GetCompTime().motionScale = 0f;
		}
	}

	internal override void OnRemove()
	{
		if (owner.TryGetCompTime(out CompTime component))
		{
			component.motionScale = 1f;
		}
	}
}
