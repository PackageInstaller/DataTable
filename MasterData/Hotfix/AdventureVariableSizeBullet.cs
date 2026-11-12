using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/可变尺寸子弹")]
public class AdventureVariableSizeBullet : AdventureBulletBase
{
	public enum EdgeDiffuseType
	{
		Default,
		OnlyWidth,
		OnlyLength,
		SameRatio
	}

	public FP delayMove = 0f;

	public FP moveSpeed = 5f;

	public FP acceleratedVelocity = 0f;

	public FP borderVelocitySpeed = 5f;

	[Space]
	public FP lifeTime = 5f;

	[Space]
	public GameObject muzzleFlashPrefab;

	public GameObject hitPrefab;

	public GameObject hittedPrefab;

	public bool effectTimeScale = true;

	public GameObject fxPrefab;

	public GameObject trailPrefab;

	[Space]
	public AdventurePlayerFeedbackEffectConfigureData hitFeedbackEffectConfigureData;

	public FP damageImmuneDuration;

	[Space]
	public FP changeSpeed = 0;

	public EdgeDiffuseType edgeDiffuseType;

	public FP maxLength = 1;

	public FP maxWidth = 1;

	public FP maxRadius = 1;

	public FP minLength = 1;

	public FP minWidth = 1;

	public FP minRadius = 1;

	public FP delayChangeTime = 0;

	private const int hitableLayerMaskWithoutAreaEffect = 20736;

	private const int hitableLayerMaskAll = 151808;

	private AdventureFXPlayer _fx;

	private long _fxToken;

	private FP _delayTimer;

	private FP _lifeTimer;

	private TSVector _defaultSize;

	private FP _defaultRadius;

	private FP _boxRatio;

	private FP _delayChangeTime;

	private bool _haveHitAreaEffectFeature;

	private int _hitableLayerMask;

	protected override void OnInit()
	{
		base.OnInit();
		Collider collider = base.collider;
		if (!(collider is BoxCollider boxCollider))
		{
			if (collider is SphereCollider sphereCollider)
			{
				_defaultRadius = sphereCollider.radius;
			}
		}
		else
		{
			_defaultSize = new TSVector(FP.FromConfigFloat(boxCollider.size.x), FP.FromConfigFloat(boxCollider.size.y), FP.FromConfigFloat(boxCollider.size.z));
			_boxRatio = ((_defaultSize.z > FP.Zero) ? (_defaultSize.x / _defaultSize.z) : FP.Zero);
		}
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		TrueSyncTransform trueSyncTransform = tsTransform;
		TSVector2 position2 = (originPosition = position);
		trueSyncTransform.Position = position2;
		_delayTimer = delayMove;
		_delayChangeTime = delayChangeTime;
		if (fxPrefab != null)
		{
			_fx = AdventureFXPlayer.PlayFX(fxPrefab, 1f, transform.position, transform.rotation);
			_fx.Bind(gameObject);
			_fx.ownerActor = owner as AdventureActor;
			_fx.syncNode = transform;
			_fxToken = _fx.token;
		}
		if (trailPrefab != null)
		{
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(trailPrefab, 1f, transform.position, transform.rotation);
			adventureFXPlayer.Bind(gameObject);
			adventureFXPlayer.ownerActor = owner as AdventureActor;
			adventureFXPlayer.syncNode = transform;
		}
		if (muzzleFlashPrefab != null)
		{
			AdventureFXPlayer adventureFXPlayer2 = AdventureFXPlayer.PlayFX(muzzleFlashPrefab, (float)logicTimeScale, transform.position, transform.rotation);
			adventureFXPlayer2.ownerActor = owner as AdventureActor;
			adventureFXPlayer2.Bind(gameObject);
		}
		_haveHitAreaEffectFeature = (hitBox.featureFlags & HitBox.FeatureFlag.ChangeArea) == HitBox.FeatureFlag.ChangeArea;
		_hitableLayerMask = 151808;
		_hitableLayerMask = (_haveHitAreaEffectFeature ? 151808 : 20736);
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		velocitySpeed = moveSpeed;
		_lifeTimer = 0f;
		Collider collider = base.collider;
		if (!(collider is BoxCollider boxCollider))
		{
			if (collider is SphereCollider sphereCollider)
			{
				sphereCollider.radius = (float)_defaultRadius;
			}
		}
		else
		{
			boxCollider.size = new Vector3((float)_defaultSize.x, (float)_defaultSize.y, (float)_defaultSize.z);
		}
		dtCollider?.LoadFromUnityCollider(base.collider);
	}

	public override void Finish(bool cancel = false, bool catched = false, bool _ignorFinishFX = false)
	{
		if (_fx != null && _fxToken == _fx.token)
		{
			_fx.Stop();
			_fx = null;
		}
		base.Finish(cancel, catched, _ignorFinishFX);
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
			_lifeTimer += logicDeltaTime;
			if (_delayTimer > 0f)
			{
				_delayTimer -= logicDeltaTime;
			}
			bool flag = _delayTimer <= 0f;
			if (_delayChangeTime > 0f)
			{
				_delayChangeTime -= logicDeltaTime;
			}
			bool flag2 = true;
			if (lifeTime > 0f && _lifeTimer >= lifeTime)
			{
				flag2 = false;
			}
			else
			{
				if (useDamageImmuneDurationForMonsterWeapon)
				{
					damageImmuneDuration = damageImmuneDurationForMonsterWeapon;
				}
				_hitBox.hitDamageId = hitDamageId;
				int damageCount;
				int hittedCount;
				if (dtCollider.ColliderShape == DeterministicColliderShape.Rect)
				{
					flag2 = _hitBox.RectangleAreaHit(dtCollider.ColliderWidth, dtCollider.ColliderLength, tsTransform.Position, tsTransform.Rotation, out damageCount, out hittedCount, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, _hitableLayerMask, damageImmuneDuration, randomHit: false, null, !effectTimeScale);
				}
				else if (dtCollider.ColliderShape == DeterministicColliderShape.Circle)
				{
					flag2 = _hitBox.CircleAreaHit(dtCollider.Radius, 0f, tsTransform.Position, out hittedCount, out damageCount, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, _hitableLayerMask, damageImmuneDuration, randomHit: false, !effectTimeScale);
				}
			}
			if (flag2)
			{
				if (CheckCanChange())
				{
					ChangeSize(logicDeltaTime);
				}
				if (flag)
				{
					Move(logicDeltaTime);
				}
			}
			else
			{
				Finish();
			}
		}
	}

	private bool CheckCanChange()
	{
		if (changeSpeed == 0)
		{
			return false;
		}
		if (_delayChangeTime > 0)
		{
			return false;
		}
		if (dtCollider.ColliderShape == DeterministicColliderShape.Rect)
		{
			if (changeSpeed > 0)
			{
				switch (edgeDiffuseType)
				{
				case EdgeDiffuseType.OnlyWidth:
					return dtCollider.ColliderWidth < maxWidth;
				case EdgeDiffuseType.OnlyLength:
					return dtCollider.ColliderLength < maxLength;
				case EdgeDiffuseType.Default:
				case EdgeDiffuseType.SameRatio:
					if (dtCollider.ColliderWidth < maxWidth)
					{
						return dtCollider.ColliderLength < maxLength;
					}
					return false;
				}
			}
			else
			{
				switch (edgeDiffuseType)
				{
				case EdgeDiffuseType.OnlyWidth:
					return dtCollider.ColliderWidth > minWidth;
				case EdgeDiffuseType.OnlyLength:
					return dtCollider.ColliderLength > minLength;
				case EdgeDiffuseType.Default:
				case EdgeDiffuseType.SameRatio:
					if (dtCollider.ColliderWidth > minWidth)
					{
						return dtCollider.ColliderLength > minLength;
					}
					return false;
				}
			}
		}
		else if (dtCollider.ColliderShape == DeterministicColliderShape.Circle)
		{
			if (changeSpeed > 0)
			{
				return dtCollider.Radius < maxRadius;
			}
			if (changeSpeed < 0)
			{
				return dtCollider.Radius > minRadius;
			}
		}
		return false;
	}

	private void ChangeSize(FP dt)
	{
		if (dtCollider == null)
		{
			return;
		}
		FP fP = changeSpeed * dt;
		if (dtCollider.ColliderShape == DeterministicColliderShape.Rect)
		{
			switch (edgeDiffuseType)
			{
			case EdgeDiffuseType.Default:
				dtCollider.ColliderWidth += fP;
				dtCollider.ColliderLength += fP;
				break;
			case EdgeDiffuseType.OnlyWidth:
				dtCollider.ColliderWidth += fP;
				break;
			case EdgeDiffuseType.OnlyLength:
				dtCollider.ColliderLength += fP;
				break;
			case EdgeDiffuseType.SameRatio:
				dtCollider.ColliderWidth += fP * _boxRatio;
				dtCollider.ColliderLength += fP;
				break;
			}
		}
		else if (dtCollider.ColliderShape == DeterministicColliderShape.Circle)
		{
			dtCollider.Radius += fP;
		}
	}

	private void Move(FP dt)
	{
		TSVector2 tSVector = velocity * dt;
		tsTransform.Position += tSVector;
		tsTransform.Forward = velocityDirection;
		if (!AdventureModuleController.sceneLimitZone.Contains(tsTransform.Position))
		{
			Finish(cancel: true);
		}
		else if (acceleratedVelocity != 0f)
		{
			velocitySpeed += acceleratedVelocity * dt;
			if ((acceleratedVelocity > 0f && velocitySpeed > borderVelocitySpeed) || (acceleratedVelocity < 0f && velocitySpeed < borderVelocitySpeed))
			{
				velocitySpeed = borderVelocitySpeed;
			}
		}
	}
}
