using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("忽略环境碰撞Tag", "Mixin", new string[] { "ignore", "environment", "collision", "tag" })]
public class ConfigMixinIgnoreEnvironmentCollisionTag : ConfigMixin
{
	[Tooltip("Ability存在期间，Entity会忽略环境层上使用该Unity Tag的Collider")]
	public string ignoreEnvironmentCollisionTag;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinIgnoreEnvironmentCollisionTag(this, ab, index);
	}
}
