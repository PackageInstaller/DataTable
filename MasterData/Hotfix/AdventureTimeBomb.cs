using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/定时炸弹")]
public class AdventureTimeBomb : AdventureBulletBase
{
	public FP delayTime = 0f;

	[Space]
	public TSVector2 startRelativePosition = TSVector2.zero;

	public FP startRelativePositionY = 0f;

	public TSFloatEase.EaseType motionEaseType;

	public bool traceTarget;

	public bool showGraphicIndicator;

	[Space]
	public GameObject muzzleFlashPrefab;

	public GameObject explosionPrefab;

	public float explosionScale = 1f;

	public GameObject hittedPrefab;

	public GameObject trailPrefab;

	[Space]
	public AdventurePlayerFeedbackEffectConfigureData explosionFeedbackEffectConfigureData;

	public HitBox.Shape shape = HitBox.Shape.Circle;

	[Space]
	public FP fanInnerRadius;

	[Space]
	public FP fanOuterRadius;

	[Space]
	public FP fanAngle;

	protected FP _elapsedTime;

	protected TSVector2 _startPosition;

	protected FP _startPositionY;

	protected FP _targetPositionY;

	protected CircleGraphicIndicator _graphicIndicator;

	protected override void OnDeactive()
	{
		if (_graphicIndicator != null)
		{
			SceneSingleton<AdventureIndicatorController>.Instance.DespawnGraphicInspector(_graphicIndicator);
			_graphicIndicator = null;
		}
		base.OnDeactive();
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		if (showGraphicIndicator)
		{
			_graphicIndicator = SceneSingleton<AdventureIndicatorController>.Instance.SpawnCircleGraphicIndicator();
		}
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		if (trailPrefab != null)
		{
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(trailPrefab, 1f, transform.position, transform.rotation);
			adventureFXPlayer.Bind(gameObject);
			adventureFXPlayer.syncNode = transform;
		}
		if (muzzleFlashPrefab != null)
		{
			AdventureFXPlayer.PlayFX(muzzleFlashPrefab, (float)logicTimeScale, transform.position, transform.rotation);
		}
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		if (traceTarget && target != null)
		{
			targetPosition = target.tsTransform.Position;
		}
		_targetPositionY = targetPositionY;
		tsTransform.Position = (_startPosition = targetPosition + startRelativePosition);
		tsTransform.PositionY = (_startPositionY = _targetPositionY + startRelativePositionY);
		_elapsedTime = 0f;
		transform.position = new Vector3((float)tsTransform.Position.x, (float)tsTransform.PositionY, (float)tsTransform.Position.y);
		if (_graphicIndicator != null)
		{
			_graphicIndicator.position = targetPosition.ToVector2();
			_graphicIndicator.rotation = (float)direction.GetAngle();
			_graphicIndicator.size = (float)GetDamageArea() * 2f;
			_graphicIndicator.progress = 0f;
		}
	}

	public override void Finish(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		base.Finish(cancel: false, catched: false, ignorFinishFX);
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (!DelayShootUpdate())
		{
			return;
		}
		FP logicDeltaTime = LogicDeltaTime;
		_elapsedTime += logicDeltaTime;
		bool flag = true;
		FP fP = ((delayTime > 0f) ? TSMath.Clamp01(_elapsedTime / delayTime) : ((FP)1f));
		if (fP < 1f)
		{
			Motion(fP);
		}
		else
		{
			tsTransform.Position = targetPosition;
			tsTransform.PositionY = _targetPositionY;
			flag = false;
		}
		if (flag)
		{
			if (_graphicIndicator != null)
			{
				_graphicIndicator.progress = (float)fP;
			}
			return;
		}
		if (_graphicIndicator != null)
		{
			_graphicIndicator.progress = 1f;
		}
		FP damageImmuneDuration = 0;
		if (useDamageImmuneDurationForMonsterWeapon)
		{
			damageImmuneDuration = damageImmuneDurationForMonsterWeapon;
		}
		int hittedCount;
		int damageCount;
		switch (shape)
		{
		case HitBox.Shape.Circle:
			_hitBox.CircleAreaHit(GetDamageArea(), 0f, tsTransform.Position, out hittedCount, out damageCount, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, -5, damageImmuneDuration);
			break;
		case HitBox.Shape.Fan:
			_hitBox.FanAreaHit(fanAngle, GetDamamgeFanOuterRadius(), GetDamamgeFanInnerRadius(), tsTransform.Position, tsTransform.Rotation, out damageCount, out hittedCount, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, damageImmuneDuration);
			break;
		}
		smooth.SyncDeterministicTransform();
		if (explosionPrefab != null)
		{
			AdventureFXPlayer.PlayFX(explosionPrefab, (float)logicTimeScale, transform.position, transform.rotation, explosionScale * transform.localScale.x);
		}
		if (explosionFeedbackEffectConfigureData != null)
		{
			explosionFeedbackEffectConfigureData.Play(transform.position, gameObject, GetCameraShakeSort());
		}
		Finish();
	}

	private FP GetDamamgeFanInnerRadius()
	{
		if (shape != HitBox.Shape.Fan)
		{
			return 0;
		}
		return ((fanInnerRadius > 0) ? fanInnerRadius : ((FP)0)) * transform.localScale.x;
	}

	private FP GetDamamgeFanOuterRadius()
	{
		if (shape != HitBox.Shape.Fan)
		{
			return 0;
		}
		return ((fanOuterRadius > 0) ? fanOuterRadius : dtCollider.Radius) * transform.localScale.x;
	}

	protected void Motion(FP normalizedTime)
	{
		if (traceTarget && target != null)
		{
			targetPosition = target.tsTransform.Position;
		}
		FP x = TSFloatEase.Easing(TSFloatEase.EaseType.Linear, _startPosition.x, targetPosition.x, normalizedTime);
		FP y = TSFloatEase.Easing(TSFloatEase.EaseType.Linear, _startPosition.y, targetPosition.y, normalizedTime);
		tsTransform.Position = new TSVector2(x, y);
		FP positionY = TSFloatEase.Easing(motionEaseType, _startPositionY, _targetPositionY, normalizedTime);
		tsTransform.PositionY = positionY;
	}
}
