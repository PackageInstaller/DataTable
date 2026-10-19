using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("当前攻击者效果", "Mixin", new string[] { "get", "current", "attacker", "target", "retarget", "aim" })]
public class ConfigMixinGetCurrentAttacker : ConfigMixin
{
	[Tooltip("需要执行的动作")]
	public ConfigAction[] actions;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinGetCurrentAttacker(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, actions, configAbility);
	}
}
