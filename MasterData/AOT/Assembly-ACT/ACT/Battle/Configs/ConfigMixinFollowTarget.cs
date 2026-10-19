using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("跟随目标效果", "Mixin", new string[] { "follow", "target", "retarget", "aim" })]
public class ConfigMixinFollowTarget : ConfigMixin
{
	public enum FollowMode
	{
		X,
		XY
	}

	public enum ConfigMixinFollowTargetType
	{
		always,
		onlyOnce
	}

	public FollowMode followMode;

	public float followAppend = 0.1f;

	public ConfigAction[] onEndActions;

	public ConfigFunction<Vector3> offset;

	public ConfigMixinFollowTargetType followType;

	public BaseFindTargets findTarget;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinFollowTarget(this, ab, index);
	}
}
