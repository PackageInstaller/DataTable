using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("重新Call效果", "Mixin", new string[] { "re", "call" })]
public class ConfigMixinReCall : ConfigMixin
{
	[Tooltip("回溯buff的名字")]
	public string name;

	public float waitTime = 1f;

	public ConfigAction[] onAddList;

	public ConfigAction[] onRemoveList;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityReCall(this, ab, index);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility configAbility)
	{
		ConfigAbility.CacheActionList(list, onAddList, configAbility);
		ConfigAbility.CacheActionList(list, onRemoveList, configAbility);
	}
}
