using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[RequireComponent(typeof(Collider))]
public class AdventureWeapon : LogicEntity, IHitBoxContext
{
	public enum MultipleShootStyle
	{
		[InspectorName("单发射击")]
		OneShot,
		[InspectorName("从中心往外射击")]
		FromCenterToSide,
		[InspectorName("从外往中心射击")]
		FromSideToCenter,
		[InspectorName("从左往右射击")]
		FromLeftToRight,
		[InspectorName("从右往左射击")]
		FromRightToLeft,
		[InspectorName("随机方向射击")]
		RandomDirection
	}

	protected LogicEntity _owner;

	protected long _ownerId;

	[HideInInspector]
	public bool useOwnerActorInfo;

	public string weaponTag;

	[Space]
	public string bulletTag;

	public int hitDamageId;

	public HitBox.HitDamageIdData[] _hitdamagedatas;

	[Space]
	public HeightClass heightClass = HeightClass.Medium;

	[Space]
	public HitBox.FeatureFlag hitFlags;

	[Space]
	public HitBox.HitBoxFeatureData hitFeatureData;

	public HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small;

	[Space]
	public bool canBeBlock = true;

	[HideInInspector]
	public bool isPauseMove;

	[HideInInspector]
	public int attackRound;

	[HideInInspector]
	public int temphitDmgId;

	[SerializeField]
	[HideInInspector]
	internal int weaponHashCode;

	[SerializeField]
	[HideInInspector]
	internal int bulletHashCode;

	protected Collider collider;

	public readonly SkillSlotLevelInfo bindSkillSlotLevelInfo = new SkillSlotLevelInfo();

	public readonly AttributeList attributeList = new AttributeList();

	public Dictionary<int, FDP> attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();

	protected HitBox _hitBox;

	protected readonly Dictionary<long, FP> _hitedActors = new Dictionary<long, FP>(5);

	[HideInInspector]
	private HashSet<int> subWeaponTags;

	[HideInInspector]
	internal List<int> additionalAttrIdList;

	public GameObject prefab { get; set; }

	public LogicEntity owner
	{
		get
		{
			return _owner;
		}
		set
		{
			_owner = value;
			if (_owner != null)
			{
				_ownerId = _owner.Id;
				AdventureActor adventureActor = _owner as AdventureActor;
				if (adventureActor != null && adventureActor.isWitchTimeOwner)
				{
					ModuleController<AdventureModuleController>.Instance?.SetForzenTimeChildren(iAdd: true, this);
				}
			}
			else
			{
				_ownerId = 0L;
			}
		}
	}

	public long ownerId => _ownerId;

	public TSVector2 originPosition { get; set; }

	public TSVector2 originDirection { get; set; }

	public FP velocitySpeed { get; set; }

	public TSVector2 velocityDirection { get; set; }

	public TSVector2 velocity
	{
		get
		{
			if (!isPauseMove)
			{
				return velocityDirection * velocitySpeed;
			}
			return TSVector2.zero;
		}
	}

	public virtual bool isValid
	{
		get
		{
			if (_owner != null && _ownerId == _owner.Id)
			{
				return !((AdventureActor)_owner).isDead;
			}
			return false;
		}
	}

	[HideInInspector]
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

	public int WeaponHashCode => weaponHashCode;

	protected VisualSmooth smooth { get; private set; }

	public DeterministicCollider dtCollider { get; protected set; }

	public string DefaultWeaponTag { get; protected set; }

	public string DefaultBulletTag { get; protected set; }

	public Vector3 DefaultWeaponScale { get; protected set; }

	public HitBox hitBox => _hitBox;

	public virtual bool isShootableWeapon => false;

	public virtual bool isEquipableWeapon => false;

	public virtual bool isShield => false;

	public virtual bool isShowShadowBlob => false;

	protected override void OnInit()
	{
		base.OnInit();
		attributeList.Init();
		DeterministicCollider deterministicCollider = null;
		this.SetDeterministicCollider(ref collider, ref deterministicCollider);
		dtCollider = deterministicCollider;
		gameObject.layer = 9;
		if (dtCollider != null)
		{
			dtCollider.layer = 9;
		}
		smooth = AddOrGetMonoLogicComponent<VisualSmooth>();
		DefaultWeaponTag = weaponTag;
		DefaultWeaponScale = transform.localScale;
		attackRound = 0;
		temphitDmgId = 0;
		_hitBox = HitBox.Setup(gameObject, this, this);
		_hitBox.initHitDamageIdData(_hitdamagedatas);
		_hitBox.hitDamageId = hitDamageId;
		_hitBox.featureFlags = hitFlags;
		_hitBox.featureData = hitFeatureData;
		_hitBox.hurtAnimType = hurtAnimType;
	}

	public void ResetHitID(int _hitDamageID)
	{
		hitDamageId = _hitDamageID;
		_hitBox.hitDamageId = hitDamageId;
	}

	protected override void OnActive()
	{
		tsTransform.transformSyncEnabled = false;
	}

	protected int GetCameraShakeSort()
	{
		if (owner == null)
		{
			return 0;
		}
		if (!(owner is PlayerAdventureActor playerAdventureActor))
		{
			return 2;
		}
		if (playerAdventureActor.isAssist)
		{
			return -1;
		}
		return 1;
	}

	protected override void OnDeactive()
	{
		tsTransform.transformSyncEnabled = true;
		_hitedActors.Clear();
		prefab = null;
		owner = null;
	}

	protected override void OnLogicStart()
	{
	}

	protected override void OnLogicUpdate()
	{
	}

	public virtual void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		bindSkillSlotLevelInfo.Clear();
		AdventureActor component = owner.GetComponent<AdventureActor>();
		if (component != null)
		{
			AttributeList attributeList = (owner.IsUseHitFromSummon(out var summoner) ? summoner.attributeList : component.attributeList);
			this.attributeList.CopyValueFrom(attributeList);
			bindSkillSlotLevelInfo.CopyValueFrom(owner.GetLogicComponent<PlayerSkillCd>());
			attributeWithElementOrDamageTypeDict.Clear();
			Dictionary<int, FDP> dictionary = (owner.IsUseHitFromSummon(out summoner) ? summoner.actorInfo.attributeWithElementOrDamageTypeDict : component.actorInfo.attributeWithElementOrDamageTypeDict);
			if (dictionary != null)
			{
				foreach (KeyValuePair<int, FDP> item in dictionary)
				{
					attributeWithElementOrDamageTypeDict.Add(item.Key, item.Value);
				}
			}
			if (owner.IsPlayerSummoned(out var summoner2, out var _))
			{
				bindSkillSlotLevelInfo.CopyValueFrom(summoner2.GetLogicComponent<PlayerSkillCd>());
			}
		}
		ResetWeaponTag();
		ResetWeaponScale();
		_hitBox.hitDamageId = hitDamageId;
		additionalAttrIdList?.Clear();
		subWeaponTags?.Clear();
		attackRound = 0;
		Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		EnableLogicUpdate();
		AdventureWeaponBornEvent adventureWeaponBornEvent = AdventureWeaponBornEvent.Generate();
		adventureWeaponBornEvent.sender = this;
		adventureWeaponBornEvent.weaponTag = weaponTag;
		adventureWeaponBornEvent.owner = owner;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureWeaponBornEvent);
	}

	public virtual void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		this.owner = owner;
		Parent = owner;
		TrueSyncTransform trueSyncTransform = tsTransform;
		TSVector2 position2 = (originPosition = position);
		trueSyncTransform.Position = position2;
		TrueSyncTransform trueSyncTransform2 = tsTransform;
		position2 = (originDirection = direction);
		trueSyncTransform2.Forward = position2;
		tsTransform.PositionY = positionY;
		velocitySpeed = 0f;
		velocityDirection = originDirection;
		isPauseMove = false;
		smooth.SyncDeterministicTransform();
	}

	public virtual void Finish(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		AdventureWeaponFinishEvent adventureWeaponFinishEvent = AdventureWeaponFinishEvent.Generate();
		adventureWeaponFinishEvent.sender = this;
		adventureWeaponFinishEvent.weaponTag = weaponTag;
		adventureWeaponFinishEvent.owner = owner;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureWeaponFinishEvent);
		if (owner != null && owner is MonsterAdventureActor)
		{
			ModuleController<AdventureModuleController>.Instance?.ReduceMonsterWeapon();
		}
		gameObject.SetActive(value: false);
	}

	public void Recycle()
	{
		ModuleController<AdventureModuleController>.Instance.DespawnWeapon(this);
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

	public virtual bool CheckHitable(HitBox hitBox, LogicEntity actor)
	{
		if (!(owner == null) && (hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !owner.IsConfrontWith(actor))
		{
			return owner.IsNeutralWith(actor);
		}
		return true;
	}

	public virtual bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		_ = isValid;
		return false;
	}

	public virtual bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		if (!isValid)
		{
			return false;
		}
		_ = shield.isShield;
		return false;
	}

	public virtual bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		_ = isValid;
		return false;
	}

	public virtual bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		_ = isValid;
		return false;
	}

	public virtual void OnEquipWith()
	{
	}

	public virtual void OnEquipUpdate()
	{
	}

	public virtual void OnEquipDrop()
	{
	}

	public virtual bool iShowShadowBlob()
	{
		return false;
	}

	public void UpdateHitFeatureData(HitBox.FeatureFlag featureFlag, HitBox.HitBoxFeatureData hitBoxFeatureData)
	{
		if (featureFlag == HitBox.FeatureFlag.KnockBack)
		{
			_hitBox.featureFlags |= featureFlag;
			_hitBox.featureData.KnockBackForce = hitBoxFeatureData.KnockBackForce;
			_hitBox.featureData.KnockBackDistance = hitBoxFeatureData.KnockBackDistance;
			_hitBox.featureData.hitStrenth = hitBoxFeatureData.hitStrenth;
			_hitBox.featureData.UseAtttackForward = hitBoxFeatureData.UseAtttackForward;
			_hitBox.featureData.UseHitBoxPosition = hitBoxFeatureData.UseHitBoxPosition;
		}
	}

	public virtual void ModifyWeaponScaleByMulti(FP scaleMulti)
	{
		if (!(dtCollider == null) && !(collider == null) && !(scaleMulti == FP.Zero))
		{
			transform.localScale = DefaultWeaponScale * scaleMulti.AsFloat();
			dtCollider.LoadFromUnityCollider(collider, applyTransformScale: true);
			OnWeaponScaleChange();
		}
	}

	public void ModifyWeaponScaleByValue(FP scaleX, FP scaleY, FP scaleZ)
	{
		if (!(dtCollider == null) && !(collider == null) && !(scaleX == FP.Zero) && !(scaleY == FP.Zero) && !(scaleZ == FP.Zero))
		{
			transform.localScale = new Vector3(scaleX.AsFloat(), scaleY.AsFloat(), scaleZ.AsFloat());
			dtCollider.LoadFromUnityCollider(collider, applyTransformScale: true);
			OnWeaponScaleChange();
		}
	}

	public void ResetWeaponScale()
	{
		if (!(dtCollider == null) && !(collider == null) && !(transform.localScale == DefaultWeaponScale))
		{
			transform.localScale = DefaultWeaponScale;
			dtCollider.LoadFromUnityCollider(collider, applyTransformScale: true);
			OnWeaponScaleChange();
		}
	}

	protected virtual void OnWeaponScaleChange()
	{
	}

	public void AddSubTag(string sub_tag)
	{
		if (!string.IsNullOrEmpty(sub_tag))
		{
			int hashCode = CommonHelper.StringToHash(sub_tag);
			AddSubTag(hashCode);
		}
	}

	public void AddSubTag(int hashCode)
	{
		if (hashCode != 0)
		{
			if (subWeaponTags == null)
			{
				subWeaponTags = new HashSet<int>(5);
			}
			subWeaponTags.Add(hashCode);
		}
	}

	public void RemoveSubTag(string tag)
	{
		if (!string.IsNullOrEmpty(tag))
		{
			int hashCode = CommonHelper.StringToHash(tag);
			RemoveSubTag(hashCode);
		}
	}

	public void RemoveSubTag(int hashCode)
	{
		if (hashCode != 0)
		{
			subWeaponTags?.Remove(hashCode);
		}
	}

	public bool CheckSubTag(string tag)
	{
		if (string.IsNullOrEmpty(tag))
		{
			return false;
		}
		int hashCode = CommonHelper.StringToHash(tag);
		return CheckSubTag(hashCode);
	}

	public bool CheckSubTag(int hashCode)
	{
		if (string.IsNullOrEmpty(tag))
		{
			return false;
		}
		HashSet<int> hashSet = subWeaponTags;
		if (hashSet != null && hashSet.Count > 0)
		{
			return subWeaponTags.Contains(hashCode);
		}
		return false;
	}

	public void AddAdditionalAttr(int attrId, int count = 1)
	{
		if (attrId > 0 && count > 0)
		{
			if (additionalAttrIdList == null)
			{
				additionalAttrIdList = new List<int>(5);
			}
			for (int i = 0; i < count; i++)
			{
				additionalAttrIdList.Add(attrId);
			}
		}
	}

	public void OnWeaponTagChange()
	{
		weaponHashCode = CommonHelper.StringToHash(weaponTag);
	}

	public void OnBulletTagChange()
	{
		bulletHashCode = CommonHelper.StringToHash(bulletTag);
	}

	public void ModifyWeaponTag(string sub_tag)
	{
		if (!string.Equals(weaponTag, sub_tag))
		{
			weaponTag = sub_tag;
			OnWeaponTagChange();
		}
	}

	public void ModifyWeaponTag(int hashCode)
	{
		weaponHashCode = hashCode;
	}

	public bool CheckWeaponTag(string sub_tag)
	{
		int hashCode = CommonHelper.StringToHash(sub_tag);
		return CheckWeaponTag(hashCode);
	}

	public bool CheckWeaponTag(int hashCode)
	{
		return weaponHashCode == hashCode;
	}

	public void ResetWeaponTag()
	{
		weaponTag = DefaultWeaponTag;
		OnWeaponTagChange();
	}

	public void ModifyBulletTag(string subTag)
	{
		if (!string.Equals(bulletTag, subTag))
		{
			bulletTag = subTag;
			OnBulletTagChange();
		}
	}

	public void ModifyBulletTag(int hashCode)
	{
		bulletHashCode = hashCode;
	}

	public bool CheckBulletTag(string subTag)
	{
		int hashCode = CommonHelper.StringToHash(subTag);
		return CheckBulletTag(hashCode);
	}

	public bool CheckBulletTag(int hashCode)
	{
		return bulletHashCode == hashCode;
	}

	public void ResetBulletTag()
	{
		bulletTag = DefaultBulletTag;
		OnBulletTagChange();
	}
}
