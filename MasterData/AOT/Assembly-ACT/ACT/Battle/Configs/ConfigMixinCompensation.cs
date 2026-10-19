using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("Compensation效果", "Mixin", new string[] { "compensation" })]
public class ConfigMixinCompensation : ConfigMixin
{
	public MixinTimer mixinTimer;

	public ConfigFunction<Vector3> pos;

	public ConfigCompensation config;

	public ConfigFunction<Vector3> offset;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinCompensation(this, ab, index);
	}
}
