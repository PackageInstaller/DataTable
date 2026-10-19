using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("监听自定义事件", "Mixin", new string[] { "listen", "custom", "evt" })]
public class ConfigMixinListenCustomEvt : ConfigMixin
{
	public string id;

	public ConfigAction[] actions;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinListenCustomEvt(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, actions, configAbility);
	}
}
