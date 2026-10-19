using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("监听动作", "Mixin", new string[] { "listen", "motion", "change" })]
public class ConfigMixinListenMotionChange : ConfigMixin
{
	public enum ListenMotionChangeType
	{
		ListemSpecifyMotion,
		ListemCurMotion
	}

	public string[] from;

	public string[] to;

	public ConfigAction[] actionList;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinListenMotionChange(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, actionList, configAbility);
	}
}
