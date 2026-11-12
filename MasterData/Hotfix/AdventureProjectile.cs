using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/抛射型子弹")]
public class AdventureProjectile : AdventureBulletBase
{
	public bool useLifeTime;

	public FP lifeTime;

	public FP moveSpeed = 5f;

	public bool useCustomMinJumpDuration;

	public FP customMinJumpDuration = 0.3;

	public bool checkWalkableAndReachable = true;

	[Space]
	public bool enableEarlyWarningEffect;

	public GameObject earlyWarningPrefab;

	public float earlyWarningScale = 1f;

	[Space]
	public GameObject muzzleFlashPrefab;

	public GameObject explosionPrefab;

	public float explosionScale = 1f;

	public GameObject hittedPrefab;

	public GameObject trailPrefab;

	[Space]
	public AdventurePlayerFeedbackEffectConfigureData explosionFeedbackEffectConfigureData;

	[Space]
	public bool rotateByThrowPath;

	protected FP _distance;

	protected FP _startPositionY;

	protected FP _elapsedTime;

	protected float _pitchRotationAngle;

	protected AdventureEarlyWarningFXPlayer _earlyWarningFXPlayer;

	protected long _earlyWarningFXToken;

	private FP _customMinJumpDuration;

	public FP CustomMinJumpDuration
	{
		get
		{
			return _customMinJumpDuration;
		}
		set
		{
			_customMinJumpDuration = value;
		}
	}

	public override bool isShowShadowBlob => true;

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		if (trailPrefab != null)
		{
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(trailPrefab, 1f, transform.position, transform.rotation);
			adventureFXPlayer.Bind(gameObject);
			adventureFXPlayer.syncNode = transform;
		}
		if (muzzleFlashPrefab != null)
		{
			AdventureFXPlayer.PlayFX(muzzleFlashPrefab, (float)logicTimeScale, transform.position, transform.rotation).Bind(gameObject);
		}
		if (enableEarlyWarningEffect && earlyWarningPrefab != null)
		{
			FP val = (useLifeTime ? lifeTime : (_distance / moveSpeed));
			FP fP = TSMath.Max(AdventureModuleController.Config.Combat_MinJumpDuration, val);
			Vector3 vector = new Vector3((float)base.targetPosition.x, transform.position.y, (float)base.targetPosition.y);
			Quaternion spawnRotation = Quaternion.LookRotation(vector - transform.position, Vector3.up);
			vector.y = (float)base.targetPositionY;
			_earlyWarningFXPlayer = AdventureEarlyWarningFXPlayer.PlayFX(earlyWarningPrefab, (float)fP, vector, spawnRotation, earlyWarningScale);
			_earlyWarningFXPlayer.Bind(gameObject);
			_earlyWarningFXToken = _earlyWarningFXPlayer.token;
		}
		else
		{
			_earlyWarningFXPlayer = null;
		}
		_customMinJumpDuration = customMinJumpDuration;
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		velocitySpeed = moveSpeed;
		_distance = TSVector2.Distance(originPosition, targetPosition);
		_startPositionY = positionY;
		_elapsedTime = 0f;
		_pitchRotationAngle = 0f;
		smooth.pitch = _pitchRotationAngle;
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (CheckFinishByWeaponFeature())
		{
			Finish(cancel: true);
		}
		else
		{
			if (!DelayShootUpdate())
			{
				return;
			}
			FP logicDeltaTime = LogicDeltaTime;
			_elapsedTime += logicDeltaTime;
			bool flag = true;
			FP fP = (useLifeTime ? lifeTime : (_distance / velocitySpeed));
			if (useLifeTime)
			{
				velocitySpeed = _distance / fP;
			}
			if (fP < (useCustomMinJumpDuration ? CustomMinJumpDuration : AdventureModuleController.Config.Combat_MinJumpDuration))
			{
				fP = (useCustomMinJumpDuration ? CustomMinJumpDuration : AdventureModuleController.Config.Combat_MinJumpDuration);
				velocitySpeed = _distance / fP;
			}
			FP fP2 = TSMath.Clamp01(_elapsedTime / fP);
			if (fP2 < 1f)
			{
				Motion(fP2);
			}
			else
			{
				tsTransform.Position = targetPosition;
				tsTransform.PositionY = targetPositionY;
				smooth.SyncDeterministicTransform();
				flag = false;
			}
			if (flag)
			{
				TSVector2 tSVector = velocity * logicDeltaTime;
				tsTransform.Position += tSVector;
				tsTransform.Forward = velocityDirection;
				if (!AdventureModuleController.sceneLimitZone.Contains(tsTransform.Position))
				{
					Finish(cancel: true);
				}
				return;
			}
			FP damageImmuneDuration = 0;
			if (useDamageImmuneDurationForMonsterWeapon)
			{
				damageImmuneDuration = damageImmuneDurationForMonsterWeapon;
			}
			_hitBox.CircleAreaHit(GetDamageArea(), 0f, tsTransform.Position, out var _, out var _, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, -5, damageImmuneDuration);
			if (explosionPrefab != null)
			{
				AdventureFXPlayer.PlayFX(explosionPrefab, (float)logicTimeScale, transform.position, transform.rotation, explosionScale);
			}
			if (explosionFeedbackEffectConfigureData != null)
			{
				explosionFeedbackEffectConfigureData.Play(transform.position, gameObject, GetCameraShakeSort());
			}
			if (_earlyWarningFXPlayer != null && _earlyWarningFXPlayer.token == _earlyWarningFXToken)
			{
				_earlyWarningFXPlayer.Complete();
			}
			Finish();
		}
	}

	protected void Motion(FP normalizedTime)
	{
		tsTransform.PositionY = CalcDeterministicPositionY(normalizedTime);
		if (rotateByThrowPath)
		{
			float y = (float)CalcDeterministicPositionY(normalizedTime + 0.05f) - (float)tsTransform.PositionY;
			float x = (float)_distance * 0.05f;
			_pitchRotationAngle = 0f - Vector2.SignedAngle(to: new Vector2(x, y), from: new Vector2(1f, 0f));
			smooth.pitch = _pitchRotationAngle;
		}
	}

	protected FP CalcDeterministicPositionY(FP normalizedTime)
	{
		AdventureModuleConfigureData config = AdventureModuleController.Config;
		FP fP = TSMath.Max(_startPositionY, targetPositionY);
		FP fP2 = TSMath.Max(TSMath.Min(_distance * 0.5f, config.Combat_MaxJumpHeight), config.Combat_MinJumpHeight);
		fP2 += fP;
		if (normalizedTime < 0.5f)
		{
			FP t = normalizedTime * 2f;
			return TSFloatEase.Easing(TSFloatEase.EaseType.EaseOutSine, _startPositionY, fP2, t);
		}
		FP t2 = (normalizedTime - 0.5f) * 2f;
		return TSFloatEase.Easing(TSFloatEase.EaseType.EaseInSine, fP2, targetPositionY, t2);
	}
}
