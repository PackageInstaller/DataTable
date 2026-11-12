using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/贝塞尔曲线轨迹子弹")]
public class AdventureBezierBullet : AdventureBulletBase
{
	public FP delayMove = 0f;

	[Space]
	public FP flyTime = 5f;

	[Space]
	public TSVector2 controlPosition = new TSVector2(2, 2);

	[Space]
	public float bezierPathRotate;

	[Space]
	public bool isTraceable;

	[Space]
	public GameObject muzzleFlashPrefab;

	public GameObject hitPrefab;

	public GameObject explosionPrefab;

	public GameObject hittedPrefab;

	public bool effectTimeScale = true;

	public GameObject fxPrefab;

	public GameObject trailPrefab;

	[Space]
	public AdventurePlayerFeedbackEffectConfigureData hitFeedbackEffectConfigureData;

	protected FP _delayTimer;

	protected FP _flyTimer;

	private FP _bezierPathRotateFP;

	private TSVector controlP;

	private TSVector targetP;

	private TSVector originP;

	private Transform targetBody;

	protected TSVector _currentPosition;

	protected TSVector _prePosition;

	private AdventureFXPlayer _fx;

	private Vector3 _currentScale;

	private long _fxToken;

	protected override void OnInit()
	{
		base.OnInit();
		_currentScale = transform.localScale;
		_bezierPathRotateFP = FP.FromConfigFloat(bezierPathRotate);
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		if (smooth != null)
		{
			smooth.dontSyncRotate = true;
		}
		_currentPosition = (_prePosition = default);
		DeterministicCollider deterministicCollider = SceneSingleton<DeterministicCollisionManager>.Instance.CheckPointInterior(ref position, 151808);
		if (deterministicCollider != null && owner != null)
		{
			TSVector2 origin = owner.tsTransform.Position;
			if (deterministicCollider.Raycast(ref origin, ref direction, out var hitInfo, TSVector2.Distance(position, origin)))
			{
				position = hitInfo.point - direction * dtCollider.Radius;
			}
		}
		TrueSyncTransform trueSyncTransform = tsTransform;
		TSVector2 position2 = (originPosition = position);
		trueSyncTransform.Position = position2;
		_delayTimer = delayMove;
		if (aimType == AimType.Target && target != null)
		{
			targetP = target.tsTransform.Position3D;
			targetBody = target.GetComponent<AnimationSlotConfigComponent>()?.bodySlot;
			if (targetBody != null)
			{
				targetP.y = targetBody.position.y;
			}
		}
		else
		{
			targetP = new TSVector(targetPosition.x, targetPositionY, targetPosition.y);
		}
		originP = new TSVector(originPosition.x, positionY, originPosition.y);
		TSVector2 normalized = direction.normalized;
		TSVector tSVector2 = new TSVector(normalized.x, 0, normalized.y);
		TSVector tSVector3 = originP + tSVector2 * controlPosition.x;
		TSVector tSVector4 = new TSVector(originP.x, originP.y + controlPosition.y, originP.z);
		TSVector tSVector5 = tSVector3 - originP + (tSVector4 - originP);
		if (_bezierPathRotateFP != 0)
		{
			controlP = TSQuaternion.AngleAxis(_bezierPathRotateFP, tSVector2.normalized) * tSVector5 + originP;
		}
		else
		{
			controlP = tSVector5 + originP;
		}
		if (fxPrefab != null)
		{
			_fx = AdventureFXPlayer.PlayFX(fxPrefab, 1f, transform.position, transform.rotation);
			_fx.Bind(gameObject);
			_fx.syncNode = transform;
			_fxToken = _fx.token;
		}
		else
		{
			Debug.LogWarning("注意：贝塞尔曲线子弹应配置自身特效！" + gameObject.name);
		}
		if (trailPrefab != null)
		{
			AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(trailPrefab, 1f, transform.position, transform.rotation);
			adventureFXPlayer.Bind(gameObject);
			adventureFXPlayer.syncNode = transform;
		}
		transform.localScale = Vector3.zero;
		if (muzzleFlashPrefab != null)
		{
			AdventureFXPlayer.PlayFX(muzzleFlashPrefab, (float)logicTimeScale, transform.position, transform.rotation);
		}
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		_flyTimer = 0f;
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
			if (_delayTimer > 0f)
			{
				_delayTimer -= logicDeltaTime;
			}
			bool flag = _delayTimer <= 0f;
			FP fP = TSMath.Clamp01(_flyTimer / flyTime);
			if (fP < 1)
			{
				if (!flag)
				{
					return;
				}
				_flyTimer += logicDeltaTime;
				if (_currentPosition != default(TSVector))
				{
					_prePosition = _currentPosition;
				}
				_currentPosition = Move(fP);
				tsTransform.Position = new TSVector2(_currentPosition.x, _currentPosition.z);
				tsTransform.PositionY = _currentPosition.y;
				if (_prePosition != default(TSVector))
				{
					TSVector normalized = (_currentPosition - _prePosition).normalized;
					transform.forward = new Vector3((float)normalized.x, (float)normalized.y, (float)normalized.z);
					if (transform.localScale == Vector3.zero)
					{
						transform.localScale = _currentScale;
					}
				}
				if (!AdventureModuleController.sceneLimitZone.Contains(tsTransform.Position))
				{
					Finish(cancel: true);
				}
			}
			else
			{
				FP damageImmuneDuration = 0;
				if (useDamageImmuneDurationForMonsterWeapon)
				{
					damageImmuneDuration = damageImmuneDurationForMonsterWeapon;
				}
				_hitBox.CircleAreaHit(GetDamageArea(), 0f, tsTransform.Position, out var hittedCount, out var _, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, -5, damageImmuneDuration, randomHit: false, !effectTimeScale);
				if (explosionPrefab != null)
				{
					AdventureFXPlayer.PlayFX(explosionPrefab, (float)logicTimeScale, transform.position, transform.rotation, transform.localScale.x);
				}
				if (hittedCount > 0 && hitPrefab != null)
				{
					AdventureFXPlayer.PlayFX(hitPrefab, (float)logicTimeScale, transform.position, transform.rotation, transform.localScale.x);
				}
				if (hitFeedbackEffectConfigureData != null)
				{
					hitFeedbackEffectConfigureData.Play(transform.position, gameObject, GetCameraShakeSort());
				}
				Finish();
			}
		}
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

	protected TSVector Move(FP dt)
	{
		if (isTraceable && target != null)
		{
			targetP = target.tsTransform.Position3D;
			if (targetBody != null)
			{
				targetP.y = targetBody.position.y;
			}
		}
		return CommonHelper.GetBezierPointByT(originP, controlP, targetP, dt);
	}
}
