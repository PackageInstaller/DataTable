using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("混合突袭Trap效果", "Mixin", new string[] { "mixed", "raid", "trap", "trigger" })]
public class ConfigMixinMixedRaidTrapTrigger : ConfigMixin
{
	public ConfigAction[] onTriggerEnter;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinMixedRaidTrapTrigger(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, onTriggerEnter, configAbility);
	}
}
