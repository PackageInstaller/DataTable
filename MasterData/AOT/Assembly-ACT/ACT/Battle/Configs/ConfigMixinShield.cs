using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("护盾效果", "Mixin", new string[] { "shield" })]
public class ConfigMixinShield : ConfigMixin
{
	[Tooltip("优先级")]
	public int priority;

	[Tooltip("HP of shield")]
	public ConfigFunction<float> shield_HP;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinShield(this, ab, index);
	}
}
