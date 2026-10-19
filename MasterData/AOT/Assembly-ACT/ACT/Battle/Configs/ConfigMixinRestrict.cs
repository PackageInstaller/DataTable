using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("限制效果", "Mixin", new string[] { "restrict", "move", "movement", "position", "velocity" })]
public class ConfigMixinRestrict : ConfigMixin
{
	[Tooltip("受击后开始限制的随机帧范围")]
	public Vector2 randomRange;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinRestrict(this, ab, index);
	}
}
