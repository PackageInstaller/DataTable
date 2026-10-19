using System.Collections.Generic;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("切换技能位置效果", "Mixin", new string[] { "set", "switch", "skill", "pos" })]
public class ConfigMixinSetSwitchSkillPos : ConfigMixin
{
	public ConfigAction[] actionlist;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSetSwitchSkillPos(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, actionlist, configAbility);
	}
}
