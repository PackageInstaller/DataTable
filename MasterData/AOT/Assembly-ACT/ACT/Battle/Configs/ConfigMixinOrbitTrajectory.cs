using ACT.Sound;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigMixinOrbitTrajectory : ConfigMixin
{
	public YooAssetReference aimEffectAssetID;

	public YooAssetReference warningEffectAssetID;

	public AudioEventReference audioAimSoundEvt;

	public AudioEventReference audioWarningSoundEvt;

	public float rayDistance = 10f;

	public ConfigTrajectoryObject configTrajectoryObject;

	public Vector2 bulletSize = new Vector2(0.25f, 0.25f);

	public float bulletSpawnHeight = 10f;

	public FilterEntityType beHitFilter = FilterEntityType.Character;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinOrbitTrajectory(this, ab, index);
	}
}
