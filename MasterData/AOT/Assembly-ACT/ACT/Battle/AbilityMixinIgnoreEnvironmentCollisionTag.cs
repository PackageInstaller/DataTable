using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinIgnoreEnvironmentCollisionTag : BaseAbilityMixin
{
	private ConfigMixinIgnoreEnvironmentCollisionTag m_Config;

	private string m_AppliedTag;

	public AbilityMixinIgnoreEnvironmentCollisionTag(ConfigMixinIgnoreEnvironmentCollisionTag config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinIgnoreEnvironmentCollisionTag)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_AppliedTag = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		if (string.IsNullOrEmpty(m_AppliedTag))
		{
			string ignoreEnvironmentCollisionTag = m_Config.ignoreEnvironmentCollisionTag;
			if (!string.IsNullOrEmpty(ignoreEnvironmentCollisionTag) && owner.TryGetCompPhysics(out CompPhysics component))
			{
				component.AddIgnoreEnvironmentCollisionTag(ignoreEnvironmentCollisionTag);
				m_AppliedTag = ignoreEnvironmentCollisionTag;
			}
		}
	}

	internal override void OnRemove()
	{
		RemoveAppliedTag();
	}

	internal override void OnSilentRemove()
	{
		RemoveAppliedTag();
	}

	private void RemoveAppliedTag()
	{
		if (!string.IsNullOrEmpty(m_AppliedTag))
		{
			if (owner.TryGetCompPhysics(out CompPhysics component))
			{
				component.RemoveIgnoreEnvironmentCollisionTag(m_AppliedTag);
			}
			m_AppliedTag = null;
		}
	}
}
