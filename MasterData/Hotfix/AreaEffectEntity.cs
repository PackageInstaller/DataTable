using System;
using System.Collections.Generic;
using System.Linq;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/区域效果")]
public class AreaEffectEntity : LogicEntity, IHitBoxContext
{
	protected class DeterministicColliderCompare : IEqualityComparer<DeterministicCollider>
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

	public string areaTag;

	public List<string> areaChildTagList;

	public FP duration = 1;

	public bool canBeHit;

	public bool finishAfterOwnerDead;

	public bool copyBattleDataBeforeAttack;

	public HitBox.Shape hitBoxShape;

	public FP hitBoxWidth = 1f;

	public FP hitBoxLength = 1f;

	public FP hitBoxHeight = 1f;

	public FP hitBoxRadius = 1f;

	public FP hitBoxInnerRadius = 0f;

	public FP hitBoxAngle = 45f;

	public FP hitBoxRotation = 0f;

	public TSVector2 hitBoxOffset;

	public FP hitBoxOffsetY = 0f;

	public bool areaWithActorScale;

	public bool enableEarlyWarningEffect;

	public GameObject earlyWarningPrefab;

	public FP earlyWarningDuration = 1f;

	public float earlyWarningScale = 1f;

	[Space]
	public GameObject fx;

	public Transform cTrans;

	public bool effectWithActorScale;

	public float effectScale = 1f;

	public bool syncPosition = true;

	public bool syncRotation;

	public bool stopFxOnDeactive = true;

	public bool checkTargetByPosition;

	public bool shareSameDamageImmuneDuration;

	[SerializeField]
	[HideInInspector]
	internal int areaHashCode;

	[SerializeField]
	[HideInInspector]
	internal List<int> areaChildHashCodeList;

	private string originalAreaTag;

	private Vector3 orginalAreaScale;

	private long _fxToken;

	private long _earlyWarningFXToken;

	private readonly List<AreaEffect_Component> _components = new List<AreaEffect_Component>(5);

	private FP _leftTime;

	private FP _earlyWarningTime;

	public readonly AttributeList attributeList = new AttributeList();

	public readonly Dictionary<int, FDP> attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();

	public readonly SkillSlotLevelInfo bindSkillSlotLevelInfo = new SkillSlotLevelInfo();

	public Action OnBeforeEnd;

	private long _battleDataOwnerId;

	private bool _attributeListHasChanged;

	private bool _attributeWithElementOrDamageTypeHasChanged;

	private bool _SkillSlotLevelInfoHasChanged;

	private Collider _collider;

	private DeterministicCollider _dtCollider;

	protected HitBox _hitBox;

	private List<DeterministicCollider> _bulletColliderList;

	private DeterministicShape _deterministicShape;

	private VisualSmooth _smooth;

	[HideInInspector]
	public List<int> additionalAttrIdList;

	private readonly Dictionary<long, FP> _hittedEntities = new Dictionary<long, FP>(10);

	protected const int TestOverlapLayer = 164608;

	protected const int ProjectileLayer = 33280;

	protected readonly DeterministicColliderCompare _compare = new DeterministicColliderCompare();

	protected readonly List<DeterministicCollider> _lastColliderList = new List<DeterministicCollider>(16);

	protected readonly List<DeterministicCollider> _nowColliderList = new List<DeterministicCollider>(16);

	public string OriginalAreaTag
	{
		get
		{
			return originalAreaTag;
		}
		private set
		{
			originalAreaTag = value;
		}
	}

	public Vector3 OrginalAreaScale
	{
		get
		{
			return orginalAreaScale;
		}
		private set
		{
			orginalAreaScale = value;
		}
	}

	public AdventureActor owner { get; private set; }

	public AdventureFXPlayer fxPlayer { get; private set; }

	public AdventureEarlyWarningFXPlayer earlyWarningFXPlayer { get; private set; }

	public bool RunningLogic { get; private set; }

	public bool Finished { get; private set; } = true;

	internal void Setup(AdventureActor own)
	{
		owner = own;
		Parent = own;
		Finished = false;
		if (own != null)
		{
			if (owner.IsUseHitFromSummon(out var summoner))
			{
				_battleDataOwnerId = summoner.Id;
			}
			else
			{
				_battleDataOwnerId = own.Id;
			}
			CopyBattleData(force: true);
			if (own.isWitchTimeOwner)
			{
				ModuleController<AdventureModuleController>.Instance?.SetForzenTimeChildren(iAdd: true, this);
			}
		}
		else
		{
			Debug.LogError("区域效果持有者为空,实例:" + gameObject.name);
		}
		_leftTime = duration;
		EnableLogicUpdate();
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).Setup();
		}
		if (enableEarlyWarningEffect)
		{
			_earlyWarningTime = earlyWarningDuration;
			if (earlyWarningPrefab != null)
			{
				earlyWarningFXPlayer = AdventureEarlyWarningFXPlayer.PlayFX(earlyWarningPrefab, (float)earlyWarningDuration, transform.position, transform.rotation, earlyWarningScale);
				earlyWarningFXPlayer.Bind(gameObject);
				_earlyWarningFXToken = earlyWarningFXPlayer.token;
			}
		}
		else
		{
			_earlyWarningTime = 0f;
			StartLogic();
		}
		AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent = AdventureAreaEffectBeginEvent.Generate();
		adventureAreaEffectBeginEvent.sender = this;
		adventureAreaEffectBeginEvent.entityID = Id;
		adventureAreaEffectBeginEvent.owner = own;
		adventureAreaEffectBeginEvent.duration = duration;
		ModuleController<AdventureModuleController>.Instance?.DispatchEvent(adventureAreaEffectBeginEvent);
	}

	private void StartLogic()
	{
		if (fx != null)
		{
			fxPlayer = AdventureFXPlayer.PlayFX(fx, 1f, cTrans.position, cTrans.rotation, GetFxScale().AsFloat());
			fxPlayer.Bind(gameObject);
			fxPlayer.useCustomInheritOptions = true;
			_fxToken = fxPlayer.token;
		}
		if (earlyWarningFXPlayer != null && earlyWarningFXPlayer.token == _earlyWarningFXToken)
		{
			earlyWarningFXPlayer.Complete();
		}
		earlyWarningFXPlayer = null;
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).StartLogic();
		}
		RunningLogic = true;
	}

	public bool CheckTarget(LogicEntity target, TargetType targetType)
	{
		if (owner == null || target == null)
		{
			return false;
		}
		return owner.CheckTarget(target, targetType);
	}

	public T GetAreaEffectComponent<T>(int index = 0) where T : AreaEffect_Component
	{
		Type typeFromHandle = typeof(T);
		int num = 0;
		for (int i = 0; i < _components.Count; i++)
		{
			AreaEffect_Component areaEffect_Component = _components.get_Item(i);
			if (typeFromHandle.IsInstanceOfType(areaEffect_Component))
			{
				if (num == index)
				{
					return (T)areaEffect_Component;
				}
				num++;
			}
		}
		return null;
	}

	internal void Finish()
	{
		Finished = true;
	}

	private void CurrentFinish()
	{
		if (Finished)
		{
			TriggerFinish();
			AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = AdventureAreaEffectFinishEvent.Generate();
			adventureAreaEffectFinishEvent.sender = this;
			adventureAreaEffectFinishEvent.entityID = Id;
			adventureAreaEffectFinishEvent.owner = owner;
			adventureAreaEffectFinishEvent.durationEnd = _leftTime <= 0;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureAreaEffectFinishEvent);
			OnBeforeEnd?.Invoke();
			ActiveSelf = false;
		}
	}

	internal void Recycle()
	{
		SceneSingleton<AreaEffectManager>.Instance.Despawn(this);
	}

	protected override void OnInit()
	{
		base.OnInit();
		attributeList.Init();
		gameObject.layer = 17;
		OriginalAreaTag = areaTag;
		OrginalAreaScale = transform.localScale;
		if (_smooth == null)
		{
			_smooth = AddOrGetMonoLogicComponent<VisualSmooth>();
		}
		InitCollider();
		if (_hitBox == null)
		{
			_hitBox = HitBox.Setup(gameObject, this, this);
		}
		if (cTrans == null)
		{
			cTrans = transform;
		}
		AreaEffect_Component[] components = GetComponents<AreaEffect_Component>();
		foreach (AreaEffect_Component areaEffect_Component in components)
		{
			AddLogicComponent(areaEffect_Component);
			_components.Add(areaEffect_Component);
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ATTRIBUTELIST_CHANGED", OnAttributeListChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ATTRIBUTEWITHELEMENTORDAMAGETYPE_CHANGED", OnAttributeWithElementOrDamageTypeChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_SKILLSLOTLEVELINFO_CHANGED", OnSkillSlotLevelInfoChange);
	}

	private void OnAttributeListChange(IEvent evt)
	{
		if (evt is AdventureActorAttributeListChangeEvent { sender: AdventureActor sender } && sender.Id == _battleDataOwnerId)
		{
			_attributeListHasChanged = true;
		}
	}

	private void OnAttributeWithElementOrDamageTypeChange(IEvent evt)
	{
		if (evt is AdventureActorAttributeWithElementOrDamageTypeChangeEvent { sender: AdventureActor sender } && sender.Id == _battleDataOwnerId)
		{
			_attributeWithElementOrDamageTypeHasChanged = true;
		}
	}

	private void OnSkillSlotLevelInfoChange(IEvent evt)
	{
		if (evt is AdventureActorSkillSlotLevelInfoChangeEvent { sender: AdventureActor sender } && (owner.IsPlayerSummoned(out var summoner, out var _) ? summoner : owner) == sender)
		{
			_SkillSlotLevelInfoHasChanged = true;
		}
	}

	protected override void OnLogicUpdate()
	{
		if (owner != null && finishAfterOwnerDead && owner.IsDead())
		{
			Finish();
		}
		if (!RunningLogic && _earlyWarningTime > 0f)
		{
			_earlyWarningTime -= LogicDeltaTime;
			if (_earlyWarningTime <= 0f)
			{
				StartLogic();
			}
		}
		else
		{
			TestOverLap();
			if (_components.FindAll((AreaEffect_Component component) => component.FinishAreaEffect).Count > 0)
			{
				Finish();
			}
			_leftTime -= LogicDeltaTime;
			if (_leftTime <= 0)
			{
				Finish();
			}
		}
		if (Finished)
		{
			CurrentFinish();
		}
	}

	public void SyncPositionY(FP positionY, bool withGround = false)
	{
		if (withGround)
		{
			tsTransform.PositionY = CommonHelper.GetTerrainHeight(tsTransform.Position, positionY);
		}
		else
		{
			tsTransform.PositionY = positionY;
		}
	}

	protected override void OnVisualUpdate()
	{
		SyncFx();
		SyncEarlyWarningFx();
	}

	public void SyncFx()
	{
		if (!(fxPlayer == null))
		{
			if (syncPosition)
			{
				fxPlayer.transform.position = cTrans.position;
			}
			if (syncRotation)
			{
				fxPlayer.transform.rotation = cTrans.rotation;
			}
		}
	}

	public void SyncEarlyWarningFx()
	{
		if (!(earlyWarningFXPlayer == null))
		{
			if (syncPosition)
			{
				earlyWarningFXPlayer.transform.position = cTrans.position;
			}
			if (syncRotation)
			{
				earlyWarningFXPlayer.transform.rotation = cTrans.rotation;
			}
		}
	}

	public FP GetLeftTime()
	{
		return _leftTime;
	}

	public void AddLeftTime(FP value)
	{
		_leftTime += value;
		if (_leftTime <= 0)
		{
			Finish();
		}
	}

	public void ModifyLeftTime(FP value)
	{
		_leftTime = value;
		if (_leftTime <= 0)
		{
			Finish();
		}
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ATTRIBUTELIST_CHANGED", OnAttributeListChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ATTRIBUTEWITHELEMENTORDAMAGETYPE_CHANGED", OnAttributeWithElementOrDamageTypeChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_SKILLSLOTLEVELINFO_CHANGED", OnSkillSlotLevelInfoChange);
		DisableLogicUpdate();
		RunningLogic = false;
		Finished = true;
		_leftTime = 0f;
		if (fxPlayer != null && stopFxOnDeactive && fxPlayer.token == _fxToken)
		{
			fxPlayer.Stop();
		}
		fxPlayer = null;
		ResetScale(force: true);
		_hittedEntities.Clear();
		_lastColliderList.Clear();
		_nowColliderList.Clear();
		_bulletColliderList?.Clear();
		bindSkillSlotLevelInfo.Clear();
		additionalAttrIdList?.Clear();
		_battleDataOwnerId = 0L;
		_attributeListHasChanged = false;
		_attributeWithElementOrDamageTypeHasChanged = false;
		_SkillSlotLevelInfoHasChanged = false;
		earlyWarningFXPlayer = null;
		_earlyWarningTime = 0f;
		OnBeforeEnd = null;
		owner = null;
	}

	private void InitCollider()
	{
		if (canBeHit)
		{
			if (hitBoxShape == HitBox.Shape.Rectangle)
			{
				_collider = gameObject.AddOrGetComponent<BoxCollider>();
			}
			else
			{
				_collider = gameObject.AddOrGetComponent<SphereCollider>();
			}
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
		if (_dtCollider == null || _collider == null)
		{
			return;
		}
		if (hitBoxShape == HitBox.Shape.Rectangle)
		{
			BoxCollider boxCollider = _collider as BoxCollider;
			if (boxCollider != null)
			{
				boxCollider.center = new Vector3(hitBoxOffset.x.AsFloat(), hitBoxOffsetY.AsFloat(), hitBoxOffset.y.AsFloat());
				boxCollider.size = new Vector3(GetAreaWidth().AsFloat(), GetAreaHeight().AsFloat(), GetAreaLength().AsFloat());
			}
		}
		else
		{
			SphereCollider sphereCollider = _collider as SphereCollider;
			if (sphereCollider != null)
			{
				sphereCollider.center = new Vector3(hitBoxOffset.x.AsFloat(), hitBoxOffsetY.AsFloat(), hitBoxOffset.y.AsFloat());
				sphereCollider.radius = GetAreaRadius().AsFloat();
			}
		}
		_dtCollider.LoadFromUnityCollider(_collider);
	}

	public void ChangeCollisionState(bool ignoreCollision)
	{
		if (!canBeHit || _dtCollider == null)
		{
			Debug.LogError("该区域效果不可被命中,请检查配置,区域效果名称:" + name);
		}
		else if (_dtCollider.IgnoreCollision != ignoreCollision)
		{
			_dtCollider.IgnoreCollision = ignoreCollision;
		}
	}

	public void Hit(int hitDamageId, HitBox.FeatureFlag hitFlags, HitBox.HitBoxFeatureData hitFeatureData, HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small, GameObject hittedEffectPrefab = null, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true, FP damageImmuneDuration = default(FP), bool haveFeedbackEffect = false, AdventurePlayerFeedbackEffectConfigureData playerfeedbackEffectConfigureData = null, IHitBoxContext context = null)
	{
		if (!(owner == null))
		{
			if (copyBattleDataBeforeAttack)
			{
				CopyBattleData();
			}
			_hitBox.hitDamageId = hitDamageId;
			_hitBox.featureFlags = hitFlags;
			_hitBox.featureData = hitFeatureData;
			_hitBox.hurtAnimType = hurtAnimType;
			_hitBox.context = context ?? this;
			FP areaWidth = GetAreaWidth();
			FP areaLength = GetAreaLength();
			FP areaRadius = GetAreaRadius();
			FP areaInnerRadius = GetAreaInnerRadius();
			FP angle = hitBoxAngle;
			TSVector2 hitPos = GetHitPos();
			FP hitRot = GetHitRot();
			int uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
			int hittedCount;
			int damageCount;
			switch (hitBoxShape)
			{
			case HitBox.Shape.Rectangle:
				_hitBox.RectangleAreaHit(areaWidth, areaLength, hitPos, hitRot, out hittedCount, out damageCount, uniqueAttackId, hittedEffectPrefab, isHittedEffectScale, -5, damageImmuneDuration, randomHit: false, null, effectIgnoreTimeScale);
				break;
			case HitBox.Shape.Circle:
				_hitBox.CircleAreaHit(areaRadius, areaInnerRadius, hitPos, out hittedCount, out damageCount, uniqueAttackId, hittedEffectPrefab, isHittedEffectScale, -5, damageImmuneDuration, randomHit: false, effectIgnoreTimeScale);
				break;
			case HitBox.Shape.Fan:
				_hitBox.FanAreaHit(angle, areaRadius, areaInnerRadius, hitPos, hitRot, out hittedCount, out damageCount, uniqueAttackId, hittedEffectPrefab, isHittedEffectScale, damageImmuneDuration, effectIgnoreTimeScale);
				break;
			default:
				damageCount = 0;
				break;
			}
			if (haveFeedbackEffect && damageCount > 0)
			{
				PlayFeedbackEffect(playerfeedbackEffectConfigureData, hitPos, GetHitPosY());
			}
		}
	}

	public void HitWithOwnerRadius(FP radiusAmend, int hitDamageId, HitBox.FeatureFlag hitFlags, HitBox.HitBoxFeatureData hitFeatureData, HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small, GameObject hittedEffectPrefab = null, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true, FP damageImmuneDuration = default(FP), bool haveFeedbackEffect = false, AdventurePlayerFeedbackEffectConfigureData playerfeedbackEffectConfigureData = null, IHitBoxContext context = null)
	{
		if (owner == null)
		{
			return;
		}
		if (copyBattleDataBeforeAttack)
		{
			CopyBattleData();
		}
		_hitBox.hitDamageId = hitDamageId;
		_hitBox.featureFlags = hitFlags;
		_hitBox.featureData = hitFeatureData;
		_hitBox.hurtAnimType = hurtAnimType;
		_hitBox.context = context ?? this;
		FP fP = owner.dtCollider.Radius + radiusAmend;
		if (!(fP <= 0))
		{
			TSVector2 hitPos = GetHitPos();
			int uniqueAttackId = SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId();
			_hitBox.CircleAreaHit(fP, 0, hitPos, out var _, out var damageCount, uniqueAttackId, hittedEffectPrefab, isHittedEffectScale, -5, damageImmuneDuration, randomHit: false, effectIgnoreTimeScale);
			if (haveFeedbackEffect && damageCount > 0)
			{
				PlayFeedbackEffect(playerfeedbackEffectConfigureData, hitPos, GetHitPosY());
			}
		}
	}

	public void Damage(AdventureActor target, int hitDamageId, HitBox.FeatureFlag hitFlags, HitBox.HitBoxFeatureData hitFeatureData, HitBox.HurtAnimType hurtAnimType = HitBox.HurtAnimType.Small, GameObject hittedEffectPrefab = null, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true, FP damageImmuneDuration = default(FP), bool haveFeedbackEffect = false, AdventurePlayerFeedbackEffectConfigureData playerfeedbackEffectConfigureData = null, IHitBoxContext context = null)
	{
		if (target.actorHealthInfo.isAlive)
		{
			if (copyBattleDataBeforeAttack)
			{
				CopyBattleData();
			}
			_hitBox.hitDamageId = hitDamageId;
			_hitBox.featureFlags = hitFlags;
			_hitBox.featureData = hitFeatureData;
			_hitBox.hurtAnimType = hurtAnimType;
			_hitBox.context = context ?? this;
			DeterministicRaycastHit raycastHit = new DeterministicRaycastHit
			{
				isValid = false
			};
			_hitBox.HitSingleTarget(SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), target.dtCollider, out var _, out var damaged, ref raycastHit, hittedEffectPrefab, isHittedEffectScale, damageImmuneDuration, 1, effectIgnoreTimeScale);
			if (haveFeedbackEffect & damaged)
			{
				PlayFeedbackEffect(playerfeedbackEffectConfigureData, target.tsTransform.Position, target.tsTransform.PositionY);
			}
		}
	}

	public void PlayFeedbackEffect(AdventurePlayerFeedbackEffectConfigureData playerfeedbackEffectConfigureData, TSVector2? position = null, FP? positionY = null)
	{
		if (!(playerfeedbackEffectConfigureData == null))
		{
			TSVector2 tSVector = position ?? GetHitPos();
			FP fP = positionY ?? GetHitPosY();
			Vector3 effectPosition = new Vector3(tSVector.x.AsFloat(), fP.AsFloat(), tSVector.y.AsFloat());
			playerfeedbackEffectConfigureData.Play(effectPosition, gameObject, GetCameraShakeSort());
		}
	}

	private int GetCameraShakeSort()
	{
		if (owner == null)
		{
			return 0;
		}
		if (owner is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor.isAssist)
			{
				return -1;
			}
			return 1;
		}
		return 2;
	}

	public void BlockBullet(TargetFilterCriteriaInfo criteriaInfo, GameObject blockFinishFx, int filterTargetTag = 0)
	{
		if (_bulletColliderList == null)
		{
			_bulletColliderList = new List<DeterministicCollider>(10);
		}
		_bulletColliderList.Clear();
		DeterministicCollision(_bulletColliderList, 33280, filterTargetTag);
		for (int i = 0; i < _bulletColliderList.Count; i++)
		{
			AdventureWeapon adventureWeapon = _bulletColliderList.get_Item(i).Entity as AdventureWeapon;
			if (adventureWeapon.canBeBlock && CheckTarget(adventureWeapon.owner, criteriaInfo))
			{
				if (blockFinishFx != null)
				{
					AdventureFXPlayer.PlayFX(blockFinishFx, (float)logicTimeScale, adventureWeapon.transform.position, adventureWeapon.transform.rotation);
				}
				adventureWeapon.Finish(cancel: true);
			}
		}
	}

	public void DeterministicCollision(List<DeterministicCollider> result, int layer, int filterTargetTag = 0)
	{
		if (result == null)
		{
			result = new List<DeterministicCollider>(16);
		}
		result.Clear();
		_ = _deterministicShape;
		DeterministicShape.ShapeType shapeType = hitBoxShape switch
		{
			HitBox.Shape.Rectangle => DeterministicShape.ShapeType.Rectangle, 
			HitBox.Shape.Circle => DeterministicShape.ShapeType.Circle, 
			HitBox.Shape.Fan => DeterministicShape.ShapeType.Fan, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		_deterministicShape.shapeType = shapeType;
		_deterministicShape.position = GetHitPos();
		_deterministicShape.rotation = GetHitRot();
		_deterministicShape.width = GetAreaWidth();
		_deterministicShape.length = GetAreaLength();
		_deterministicShape.radius = GetAreaRadius();
		_deterministicShape.innerRadius = GetAreaInnerRadius();
		_deterministicShape.angle = hitBoxAngle;
		bool drawGizmos = false;
		if (checkTargetByPosition)
		{
			SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShapeForPoint(result, _deterministicShape, layer, drawGizmos);
		}
		else
		{
			SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(result, _deterministicShape, layer, drawGizmos);
		}
		if (filterTargetTag != 0)
		{
			result.RemoveAll((DeterministicCollider collider) => collider.Entity is AdventureActor adventureActor && !adventureActor.CheckTag(filterTargetTag));
		}
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).OnDeterministicCollisionEnter(other);
		}
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = AdventureAreaEnterExitEvent.Generate();
		adventureAreaEnterExitEvent.sender = this;
		adventureAreaEnterExitEvent.owner = owner;
		adventureAreaEnterExitEvent.triggerCollider = other;
		adventureAreaEnterExitEvent.iEnter = true;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureAreaEnterExitEvent);
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).OnDeterministicCollisionStay(other);
		}
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).OnDeterministicCollisionExit(other);
		}
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = AdventureAreaEnterExitEvent.Generate();
		adventureAreaEnterExitEvent.sender = this;
		adventureAreaEnterExitEvent.owner = owner;
		adventureAreaEnterExitEvent.triggerCollider = other;
		adventureAreaEnterExitEvent.iEnter = false;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureAreaEnterExitEvent);
	}

	public bool CheckEntitySearchable(LogicEntity entity)
	{
		if (entity == null)
		{
			return false;
		}
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return false;
		}
		if (!adventureActor.IsSearchableByEnemy(owner))
		{
			return adventureActor.IsSearchableByFriend(owner);
		}
		return true;
	}

	public void ModifyScale(FP scaleMulti)
	{
		if (!(scaleMulti == FP.Zero))
		{
			transform.localScale = OrginalAreaScale * scaleMulti.AsFloat();
			OnScaleChange();
		}
	}

	public void ResetScale(bool force = false)
	{
		if (force || !(transform.localScale == OrginalAreaScale))
		{
			transform.localScale = OrginalAreaScale;
			OnScaleChange();
		}
	}

	private void OnScaleChange()
	{
		if (fxPlayer != null)
		{
			fxPlayer.sizeScale = GetFxScale().AsFloat();
		}
		if (_dtCollider != null && _collider != null)
		{
			UpdateColliderShape();
		}
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).OnAreaScaleChange();
		}
	}

	private FP GetOwnerScale()
	{
		FP result = 1;
		if (owner != null && owner.actorScaleInfo != null)
		{
			result = owner.actorScaleInfo.modelScale;
		}
		return result;
	}

	private FP GetFxScale()
	{
		if (!effectWithActorScale)
		{
			return transform.localScale.x * effectScale;
		}
		return transform.localScale.x * GetOwnerScale();
	}

	public FP GetAreaScale()
	{
		if (!areaWithActorScale)
		{
			return transform.localScale.x;
		}
		return transform.localScale.x * GetOwnerScale();
	}

	public FP GetAreaWidth()
	{
		if (hitBoxShape != HitBox.Shape.Rectangle)
		{
			return 0;
		}
		return hitBoxWidth * GetAreaScale();
	}

	public FP GetAreaLength()
	{
		if (hitBoxShape != HitBox.Shape.Rectangle)
		{
			return 0;
		}
		return hitBoxLength * GetAreaScale();
	}

	public FP GetAreaHeight()
	{
		if (hitBoxShape != HitBox.Shape.Rectangle)
		{
			return 0;
		}
		return hitBoxHeight * GetAreaScale();
	}

	public FP GetAreaRadius()
	{
		if (hitBoxShape == HitBox.Shape.Rectangle)
		{
			return 0;
		}
		return hitBoxRadius * GetAreaScale();
	}

	public FP GetAreaInnerRadius()
	{
		if (hitBoxShape == HitBox.Shape.Rectangle)
		{
			return 0;
		}
		return hitBoxInnerRadius * GetAreaScale();
	}

	public TSVector2 GetHitPos()
	{
		TSVector2 point = hitBoxOffset * GetAreaScale();
		return tsTransform.TransformLocalPointToWorldSpace(point);
	}

	public FP GetHitPosY()
	{
		FP fP = hitBoxOffsetY * GetAreaScale();
		return tsTransform.PositionY + fP;
	}

	public FP GetHitRot()
	{
		FP fP = hitBoxRotation;
		return tsTransform.Rotation + fP;
	}

	public void EnableSmooth()
	{
		if (tsTransform.transformSyncEnabled)
		{
			_smooth?.SyncDeterministicTransform();
			tsTransform.transformSyncEnabled = false;
		}
	}

	public void DisableSmooth()
	{
		if (!tsTransform.transformSyncEnabled)
		{
			_smooth?.SyncDeterministicTransform();
			tsTransform.transformSyncEnabled = true;
		}
	}

	public void CopyBattleData(bool force = false)
	{
		if (_attributeListHasChanged | force)
		{
			CopyAttributeList();
		}
		if (_attributeWithElementOrDamageTypeHasChanged | force)
		{
			CopyAttributeWithElementOrDamageType();
		}
		if (_SkillSlotLevelInfoHasChanged | force)
		{
			CopySkillSlotLevelInfo();
		}
	}

	private void CopyAttributeList()
	{
		if (!(owner == null))
		{
			if (owner.IsUseHitFromSummon(out var summoner))
			{
				attributeList.CopyValueFrom(summoner.attributeList);
			}
			else
			{
				attributeList.CopyValueFrom(owner.attributeList);
			}
			_attributeListHasChanged = false;
		}
	}

	private void CopyAttributeWithElementOrDamageType()
	{
		if (owner == null)
		{
			return;
		}
		attributeWithElementOrDamageTypeDict.Clear();
		Dictionary<int, FDP> dictionary = (owner.IsUseHitFromSummon(out var summoner) ? summoner.actorInfo.attributeWithElementOrDamageTypeDict : owner.actorInfo.attributeWithElementOrDamageTypeDict);
		if (dictionary != null && dictionary.Count > 0)
		{
			foreach (KeyValuePair<int, FDP> item in dictionary)
			{
				attributeWithElementOrDamageTypeDict.Add(item.Key, item.Value);
			}
		}
		_attributeWithElementOrDamageTypeHasChanged = false;
	}

	private void CopySkillSlotLevelInfo()
	{
		if (!(owner == null))
		{
			if (owner.IsPlayerSummoned(out var summoner, out var _))
			{
				bindSkillSlotLevelInfo.CopyValueFrom(summoner.GetLogicComponent<PlayerSkillCd>());
			}
			else
			{
				bindSkillSlotLevelInfo.CopyValueFrom(owner.GetLogicComponent<PlayerSkillCd>());
			}
			_SkillSlotLevelInfoHasChanged = false;
		}
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

	public void ClearHittedRecord()
	{
		_hittedEntities.Clear();
	}

	public FP QueryHitBoxContextTime()
	{
		if (shareSameDamageImmuneDuration)
		{
			return LockStepManager.time;
		}
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
		if (!((!shareSameDamageImmuneDuration) ? _hittedEntities.TryGetValue(entityId, out var value) : SceneSingleton<AreaEffectManager>.Instance.QueryActorHitedTimeoutByGroup(this, entityId, out value)))
		{
			return true;
		}
		return QueryHitBoxContextTime() > value + timeout;
	}

	public void SetActorHitedTime(long entityId, FP time)
	{
		if (shareSameDamageImmuneDuration)
		{
			SceneSingleton<AreaEffectManager>.Instance.SetActorHitedTimeToGroup(this, entityId, time);
		}
		else
		{
			_hittedEntities.set_Item(entityId, time);
		}
	}

	public bool CheckHitable(HitBox hitBox, LogicEntity entity)
	{
		if (!(owner == null) && (hitBox.featureFlags & HitBox.FeatureFlag.NoDiffDamage) != HitBox.FeatureFlag.NoDiffDamage && !owner.IsConfrontWith(entity))
		{
			return owner.IsNeutralWith(entity);
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
		(damaged, _, _) = (entity as AdventureActor).Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
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
		AdventureActor adventureActor = entity as AdventureActor;
		if (!adventureActor.CurrentStepCanbeHurt())
		{
			return true;
		}
		(damaged, _, _) = adventureActor.Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}

	public void OnAreaTagChange()
	{
		areaHashCode = CommonHelper.StringToHash(areaTag);
		if (string.IsNullOrEmpty(areaTag))
		{
			shareSameDamageImmuneDuration = false;
		}
	}

	public void OnAreaChildTagChange()
	{
		List<string> list = areaChildTagList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		if (areaChildHashCodeList == null)
		{
			areaChildHashCodeList = new List<int>();
		}
		areaChildHashCodeList.Clear();
		foreach (string areaChildTag in areaChildTagList)
		{
			areaChildHashCodeList.Add(CommonHelper.StringToHash(areaChildTag));
		}
	}

	protected void TestOverLap()
	{
		DeterministicCollision(_nowColliderList, 164608);
		TriggerEnter();
		TriggerStay();
		TriggerExit();
		_lastColliderList.Clear();
		_lastColliderList.AddRange(_nowColliderList);
	}

	protected void TriggerEnter()
	{
		List<DeterministicCollider> list = _nowColliderList.Except(_lastColliderList, _compare).ToList();
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i).Entity != null && list.get_Item(i).Entity.Id != Id)
			{
				OnDeterministicCollisionEnter(list.get_Item(i));
			}
		}
	}

	protected void TriggerStay()
	{
		List<DeterministicCollider> list = _nowColliderList.Intersect(_lastColliderList, _compare).ToList();
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i).Entity != null && list.get_Item(i).Entity.Id != Id)
			{
				OnDeterministicCollisionStay(list.get_Item(i));
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
				OnDeterministicCollisionExit(list.get_Item(i));
			}
		}
	}

	protected void TriggerFinish()
	{
		for (int i = 0; i < _nowColliderList.Count; i++)
		{
			if (_nowColliderList.get_Item(i).Entity != null && _nowColliderList.get_Item(i).Entity.Id != Id)
			{
				OnDeterministicCollisionExit(_nowColliderList.get_Item(i));
			}
		}
	}

	public void ModifyTag(string tag1)
	{
		if (!string.Equals(areaTag, tag1))
		{
			areaTag = tag1;
			OnAreaTagChange();
		}
	}

	public void ModifyTag(int hashCode)
	{
		areaHashCode = hashCode;
	}

	public bool CheckTag(string tag1)
	{
		int hashCode = CommonHelper.StringToHash(tag1);
		return CheckTag(hashCode);
	}

	public bool CheckTag(int hashCode)
	{
		return areaHashCode == hashCode;
	}

	public void ResetTag()
	{
		areaTag = OriginalAreaTag;
		OnAreaTagChange();
	}

	public void AddChildTag(string tag1)
	{
		if (areaChildTagList == null)
		{
			areaChildTagList = new List<string>();
		}
		areaChildTagList.Add(tag1);
		OnAreaChildTagChange();
	}

	public void AddChildTag(int hashCode)
	{
		if (areaChildHashCodeList == null)
		{
			areaChildHashCodeList = new List<int>();
		}
		areaChildHashCodeList.Add(hashCode);
	}

	public void RemoveChildTag(string tag1)
	{
		areaChildTagList?.Remove(tag1);
		OnAreaChildTagChange();
	}

	public void RemoveChildTag(int hashCode)
	{
		areaChildHashCodeList?.Remove(hashCode);
	}

	public void ClearChildTag()
	{
		areaChildTagList?.Clear();
		OnAreaChildTagChange();
	}

	public bool CheckChildTag(string tag1)
	{
		if (string.IsNullOrEmpty(tag1))
		{
			return false;
		}
		int hashCode = CommonHelper.StringToHash(tag1);
		return CheckChildTag(hashCode);
	}

	public bool CheckChildTag(int hashCode)
	{
		List<int> list = areaChildHashCodeList;
		if (list != null && list.Count > 0)
		{
			return areaChildHashCodeList.Contains(hashCode);
		}
		return false;
	}

	public bool CheckTarget(LogicEntity target, TargetFilterCriteriaInfo filterCriteriaInfo = null)
	{
		if (owner == null || target == null)
		{
			return false;
		}
		return filterCriteriaInfo?.CheckFilterCriteria(owner, target) ?? true;
	}
}
