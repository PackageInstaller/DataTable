using System;
using System.Collections.Generic;
using Google.Protobuf.Collections;
using TrueSync;
using UnityEngine;

public class HitBox : MonoBehaviour
{
	public enum Shape
	{
		Rectangle,
		Circle,
		Fan
	}

	[Flags]
	public enum FeatureFlag : uint
	{
		None = 0u,
		KnockBack = 1u,
		AirBorne = 2u,
		ChangeArea = 8u,
		Stiff = 0x1000u,
		Kill = 0x10000u,
		KillDestructible = 0x80000u,
		NoDiffDamage = 0x20000u,
		DamageFreezeFrame = 0x10000000u,
		AddBuffForSelf = 0x10u,
		AddBuffForTarget = 0x20u,
		RemoveBuffForSelf = 0x40u,
		RemoveBuffForTarget = 0x80u,
		All = uint.MaxValue
	}

	[Serializable]
	public class HitBoxFeatureData
	{
		public FP KnockBackForce = 10f;

		public FP KnockBackDistance = 1f;

		public bool UseAtttackForward;

		public bool UseHitBoxPosition;

		public FP KnockOutForce = 10f;

		public string oldAreaTag;

		public GameObject newAreaEffectPrefab;

		public FP StiffDuration = 0.1f;

		public bool isConfirmKill;

		public bool isConfirmKillDestructible;

		public FreezeFrameType _freezeFrameType;

		public FP FreezeFrameWhenDamage = -1f;

		public FP FreezeFrameWhenCrit = -1f;

		public FP FreezeFrameWhenToughnessBroken = -1f;

		public FP aFreezeFrameWhenDamage = 0f;

		public FP aFreezeFrameTimeScaleWhenDamage = 0f;

		public FP aFreezeFrameWhenCrit = 0f;

		public FP aFreezeFrameTimeScaleWhenCrit = 0f;

		public FP aFreezeFrameWhenToughnessBroken = 0f;

		public FP aFreezeFrameTimeScaleWhenToughnessBroken = 0f;

		public FP bFreezeFrameWhenDamage = 0f;

		public FP bFreezeFrameTimeScaleWhenDamage = 0f;

		public FP bFreezeFrameWhenCrit = 0f;

		public FP bFreezeFrameTimeScaleWhenCrit = 0f;

		public FP bFreezeFrameWhenToughnessBroken = 0f;

		public FP bFreezeFrameTimeScaleWhenToughnessBroken = 0f;

		public List<int> buffIdsForSelf;

		public List<int> buffIdsForTarget;

		public List<int> removeBuffIdsForSelf;

		public List<int> removeBuffIdsForTarget;

		public FP hitStrenth = 1f;
	}

	public enum FreezeFrameType
	{
		Local,
		Global,
		Personalize
	}

	public enum HurtAnimType
	{
		None,
		Small,
		Large
	}

	[Serializable]
	public class HitDamageIdData
	{
		public FP duration = 100;

		public int HitDamageId;
	}

	public static readonly HitBoxFeatureData defaultFeatureData = new HitBoxFeatureData();

	public const int hitableLayerMask = 151808;

	public LogicEntity owner;

	public IHitBoxContext context;

	[Space]
	public FeatureFlag featureFlags;

	public HitBoxFeatureData featureData;

	private int _id;

	private List<HitDamageIdData> _HitDamageIdDatas;

	[Space]
	public HurtAnimType hurtAnimType = HurtAnimType.Small;

	public GameObject hurtEffectSource;

	protected readonly List<DeterministicCollider> _hitTargets = new List<DeterministicCollider>(5);

	protected AkWeaponHitSwitch weaponTrigger;

	protected bool canWeaponTrigger;

	public AdventureActor actor;

	private const float DefaultDuarationTime = 0.2f;

	public int hitDamageId
	{
		get
		{
			if (owner == null)
			{
				return _id;
			}
			if (_HitDamageIdDatas == null || _HitDamageIdDatas.Count < 1)
			{
				return _id;
			}
			FP fP = owner.LogicTime * 1000;
			for (int i = 0; i < _HitDamageIdDatas.Count; i++)
			{
				if (fP < _HitDamageIdDatas.get_Item(i).duration)
				{
					return _HitDamageIdDatas.get_Item(i).HitDamageId;
				}
			}
			List<HitDamageIdData> hitDamageIdDatas = _HitDamageIdDatas;
			return hitDamageIdDatas.get_Item(hitDamageIdDatas.Count - 1).HitDamageId;
		}
		set
		{
			_id = value;
		}
	}

	public AdventureActor Actor
	{
		get
		{
			if (owner == null)
			{
				return null;
			}
			AdventureActor adventureActor = owner as AdventureActor;
			AdventureWeapon adventureWeapon = owner as AdventureWeapon;
			if (adventureWeapon != null)
			{
				return adventureWeapon.owner as AdventureActor;
			}
			if (!(adventureActor != null))
			{
				return null;
			}
			return adventureActor;
		}
	}

	public Shape hitBoxShape { get; private set; }

	public FP hitBoxWidth { get; private set; }

	public FP hitBoxLength { get; private set; }

	public FP hitBoxRadius { get; private set; }

	public FP hitBoxInnerRadius { get; private set; }

	public FP hitBoxAngle { get; private set; }

	public TSVector2 hitPos { get; private set; }

	private void Awake()
	{
		weaponTrigger = GetComponent<AkWeaponHitSwitch>();
	}

	public void initHitDamageIdData(HitDamageIdData[] _hitDamageIdDatas)
	{
		if (_hitDamageIdDatas != null && _hitDamageIdDatas.Length > 0)
		{
			_HitDamageIdDatas = new List<HitDamageIdData>();
			for (int i = 0; i < _hitDamageIdDatas.Length; i++)
			{
				_HitDamageIdDatas.Add(_hitDamageIdDatas[i]);
			}
		}
	}

	public static HitBox Setup(GameObject gameObject, LogicEntity owner, IHitBoxContext context)
	{
		if (!gameObject.TryGetComponent<HitBox>(out var component))
		{
			component = gameObject.AddComponent<HitBox>();
		}
		component.owner = owner;
		component.context = context;
		return component;
	}

	public bool RectangleAreaHit(FP width, FP length, TSVector2 pos, FP rot, out int hittedCount, out int damageCount, int uniqueAttackId, GameObject hurtEffectPrefab = null, bool isHittedEffectScale = true, int layerMask = -5, FP damageImmuneDuration = default(FP), bool randomHit = false, Action<AdventureActor> cb = null, bool effectIgnoreTimeScale = true)
	{
		hitBoxShape = Shape.Rectangle;
		hitBoxWidth = width;
		hitBoxLength = length;
		hitPos = pos;
		hittedCount = 0;
		damageCount = 0;
		DeterministicRaycastHit raycastHit = new DeterministicRaycastHit
		{
			isValid = false
		};
		if (layerMask == -5)
		{
			layerMask = 131328;
		}
		bool flag = false;
		if (SceneSingleton<AdventureModuleDebugHelper>.Instance.HitboxGizmo | flag)
		{
			Transform transform = owner.transform;
			Vector3 pos2 = new Vector3((float)pos.x, transform.position.y, (float)pos.y);
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowRectangleGizmo(pos2, (float)width, (float)length, (float)rot, Color.red, 0.2f);
		}
		bool result = !SceneSingleton<DeterministicCollisionManager>.Instance.CheckRectangleOverlap(width, length, pos, rot, _hitTargets, layerMask, flag) || HitTargets(uniqueAttackId, _hitTargets, out hittedCount, out damageCount, ref raycastHit, hurtEffectPrefab, isHittedEffectScale, damageImmuneDuration, randomHit, cb, effectIgnoreTimeScale);
		_hitTargets.Clear();
		return result;
	}

	public bool CircleAreaHit(FP radius, FP innerRadius, TSVector2 pos, out int hittedCount, out int damageCount, int uniqueAttackId, GameObject hurtEffectPrefab = null, bool isHittedEffectScale = true, int layerMask = -5, FP damageImmuneDuration = default(FP), bool randomHit = false, bool effectIgnoreTimeScale = true)
	{
		hitBoxShape = Shape.Circle;
		hitBoxRadius = radius;
		hitBoxInnerRadius = innerRadius;
		hitPos = pos;
		hittedCount = 0;
		damageCount = 0;
		DeterministicRaycastHit raycastHit = new DeterministicRaycastHit
		{
			isValid = false
		};
		if (layerMask == -5)
		{
			layerMask = 131328;
		}
		bool flag = false;
		bool result;
		if (innerRadius > 0f)
		{
			if (SceneSingleton<AdventureModuleDebugHelper>.Instance.HitboxGizmo | flag)
			{
				Transform transform = owner.transform;
				Vector3 pos2 = new Vector3((float)pos.x, transform.position.y, (float)pos.y);
				SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowRingGizmo(pos2, Vector3.up, (float)innerRadius, (float)radius, Color.yellow, Color.red, 0.2f);
			}
			result = !SceneSingleton<DeterministicCollisionManager>.Instance.CheckRingOverlap(radius, innerRadius, pos, _hitTargets, layerMask, flag) || HitTargets(uniqueAttackId, _hitTargets, out hittedCount, out damageCount, ref raycastHit, hurtEffectPrefab, isHittedEffectScale, damageImmuneDuration, randomHit, null, effectIgnoreTimeScale);
		}
		else
		{
			if (SceneSingleton<AdventureModuleDebugHelper>.Instance.HitboxGizmo | flag)
			{
				Transform transform2 = owner.transform;
				Vector3 pos3 = new Vector3((float)pos.x, transform2.position.y, (float)pos.y);
				SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCircleGizmo(pos3, Vector3.up, (float)radius, Color.red, 0.2f);
			}
			result = !SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(radius, pos, _hitTargets, layerMask, flag) || HitTargets(uniqueAttackId, _hitTargets, out hittedCount, out damageCount, ref raycastHit, hurtEffectPrefab, isHittedEffectScale, damageImmuneDuration, randomHit, null, effectIgnoreTimeScale);
		}
		_hitTargets.Clear();
		return result;
	}

	public bool FanAreaHit(FP angle, FP radius, FP innerRadius, TSVector2 pos, FP rot, out int hittedCount, out int damageCount, int uniqueAttackId, GameObject hurtEffectPrefab = null, bool isHittedEffectScale = true, FP damageImmuneDuration = default(FP), bool effectIgnoreTimeScale = true)
	{
		hitBoxShape = Shape.Fan;
		hitBoxRadius = radius;
		hitBoxInnerRadius = innerRadius;
		hitPos = pos;
		hittedCount = 0;
		damageCount = 0;
		DeterministicRaycastHit raycastHit = new DeterministicRaycastHit
		{
			isValid = false
		};
		bool flag = false;
		bool result;
		if (innerRadius > 0f)
		{
			if (SceneSingleton<AdventureModuleDebugHelper>.Instance.HitboxGizmo | flag)
			{
				Transform transform = owner.transform;
				Vector3 pos2 = new Vector3((float)pos.x, transform.position.y, (float)pos.y);
				SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowFanRingGizmo(pos2, (float)innerRadius, (float)radius, (float)angle, (float)rot, Color.red, 0.2f);
			}
			result = !SceneSingleton<DeterministicCollisionManager>.Instance.CheckFanRingOverlap(angle, radius, innerRadius, pos, rot, _hitTargets, 131328, flag) || HitTargets(uniqueAttackId, _hitTargets, out hittedCount, out damageCount, ref raycastHit, hurtEffectPrefab, isHittedEffectScale, damageImmuneDuration, randomHit: false, null, effectIgnoreTimeScale);
		}
		else
		{
			if (SceneSingleton<AdventureModuleDebugHelper>.Instance.HitboxGizmo | flag)
			{
				Transform transform2 = owner.transform;
				Vector3 pos3 = new Vector3((float)pos.x, transform2.position.y, (float)pos.y);
				SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowFanGizmo(pos3, (float)radius, (float)angle, (float)rot, Color.red, 0.2f);
			}
			result = !SceneSingleton<DeterministicCollisionManager>.Instance.CheckFanOverlap(angle, radius, pos, rot, _hitTargets, 131328, flag) || HitTargets(uniqueAttackId, _hitTargets, out hittedCount, out damageCount, ref raycastHit, hurtEffectPrefab, isHittedEffectScale, damageImmuneDuration, randomHit: false, null, effectIgnoreTimeScale);
		}
		_hitTargets.Clear();
		return result;
	}

	public bool HitTargets(int uniqueAttackId, List<DeterministicCollider> hitTargets, out int hittedCount, out int damageCount, ref DeterministicRaycastHit raycastHit, GameObject hurtEffectPrefab, bool isHittedEffectScale, FP damageImmuneDuration = default(FP), bool randomHit = false, Action<AdventureActor> cb = null, bool effectIgnoreTimeScale = true)
	{
		AdeventrueMulTargetsHitBegin adeventrueMulTargetsHitBegin = AdeventrueMulTargetsHitBegin.Generate();
		adeventrueMulTargetsHitBegin.sender = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adeventrueMulTargetsHitBegin);
		hittedCount = 0;
		damageCount = 0;
		bool flag = false;
		int num = 0;
		if (randomHit)
		{
			for (int num2 = hitTargets.Count - 1; num2 >= 0; num2--)
			{
				if (hitTargets.get_Item(num2).layer == 8)
				{
					if (!CheckActorTargetValidated(hitTargets.get_Item(num2).Entity))
					{
						hitTargets.RemoveAt(num2);
					}
				}
				else
				{
					hitTargets.RemoveAt(num2);
				}
			}
			if (hitTargets.Count > 0)
			{
				num = 1;
				if (_HitSingleTarget(uniqueAttackId, hitTargets.get_Item(TSRandom.Range(0, hitTargets.Count)), out var hitted, out var damaged, ref raycastHit, hurtEffectPrefab, isHittedEffectScale, damageImmuneDuration, num, cb, effectIgnoreTimeScale))
				{
					flag = true;
				}
				if (hitted)
				{
					hittedCount++;
				}
				if (damaged)
				{
					damageCount++;
				}
			}
		}
		else
		{
			for (int num3 = hitTargets.Count - 1; num3 >= 0; num3--)
			{
				if (hitTargets.get_Item(num3).layer == 8)
				{
					if (!CheckActorTargetValidated(hitTargets.get_Item(num3).Entity))
					{
						hitTargets.RemoveAt(num3);
					}
					else
					{
						num++;
					}
				}
			}
			flag = true;
			for (int i = 0; i < hitTargets.Count; i++)
			{
				flag = _HitSingleTarget(uniqueAttackId, hitTargets.get_Item(i), out var hitted2, out var damaged2, ref raycastHit, hurtEffectPrefab, isHittedEffectScale, damageImmuneDuration, num, cb, effectIgnoreTimeScale) & flag;
				if (hitted2)
				{
					hittedCount++;
				}
				if (damaged2)
				{
					damageCount++;
				}
			}
		}
		if (hittedCount == 0)
		{
			flag = true;
		}
		return flag;
	}

	private bool CheckActorTargetValidated(LogicEntity target)
	{
		if (target != null && target is AdventureActor adventureActor && context.CheckHitable(this, target) && adventureActor.actorHealthInfo.isAlive && !adventureActor.isUnparalleled)
		{
			return !adventureActor.isBattleOut;
		}
		return false;
	}

	public bool HitSingleTarget(int uniqueAttackId, DeterministicCollider hitTarget, out bool hitted, out bool damaged, ref DeterministicRaycastHit raycastHit, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, FP damageImmuneDuration = default(FP), int onceAttackTargetCount = 1, bool effectIgnoreTimeScale = true)
	{
		AdeventrueMulTargetsHitBegin adeventrueMulTargetsHitBegin = AdeventrueMulTargetsHitBegin.Generate();
		adeventrueMulTargetsHitBegin.sender = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adeventrueMulTargetsHitBegin);
		bool flag = false;
		if (SceneSingleton<AdventureModuleDebugHelper>.Instance.HitboxGizmo | flag)
		{
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowArrowLineGizmo(transform.position, hitTarget.transform.position, Color.red, 0.2f);
		}
		return _HitSingleTarget(uniqueAttackId, hitTarget, out hitted, out damaged, ref raycastHit, hurtEffectPrefab, isHittedEffectScale, damageImmuneDuration, onceAttackTargetCount, null, effectIgnoreTimeScale);
	}

	public bool _HitSingleTarget(int uniqueAttackId, DeterministicCollider hitTarget, out bool hitted, out bool damaged, ref DeterministicRaycastHit raycastHit, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, FP damageImmuneDuration = default(FP), int onceAttackTargetCount = 1, Action<AdventureActor> cb = null, bool effectIgnoreTimeScale = true)
	{
		bool result = false;
		hitted = false;
		damaged = false;
		canWeaponTrigger = false;
		int layer = hitTarget.layer;
		bool iDamageImmuneDuration = false;
		switch (layer)
		{
		case 8:
		{
			AdventureActor adventureActor2 = (AdventureActor)hitTarget.Entity;
			if (CheckActorTargetValidated(adventureActor2))
			{
				adventureActor2.BeginHitIdImmunityCheck();
				hitted = true;
				result = HitActor(uniqueAttackId, onceAttackTargetCount, adventureActor2, ref raycastHit, out damaged, hurtEffectPrefab, isHittedEffectScale, out iDamageImmuneDuration, damageImmuneDuration, cb, effectIgnoreTimeScale);
				canWeaponTrigger = damaged;
				if (!canWeaponTrigger && !iDamageImmuneDuration && !adventureActor2._hitIdImmuneTriggered)
				{
					canWeaponTrigger = adventureActor2.isInvincible || adventureActor2.damageImmunity;
				}
				if (adventureActor2 is PlayerAdventureActor { isAssist: not false })
				{
					canWeaponTrigger = false;
				}
			}
			break;
		}
		case 14:
		{
			AdventureWeapon adventureWeapon = (AdventureWeapon)hitTarget.Entity;
			if (null != adventureWeapon && context.CheckHitable(this, adventureWeapon.owner))
			{
				hitted = true;
				result = (canWeaponTrigger = context.OnHitShield(this, adventureWeapon, ref raycastHit));
			}
			break;
		}
		case 12:
		{
			AdventureObstacle adventureObstacle = (AdventureObstacle)hitTarget.Entity;
			if (null != adventureObstacle)
			{
				hitted = true;
				result = (canWeaponTrigger = context.OnHitObstacle(this, adventureObstacle, ref raycastHit));
			}
			break;
		}
		case 17:
		{
			AreaEffectEntity areaEffectEntity = hitTarget.Entity as AreaEffectEntity;
			if (null != areaEffectEntity)
			{
				if ((featureFlags & FeatureFlag.ChangeArea) == FeatureFlag.ChangeArea && !string.IsNullOrEmpty(featureData.oldAreaTag) && featureData.newAreaEffectPrefab != null && string.Equals(areaEffectEntity.areaTag, featureData.oldAreaTag))
				{
					AdventureActor adventureActor = areaEffectEntity.owner;
					Transform transform = areaEffectEntity.transform;
					Vector3 position = transform.position;
					Quaternion rotation = transform.rotation;
					areaEffectEntity.Finish();
					SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(adventureActor, featureData.newAreaEffectPrefab, position, rotation);
				}
				hitted = true;
				result = true;
				canWeaponTrigger = false;
			}
			break;
		}
		}
		if (!hitted)
		{
			result = true;
		}
		else if (canWeaponTrigger)
		{
			AkWeaponHitSwitch component = hitTarget.Entity.GetComponent<AkWeaponHitSwitch>();
			if (component != null)
			{
				component.ToPostEvent(weaponTrigger, hitTarget.Entity);
			}
		}
		return result;
	}

	public bool HitActor(int uniqueAttackId, int onceAttackTargetCount, AdventureActor adventureActor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, out bool iDamageImmuneDuration, FP damageImmuneDuration = default(FP), Action<AdventureActor> cb = null, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		iDamageImmuneDuration = false;
		if (damageImmuneDuration == 0 || damageImmuneDuration == default(FP))
		{
			damageImmuneDuration = AdventureModuleController.Config.Combat_HitboxDamageImmuneDuration;
		}
		MonsterAdventureActor monsterAdventureActor = null;
		if (owner is AdventureWeapon { owner: MonsterAdventureActor monsterAdventureActor2 } && !monsterAdventureActor2.IsPlayerSummoned(out var _, out var _))
		{
			if (!monsterAdventureActor2.QueryMonsterWeaponHitedTimeout(adventureActor.Id, damageImmuneDuration))
			{
				iDamageImmuneDuration = true;
				return true;
			}
			monsterAdventureActor = monsterAdventureActor2;
		}
		if (!context.QueryActorHitedTimeout(adventureActor.Id, damageImmuneDuration))
		{
			iDamageImmuneDuration = true;
			return true;
		}
		bool result = false;
		bool flag = PreProcessHitBoxFeatureFlags(adventureActor, hurtEffectPrefab, isHittedEffectScale, effectIgnoreTimeScale);
		if (!flag)
		{
			result = ((adventureActor is DestructibleStateSingle) ? context.OnHitDestructibleObstacle(this, uniqueAttackId, onceAttackTargetCount, adventureActor, ref raycastHit, out damaged, hurtEffectPrefab, isHittedEffectScale, effectIgnoreTimeScale) : context.OnHitActor(this, uniqueAttackId, onceAttackTargetCount, adventureActor, ref raycastHit, out damaged, hurtEffectPrefab, isHittedEffectScale, effectIgnoreTimeScale));
			cb?.Invoke(adventureActor);
		}
		PostProcessHitBoxFeatureFlags(adventureActor, damaged);
		if (hitDamageId >= 0)
		{
			FP time = context.QueryHitBoxContextTime();
			context.SetActorHitedTime(adventureActor.Id, time);
			if (monsterAdventureActor != null)
			{
				monsterAdventureActor.SetMonsterWeaponHitedTime(adventureActor.Id, monsterAdventureActor.QueryHitBoxContextTime());
			}
		}
		if (flag)
		{
			damaged = true;
		}
		return result;
	}

	protected bool PreProcessHitBoxFeatureFlags(AdventureActor adventureActor, GameObject hurtEffectPrefab = null, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		if (featureFlags == FeatureFlag.None)
		{
			return false;
		}
		HitBoxFeatureData hitboxFeatureData = featureData ?? defaultFeatureData;
		bool result = false;
		if (adventureActor.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			if (adventureActor is DestructibleStateSingle destructibleStateSingle)
			{
				if ((featureFlags & FeatureFlag.KillDestructible) == FeatureFlag.KillDestructible && featureData.isConfirmKillDestructible)
				{
					destructibleStateSingle.OnKill();
					result = true;
				}
			}
			else if ((featureFlags & FeatureFlag.Kill) == FeatureFlag.Kill && featureData.isConfirmKill)
			{
				RepeatedField<int> damageTag = Singleton<HotfixDataController>.Instance.GetHitDamage(hitDamageId)?.DamageTag;
				result = adventureActor.Kill(context as LogicEntity, hurtEffectPrefab, featureFlags, hitboxFeatureData, isHittedEffectScale, damageTag, effectIgnoreTimeScale);
			}
		}
		return result;
	}

	protected void PostProcessHitBoxFeatureFlags(AdventureActor adventureActor, bool damaged)
	{
	}

	public bool CheckWithInRing(LogicEntity entity)
	{
		if (hitBoxShape == Shape.Rectangle)
		{
			return false;
		}
		if (hitBoxInnerRadius <= 0)
		{
			return false;
		}
		FP fP = hitBoxRadius - hitBoxInnerRadius;
		return TSVector2.Distance(entity.tsTransform.Position, hitPos) < hitBoxRadius + fP / 2;
	}

	public void HitWithCollider(DeterministicCollider deterministicCollider, GameObject hurtEffectPrefab, FP _damageImmuneDuration = default(FP))
	{
		int hittedCount;
		int damageCount;
		switch (deterministicCollider.ColliderShape)
		{
		case DeterministicColliderShape.Circle:
			CircleAreaHit(deterministicCollider.Radius, 0f, deterministicCollider.CenterPosition, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), hurtEffectPrefab, isHittedEffectScale: true, -5, _damageImmuneDuration);
			break;
		case DeterministicColliderShape.Rect:
			RectangleAreaHit(deterministicCollider.ColliderWidth, deterministicCollider.ColliderLength, deterministicCollider.CenterPosition, deterministicCollider.tsTransform.Rotation, out damageCount, out hittedCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), hurtEffectPrefab, isHittedEffectScale: true, -5, _damageImmuneDuration);
			break;
		default:
			throw new ArgumentOutOfRangeException();
		case DeterministicColliderShape.None:
			break;
		}
	}
}
