using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("动作速度效果", "Mixin", new string[] { "change", "motion", "speed" })]
public class ConfigMixinChangeMotionSpeed : ConfigMixin
{
	public string[] motionTypes;

	[Tooltip("states")]
	public string[] motionStates;

	public float value;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinChangeMotionSpeed(this, ab, index);
	}
}
