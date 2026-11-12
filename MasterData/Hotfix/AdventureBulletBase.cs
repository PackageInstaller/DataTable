using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;
using UnityEngine.Serialization;

public class AdventureBulletBase : AdventureWeapon
{
	[Space]
	[FormerlySerializedAs("_damageArea")]
	public FP damageArea = 0f;

	[Space]
	public GameObject finishPrefab;

	[HideInInspector]
	public bool isPlayFinishPrefab = true;

	private LogicEntity _target;

	protected AimType _aimType;

	[HideInInspector]
	public long tagUid;

	protected BulletFinishReason _finishReason;

	public FP damageImmuneDurationForMonsterWeapon;

	protected FP _delayShootTimer;

	public LogicEntity target
	{
		get
		{
			if (_target == null)
			{
				return null;
			}
			if (!(_target is AdventureActor { isSneak: not false, isPenetrate: not false }))
			{
				return _target;
			}
			return null;
		}
		set
		{
			_target = value;
		}
	}

	public TSVector2 targetPosition { get; set; }

	public FP targetPositionY { get; set; }

	public AimType aimType => _aimType;

	public int BulletHashCode => bulletHashCode;

	public bool useDamageImmuneDurationForMonsterWeapon
	{
		get
		{
			if (owner is MonsterAdventureActor entity && !entity.IsPlayerSummoned(out var _, out var _))
			{
				if (!(damageImmuneDurationForMonsterWeapon != 0))
				{
					return damageImmuneDurationForMonsterWeapon != default(FP);
				}
				return true;
			}
			return false;
		}
	}

	public override bool isValid
	{
		get
		{
			if (_delayShootTimer >= delayShoot)
			{
				return base.isValid;
			}
			return false;
		}
	}

	public bool isFinished { get; set; }

	public List<WeaponFeature> features { get; } = new List<WeaponFeature>(4);

	public override bool isShootableWeapon => true;

	public FP delayShoot { get; set; }

	protected FP GetDamageArea()
	{
		if (damageArea <= 0)
		{
			damageArea = dtCollider.Radius;
		}
		return damageArea * transform.localScale.x;
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		ResetBulletTag();
		_aimType = aimType;
		FP delayShootTimer = (delayShoot = FP.Zero);
		_delayShootTimer = delayShootTimer;
		isFinished = false;
		AdventureBulletBornEvent adventureBulletBornEvent = AdventureBulletBornEvent.Generate();
		adventureBulletBornEvent.sender = this;
		adventureBulletBornEvent.tag = bulletTag;
		adventureBulletBornEvent.bulletHashCode = bulletHashCode;
		adventureBulletBornEvent.id = Id;
		adventureBulletBornEvent.owner = (AdventureActor)owner;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureBulletBornEvent);
	}

	protected override void OnInit()
	{
		base.OnInit();
		gameObject.layer = 15;
		if (dtCollider != null)
		{
			dtCollider.layer = 15;
		}
		DefaultBulletTag = bulletTag;
		WeaponFeature[] components = GetComponents<WeaponFeature>();
		if (components != null && components.Length > 0)
		{
			features.Clear();
			for (int i = 0; i < components.Length; i++)
			{
				features.Add(components[i]);
			}
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
		for (int i = 0; i < features.Count; i++)
		{
			features.get_Item(i).OnActive();
		}
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		for (int i = 0; i < features.Count; i++)
		{
			features.get_Item(i).OnDeactive();
		}
		target = null;
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		this.target = target;
		this.targetPosition = targetPosition;
		this.targetPositionY = targetPositionY;
		_finishReason = BulletFinishReason.Timeout;
	}

	public override void Finish(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		if (!cancel && isValid)
		{
			bool flag = false;
			for (int i = 0; i < features.Count; i++)
			{
				if (features.get_Item(i).OnEnd())
				{
					flag = true;
				}
			}
			if (flag)
			{
				return;
			}
		}
		if (finishPrefab != null && !ignorFinishFX && isPlayFinishPrefab)
		{
			AdventureFXPlayer.PlayFX(finishPrefab, (float)logicTimeScale, transform.position, transform.rotation, transform.localScale.x);
		}
		AdventureBulletFinishEvent adventureBulletFinishEvent = AdventureBulletFinishEvent.Generate();
		adventureBulletFinishEvent.sender = this;
		adventureBulletFinishEvent.bulletPosition = tsTransform.Position;
		adventureBulletFinishEvent.bulletPositionY = tsTransform.PositionY;
		adventureBulletFinishEvent.tag = bulletTag;
		adventureBulletFinishEvent.catched = catched;
		adventureBulletFinishEvent.bulletHashCode = bulletHashCode;
		adventureBulletFinishEvent.owner = (AdventureActor)owner;
		adventureBulletFinishEvent.finishReason = _finishReason;
		adventureBulletFinishEvent.id = Id;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureBulletFinishEvent);
		isFinished = true;
		base.Finish(cancel, catched, ignorFinishFX);
	}

	public void Kill(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		_finishReason = BulletFinishReason.Kill;
		Finish(cancel, catched, ignorFinishFX);
	}

	protected override void OnLogicStart()
	{
		base.OnLogicStart();
		CommonHelper.StartWeaponFeature(features);
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (isValid)
		{
			CommonHelper.UpdateWeaponFeature(features);
		}
	}

	public WeaponFeature QueryAttachedWeaponFeature(Type featureType)
	{
		WeaponFeature weaponFeature = gameObject.GetComponent(featureType) as WeaponFeature;
		if (weaponFeature != null && weaponFeature.enabled)
		{
			return weaponFeature;
		}
		return null;
	}

	public WeaponFeature AttachWeaponFeature(Type featureType, int initLevel = 1)
	{
		if (!typeof(WeaponFeature).IsAssignableFrom(featureType))
		{
			throw new ArgumentException("type is not support", "featureType");
		}
		bool flag = false;
		WeaponFeature weaponFeature = gameObject.GetComponent(featureType) as WeaponFeature;
		if (weaponFeature == null)
		{
			weaponFeature = (WeaponFeature)gameObject.AddComponent(featureType);
			flag = true;
		}
		else if (!weaponFeature.enabled)
		{
			flag = true;
		}
		weaponFeature.initLevel = initLevel;
		weaponFeature.enabled = true;
		for (int i = weaponFeature.level; i < weaponFeature.initLevel; i++)
		{
			weaponFeature.UpgradeLevel();
		}
		if (flag)
		{
			weaponFeature.OnStart();
		}
		return weaponFeature;
	}

	public void RemoveWeaponFeature(Type featureType)
	{
		WeaponFeature weaponFeature = gameObject.GetComponent(featureType) as WeaponFeature;
		if (weaponFeature != null)
		{
			weaponFeature.OnEnd();
			weaponFeature.enabled = false;
		}
	}

	public bool CheckFinishByWeaponFeature()
	{
		if (features.Count > 0)
		{
			for (int i = 0; i < features.Count; i++)
			{
				if (features.get_Item(i).finishAttachedWeapon)
				{
					_finishReason = BulletFinishReason.ByFeature;
					return true;
				}
			}
		}
		return false;
	}

	protected bool DelayShootUpdate()
	{
		if (_delayShootTimer >= delayShoot)
		{
			return true;
		}
		_delayShootTimer += LogicDeltaTime;
		return _delayShootTimer >= delayShoot;
	}

	public override bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!isValid)
		{
			return false;
		}
		if (!actor.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		bool flag = false;
		bool flag2 = true;
		for (int num = features.Count - 1; num >= 0; num--)
		{
			WeaponFeature weaponFeature = features.get_Item(num);
			if (weaponFeature is WeaponFeatureCertainActorHitted)
			{
				flag2 = weaponFeature.OnHitActor(actor, ref raycastHit);
			}
			else if (weaponFeature.OnHitActor(actor, ref raycastHit))
			{
				flag = true;
			}
		}
		AdventureActor component = actor.GetComponent<AdventureActor>();
		if (component.IsNotBlockBullet)
		{
			flag = true;
		}
		if (component.state == ActorState.Spawn)
		{
			flag = true;
		}
		if (flag2)
		{
			(bool, long, bool) tuple = component.Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
			(damaged, _, _) = tuple;
			if (tuple.Item3)
			{
				flag = true;
			}
		}
		else
		{
			flag = true;
		}
		if (!flag)
		{
			_finishReason = BulletFinishReason.HitActor;
		}
		return flag;
	}

	public override bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		if (!isValid)
		{
			return false;
		}
		if (!shield.isShield)
		{
			return false;
		}
		bool flag = false;
		for (int num = features.Count - 1; num >= 0; num--)
		{
			if (features.get_Item(num).OnHitShield(shield, ref raycastHit))
			{
				flag = true;
			}
		}
		if (!flag)
		{
			_finishReason = BulletFinishReason.HitShield;
		}
		return flag;
	}

	public override bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		if (!isValid)
		{
			return false;
		}
		if (heightClass > obstacle.heightClass)
		{
			return true;
		}
		bool flag = false;
		for (int num = features.Count - 1; num >= 0; num--)
		{
			if (features.get_Item(num).OnHitObstacle(obstacle, ref raycastHit))
			{
				flag = true;
			}
		}
		if (!flag)
		{
			_finishReason = BulletFinishReason.HitObstacle;
		}
		return flag;
	}

	public override bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!isValid)
		{
			return false;
		}
		AdventureActor component = actor.GetComponent<AdventureActor>();
		if (!component.CurrentStepCanbeHurt())
		{
			return true;
		}
		DestructibleStateSingle destructibleStateSingle = actor as DestructibleStateSingle;
		if (destructibleStateSingle == null)
		{
			return true;
		}
		if (heightClass > destructibleStateSingle.getHeight())
		{
			return true;
		}
		bool flag = false;
		bool flag2 = true;
		for (int num = features.Count - 1; num >= 0; num--)
		{
			WeaponFeature weaponFeature = features.get_Item(num);
			if (weaponFeature is WeaponFeatureCertainActorHitted)
			{
				flag2 = weaponFeature.OnHitActor(actor, ref raycastHit);
			}
			else if (weaponFeature.OnHitActor(actor, ref raycastHit))
			{
				flag = true;
			}
		}
		if (flag2)
		{
			(damaged, _, _) = component.Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		}
		else
		{
			flag = true;
		}
		if (!flag)
		{
			_finishReason = BulletFinishReason.HitDestructibleObstacle;
		}
		return flag;
	}
}
