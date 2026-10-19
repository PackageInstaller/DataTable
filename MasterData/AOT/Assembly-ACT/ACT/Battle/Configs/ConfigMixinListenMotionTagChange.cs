using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("监听动作标签", "Mixin", new string[] { "listen", "motion", "tag", "change" })]
public class ConfigMixinListenMotionTagChange : ConfigMixin
{
	public MotionPrimaryTypeTag fromPrimaryTypeTag;

	public MotionTypeTag fromTypeTag;

	public MotionPrimaryTypeTag toPrimaryTypeTag;

	public MotionTypeTag toTypeTag;

	public ConfigAction[] actionList;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinListenMotionTagChange(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, actionList, configAbility);
	}
}
