using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("目标速度效果", "Mixin", new string[] { "change", "target", "speed", "retarget", "aim" })]
public class ConfigMixinChangeTargetSpeed : ConfigMixin
{
	[HideInInspector]
	public enum ChangeTargetSpeed
	{
		alliance,
		onceFindTargetResult,
		continueFindTargetResult
	}

	public ConfigFunction<float> speed;

	[HideInInspector]
	public Alliance alliance;

	public TimeType timeType;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinChangeEnemySpeed(this, ab, index);
	}
}
