using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/地刺")]
[DisallowMultipleComponent]
public class SpikeweedEneity : LogicEntity, IHitBoxContext, ISpecialEntity
{
	public int hitDamageId;

	public FP hitRadius = 1f;

	public FP hitInterval = 1f;

	public GameObject hitFx;

	public HitBox.FeatureFlag hitFlags;

	public HitBox.HitBoxFeatureData hitFeatureData;

	public HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small;

	public GameObject hittedEffectPrefab;

	public bool isHittedEffectScale = true;

	public bool effectIgnoreTimeScale = true;

	public FP damageImmuneDuration;

	public bool haveFeedbackEffect;

	public AdventurePlayerFeedbackEffectConfigureData playerfeedbackEffectConfigureData;

	public FP duration = 10f;

	public GameObject fx;

	public FP moveSpeed = 1f;

	public FP maxRotateSpeed = 60f;

	public bool canRebouned = true;

	protected AdventureActor _owner;

	protected HitBox _hitBox;

	protected AdventureFXPlayer _fxPlayer;

	protected FP _duration;

	protected FP _hitInterval;

	protected TSVector2 _velocityDirection;

	protected Dictionary<long, FP> _hitedEntities = new Dictionary<long, FP>(5);

	protected TSVector2 Velocity => _velocityDirection * moveSpeed;

	public AdventureActor Owner => _owner;

	protected override void OnInit()
	{
		base.OnInit();
		if (_hitBox == null)
		{
			_hitBox = HitBox.Setup(gameObject, this, this);
			_hitBox.hitDamageId = hitDamageId;
			_hitBox.featureFlags = hitFlags;
			_hitBox.featureData = hitFeatureData;
			_hitBox.hurtAnimType = hurtAnimType;
		}
	}

	public void Setup(AdventureActor owner)
	{
		_owner = owner;
		_hitInterval = hitInterval;
		_duration = duration;
		if (fx != null)
		{
			_fxPlayer = AdventureFXPlayer.PlayFX(fx, (float)logicTimeScale, transform.position, Quaternion.identity);
		}
		EnableLogicUpdate();
	}

	protected override void OnLogicUpdate()
	{
		if (hitInterval > 0)
		{
			_hitInterval -= LogicDeltaTime;
			if (_hitInterval <= 0)
			{
				Hit();
				_hitInterval = hitInterval;
			}
		}
		TracePlayer();
		TSVector2 origin = tsTransform.Position;
		TSVector2 direction = _velocityDirection;
		if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out var _, hitRadius, 4096))
		{
			if (!canRebouned)
			{
				Finish();
				return;
			}
			_velocityDirection = -_velocityDirection;
		}
		_duration -= LogicDeltaTime;
		if (_duration <= 0)
		{
			Finish();
		}
	}

	protected void TracePlayer()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (!(activedPlayerActor == null))
		{
			TSVector2 to = TSVector2.Normalize(activedPlayerActor.tsTransform.Position - tsTransform.Position);
			_velocityDirection = TrueSyncExtensions.RotateTowards(_velocityDirection, to, maxRotateSpeed * LogicDeltaTime);
			tsTransform.Position += Velocity * LogicDeltaTime;
			tsTransform.Forward = _velocityDirection;
			if (_fxPlayer != null)
			{
				_fxPlayer.transform.position = transform.position;
				_fxPlayer.transform.rotation = transform.rotation;
			}
		}
	}

	protected void Hit()
	{
		if (_owner == null)
		{
			return;
		}
		int uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
		if (hitFx != null)
		{
			AdventureFXPlayer.PlayFX(hitFx, (float)logicTimeScale, transform.position, Quaternion.identity);
		}
		_hitBox.CircleAreaHit(hitRadius, 0, tsTransform.Position, out var _, out var damageCount, uniqueAttackId, hittedEffectPrefab, isHittedEffectScale: true, -5, damageImmuneDuration, randomHit: false, effectIgnoreTimeScale);
		if (haveFeedbackEffect && damageCount > 0)
		{
			PlayerAdventureActor playerAdventureActor = _owner as PlayerAdventureActor;
			if (playerAdventureActor != null)
			{
				TSVector2 tSVector = tsTransform.TransformLocalPointToWorldSpace(default);
				float y = (float)playerAdventureActor.tsTransform.PositionY;
				Vector3 effectPosition = new Vector3((float)tSVector.x, y, (float)tSVector.y);
				playerfeedbackEffectConfigureData.Play(effectPosition, playerAdventureActor.gameObject);
			}
		}
	}

	public void Finish()
	{
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		DisableLogicUpdate();
		_hitedEntities.Clear();
		_fxPlayer?.Stop();
		_fxPlayer = null;
		_owner = null;
		_hitInterval = 0;
		_duration = 0;
	}

	public FP QueryHitBoxContextTime()
	{
		return LogicTime;
	}

	public TSVector2 QueryHitBoxContextPosition()
	{
		return tsTransform.Position;
	}

	public TSVector2 QueryHitBoxContextDirection()
	{
		return tsTransform.Forward;
	}

	public bool QueryActorHitedTimeout(long entityId, FP timeout)
	{
		if (_hitedEntities.TryGetValue(entityId, out var value) && LogicTime <= value + timeout)
		{
			return false;
		}
		return true;
	}

	public void SetActorHitedTime(long entityId, FP time)
	{
		_hitedEntities.set_Item(entityId, time);
	}

	public bool CheckHitable(HitBox hitBox, LogicEntity entity)
	{
		if (!(_owner == null) && (hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !_owner.IsConfrontWith(entity))
		{
			return _owner.IsNeutralWith(entity);
		}
		return true;
	}

	public bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!entity.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		(damaged, _, _) = (entity as AdventureActor).Damage(_owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}

	public bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		return true;
	}
}
