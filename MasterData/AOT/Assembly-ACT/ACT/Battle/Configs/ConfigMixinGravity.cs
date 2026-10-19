using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("重力效果", "Mixin", new string[] { "gravity", "move", "movement", "position", "velocity" })]
public class ConfigMixinGravity : ConfigMixin
{
	public enum MixinGravityType
	{
		NoGrabAfterFinish,
		AlwaysGrab
	}

	public MixinGravityType mixinGravityType;

	public uint animationCurve = 1u;

	public float pushImpetus = 3000f;

	public float cd;

	public float stopDistance = 0.1f;

	[Space(15f)]
	public TargetBounds targetBounds;

	public Vector3 offset;

	public ConfigPredicate[] configPredicateList = new ConfigPredicate[2]
	{
		new CheckEntityVolume
		{
			target = CheckTarget.Target,
			checkVolumeType = MonsterWeigtType.Normal
		},
		new CheckAllianceIs
		{
			target = CheckTarget.Target,
			alliance = Alliance.Enemy
		}
	};

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinGravity(this, ab, index);
	}
}
