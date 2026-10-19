using ACT.Core;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("伤害Reduction事件效果", "Mixin", new string[] { "damage", "reduction", "evt" })]
public class ConfigMixinDamageReductionEvt : ConfigMixin
{
	public ElementBitmask element;

	[Range(0f, 1f)]
	public float damageReduction;

	public bool inverse;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinDamageReductionEvt(this, ab, index);
	}
}
