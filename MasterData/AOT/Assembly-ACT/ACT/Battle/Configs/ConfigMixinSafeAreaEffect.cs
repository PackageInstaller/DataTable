using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("安全区域特效效果", "Mixin", new string[] { "safe", "area", "effect" })]
public class ConfigMixinSafeAreaEffect : ConfigMixin
{
	public YooAssetReference effectAssetID;

	[Tooltip("填Animator的parameter")]
	public string name;

	public CheckAbilityDuration checkConfig;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSafeAreaEffect(this, ab, index);
	}
}
