using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Unilateral效果", "Mixin", new string[] { "unilateral" })]
public class ConfigMixinUnilateral : ConfigMixin
{
	[Tooltip("是否朝右，只有左右2个朝向")]
	public bool faceRight;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinUnilateral(this, ab, index);
	}
}
