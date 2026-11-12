using TrueSync;

namespace AdventureBehaviour;

public class CommomAreaHitConfig
{
	public string fxAlias;

	public float fxPositionY;

	public float fxPlaybackSpeed = 1f;

	public float fxScale = 1f;

	public bool actorScale;

	public TSVector2 position;

	public TSVector2 direction;

	public int hitDamageId;

	public int uniqueAttackId;

	public HitBox.FeatureFlag hitFlags;

	public HitBox.HitBoxFeatureData hitFeatureData;

	public string hittedEffectAlias;

	public HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small;

	public FP damageImmuneDuration = -1;
}
