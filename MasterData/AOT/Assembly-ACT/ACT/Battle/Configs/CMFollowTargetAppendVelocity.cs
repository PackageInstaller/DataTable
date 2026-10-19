using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("CM跟随目标Append速度效果", "Mixin", new string[] { "cm", "follow", "target", "append", "velocity", "retarget", "aim" })]
public class CMFollowTargetAppendVelocity : ConfigMixin
{
	public enum DirMode
	{
		Once,
		Always
	}

	public DirMode dirMode;

	public ConfigMixinFollowTarget.FollowMode followMode;

	public float followAppend = 0.1f;

	public Vector3 offset;

	public float init;

	public float acc;

	public float max;

	public Vector3 fallBackDir;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityCMFollowTargetAppendVelocity(this, ab, index);
	}
}
