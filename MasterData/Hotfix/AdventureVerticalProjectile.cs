using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/垂直弹射子弹")]
public class AdventureVerticalProjectile : AdventureBulletBase
{
	public FP lifeTime = 2f;

	public FP verticalHeight = 2f;

	public GameObject explosionPrefab;

	public float explosionScale = 1f;

	public GameObject hittedPrefab;

	public GameObject trailPrefab;

	[Space]
	public AdventurePlayerFeedbackEffectConfigureData explosionFeedbackEffectConfigureData;

	protected FP _distance;

	protected FP offsetY;

	protected FP _elapsedTime;

	protected float _pitchRotationAngle;

	private LogicEntity _atkTarget;

	private TSVector2 lastPos;

	private FP lastPosY;

	private AdventureFXPlayer trailFX;

	private LogicEntity atkTarget
	{
		get
		{
			if (_atkTarget == null)
			{
				return null;
			}
			if (_atkTarget is AdventureActor adventureActor)
			{
				if (!adventureActor.isSneak && !adventureActor.isPenetrate && adventureActor.actorHealthInfo.isAlive)
				{
					return _atkTarget;
				}
				return null;
			}
			return null;
		}
		set
		{
			_atkTarget = value;
		}
	}

	public override bool isShowShadowBlob => true;

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		if (trailPrefab != null)
		{
			trailFX = AdventureFXPlayer.PlayFX(trailPrefab, 1f, transform.position, transform.rotation);
			trailFX.Bind(gameObject);
			trailFX.syncNode = transform;
			trailFX.syncSlotScale = true;
		}
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		offsetY = positionY;
		_elapsedTime = 0f;
		_atkTarget = target;
		if (_atkTarget != null)
		{
			lastPos = _atkTarget.tsTransform.Position;
			lastPosY = _atkTarget.tsTransform.PositionY;
		}
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
			FP fP = lifeTime;
			if (atkTarget != null)
			{
				lastPos = atkTarget.tsTransform.Position;
				lastPosY = atkTarget.tsTransform.PositionY;
			}
			FP fP2 = TSMath.Clamp01(_elapsedTime / fP);
			bool flag = fP2 < 1f;
			FP fP3 = CalcPositionY(fP2);
			tsTransform.Position = lastPos;
			tsTransform.PositionY = fP3 + offsetY + lastPosY;
			if (flag)
			{
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
			Finish();
		}
	}

	protected FP CalcPositionY(FP normalizedTime)
	{
		if (normalizedTime < 0.5f)
		{
			FP t = normalizedTime * 2f;
			return TSFloatEase.Easing(TSFloatEase.EaseType.EaseOutSine, 0, verticalHeight, t);
		}
		FP t2 = (normalizedTime - 0.5f) * 2f;
		return TSFloatEase.Easing(TSFloatEase.EaseType.EaseInSine, verticalHeight, 0, t2);
	}

	public void ChangeTrailFxSize(float scale)
	{
		trailFX.syncSlotScale = false;
		trailFX.sizeScale = trailFX.syncNode.lossyScale.x + scale;
	}
}
