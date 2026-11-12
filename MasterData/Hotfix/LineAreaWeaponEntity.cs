#define LOG_ERROR
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/连线区域武器")]
[DisallowMultipleComponent]
public class LineAreaWeaponEntity : LogicEntity, ISpecialEntity, IHitBoxContext
{
	public FP duration = 1;

	public GameObject linkFX;

	public bool finishAfterOwnerDead;

	public FP areaWidth = 1;

	public FP hitInterval = 1;

	public bool hitImmediately;

	public int hitDamageId;

	public HitBox.FeatureFlag hitFlags;

	public HitBox.HitBoxFeatureData hitFeatureData;

	public HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small;

	public GameObject hittedEffectPrefab;

	public bool isHittedEffectScale = true;

	public bool effectIgnoreTimeScale = true;

	public FP damageImmuneDuration;

	private AdventureActor _owner;

	private HitBox _hitBox;

	private AdventureFXPlayer _fxPlayer;

	private FP _duration;

	private long _sourceEntityId;

	private long _targetEntityId;

	private FP _hitInterval;

	private FP _length;

	private FP _width;

	private readonly Dictionary<long, FP> _hittedEntities = new Dictionary<long, FP>(10);

	public TSVector2 SourcePosition { get; private set; }

	public FP SourcePositionY { get; private set; }

	public bool IsFixedEntitySource { get; private set; }

	public LogicEntity SourceEntity { get; private set; }

	public TSVector2 SourceOffset { get; private set; }

	public TSVector2 TargetPosition { get; private set; }

	public FP TargetPositionY { get; private set; }

	public bool IsFixedEntityTarget { get; private set; }

	public LogicEntity TargetEntity { get; private set; }

	public TSVector2 TargetOffset { get; private set; }

	public AdventureActor Owner => _owner;

	public bool InLinkState { get; private set; }

	private bool NeedUpdateArea
	{
		get
		{
			if (!IsFixedEntitySource)
			{
				return IsFixedEntityTarget;
			}
			return true;
		}
	}

	public void Setup(AdventureActor owner)
	{
		InLinkState = false;
		_owner = owner;
		_duration = duration;
		_hitInterval = hitInterval;
		_width = areaWidth;
	}

	public void Link(TSVector2 sourcePosition, FP sourcePositionY, bool isFixedEntitySource, LogicEntity sourceEntity, TSVector2 sourceOffset, TSVector2 targetPosition, FP targetPositionY, bool isFixedEntityTarget, LogicEntity targetEntity, TSVector2 targetOffset)
	{
		if (duration <= 0)
		{
			NovaLogger.Error("连线区域武器持续时间配置错误:" + name);
			Finish();
		}
		if (InLinkState)
		{
			return;
		}
		InLinkState = true;
		SourcePosition = sourcePosition;
		SourcePositionY = sourcePositionY;
		IsFixedEntitySource = isFixedEntitySource;
		SourceEntity = sourceEntity;
		SourceOffset = sourceOffset;
		_sourceEntityId = ((sourceEntity != null) ? sourceEntity.Id : 0);
		TargetPosition = targetPosition;
		TargetPositionY = targetPositionY;
		IsFixedEntityTarget = isFixedEntityTarget;
		TargetEntity = targetEntity;
		TargetOffset = targetOffset;
		_targetEntityId = ((targetEntity != null) ? targetEntity.Id : 0);
		if (CheckInterrupt())
		{
			NovaLogger.Error("连线区域武器开始连接实体目标时起点或终点实体为空或已失效:" + name);
			Finish();
			return;
		}
		UpdateArea();
		if (linkFX != null)
		{
			ref AdventureFXPlayer fxPlayer = ref _fxPlayer;
			GameObject callerEntity = ((sourceEntity != null) ? sourceEntity.gameObject : null);
			GameObject fxPrefab = linkFX;
			Quaternion identity = Quaternion.identity;
			Transform transform;
			if (IsFixedEntitySource)
			{
				transform = ((sourceEntity != null) ? sourceEntity.transform : null);
			}
			else
			{
				transform = null;
			}
			Transform source = transform;
			Vector3 sourcePosition2 = new Vector3(sourcePosition.x.AsFloat(), sourcePositionY.AsFloat(), sourcePosition.y.AsFloat());
			Transform target;
			if (IsFixedEntitySource)
			{
				target = ((targetEntity != null) ? targetEntity.transform : null);
			}
			else
			{
				target = null;
			}
			fxPlayer = AdventureFXPlayer.PlayFX(callerEntity, useActorSizeScale: true, useTransformSync: true, fxPrefab, 1f, default, identity, 1f, source, sourcePosition2, target, new Vector3(targetPosition.x.AsFloat(), targetPositionY.AsFloat(), targetPosition.y.AsFloat()));
		}
		if (hitImmediately)
		{
			Hit();
		}
	}

	public bool CheckInterrupt()
	{
		if (IsFixedEntitySource && !CheckTargetValid(SourceEntity, _sourceEntityId))
		{
			return true;
		}
		if (IsFixedEntityTarget && !CheckTargetValid(TargetEntity, _targetEntityId))
		{
			return true;
		}
		return false;
	}

	private bool CheckTargetValid(LogicEntity entity, long entityId)
	{
		if (entity == null || entity.Id != entityId)
		{
			return false;
		}
		if (entity is AdventureActor adventureActor)
		{
			bool flag = false;
			if (_owner.IsConfrontWith(adventureActor) && adventureActor.IsSearchedImmunity())
			{
				flag = true;
			}
			ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
			if ((actorHealthInfo != null && !actorHealthInfo.isAlive) | flag)
			{
				return false;
			}
		}
		return true;
	}

	public void UpdateArea()
	{
		if (IsFixedEntitySource && SourceEntity != null)
		{
			SourcePosition = SourceEntity.tsTransform.Position + SourceEntity.tsTransform.Left * SourceOffset.x + SourceEntity.tsTransform.Forward * SourceOffset.y;
		}
		if (IsFixedEntityTarget && TargetEntity != null)
		{
			TargetPosition = TargetEntity.tsTransform.Position + TargetEntity.tsTransform.Left * TargetOffset.x + TargetEntity.tsTransform.Forward * TargetOffset.y;
		}
		TSVector2 tSVector = TargetPosition - SourcePosition;
		tsTransform.Forward = tSVector.normalized;
		tsTransform.Position = SourcePosition + tSVector * 0.5;
		_length = TSVector2.Distance(SourcePosition, TargetPosition);
	}

	public void Hit()
	{
		_hitBox.hitDamageId = hitDamageId;
		_hitBox.featureFlags = hitFlags;
		_hitBox.featureData = hitFeatureData;
		_hitBox.hurtAnimType = hurtAnimType;
		_hitBox.RectangleAreaHit(_width, _length, tsTransform.Position, tsTransform.Rotation, out var _, out var _, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), hittedEffectPrefab, isHittedEffectScale, -5, damageImmuneDuration, randomHit: false, null, effectIgnoreTimeScale);
	}

	public void Finish()
	{
		InLinkState = false;
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}

	protected override void OnInit()
	{
		base.OnInit();
		if (_hitBox == null)
		{
			_hitBox = HitBox.Setup(gameObject, this, this);
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
		EnableLogicUpdate();
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (_owner != null && finishAfterOwnerDead && !_owner.actorHealthInfo.isAlive)
		{
			Finish();
		}
		if (!InLinkState)
		{
			return;
		}
		if (CheckInterrupt())
		{
			Finish();
			return;
		}
		if (NeedUpdateArea)
		{
			UpdateArea();
		}
		if (hitInterval > 0)
		{
			_hitInterval -= LogicDeltaTime;
			if (_hitInterval <= 0)
			{
				_hitInterval = hitInterval;
				Hit();
			}
		}
		_duration -= LogicDeltaTime;
		if (_duration <= 0)
		{
			Finish();
		}
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		DisableLogicUpdate();
		InLinkState = false;
		_fxPlayer?.Stop();
		_fxPlayer = null;
		_hittedEntities.Clear();
		IsFixedEntitySource = false;
		SourceEntity = null;
		_sourceEntityId = 0L;
		IsFixedEntityTarget = false;
		TargetEntity = null;
		_targetEntityId = 0L;
		_owner = null;
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

	public bool QueryActorHitedTimeout(long actorId, FP timeout)
	{
		if (!_hittedEntities.TryGetValue(actorId, out var value))
		{
			return true;
		}
		return LogicTime > value + timeout;
	}

	public void SetActorHitedTime(long actorId, FP time)
	{
		_hittedEntities.set_Item(actorId, time);
	}

	public bool CheckHitable(HitBox hitBox, LogicEntity entity)
	{
		if (!(Owner == null) && (hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !Owner.IsConfrontWith(entity))
		{
			return Owner.IsNeutralWith(entity);
		}
		return true;
	}

	public bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (entity is AdventureActor adventureActor)
		{
			if (!adventureActor.actorHealthInfo.isAlive)
			{
				return true;
			}
			(damaged, _, _) = adventureActor.Damage(_owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		}
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

	public bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (entity is AdventureActor adventureActor)
		{
			if (!adventureActor.CurrentStepCanbeHurt())
			{
				return true;
			}
			(damaged, _, _) = adventureActor.Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		}
		return true;
	}
}
