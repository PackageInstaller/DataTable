using System.Collections;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/折线子弹")]
public class AdventureBrokenLineBullet : AdventureBulletBase
{
	public FP delayMove = 0f;

	public FP moveSpeed = 5f;

	public FP acceleratedVelocity = 0f;

	public FP minVelocitySpeed = 0;

	public FP maxVelocitySpeed = 50f;

	[Space]
	public FP forwardLifeTime = 2f;

	[Space]
	public FP backwardLifeTime = 3f;

	[Space]
	public FP stopDuration = 2f;

	[Space]
	public FP delayDestroyTime = 0;

	[Space]
	public FP backwardRangeRadius = 5f;

	[Space]
	public FP backwardRangeCenterOffset = 1f;

	public GameObject fxPrefab;

	[Space]
	public GameObject muzzleFlashPrefab;

	public GameObject hitPrefab;

	public GameObject hittedPrefab;

	public bool effectTimeScale = true;

	public GameObject trailPrefab;

	[Space]
	public AdventurePlayerFeedbackEffectConfigureData hitFeedbackEffectConfigureData;

	[Space]
	public FP hitTestInterval = 0f;

	[Space]
	public bool isRangeHit;

	[Space]
	public HitBox.Shape shape = HitBox.Shape.Circle;

	[Space]
	public FP damageRadius;

	protected FP _delayTimer;

	protected FP _lifeTimer;

	protected FP _currentPhaseLifeTime;

	private bool _forwardPhase;

	private FP _stopDuration;

	private AdventureFXPlayer _fx;

	private long _fxToken;

	private FP _acceleratedVelocity;

	private bool _catched;

	private bool _delayFinish;

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		DeterministicCollider deterministicCollider = SceneSingleton<DeterministicCollisionManager>.Instance.CheckPointInterior(ref position, 151808);
		if (deterministicCollider != null)
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
		_currentPhaseLifeTime = forwardLifeTime;
		_forwardPhase = true;
		_stopDuration = 0;
		_catched = false;
		_delayFinish = false;
		if (fxPrefab != null)
		{
			_fx = AdventureFXPlayer.PlayFX(fxPrefab, 1f, transform.position, transform.rotation);
			_fx.Bind(gameObject);
			_fx.syncNode = transform;
			_fxToken = _fx.token;
		}
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
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CHECK_BROKENLINE_BULLET_SUCCESS", OnActorCheckSuccess);
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		if (!_forwardPhase)
		{
			velocitySpeed = moveSpeed;
			_acceleratedVelocity = acceleratedVelocity;
		}
		else if (acceleratedVelocity != 0)
		{
			velocitySpeed = 0;
			_acceleratedVelocity = -acceleratedVelocity;
		}
		else
		{
			velocitySpeed = moveSpeed;
		}
		_lifeTimer = 0f;
		_currentPhaseLifeTime = backwardLifeTime;
		_forwardPhase = false;
	}

	private bool InStoppingPhase()
	{
		if (_stopDuration <= 0)
		{
			return false;
		}
		_stopDuration -= LogicDeltaTime;
		if (_stopDuration <= 0)
		{
			AdventureActorStartCheckBrokenBulletEvent adventureActorStartCheckBrokenBulletEvent = AdventureActorStartCheckBrokenBulletEvent.Generate();
			adventureActorStartCheckBrokenBulletEvent.entity = owner;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorStartCheckBrokenBulletEvent);
			TSVector2 tSVector = owner.tsTransform.Position;
			if (owner is PlayerAdventureActor)
			{
				if (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
				{
					tSVector += SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() * backwardRangeCenterOffset;
				}
				tSVector = TrueSyncExtensions.RandomPointInsideRing(tSVector, 0, backwardRangeRadius);
			}
			TSVector2 normalized = (tSVector - tsTransform.Position).normalized;
			Reset(owner, tsTransform.Position, tsTransform.PositionY, normalized, target, targetPosition);
		}
		return _stopDuration > 0;
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
			if (!DelayShootUpdate() || _delayFinish)
			{
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
			if (_currentPhaseLifeTime > 0f && _lifeTimer >= _currentPhaseLifeTime)
			{
				flag = false;
			}
			else
			{
				if (useDamageImmuneDurationForMonsterWeapon)
				{
					hitTestInterval = damageImmuneDurationForMonsterWeapon;
				}
				if (isRangeHit)
				{
					if (damageRadius <= 0f)
					{
						damageRadius = dtCollider.Radius;
					}
					flag = _hitBox.CircleAreaHit(damageRadius, 0f, tsTransform.Position, out var _, out var _, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, 151808, hitTestInterval, randomHit: false, !effectTimeScale);
				}
				else
				{
					TSVector2 origin = tsTransform.Position;
					TSVector2 direction = velocityDirection;
					if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out var hitInfo, flag2 ? (velocitySpeed * logicDeltaTime + dtCollider.Radius) : dtCollider.Radius, 151808))
					{
						flag = _hitBox.HitSingleTarget(uniqueAttackId, hitInfo.collider, out var _, out var damaged, ref hitInfo, hittedPrefab, isHittedEffectScale: true, hitTestInterval, 1, !effectTimeScale);
						if (damaged)
						{
							Vector3 vector = new Vector3((float)hitInfo.point.x, transform.position.y, (float)hitInfo.point.y);
							Vector3 forward = new Vector3((float)hitInfo.normal.x, (-transform.forward).y, (float)hitInfo.normal.y);
							forward.Normalize();
							Quaternion spawnRotation = Quaternion.LookRotation(forward, Vector3.up);
							if (hitPrefab != null)
							{
								AdventureFXPlayer.PlayFX(hitPrefab, (float)logicTimeScale, vector, spawnRotation);
							}
							if (hitFeedbackEffectConfigureData != null)
							{
								hitFeedbackEffectConfigureData.Play(vector, gameObject, GetCameraShakeSort());
							}
						}
					}
				}
			}
			if (InStoppingPhase())
			{
				return;
			}
			if (flag)
			{
				if (flag2)
				{
					TSVector2 tSVector = velocity * logicDeltaTime;
					tsTransform.Position += tSVector;
					tsTransform.Forward = velocityDirection;
					if (!AdventureModuleController.sceneLimitZone.Contains(tsTransform.Position))
					{
						Finished(cancel: true);
					}
					else if (_acceleratedVelocity != 0f)
					{
						velocitySpeed += _acceleratedVelocity * logicDeltaTime;
						velocitySpeed = TSMath.Clamp(velocitySpeed, minVelocitySpeed, maxVelocitySpeed);
					}
				}
			}
			else if (_forwardPhase)
			{
				_currentPhaseLifeTime = 0;
				_stopDuration = ((stopDuration > 0) ? stopDuration : ((FP)0.01));
			}
			else
			{
				Finished();
			}
		}
	}

	protected void OnActorCheckSuccess(IEvent e)
	{
		if (!_forwardPhase && e is AdventureActorCheckBrokenBulletSuccessEvent adventureActorCheckBrokenBulletSuccessEvent && adventureActorCheckBrokenBulletSuccessEvent.entity == owner && adventureActorCheckBrokenBulletSuccessEvent.bullet == this)
		{
			_catched = true;
			if (delayDestroyTime > 0)
			{
				StartLogicCoroutine(WaitForFinish());
			}
			else
			{
				Finished();
			}
		}
	}

	private IEnumerator WaitForFinish()
	{
		_delayFinish = true;
		RemoveCheckEventListener();
		yield return delayDestroyTime;
		Finished(cancel: false, removeCheckEventListener: false);
	}

	protected void Finished(bool cancel = false, bool removeCheckEventListener = true)
	{
		if (_fx != null && _fxToken == _fx.token)
		{
			_fx.Stop();
			_fx = null;
		}
		if (removeCheckEventListener)
		{
			RemoveCheckEventListener();
		}
		Finish(cancel, _catched);
	}

	private void RemoveCheckEventListener()
	{
		AdventureActorCancelCheckBrokenBulletEvent adventureActorCancelCheckBrokenBulletEvent = AdventureActorCancelCheckBrokenBulletEvent.Generate();
		adventureActorCancelCheckBrokenBulletEvent.entity = owner;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCancelCheckBrokenBulletEvent);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CHECK_BROKENLINE_BULLET_SUCCESS", OnActorCheckSuccess);
	}
}
