using TrueSync;

public class Brick_SpawnBall : Brick_BallBase
{
	public FP spawnInitialSpeed = 13f;

	public FP spawnNormalMaxSpeed = 16f;

	public FP spawnLimitSpeed = 25f;

	public FP spawnLimitSpeedInv = 32f;

	public FP spawnMinSpeed = 12f;

	public FP spawnChangeSpeed = 1.5f;

	public FP spawnRandomAngle = 5f;

	public FP spawnPoy = 0.38f;

	public int spawnDamageId;

	public bool spawnIsHittedEffectScale = true;

	public FP spawnDamageImmuneDuration = 0.2f;

	public HitBox hitBox;

	protected override FP read_initialSpeed => spawnInitialSpeed;

	protected override FP normal_maxSpeed => spawnNormalMaxSpeed;

	protected override FP limitSpeed => spawnLimitSpeed;

	protected override FP limitSpeed_inv => spawnLimitSpeedInv;

	protected override FP minSpeed => spawnMinSpeed;

	protected override FP read_changeSpeed => spawnChangeSpeed;

	protected override FP random_Angle => spawnRandomAngle;

	protected override FP _poy => spawnPoy;

	protected override bool CanSpawnOnBouncePole => false;

	protected override bool AffectedByLaunchState => false;

	protected override void RegisterToManager()
	{
		_isSplitBall = true;
		if (hitBox == null)
		{
			hitBox = transform.GetComponent<HitBox>();
		}
		Singleton<BrickBreakerManager>.Instance.AddSpawnedBall(this);
	}

	protected override void HandleOutAreaDeath()
	{
		Singleton<BrickBreakerManager>.Instance.RemoveAllBlackHoleForBall(this);
		Singleton<BrickBreakerManager>.Instance.RemoveAllSpeedBandForBall(this);
		Singleton<BrickBreakerManager>.Instance.RemoveAllPortalTractionForBall(this);
		Singleton<BrickBreakerManager>.Instance.RemoveSpawnedBall(this);
	}

	protected override void ChangeHitId()
	{
		if (!(Hit_Box == null))
		{
			Hit_Box.hitDamageId = spawnDamageId;
			Hit_Box.featureFlags = hitBox.featureFlags;
			Hit_Box.featureData = hitBox.featureData;
			Hit_Box.hurtAnimType = hitBox.hurtAnimType;
		}
	}

	public void ApplyHitId()
	{
		ChangeHitId();
	}

	protected override void HitTarget(ref DeterministicRaycastHit raycastHit)
	{
		if (!(Hit_Box == null))
		{
			Hit_Box.HitSingleTarget(UniqueAttackId, raycastHit.collider, out var _, out var _, ref raycastHit, null, spawnIsHittedEffectScale, spawnDamageImmuneDuration);
		}
	}
}
