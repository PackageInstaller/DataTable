using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("战斗实体Buff效果", "Mixin", new string[] { "battle", "entity", "add", "buff", "state", "status", "tag" })]
public class ConfigMixinBattleEntityAddBuff : ConfigMixin
{
	[Tooltip("buff名字")]
	public string ability;

	public string[] abilities;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinBattleEntityAddBuff(this, ab, index);
	}
}
