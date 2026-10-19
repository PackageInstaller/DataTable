using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinChangeCDModifier : BaseAbilityMixin
{
	private ConfigMixinChangeCDModifier m_Config;

	public AbilityMixinChangeCDModifier(ConfigMixinChangeCDModifier config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinChangeCDModifier)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		if (owner.HasCompAbility())
		{
			owner.AddChangeCDModifier(ability.config.name, m_Config.addCD.Return(new ActionMemory(caster, owner, owner)));
		}
	}

	internal override void OnRemove()
	{
		if (owner.HasCompAbility())
		{
			owner.RemoveChangeCDModifier(ability.config.name);
		}
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}
}
