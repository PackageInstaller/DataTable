using System;
using System.Collections.Generic;
using System.Linq;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/激光射线实体(旋转，射线)")]
[DisallowMultipleComponent]
public class LaserEntity : LogicEntity, ISpecialEntity, IHitBoxContext
{
	private class DeterministicColliderCompare : IEqualityComparer<DeterministicCollider>
	{
		public bool Equals(DeterministicCollider A, DeterministicCollider B)
		{
			if (A.Entity == null || B.Entity == null)
			{
				return false;
			}
			return A.Entity.Id == B.Entity.Id;
		}

		public int GetHashCode(DeterministicCollider collider)
		{
			return collider.GetHashCode();
		}
	}

	public LaserType laserType = LaserType.Owner;

	public FP leftTime;

	public string linkEffect;

	public GameObject hitPrefab;

	public GameObject hittedPrefab;

	public AdventurePlayerFeedbackEffectConfigureData hitFeedbackEffectConfigureData;

	public int hitDamageId;

	public FP hitInterval;

	public HitBox.HitDamageIdData[] _hitdamagedatas;

	public HitBox.FeatureFlag hitFlags;

	public HitBox.HitBoxFeatureData hitFeatureData;

	public HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small;

	public FP damageImmuneDuration;

	public FP maxLen;

	public FP width;

	public FP extraWidth;

	public FP threshold = 0.2;

	public FP LenOffset = 0.2;

	public GameObject targetObj;

	public AnimationSlotConfigComponent.SlotType srcSlot;

	[HideInInspector]
	public FP LeftTime;

	private FP additionLeftTime;

	private FP curLeftTime;

	protected long _ownerId;

	private AdventureActor _owner;

	private LogicEntity _atkTarget;

	private VisualSmooth _smooth;

	private FP curLen;

	private FP lastLen;

	private AdventureActor lastTarget;

	private PlayFX linkFx = new PlayFX();

	public Action<LogicEntity> OnCollisionEnter;

	public Action<LogicEntity> OnCollisionExit;

	public Action<LogicEntity> OnOtherCollisionEnter;

	public Action<LogicEntity> OnOtherCollisionExit;

	public Action OnBeforeFinish;

	private bool isDirty;

	private List<DeterministicCollider> hitTargets = new List<DeterministicCollider>(5);

	private FP lastHitTime;

	private DeterministicColliderCompare _compare = new DeterministicColliderCompare();

	private List<DeterministicCollider> _lastColliderList = new List<DeterministicCollider>(16);

	private List<DeterministicCollider> _nowColliderList = new List<DeterministicCollider>(16);

	private bool colliderEnable;

	private Transform srcTransform;

	private FP _damageImmuneDuration;

	protected const int TestOverlapLayer = 164608;

	private Collider _collider;

	private DeterministicCollider _dtCollider;

	private DeterministicShape _deterministicShape;

	protected HitBox _hitBox;

	protected readonly Dictionary<long, FP> _hitedActors = new Dictionary<long, FP>(5);

	public FP FinalLeftTime => LeftTime + additionLeftTime;

	public long ownerId => _ownerId;

	public AdventureActor Owner
	{
		get
		{
			return _owner;
		}
		set
		{
			if (_owner != value)
			{
				_owner = value;
				_ownerId = _owner?.Id ?? 0;
			}
		}
	}

	public LogicEntity atkTarget
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

	public int uniqueAttackId
	{
		get
		{
			if (SceneSingleton<AdventurePlayerController>.Instance != null)
			{
				return SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
			}
			return 0;
		}
	}

	public FP DamageImmuneDuration
	{
		get
		{
			return _damageImmuneDuration;
		}
		set
		{
			_damageImmuneDuration = value;
		}
	}

	public HitBox hitBox => _hitBox;

	protected override void OnInit()
	{
		base.OnInit();
		if (targetObj == null)
		{
			Debug.LogError("激光实体缺少targetObj,请检查配置,激光实体名称:" + name);
		}
		gameObject.layer = 17;
		_smooth = _smooth ?? AddOrGetMonoLogicComponent<VisualSmooth>();
		SetColliderState(enable: false);
	}

	protected override void OnActive()
	{
		base.OnActive();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		DisableLogicUpdate();
		_owner = null;
		linkFx.Stop();
		OnCollisionEnter = null;
		OnCollisionExit = null;
		OnOtherCollisionEnter = null;
		OnOtherCollisionExit = null;
		OnBeforeFinish = null;
		_lastColliderList.Clear();
		_nowColliderList.Clear();
		hitTargets.Clear();
		lastTarget = null;
		_atkTarget = null;
		_hitedActors.Clear();
	}

	public void Setup(AdventureActor owner)
	{
		LeftTime = leftTime;
		additionLeftTime = 0;
		curLeftTime = 0;
		lastLen = 0;
		_owner = owner;
		lastHitTime = 0;
		isDirty = false;
		_damageImmuneDuration = damageImmuneDuration;
		curLen = maxLen;
		EnableLogicUpdate();
		_hitBox = HitBox.Setup(gameObject, _owner, this);
		_hitBox.initHitDamageIdData(_hitdamagedatas);
		_hitBox.hitDamageId = hitDamageId;
		_hitBox.featureFlags = hitFlags;
		_hitBox.featureData = hitFeatureData;
		_hitBox.hurtAnimType = hurtAnimType;
		AnimationSlotConfigComponent component = _owner.GetComponent<AnimationSlotConfigComponent>();
		if (component != null)
		{
			srcTransform = component.GetSlotNode(srcSlot, allowFallback: true);
		}
		else
		{
			srcTransform = _owner.gameObject.transform;
		}
		if (laserType == LaserType.Owner)
		{
			RefreshPlayFx();
		}
		else
		{
			linkFx.PlayLinFx(_owner, linkEffect, 1f, useCustSource: false, gameObject, TSVector.zero, default, targetObj, TSVector.zero, default);
		}
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (_owner != null)
		{
			if (_owner.IsDead())
			{
				Finish();
				return;
			}
			if (laserType == LaserType.Owner)
			{
				RefreshPlayFx();
			}
		}
		curLeftTime += LogicDeltaTime;
		if (curLeftTime > FinalLeftTime)
		{
			Finish();
			return;
		}
		TestOverLap();
		RefreshTRS();
		curLen = CalclateLen();
		TSVector2 tSVector = tsTransform.Position + tsTransform.Forward * curLen;
		Vector3 position = new Vector3(tSVector.x.AsFloat(), srcTransform.position.y, tSVector.y.AsFloat());
		targetObj.transform.position = position;
		isDirty = TSMath.Abs(curLen - lastLen) > threshold;
		if (isDirty)
		{
			UpdateColliderShape();
		}
		lastLen = curLen;
		if (!(LogicTime - lastHitTime > hitInterval) && !(lastHitTime <= 0))
		{
			return;
		}
		lastHitTime = LogicTime;
		TSVector2 point = TSVector2.up * curLen / 2f;
		TSVector2 pos = tsTransform.TransformLocalPointToWorldSpace(point);
		_hitBox.RectangleAreaHit(width, curLen, pos, tsTransform.Forward.GetAngle(), out var hittedCount, out var _, uniqueAttackId, hittedPrefab, isHittedEffectScale: true, -5, DamageImmuneDuration, randomHit: false, (AdventureActor hitTarget) =>
		{
			lastTarget = hitTarget;
		});
		if (hittedCount > 0)
		{
			if (hitFeedbackEffectConfigureData != null && lastTarget != null)
			{
				hitFeedbackEffectConfigureData.Play(lastTarget.transform.position, gameObject, GetCameraShakeSort());
			}
			if (lastTarget != null && hitPrefab != null)
			{
				AdventureFXPlayer.PlayFX(hitPrefab, (float)logicTimeScale, targetObj.transform.position, transform.rotation, targetObj.transform.localScale.x).ownerActor = _owner;
			}
		}
	}

	private void RefreshTRS()
	{
		tsTransform.Position = _owner.tsTransform.Position;
		if (laserType == LaserType.Owner)
		{
			tsTransform.Forward = _owner.tsTransform.Forward;
		}
		else if (atkTarget != null)
		{
			tsTransform.Forward = (atkTarget.tsTransform.Position - tsTransform.Position).normalized;
		}
	}

	private FP CalclateLen()
	{
		FP fP = curLen;
		if (laserType == LaserType.Owner)
		{
			TSVector2 point = TSVector2.up * maxLen / 2f;
			TSVector2 pos = tsTransform.TransformLocalPointToWorldSpace(point);
			SceneSingleton<DeterministicCollisionManager>.Instance.CheckRectangleOverlap(width, maxLen, pos, tsTransform.Forward.GetAngle(), hitTargets, 151808);
			if (hitTargets.Count > 0)
			{
				fP = maxLen;
				for (int i = 0; i < hitTargets.Count; i++)
				{
					if (hitTargets.get_Item(i).Entity is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.actorHealthInfo.isAlive && !monsterAdventureActor.IsPlayerSummoned(out var _, out var _))
					{
						FP val = TSVector2.Distance(tsTransform.Position, monsterAdventureActor.tsTransform.Position) - monsterAdventureActor.GetRadius() + LenOffset;
						fP = TSMath.Min(fP, val);
					}
				}
			}
			else
			{
				fP = maxLen;
			}
		}
		else if (atkTarget != null)
		{
			fP = TSVector2.Distance(tsTransform.Position, atkTarget.tsTransform.Position);
		}
		return fP;
	}

	public void Finish()
	{
		OnBeforeFinish?.Invoke();
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}

	public void AddLeftTime(FP addTime)
	{
		additionLeftTime += addTime;
	}

	protected int GetCameraShakeSort()
	{
		if (_owner == null)
		{
			return 0;
		}
		if (!(_owner is PlayerAdventureActor playerAdventureActor))
		{
			return 2;
		}
		if (playerAdventureActor.isAssist)
		{
			return -1;
		}
		return 1;
	}

	private void RefreshPlayFx()
	{
		if (_owner != null && _owner.attackTarget != null)
		{
			if (!linkFx.isPlaying)
			{
				TSVector2 tSVector = tsTransform.Position + tsTransform.Forward * curLen;
				Vector3 position = new Vector3(tSVector.x.AsFloat(), srcTransform.position.y, tSVector.y.AsFloat());
				targetObj.transform.position = position;
				linkFx.PlayLinFx(_owner, linkEffect, 1f, useCustSource: false, gameObject, TSVector.zero, default, targetObj, TSVector.zero, default);
			}
		}
		else if (linkFx.isPlaying)
		{
			linkFx.Stop();
		}
	}

	public void SetColliderState(bool enable)
	{
		colliderEnable = enable;
		if (enable)
		{
			_collider = gameObject.AddOrGetComponent<BoxCollider>();
			_dtCollider = AddOrGetMonoLogicComponent<DeterministicCollider>();
			_dtCollider.priority = 3;
			_dtCollider.IgnoreCollision = false;
			UpdateColliderShape();
		}
		else
		{
			DeterministicCollider logicComponent = GetLogicComponent<DeterministicCollider>();
			if (logicComponent != null)
			{
				logicComponent.IgnoreCollision = true;
				logicComponent.ActiveSelf = false;
			}
		}
	}

	public void UpdateColliderShape()
	{
		if (!(_dtCollider == null) && !(_collider == null) && colliderEnable)
		{
			BoxCollider boxCollider = _collider as BoxCollider;
			if (boxCollider != null)
			{
				boxCollider.center = new Vector3(0f, 0f, 0f);
				boxCollider.size = new Vector3(curLen.AsFloat(), 0f, width.AsFloat());
			}
			_dtCollider.LoadFromUnityCollider(_collider);
		}
	}

	public void ChangeCollisionState(bool ignoreCollision)
	{
		if (!colliderEnable || _dtCollider == null)
		{
			Debug.LogError("该区域效果不可被命中,请检查配置,区域效果名称:" + name);
		}
		else if (_dtCollider.IgnoreCollision != ignoreCollision)
		{
			_dtCollider.IgnoreCollision = ignoreCollision;
		}
	}

	protected void TestOverLap()
	{
		if (colliderEnable)
		{
			DeterministicCollision(_nowColliderList, 164608);
			TriggerEnter();
			TriggerExit();
			_lastColliderList.Clear();
			_lastColliderList.AddRange(_nowColliderList);
		}
	}

	public void DeterministicCollision(List<DeterministicCollider> result, int layer, int filterTargetTag = 0)
	{
		if (result == null)
		{
			result = new List<DeterministicCollider>(16);
		}
		result.Clear();
		_deterministicShape.shapeType = DeterministicShape.ShapeType.Rectangle;
		_deterministicShape.position = tsTransform.Position + tsTransform.Forward * curLen / 2f;
		_deterministicShape.rotation = tsTransform.Rotation;
		_deterministicShape.width = width + extraWidth;
		_deterministicShape.length = curLen;
		bool drawGizmos = false;
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(result, _deterministicShape, layer, drawGizmos);
		if (filterTargetTag != 0)
		{
			result.RemoveAll((DeterministicCollider collider) => collider.Entity is AdventureActor adventureActor && !adventureActor.CheckTag(filterTargetTag));
		}
	}

	protected void TriggerEnter()
	{
		List<DeterministicCollider> list = _nowColliderList.Except(_lastColliderList, _compare).ToList();
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i).Entity != null && list.get_Item(i).Entity.Id != Id)
			{
				OnCollisionEnter?.Invoke(list.get_Item(i).Entity);
			}
		}
	}

	protected void TriggerExit()
	{
		List<DeterministicCollider> list = _lastColliderList.Except(_nowColliderList, _compare).ToList();
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i).Entity != null && list.get_Item(i).Entity.Id != Id)
			{
				OnCollisionExit?.Invoke(list.get_Item(i).Entity);
			}
		}
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
		if (!_hitedActors.TryGetValue(actorId, out var value))
		{
			return true;
		}
		return LogicTime > value + timeout;
	}

	public void SetActorHitedTime(long actorId, FP time)
	{
		_hitedActors.set_Item(actorId, time);
	}

	public bool CheckHitable(HitBox hitBox, LogicEntity actor)
	{
		if (!(_owner == null) && (hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !_owner.IsConfrontWith(actor))
		{
			return _owner.IsNeutralWith(actor);
		}
		return true;
	}

	public bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity target, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!target.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		(damaged, _, _) = (target as AdventureActor).Damage(Owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}

	public bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		if (!shield.isShield)
		{
			return false;
		}
		return true;
	}

	public bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity target, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		AdventureActor adventureActor = target as AdventureActor;
		if (!adventureActor.CurrentStepCanbeHurt())
		{
			return true;
		}
		(damaged, _, _) = adventureActor.Damage(Owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}
}
