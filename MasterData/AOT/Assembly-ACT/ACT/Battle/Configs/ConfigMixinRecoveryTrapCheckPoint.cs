using UnityEngine;

namespace ACT.Battle.Configs;

[Tooltip("回溯到checkpoint")]
[AbilityTypeMetadata("恢复Trap点效果", "Mixin", new string[] { "recovery", "trap", "check", "point" })]
public class ConfigMixinRecoveryTrapCheckPoint : ConfigMixin
{
	public float fadeInTime;

	public float lastTime;

	public float fadeOutTime;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinRecoveryTrapCheckPoint(this, ab, index);
	}
}
