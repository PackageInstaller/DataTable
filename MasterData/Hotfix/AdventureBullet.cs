using System;
using System.Collections.Generic;
using Drawing;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/实体子弹")]
public class AdventureBullet : AdventureBulletBase
{
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
	public bool isRangeHit;

	[Space]
	public HitBox.Shape shape = HitBox.Shape.Circle;

	[Space]
	public bool randomHit;

	[Space]
	public FP damageRadius;

	[Space]
	public FP damageHeight;

	[Space]
	public FP damageWidth;

	[Space]
	public FP fanInnerRadius;

	[Space]
	public FP fanOuterRadius;

	[Space]
	public FP fanAngle;

	public bool isAreaHit;

	public FP areaHitRadius = 0f;

	[Space]
	public bool _isShowShadowBlob;

	protected FP _delayTimer;

	protected FP _lifeTimer;

	protected FP _keepMoveToHitPointTime;

	protected bool _waitMoveToHitPoint;

	private bool _haveReflectFeature;

	private bool _haveHitAreaEffectFeature;

	private AdventureFXPlayer _fx;

	private long _fxToken;

	private const int hitableLayerMaskForActor = 256;

	private const int hitableLayerMaskForActorAndAreaEffect = 131328;

	private const int hitableLayerMaskWithoutAreaEffect = 20736;

	private const int hitableLayerMaskAll = 151808;

	protected int hitableLayerMask;

	protected readonly List<DeterministicRaycastHit> _hitInfos = new List<DeterministicRaycastHit>();

	public FP LiftTime { get; set; }

	public override bool iShowShadowBlob()
	{
		return _isShowShadowBlob;
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		TrueSyncTransform trueSyncTransform = tsTransform;
		TSVector2 position2 = (originPosition = position);
		trueSyncTransform.Position = position2;
		_delayTimer = delayMove;
		if (fxPrefab != null)
		{
			_fx = AdventureFXPlayer.PlayFX(fxPrefab, 1f, transform.position, transform.rotation);
			_fx.Bind(gameObject);
			_fx.ownerActor = owner as AdventureActor;
			_fx.syncNode = transform;
			_fxToken = _fx.token;
		}
		else
		{
			Debug.LogWarning("注意：实体子弹应配置自身特效！" + gameObject.name);
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
		for (int i = 0; i < features.Count; i++)
		{
			if (features.get_Item(i) is WeaponFeatureReflectWhenHitObstacle || features.get_Item(i) is WeaponFeatureReflectWhenHitObstacleOrStop)
			{
				_haveReflectFeature = true;
				break;
			}
		}
		_haveHitAreaEffectFeature = (hitBox.featureFlags & HitBox.FeatureFlag.ChangeArea) == HitBox.FeatureFlag.ChangeArea;
		hitableLayerMask = 151808;
		if (_haveReflectFeature)
		{
			hitableLayerMask = (_haveHitAreaEffectFeature ? 131328 : 256);
		}
		else
		{
			hitableLayerMask = (_haveHitAreaEffectFeature ? 151808 : 20736);
		}
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		velocitySpeed = moveSpeed;
		LiftTime = lifeTime;
		_lifeTimer = 0f;
		_keepMoveToHitPointTime = 0;
		_waitMoveToHitPoint = false;
	}

	public void SetDelayMove(FP delayTime)
	{
		_delayTimer = delayTime;
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
			if (_waitMoveToHitPoint)
			{
				Finish();
				return;
			}
			bool flag = true;
			FP logicDeltaTime = LogicDeltaTime;
			_lifeTimer += logicDeltaTime;
			if (_delayTimer > 0f)
			{
				_delayTimer -= logicDeltaTime;
			}
			bool flag2 = _delayTimer <= 0f;
			if (LiftTime > 0f && _lifeTimer >= LiftTime)
			{
				flag = false;
			}
			else
			{
				if (useDamageImmuneDurationForMonsterWeapon)
				{
					damageImmuneDuration = damageImmuneDurationForMonsterWeapon;
				}
				if (_hitBox.hitDamageId == 0)
				{
					_hitBox.hitDamageId = hitDamageId;
				}
				if (isRangeHit)
				{
					switch (shape)
					{
					case HitBox.Shape.Circle:
					{
						flag = _hitBox.CircleAreaHit(GetDamageRaiuds(), 0f, tsTransform.Position, out var _, out var _, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, hitableLayerMask, damageImmuneDuration, randomHit, !effectTimeScale);
						if (flag && _haveReflectFeature)
						{
							TSVector2 origin = tsTransform.Position;
							TSVector2 direction = velocityDirection;
							if (SceneSingleton<DeterministicCollisionManager>.Instance.SphereCastHit(ref origin, ref direction, out var hitInfo, flag2 ? (velocitySpeed * logicDeltaTime) : ((FP)0f), dtCollider.Radius, 20480))
							{
								_hitBox.hitDamageId = 0;
								_hitBox.HitSingleTarget(uniqueAttackId, hitInfo.collider, out var _, out var _, ref hitInfo, hittedPrefab, isHittedEffectScale: true, damageImmuneDuration, 1, !effectTimeScale);
							}
						}
						break;
					}
					case HitBox.Shape.Rectangle:
					{
						flag = _hitBox.RectangleAreaHit(GetDamageWidth(), GetDamageHeight(), tsTransform.Position, tsTransform.Rotation, out var _, out var _, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, hitableLayerMask, damageImmuneDuration, randomHit, null, !effectTimeScale);
						break;
					}
					case HitBox.Shape.Fan:
					{
						flag = _hitBox.FanAreaHit(fanAngle, GetDamageFanOuterRadius(), GetDamageFanInnerRadius(), tsTransform.Position, tsTransform.Rotation, out var _, out var _, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, damageImmuneDuration, !effectTimeScale);
						break;
					}
					default:
						throw new ArgumentOutOfRangeException();
					}
				}
				else
				{
					TSVector2 origin2 = tsTransform.Position;
					TSVector2 direction2 = velocityDirection;
					bool flag3 = false;
					if (SceneSingleton<AdventureModuleDebugHelper>.Instance.BulletGizmo | flag3)
					{
						CommandBuilder ingame = Draw.ingame;
						Transform transform = base.transform;
						float num = (float)dtCollider.Radius;
						Vector3 normalized = new Vector3((float)direction2.x, 0f, (float)direction2.y).normalized;
						float num2 = (float)(velocitySpeed * logicDeltaTime);
						Vector3 vector = new Vector3((float)origin2.x, transform.position.y, (float)origin2.y);
						Vector3 vector2 = vector + num2 * 0.5f * normalized;
						Quaternion quaternion2 = Quaternion.LookRotation(normalized, Vector3.up);
						Vector2 vector3 = new Vector2(num * 2f, num2 + num * 2f);
						using (ingame.WithColor(Color.red))
						{
							using (ingame.WithDuration(0.1f))
							{
								ingame.WireRectangle(vector2, quaternion2, vector3);
								ingame.Circle(vector, Vector3.up, num);
								ingame.ArrowheadArc(vector, normalized, num + 0.1f);
							}
						}
					}
					SceneSingleton<DeterministicCollisionManager>.Instance.SphereCastAll(ref origin2, ref direction2, _hitInfos, flag2 ? (velocitySpeed * logicDeltaTime) : ((FP)0f), dtCollider.Radius, hitableLayerMask);
					bool hitted2;
					if (_hitInfos.Count > 0)
					{
						DeterministicRaycastHit raycastHit = _hitInfos.get_Item(0);
						if (isAreaHit && areaHitRadius > 0)
						{
							if (!(raycastHit.collider.Entity is AdventureActor) || (raycastHit.collider.Entity is AdventureActor actor && CheckHitable(_hitBox, actor)))
							{
								flag = _hitBox.CircleAreaHit(areaHitRadius, 0f, raycastHit.point, out var _, out var damageCount4, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, hitableLayerMask, damageImmuneDuration, randomHit: false, !effectTimeScale);
								if (damageCount4 > 0)
								{
									ShowHitEffect(raycastHit);
								}
							}
						}
						else
						{
							foreach (DeterministicRaycastHit hitInfo3 in _hitInfos)
							{
								raycastHit = hitInfo3;
								flag = _hitBox.HitSingleTarget(uniqueAttackId, hitInfo3.collider, out hitted2, out var damaged2, ref raycastHit, hittedPrefab, isHittedEffectScale: true, damageImmuneDuration, 1, !effectTimeScale);
								if (damaged2)
								{
									ShowHitEffect(raycastHit);
								}
								if (!flag || (_haveReflectFeature && hitInfo3.collider.Entity as AdventureObstacle != null))
								{
									break;
								}
							}
							if (!flag && raycastHit.collider.layer == 8)
							{
								FP fP = TSVector2.Distance(tsTransform.Position, raycastHit.point);
								FP fP2 = velocitySpeed * logicDeltaTime;
								_keepMoveToHitPointTime = fP / fP2 * logicDeltaTime;
							}
						}
					}
					if (flag && _haveReflectFeature)
					{
						TSVector2 origin3 = tsTransform.Position;
						TSVector2 direction3 = velocityDirection;
						if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin3, ref direction3, out var hitInfo2, flag2 ? (velocitySpeed * logicDeltaTime + GetDamageRaiuds()) : GetDamageRaiuds(), 20480))
						{
							_hitBox.hitDamageId = 0;
							_hitBox.HitSingleTarget(uniqueAttackId, hitInfo2.collider, out hitted2, out var _, ref hitInfo2, hittedPrefab, isHittedEffectScale: true, damageImmuneDuration, 1, !effectTimeScale);
						}
					}
				}
			}
			if (flag)
			{
				if (flag2)
				{
					Move(logicDeltaTime);
				}
			}
			else if (_keepMoveToHitPointTime <= 0)
			{
				Finish();
			}
			else
			{
				Move(_keepMoveToHitPointTime);
				_waitMoveToHitPoint = true;
			}
		}
		void ShowHitEffect(DeterministicRaycastHit deterministicRaycastHit)
		{
			Vector3 vector4 = new Vector3((float)deterministicRaycastHit.point.x, base.transform.position.y, (float)deterministicRaycastHit.point.y);
			Vector3 forward = new Vector3((float)deterministicRaycastHit.normal.x, (-base.transform.forward).y, (float)deterministicRaycastHit.normal.y);
			forward.Normalize();
			Quaternion spawnRotation = Quaternion.LookRotation(forward, Vector3.up);
			if (hitPrefab != null)
			{
				AdventureFXPlayer.PlayFX(hitPrefab, (float)logicTimeScale, vector4, spawnRotation, base.transform.localScale.x).ownerActor = owner as AdventureActor;
			}
			if (hitFeedbackEffectConfigureData != null)
			{
				hitFeedbackEffectConfigureData.Play(vector4, gameObject, GetCameraShakeSort());
			}
		}
	}

	private FP GetDamageRaiuds()
	{
		if (!isRangeHit || shape != HitBox.Shape.Circle)
		{
			return 0;
		}
		return ((damageRadius > 0) ? damageRadius : dtCollider.Radius) * transform.localScale.x;
	}

	private FP GetDamageHeight()
	{
		if (!isRangeHit || shape != HitBox.Shape.Rectangle)
		{
			return 0;
		}
		return ((damageHeight > 0) ? damageHeight : dtCollider.ColliderLength) * transform.localScale.z;
	}

	private FP GetDamageWidth()
	{
		if (!isRangeHit || shape != HitBox.Shape.Rectangle)
		{
			return 0;
		}
		return ((damageWidth > 0) ? damageWidth : dtCollider.ColliderWidth) * transform.localScale.x;
	}

	private FP GetDamageFanInnerRadius()
	{
		if (!isRangeHit || shape != HitBox.Shape.Fan)
		{
			return 0;
		}
		return ((fanInnerRadius > 0) ? fanInnerRadius : ((FP)0)) * transform.localScale.x;
	}

	private FP GetDamageFanOuterRadius()
	{
		if (!isRangeHit || shape != HitBox.Shape.Fan)
		{
			return 0;
		}
		return ((fanOuterRadius > 0) ? fanOuterRadius : dtCollider.Radius) * transform.localScale.x;
	}

	public virtual void Move(FP dt)
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

	public FP GetLeftTime()
	{
		return LiftTime - _lifeTimer;
	}

	private void OnIsRangeHitValueChange()
	{
		if (isRangeHit && isAreaHit)
		{
			isAreaHit = false;
		}
	}
}
