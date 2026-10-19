using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("推动效果", "Mixin", new string[] { "push", "move", "movement", "position", "velocity" })]
public class ConfigMixinPush : ConfigMixin
{
	public float offest;

	public Vector3 scaleColliderExtents = Vector3.one;

	public bool useEntityVelocity;

	public Vector3 velocity;

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
		return new AbilityMixinPush(this, ab, index);
	}
}
