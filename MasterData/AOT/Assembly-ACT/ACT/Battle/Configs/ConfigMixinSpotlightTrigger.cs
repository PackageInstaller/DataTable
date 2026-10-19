using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("聚光效果", "Mixin", new string[] { "spotlight", "trigger" })]
public class ConfigMixinSpotlightTrigger : ConfigMixin
{
	public ConfigAction[] onAdd;

	public ConfigAction[] onRemove;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSpotlightTrigger(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, onAdd, configAbility);
		ConfigAbility.CacheActionList(list, onRemove, configAbility);
	}
}
