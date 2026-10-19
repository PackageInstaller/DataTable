using ACT.Battle.Configs;

namespace ACT.Battle;

public class AbilityMixinSprint : BaseAbilityMixin
{
	public ConfigMixinSprint m_config;

	public AbilityMixinSprint(ConfigMixinSprint configMixinSprint, Ability ab, byte index)
		: base(ab, index)
	{
		m_config = configMixinSprint;
	}
}
