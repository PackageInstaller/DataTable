using ACT.Battle.Configs;

namespace ACT.Battle;

public class AbilityMixinCarry : BaseAbilityMixin
{
	private ConfigMixinCarry m_Config;

	public AbilityMixinCarry(ConfigMixinCarry config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinCarry)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		base.ResetForPool();
	}
}
