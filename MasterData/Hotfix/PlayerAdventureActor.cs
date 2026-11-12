using System;
using System.Collections.Generic;
using Nova.Hotfix;
using Pathfinding.RVO;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Actor/Player Actor")]
public class PlayerAdventureActor : AdventureActor, IActorBehaviourState
{
	[Serializable]
	public class SerializableDictionary<TKey, TValue> : Dictionary<TKey, TValue>, ISerializationCallbackReceiver
	{
		[SerializeField]
		private List<TKey> keys = new List<TKey>();

		[SerializeField]
		private List<TValue> values = new List<TValue>();

		public void OnBeforeSerialize()
		{
			keys.Clear();
			keys.AddRange(Keys);
			values.Clear();
			values.AddRange(Values);
		}

		public void OnAfterDeserialize()
		{
			Clear();
			if (keys != null && values != null && keys.Count == values.Count)
			{
				for (int i = 0; i < keys.Count; i++)
				{
					Add(keys.get_Item(i), values.get_Item(i));
				}
			}
		}
	}

	public const string StandaloneModeGroupID = "STANDALONE_PLAYER_ACTOR_GROUP";

	[Space]
	public AdventureLevelObjPoolMgr.PoolObj spawnPoolObj;

	[Space]
	public PlayerSkillCd playerSkillCd;

	[Space]
	public PlayerAIInfo playerAIInfo;

	[Space]
	public bool isAssist;

	[Space]
	public bool isAssistAIFinish;

	[Space]
	public AdventureActor assistWitchTimeTarget;

	[Space]
	public bool isResident;

	[Space]
	public bool isResidentAssist;

	[Space]
	public bool isAssistStartLeave;

	[Space]
	public bool isAssistLeaving;

	[Space]
	public ActorStatus status;

	[Space]
	public FP specialStatusTime = 0;

	[Space]
	public PlayerActorSearchType searchType;

	[Space]
	public PlayerActorMoveType moveControlType;

	[Space]
	public bool enableReload;

	[Space]
	public bool enableIndependentRushSkill;

	[Space]
	public bool isSkin;

	[Space]
	public ComboGroup comboGroupForSkin;

	public Dictionary<string, ComboClip> overrideComboClipsForSkin;

	public bool isPreventNormalAttackByObstacle;

	public bool isBornForceMove;

	private readonly AttributeEntry[] playerEntries = new AttributeEntry[3];

	public readonly AttributeList attributeListOfInitialSnapshot = new AttributeList();

	public Dictionary<int, FDP> attributeWithElementOrDamageTypeDictOfInitialSnapshot;

	public Action dodgeSkillActivationEndEvent;

	private Dictionary<ActionKey, ActionCondition> _actionConditionDict;

	protected bool _movementHasInput;

	protected TSVector2 _movementInputVector;

	[Space]
	public bool dodgeButtonHold;

	public bool switchToRush;

	private IEvent _evt;

	private bool enterElevator;

	private Transform elevatorFloor;

	public SerializableDictionary<string, string> localData;

	private static readonly Color color1 = new Color(0.9f, 0f, 0.9f);

	private static readonly Color color2 = new Color(0.6f, 0f, 0.6f);

	private static readonly Color color3 = new Color(0f, 0.9f, 0.9f);

	private static readonly Color color4 = new Color(0f, 0.6f, 0.6f);

	private static readonly Color color5 = new Color(0f, 0.73f, 0.07f);

	private readonly List<TSVector> points = new List<TSVector>();

	private static readonly List<PlayerAdventureActor> _activeInstances = new List<PlayerAdventureActor>();

	public FDP frontEnergyConvertRatio => GetAttributeValue(HotfixEnum.playerAttributeType.FRONT_ADD_ENERGY);

	public FDP energyConvertRatio => GetAttributeValue(HotfixEnum.playerAttributeType.ADD_ENERGY);

	public bool canInput
	{
		get
		{
			ActorHealthInfo actorHealthInfo = base.actorHealthInfo;
			if (actorHealthInfo != null && actorHealthInfo.isAlive && logicUpdateEnabled)
			{
				return isControllable;
			}
			return false;
		}
	}

	public TSVector2 MovementInputDirection { get; protected set; }

	public bool actived { get; protected set; }

	bool IActorBehaviourState.DodgeButtonHold => dodgeButtonHold;

	bool IActorBehaviourState.OnHurtAudioCD => onHurtAudioCD;

	public void SetActionCondition(ActionKey key, bool canCast, FP holdTime)
	{
		if (_actionConditionDict == null)
		{
			_actionConditionDict = new Dictionary<ActionKey, ActionCondition>();
		}
		if (_actionConditionDict.TryGetValue(key, out var value))
		{
			value.CanCast = canCast;
			value.HoldTime = holdTime;
		}
		else
		{
			_actionConditionDict.set_Item(key, new ActionCondition(canCast, holdTime));
		}
	}

	public void SetActionCondition(ActionKey key, bool canCast)
	{
		if (_actionConditionDict == null)
		{
			_actionConditionDict = new Dictionary<ActionKey, ActionCondition>();
		}
		if (_actionConditionDict.TryGetValue(key, out var value))
		{
			value.CanCast = canCast;
		}
		else
		{
			_actionConditionDict.set_Item(key, new ActionCondition(canCast, 0));
		}
	}

	public void SetActionCondition(ActionKey key, FP holdTime)
	{
		if (_actionConditionDict == null)
		{
			_actionConditionDict = new Dictionary<ActionKey, ActionCondition>();
		}
		if (_actionConditionDict.TryGetValue(key, out var value))
		{
			value.HoldTime = holdTime;
		}
		else
		{
			_actionConditionDict.set_Item(key, new ActionCondition(canCast: true, holdTime));
		}
	}

	public bool CheckActionCondition(ActionKey key)
	{
		if (_actionConditionDict == null)
		{
			return true;
		}
		if (_actionConditionDict.TryGetValue(key, out var value))
		{
			return value.CanCast;
		}
		return true;
	}

	public FP GetActionHoldTime(ActionKey key)
	{
		if (_actionConditionDict == null)
		{
			return 0;
		}
		if (_actionConditionDict.TryGetValue(key, out var value))
		{
			return value.HoldTime;
		}
		return 0;
	}

	public FDP GetAttributeValue(HotfixEnum.playerAttributeType type)
	{
		if (type == HotfixEnum.playerAttributeType.MAX)
		{
			return FDP.Zero;
		}
		return playerEntries[(int)type].AmendValue;
	}

	public void SetOriginIntValue(HotfixEnum.playerAttributeType type, int val, FDP ratio)
	{
		if (type != HotfixEnum.playerAttributeType.MAX)
		{
			playerEntries[(int)type].SetOrigin(val * ratio);
		}
	}

	public void SetOriginIntFloatValue(HotfixEnum.playerAttributeType type, int val, FDP ratio)
	{
		if (type != HotfixEnum.playerAttributeType.MAX)
		{
			playerEntries[(int)type].SetOrigin(FDP.FromMyriad(val) * ratio);
		}
	}

	public void ChangePlayerAttrValue(int firstSubType, int secondSubType, FDP value)
	{
		if (firstSubType != 3)
		{
			playerEntries[firstSubType].ChangeValue((HotfixEnum.parameterType)secondSubType, value);
		}
	}

	public void SavePlayerAttributeSnapshot()
	{
		attributeListOfInitialSnapshot.CopyOwnerValue(attributeList, FDP.One);
		if (actorInfo.attributeWithElementOrDamageTypeDict != null)
		{
			attributeWithElementOrDamageTypeDictOfInitialSnapshot = new Dictionary<int, FDP>(actorInfo.attributeWithElementOrDamageTypeDict);
		}
	}

	protected override void OnInit()
	{
		base.OnInit();
		playerSkillCd = AddOrGetLogicComponent<PlayerSkillCd>();
		playerAIInfo = AddOrGetLogicComponent<PlayerAIInfo>();
		dtCollider.priority = 1;
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure_Player");
	}

	protected override void OnActive()
	{
		base.OnActive();
		_activeInstances.Add(this);
		InitData();
		movAgent.iPlayer = true;
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		instance?.AddEventListener("ADVENTURE_ACTOR_LOSTCONTROL", OnActorLostControl);
		instance?.AddEventListener("ACTOR_ACCESS_ELEVATOR", OnAccessElevator);
		instance?.AddEventListener("ACTOR_SKILL_HAVE_SECTION_AMOUNT", OnSkillHaveAmount);
		playerSkillCd.SkillBindEvent += OnSkillBindEvent;
		playerSkillCd.SkillResidentHintEvent += OnSkillResidentHintEvent;
		playerSkillCd.SyncSkillBtnToLua += OnSyncSkillBtnToLua;
		actorSearchTargetInfo.EnterAlertEvent += OnEnterAlertEvent;
		if (ammoInfo != null)
		{
			ammoInfo.AmmoChangedEvent += OnAmmoChanged;
		}
		buffComponent.JsReduceTimeEvent += OnJsReduceTimeEvent;
		buffComponent.BuffUIEvent += OnBuffUIEvent;
		specialAttributeList.ValueChangedEvent += OnSpecialValueChanged;
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		_activeInstances.Remove(this);
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (instance != null)
		{
			instance.RemoveEventListener("ADVENTURE_ACTOR_LOSTCONTROL", OnActorLostControl);
			instance.RemoveEventListener("ACTOR_ACCESS_ELEVATOR", OnAccessElevator);
			instance.RemoveEventListener("ACTOR_SKILL_HAVE_SECTION_AMOUNT", OnSkillHaveAmount);
		}
		specialAttributeList.ValueChangedEvent -= OnSpecialValueChanged;
		playerSkillCd.SkillBindEvent -= OnSkillBindEvent;
		playerSkillCd.SkillResidentHintEvent -= OnSkillResidentHintEvent;
		playerSkillCd.SyncSkillBtnToLua -= OnSyncSkillBtnToLua;
		actorSearchTargetInfo.EnterAlertEvent -= OnEnterAlertEvent;
		if (ammoInfo != null)
		{
			ammoInfo.AmmoChangedEvent -= OnAmmoChanged;
			ammoInfo.Reset();
		}
		buffComponent.JsReduceTimeEvent -= OnJsReduceTimeEvent;
		buffComponent.BuffUIEvent -= OnBuffUIEvent;
		actorInfo.Reset();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_INPUT_ACTION_BUTTON_OPERATE", OnPlayerInput);
		actived = false;
		status = ActorStatus.Default;
		specialStatusTime = 0;
		ClearLocalData();
		enableIndependentRushSkill = false;
		overrideComboClipsForSkin?.Clear();
		isBornForceMove = false;
		_actionConditionDict?.Clear();
	}

	protected override void OnLogicUpdateDisabled()
	{
		base.OnLogicUpdateDisabled();
		playerSkillCd?.Clear();
	}

	private void OnSpecialValueChanged(HotfixEnum.specialAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP old, FDP current)
	{
		if (attributeType == HotfixEnum.specialAttributeType.ENERGY)
		{
			playerSkillCd?.OnSetEnergy(old, current);
		}
	}

	protected override void OnShow(bool show)
	{
		base.OnShow(show);
		if (!isAssist)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("PlayerShow", Id, show);
		}
	}

	public void ShowBlood(bool isShow)
	{
		if (!isAssist)
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("PlayerBloodShow", Id, isShow);
		}
	}

	private void OnSkillBindEvent(ActionKey actionKey, int skillId, int actorId)
	{
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillBind", Id, (int)actionKey, skillId, actorId);
	}

	private void OnSyncSkillBtnToLua(float[] data, bool locking, bool bBeginResume, bool bCanUseAssitSkill)
	{
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("SyncSkillBtnToLua", Id, data, locking, bBeginResume, bCanUseAssitSkill);
	}

	private void OnSkillResidentHintEvent(int skillId, bool isShow)
	{
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("SkillResidentHint", Id, skillId, isShow);
	}

	private void OnEnterAlertEvent(List<LogicEntity> enterAlertActors)
	{
		SceneSingleton<AdventurePlayerController>.Instance.OnEnterAlertEvent(enterAlertActors, this);
	}

	private void OnAmmoChanged(int ammo, int ammoMax)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("AmmoChanged", Id, ammo, ammoMax);
	}

	private void OnBuffUIEvent(int uid, int buffID, int count, FP cd)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("BuffUIEvent", Id, uid, buffID, (float)cd, count);
	}

	private void OnJsReduceTimeEvent(bool active)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("BuffReduceTime", Id, active);
	}

	public void OnCastAssistSkillEvent(ActionKey actionKey)
	{
		if (actionKey != ActionKey.D)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("CastAssistSkill", dataID);
		}
	}

	public bool IsAliveP()
	{
		if (isDead)
		{
			return Id == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id;
		}
		return true;
	}

	public virtual void InitData()
	{
		if (dataID <= 0)
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetActorAttribute(dataID, out var attribute) && actorHealthInfo != null && attribute.initHp > 0)
		{
			actorHealthInfo.hp = attribute.initHp;
		}
		if (ammoInfo != null && ModuleController<AdventureModuleController>.Instance.GetActorAmmoInfo(dataID, out var actorAmmoInfo))
		{
			ammoInfo.ammoType = (HotfixEnum.AmmoType)actorAmmoInfo.ammoType;
			int[] ammoCount = actorAmmoInfo.ammoCount;
			if (ammoCount != null && ammoCount.Length >= 3)
			{
				ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Special1, actorAmmoInfo.ammoCount[1], 1);
				ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Special2, actorAmmoInfo.ammoCount[2], 1);
				ammoInfo.ChangeValue(HotfixEnum.AmmoType.Main, HotfixEnum.ammoParameterType.SET_ABSOLUTE_VALUE, actorAmmoInfo.ammoCount[0]);
				ammoInfo.ChangeValue(HotfixEnum.AmmoType.Special1, HotfixEnum.ammoParameterType.SET_ABSOLUTE_VALUE, actorAmmoInfo.ammoCount[1]);
				ammoInfo.ChangeValue(HotfixEnum.AmmoType.Special2, HotfixEnum.ammoParameterType.SET_ABSOLUTE_VALUE, actorAmmoInfo.ammoCount[2]);
			}
		}
		ClearLocalData();
		if (ModuleController<AdventureModuleController>.Instance.GetActorStatus(dataID, out var actorStatusInfo))
		{
			status = (ActorStatus)actorStatusInfo.status;
			specialStatusTime = new FP(actorStatusInfo.specialStatusTime);
			if (!string.IsNullOrEmpty(actorStatusInfo.localDataJson))
			{
				SetLocalDataFromJson(actorStatusInfo.localDataJson);
			}
		}
		else
		{
			status = ActorStatus.Default;
			specialStatusTime = 0;
		}
	}

	public virtual void LoadData(Character data, CharacterSkin skinInfo)
	{
		dataID = data.Id;
		skinID = skinInfo.Id;
		isSkin = skinID != data.DefaultSkinId && skinInfo.SkinExtraTag.Contains(1);
		if (isSkin)
		{
			overrideComboClipsForSkin = new Dictionary<string, ComboClip>();
		}
		forbiddenBehitRot = skinInfo.ForbiddenBehitRot;
		base.actorInfo.jobClass = (HotfixEnum.characterJobClass)data.Class;
		base.actorInfo.attackType = (HotfixEnum.characterAttackType)data.CharacterAttackType;
		base.actorInfo.searchType = (HotfixEnum.characterSearchTargetType)data.SearchTargetType;
		base.actorInfo.actorName = data.Name;
		base.actorInfo.originAssistSkillOnStageType = (HotfixEnum.AssistOnStageType)data.AssistSkillOnStageType;
		base.actorInfo.assistSkillOnStageType = base.actorInfo.originAssistSkillOnStageType;
		base.actorInfo.originAssistSkillOnStageOrientation = (HotfixEnum.AssistOnStageOrientation)data.AssistSkillOnStageOrientation;
		base.actorInfo.assistSkillOnStageOrientation = base.actorInfo.originAssistSkillOnStageOrientation;
		base.actorInfo.originAssistSkillAngle = FP.FromMyriad(data.AssistSkillAngle);
		base.actorInfo.assistSkillAngle = base.actorInfo.originAssistSkillAngle;
		base.actorInfo.originAssistSkillRadius = FP.FromMyriad(data.AssistSkillRadius);
		base.actorInfo.assistSkillRadius = base.actorInfo.originAssistSkillRadius;
		base.actorInfo.originAssistUltraOnStageType = (HotfixEnum.AssistOnStageType)data.AssistUltimateOnStageType;
		base.actorInfo.assistUltraOnStageType = base.actorInfo.originAssistUltraOnStageType;
		base.actorInfo.originAssistUltraOnStageOrientation = (HotfixEnum.AssistOnStageOrientation)data.AssistUltimateOnStageOrientation;
		base.actorInfo.assistUltraOnStageOrientation = base.actorInfo.originAssistUltraOnStageOrientation;
		base.actorInfo.originAssistUltimateAngle = FP.FromMyriad(data.AssistUltimateAngle);
		base.actorInfo.assistUltimateAngle = base.actorInfo.originAssistUltimateAngle;
		base.actorInfo.originAssistUltimateRadius = FP.FromMyriad(data.AssistUltimateRadius);
		base.actorInfo.assistUltimateRadius = base.actorInfo.originAssistUltimateRadius;
		base.actorInfo.skillSemiAutoRng = FP.FromMyriad(data.SkillSemiAutoRng);
		base.actorInfo.ultimateSemiAutoRng = FP.FromMyriad(data.UltimateSemiAutoRng);
		base.actorInfo.originMoveType = (HotfixEnum.actorMovType)data.MovType;
		base.actorInfo.moveType = base.actorInfo.originMoveType;
		base.actorInfo.assistWitchTimeTargetType = (HotfixEnum.FrozenTimeHighlightUnit)data.FrozenTimeHighlightUnit;
		base.actorInfo.originRunSpeed = FP.FromMyriad(data.RunSpd);
		base.actorInfo.runSpeed = base.actorInfo.originRunSpeed;
		base.actorInfo.fastRunSpeed = FP.FromMyriad(data.SpRunSpd);
		base.actorInfo.transSpd = FP.FromMyriad(data.TransSpd);
		base.actorInfo.transSpdScale = ((base.actorInfo.originRunSpeed > 0) ? (base.actorInfo.transSpd / base.actorInfo.originRunSpeed) : FP.Zero);
		base.actorInfo.originWalkSpeed = FP.FromMyriad(data.WalkSpd);
		base.actorInfo.walkSpeed = base.actorInfo.originWalkSpeed;
		base.actorInfo.walktoRunDuration = FP.FromMyriad(data.WalkToRunDuration);
		base.actorInfo.dodgeToRushAcceleration = data.DodgeToRunAccelerationOrNot;
		base.actorInfo.moveAcceleration = FP.FromMyriad(data.MovAcc);
		base.actorInfo.moveDeceleration = FP.FromMyriad(data.MovAcc);
		base.actorInfo.moveRotationSpeed = FP.FromMyriad(data.RotSpd);
		base.actorInfo.runAnimationSpd = FP.FromMyriad(skinInfo.RunAnimationSpd);
		base.actorInfo.spRunAnimationSpd = FP.FromMyriad(skinInfo.SpRunAnimationSpd);
		base.actorInfo.walkAnimationSpd = FP.FromMyriad(skinInfo.WalkAnimationSpd);
		base.actorInfo.moveDirChangeSmoothTime = FP.FromMyriad(skinInfo.SmoothTime);
		base.actorInfo.SetOriginAttributeData(data, FDP.One);
		actorSearchTargetInfo.originVisionRange = FP.FromMyriad(data.VisionRng);
		actorSearchTargetInfo.visionRange = actorSearchTargetInfo.originVisionRange;
		actorSearchTargetInfo.originVisionAttackRange = FP.FromMyriad(data.VisionAttackRng);
		actorSearchTargetInfo.visionAttackRange = actorSearchTargetInfo.originVisionAttackRange;
		actorSearchTargetInfo.originVisionDeg = FP.FromMyriad(data.VisionDeg);
		actorSearchTargetInfo.visionDeg = actorSearchTargetInfo.originVisionDeg;
		actorSearchTargetInfo.originHearRange = FP.FromMyriad(data.HearRng);
		actorSearchTargetInfo.hearRange = actorSearchTargetInfo.originHearRange;
		actorSearchTargetInfo.originHearAttackRange = FP.FromMyriad(data.HearAttackRng);
		actorSearchTargetInfo.hearAttackRange = actorSearchTargetInfo.originHearAttackRange;
		actorSearchTargetInfo.originAimRange = FP.FromMyriad(data.RaiseGunRng);
		actorSearchTargetInfo.aimRange = actorSearchTargetInfo.originAimRange;
		if (data.Ammo > 0)
		{
			ammoInfo = AddOrGetLogicComponent<AmmoInfo>();
			ammoInfo.SetOriginAttributeData(data, 1);
			ammoInfo.bulletT = (HotfixEnum.bulletType)data.BulletType;
		}
		actorElementInfo.originElementType = (HotfixEnum.elementType)data.EET;
		actorElementInfo.elementType = actorElementInfo.originElementType;
		if (ModuleController<AdventureModuleController>.Instance.GetActorAttribute(data.Id, out var attribute))
		{
			attrID = attribute.attrId;
			actorHealthInfo.SetOriginAttributeData(attribute, FDP.One);
			base.actorInfo.SetOriginAttributeData(attribute, FDP.One);
			actorElementInfo.SetOriginAttributeData(attribute, FDP.One);
			SetOriginIntFloatValue(HotfixEnum.playerAttributeType.ADD_ENERGY, attribute.EnergyConvRatio, FDP.One);
			SetOriginIntFloatValue(HotfixEnum.playerAttributeType.FRONT_ADD_ENERGY, attribute.EnergyEfficiency, FDP.One);
			int[] skillLevel = attribute.SkillLevel;
			if (skillLevel != null && skillLevel.Length >= 3)
			{
				playerSkillCd.SetSkillSlotBaseLevel(ActionKey.Normal, attribute.SkillLevel[0]);
				playerSkillCd.SetSkillSlotBaseLevel(ActionKey.B, attribute.SkillLevel[1]);
				playerSkillCd.SetSkillSlotBaseLevel(ActionKey.D, attribute.SkillLevel[2]);
			}
		}
		else
		{
			Debug.LogError($"attribute config not exist, id:{data.Id}");
		}
		actorScaleInfo.originModelScale = FP.FromMyriad(skinInfo.ModelScale);
		actorScaleInfo.modelScale = actorScaleInfo.originModelScale;
		actorScaleInfo.originColliderScale = FP.FromMyriad(skinInfo.ColliderScale);
		actorScaleInfo.colliderScale = actorScaleInfo.originColliderScale;
		actorScaleInfo.overrideEffectScale = (float)FP.FromMyriad(skinInfo.EffectScaleValue);
		actorScaleInfo.overrideTagEffectScale = (float)FP.FromMyriad(skinInfo.TagEffectScaleValue);
		movAgent.radius = dtCollider.Radius * AdventureModuleController.Config.Actor_NavAgentAvoidRadiusRate;
		movAgent.height = dtCollider.ColliderHeight;
		UpdateNovementAgentTraversableType();
		UpdateNovementAgentAvoidanceBlockSetting();
		playerAIInfo.AIId = data.AIId;
		playerAIInfo.NormalAtkId = data.NormalAtkId;
		playerAIInfo.DodgeId = data.DodgeId;
		playerAIInfo.SkillId = data.SkillId;
		playerAIInfo.SpecialSkillId = data.SpecialSkillId;
		playerAIInfo.UltimateId = data.UltimateId;
		playerAIInfo.AssistAIId = data.AssistAIId;
		playerAIInfo.AssistNormalAtkId = data.AssistNormalAtkId;
		playerAIInfo.AssistDodgeId = data.AssistDodgeId;
		playerAIInfo.AssistSkillId = data.AssistSkillId;
		playerAIInfo.AssistSpecialSkillId = data.AssistSpecialSkillId;
		playerAIInfo.AssistUltimateId = data.AssistUltimateId;
		playerSkillCd.SetActorId(dataID);
		SetupPrimeFSM(playerAIInfo.AIId);
		LoadModel((float)dtCollider.Radius, (float)dtCollider.ColliderHeight);
		ActorInfo actorInfo = base.actorInfo;
		int factionID = (base.actorInfo.originFactionID = data.Faction);
		actorInfo.factionID = factionID;
		_attackFSM.SetRootMotionScale(actorScaleInfo.modelScale);
	}

	public void Born()
	{
		isBorn = true;
		if (actorHealthInfo != null)
		{
			actorHealthInfo.isAlive = true;
		}
		isDead = false;
		isDeclareDead = false;
	}

	public override bool Death(LogicEntity killer, IList<int> damageTag = null, HitBox hitBox = null, int uniqueAttackId = 0, DeadType deadType = DeadType.None)
	{
		return base.Death(killer, damageTag, hitBox, uniqueAttackId, deadType);
	}

	public bool CheckSkillReady(bool autoCast = false)
	{
		if (playerSkillCd == null)
		{
			return false;
		}
		if (disableCastSkill)
		{
			return false;
		}
		if (autoCast && !actorSkillManage.CheckIsSkillExecutableWhenSemiAutoBattle())
		{
			return false;
		}
		if (!actorSkillManage.CheckIsSkillExecutable(SkillPhaseFeatureFlag.Skill1, 0))
		{
			return false;
		}
		SkillInfo skillCD = playerSkillCd.GetSkillCD(ActionKey.B);
		if (skillCD == null)
		{
			return false;
		}
		if (skillCD.locking)
		{
			return false;
		}
		if (skillCD.currentSectionAmount <= 0)
		{
			return false;
		}
		return true;
	}

	public bool CheckUltimateSkillReady(bool autoCast = false)
	{
		if (playerSkillCd == null)
		{
			return false;
		}
		if (disableCastUltra)
		{
			return false;
		}
		if (autoCast && !actorSkillManage.CheckIsSkillExecutableWhenSemiAutoBattle())
		{
			return false;
		}
		if (!actorSkillManage.CheckIsSkillExecutable(SkillPhaseFeatureFlag.Ultimate, 0))
		{
			return false;
		}
		SkillInfo skillCD = playerSkillCd.GetSkillCD(ActionKey.D);
		if (skillCD == null)
		{
			return false;
		}
		if (skillCD.locking)
		{
			return false;
		}
		if (skillCD.currentSectionAmount <= 0)
		{
			return false;
		}
		if (!SceneSingleton<AdventurePlayerController>.Instance.ultimateIgnoreEnergy && skillCD.currentEnergy < skillCD.totalEnergy)
		{
			return false;
		}
		return true;
	}

	public void SetActorOperateType(bool assist)
	{
		isAssist = assist;
		SetSkillBind();
		SetPrimeFSMAI(isAssist ? playerAIInfo.AssistAIId : playerAIInfo.AIId);
		isResident = false;
		if (isAssist)
		{
			isAssistAIFinish = true;
			isResidentAssist = false;
			EnableSearchedImmunity();
			EnableImmuneControl();
			EnableInvincible();
			EnablePenetrate();
		}
	}

	private void SetSkillBind()
	{
		if (!isAssist)
		{
			playerSkillCd.BindSkillIdToButton(ActionKey.A, playerAIInfo.DodgeId);
			playerSkillCd.BindSkillIdToButton(ActionKey.B, playerAIInfo.SkillId);
			playerSkillCd.BindSkillIdToButton(ActionKey.C, playerAIInfo.SpecialSkillId);
			playerSkillCd.BindSkillIdToButton(ActionKey.D, playerAIInfo.UltimateId);
			playerSkillCd.BindSkillIdToButton(ActionKey.Normal, playerAIInfo.NormalAtkId);
		}
		else
		{
			playerSkillCd.BindSkillIdToButton(ActionKey.A, playerAIInfo.AssistDodgeId);
			playerSkillCd.BindSkillIdToButton(ActionKey.B, playerAIInfo.AssistSkillId);
			playerSkillCd.BindSkillIdToButton(ActionKey.D, playerAIInfo.AssistUltimateId);
			playerSkillCd.BindSkillIdToButton(ActionKey.Normal, playerAIInfo.AssistNormalAtkId);
		}
	}

	[Obsolete]
	public int GetTalentGroupLevel()
	{
		return -1;
	}

	[Obsolete]
	public PlayerSkillBranchType GetSkillBranchType()
	{
		return PlayerSkillBranchType.None;
	}

	[Obsolete]
	public PlayerTalentGroupType GetTalentGroupType()
	{
		return PlayerTalentGroupType.None;
	}

	public override void SetupPrimeFSM(int aiId)
	{
		if (_primeFSM == null)
		{
			AI aI = Singleton<HotfixDataController>.Instance.GetAI(aiId);
			if (aI == null)
			{
				Debug.LogError($"{name},ai id not found:{aiId}");
				return;
			}
			_comboGroupPath = aI.FCComboGroup;
			base.SetupPrimeFSM(aI.Id);
			_primeFSM = new ActorPrimeFSM(gameObject);
			_nullState = new ActorNullState();
			_primeFSM.RegistState(_nullState);
			_spawnState = new PlayerSpawnState();
			_primeFSM.RegistState(_spawnState);
			_idleState = new PlayerIdleState();
			_primeFSM.RegistState(_idleState);
			_lostControlState = new PlayerLostControlState();
			_primeFSM.RegistState(_lostControlState);
			_deathState = new PlayerDeathState();
			_primeFSM.RegistState(_deathState);
			RegisterActionState();
		}
	}

	public void SetPrimeFSMAI(int aiId)
	{
		if (_primeFSM == null)
		{
			return;
		}
		AI aI = Singleton<HotfixDataController>.Instance.GetAI(aiId);
		if (aI == null)
		{
			Debug.LogError($"{name},set, ai id not found:{aiId}");
			return;
		}
		_spawnState?.SetAI(aI?.FCSpawn);
		_idleState?.SetAI(aI?.FCIdle);
		_lostControlState?.SetAI(aI?.FCLostControl);
		_deathState?.SetAI(aI?.FCLostControl);
		_actionState?.SetAI(aI?.FCAction);
		if (_primeFSM.GetCurState() != null)
		{
			switch (((IBehaviourState<GameObject>)_primeFSM.GetCurState()).GetStateID())
			{
			case 1:
				_spawnState?.ForceStartAI();
				break;
			case 2:
				_idleState?.ForceStartAI();
				break;
			case 4:
				_lostControlState?.ForceStartAI();
				break;
			case 5:
				_deathState?.ForceStartAI();
				break;
			case 3:
				_actionState?.ForceStartAI();
				break;
			}
		}
		InitParallelAI(aI?.FCGlobal);
		StartParallelAI();
	}

	public void ResetPrimeFSMAI(int aiId)
	{
		if (_primeFSM == null)
		{
			return;
		}
		AI aI = Singleton<HotfixDataController>.Instance.GetAI(aiId);
		if (aI == null)
		{
			Debug.LogError($"{name},reset, ai id not found:{aiId}");
			return;
		}
		_spawnState?.ResetAI(aI?.FCSpawn);
		_idleState?.ResetAI(aI?.FCIdle);
		_lostControlState?.ResetAI(aI?.FCLostControl);
		_deathState?.ResetAI(aI?.FCLostControl);
		_actionState?.ResetAI(aI?.FCAction);
		switch (((IBehaviourState<GameObject>)_primeFSM.GetCurState()).GetStateID())
		{
		case 1:
			_spawnState?.ForceStartAI();
			break;
		case 2:
			_idleState?.ForceStartAI();
			break;
		case 4:
			_lostControlState?.ForceStartAI();
			break;
		case 5:
			_deathState?.ForceStartAI();
			break;
		case 3:
			_actionState?.ForceStartAI();
			break;
		}
		ResetParallelAI(aI?.FCGlobal);
	}

	protected virtual void RegisterActionState(string fcAction = "")
	{
		switch (actorInfo.searchType)
		{
		case HotfixEnum.characterSearchTargetType.MELEE:
			searchType = PlayerActorSearchType.Melee;
			break;
		case HotfixEnum.characterSearchTargetType.RANGED:
			searchType = PlayerActorSearchType.Range;
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		moveControlType = PlayerActorMoveType.Range;
		enableReload = true;
		_actionState = new PlayerActionState();
		_primeFSM.RegistState(_actionState, fcAction);
	}

	public override void LevelStart()
	{
		if (isDead)
		{
			return;
		}
		EnableLogicUpdate();
		Idle(isActorLevelStart: true);
		if (ModuleController<AdventureModuleController>.Instance.levelType != HotfixEnum.worldLevelType.RegionBoss)
		{
			return;
		}
		RegionBossLevel regionBossLevel = ModuleController<AdventureModuleController>.Instance.levelLoadParams.regionBossLevel;
		if (regionBossLevel == null)
		{
			return;
		}
		Dictionary<int, int> dictionary = new Dictionary<int, int>
		{
			{ regionBossLevel.EntryGroupId1, regionBossLevel.EntryGroupLevel1 },
			{ regionBossLevel.EntryGroupId2, regionBossLevel.EntryGroupLevel2 },
			{ regionBossLevel.EntryGroupId3, regionBossLevel.EntryGroupLevel3 },
			{ regionBossLevel.EntryGroupId4, regionBossLevel.EntryGroupLevel4 },
			{ regionBossLevel.EntryGroupId5, regionBossLevel.EntryGroupLevel5 }
		};
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, int> item in dictionary)
		{
			foreach (KeyValuePair<int, RegionBossAffix> regionBossAffixDatum in Singleton<HotfixDataController>.Instance.RegionBossAffixData)
			{
				if (regionBossAffixDatum.Value.GroupId == item.Key && regionBossAffixDatum.Value.Level == item.Value)
				{
					if (regionBossAffixDatum.Value.AddCamp.Contains(actorInfo.factionID))
					{
						list.Add(regionBossAffixDatum.Value.SkillId);
					}
					break;
				}
			}
		}
		foreach (int item2 in list)
		{
			buffComponent.AddBuff(item2, this);
		}
	}

	protected override void UpdateNovementAgentAvoidanceBlockSetting()
	{
		if (movementAgentEnabled)
		{
			movAgent.blockLayer = RVOLayer.DefaultAgent;
			movAgent.blockWith = RVOLayer.DefaultAgent | RVOLayer.DefaultObstacle | RVOLayer.Layer2;
			if (actorInfo.moveType == HotfixEnum.actorMovType.STATIC)
			{
				movAgent.blockPriority = NavAgentTypeNames.UnmoveableAgentPriority;
				movAgent.blockDamp = NavAgentTypeNames.UnmoveableAgentDamp;
			}
			else
			{
				movAgent.blockPriority = NavAgentTypeNames.PlayerAgentPriority;
				movAgent.blockDamp = NavAgentTypeNames.PlayerAgentDamp;
			}
			_orginMovementBlockPriority = movAgent.blockPriority;
		}
	}

	public void OnMovementInput(bool movementHasInput, TSVector2 movementInputVector, TSVector2 movementInputDirection)
	{
		if (canInput)
		{
			_movementHasInput = movementHasInput;
			_movementInputVector = movementInputVector;
			MovementInputDirection = movementInputDirection;
			_primeFSM.GetCurState().OnMovementInput(movementHasInput, movementInputVector, movementInputDirection);
		}
	}

	public bool Active()
	{
		if (actived)
		{
			return false;
		}
		if (!actorHealthInfo.isAlive)
		{
			return false;
		}
		buffComponent?.OnActorActive();
		actived = true;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_INPUT_ACTION_BUTTON_OPERATE", OnPlayerInput);
		DispatchChangeActorEvent();
		ResumeBehaviour();
		DisableHideModel();
		DisableIgnoreDeterministicCollision();
		ResumeMovementAgent();
		ResetDynamicBones();
		actorShield.UpdateShieldValue();
		if (comboGroup != null && comboGroup.switchInEffect != null)
		{
			_attackFSM.PlayEffect(oneShot: true, -1, comboGroup.switchInEffect, tsTransform.Position, tsTransform.PositionY, tsTransform.Rotation, bindActor: false);
		}
		SceneSingleton<AdventureIndicatorController>.Instance.ShowIndicatorN(showIndicator: true, actorSearchTargetInfo, tsTransform);
		return true;
	}

	public void ReActive()
	{
		DispatchChangeActorEvent();
	}

	public void DispatchChangeActorEvent()
	{
		AdventureChangePlayerActor adventureChangePlayerActor = AdventureChangePlayerActor.Generate();
		adventureChangePlayerActor.sender = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureChangePlayerActor);
	}

	public bool DeActive()
	{
		if (!actived)
		{
			return false;
		}
		if (isDead)
		{
			return false;
		}
		buffComponent?.OnActorLeave();
		bool flag = actorSkillManage.CheckCanExit();
		bool flag2 = canExit;
		if (!flag || !flag2)
		{
			return false;
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_INPUT_ACTION_BUTTON_OPERATE", OnPlayerInput);
		actived = false;
		InterruptAttack(force: true);
		actorSkillManage.DestoryAllSkill();
		InterruptMovement();
		PauseBehaviour();
		EnableHideModel();
		EnableIgnoreDeterministicCollision();
		buffComponent?.OnActorLeave(iM: true);
		Idle();
		if (comboGroup != null && comboGroup.switchOutEffect != null)
		{
			_attackFSM.PlayEffect(oneShot: true, -1, comboGroup.switchOutEffect, tsTransform.Position, tsTransform.PositionY, tsTransform.Rotation, bindActor: false);
		}
		SceneSingleton<AdventureIndicatorController>.Instance.ShowIndicatorN(showIndicator: false, actorSearchTargetInfo, tsTransform);
		return true;
	}

	public void Revive()
	{
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (!isDead)
		{
			_primeFSM.OnUpdate();
			UpdateParallelAI();
			playerSkillCd.UpdateSkillCD(LogicDeltaTime);
			buffComponent.LogicUpdate(LogicDeltaTime);
			effectManage?.LogicUpdate(LogicDeltaTime);
			actorSkillManage?.LogicUpdate(LogicDeltaTime);
			if (_evt != null)
			{
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(_evt);
				_evt = null;
			}
			updateTime();
		}
		_attackFSM.OnUpdate();
		_movementFSM.OnUpdate();
		CheckBrokenLineBulletBack();
	}

	protected override void ReleaseVisual()
	{
		base.ReleaseVisual();
		InitializeTransparentFade();
	}

	protected override void SetupVisualComponents(float visibleRadius, float visibleHeight)
	{
		base.SetupVisualComponents(visibleRadius, visibleHeight);
		visualControl.SetupBasicActorVisualComponents(visibleRadius, visibleHeight);
		visualControl.SetupHighlightOutlineMask();
		if (actorInfo != null && actorInfo.moveType == HotfixEnum.actorMovType.WALK)
		{
			visualControl.SetupInteractiveEnvironmentPawnComponent(visibleRadius);
		}
		visualControl.SetCustomStencilMode(200, RendererMaterialStackComponent.StencilMode.Replace);
		visualControl.ResetRenderLayer();
		InitializeTransparentFade();
	}

	private void OnActorLostControl(IEvent ievent)
	{
		if (ievent is AdventureActorLostControlEvent adventureActorLostControlEvent && adventureActorLostControlEvent.actor == this)
		{
			dodgeButtonHold = false;
		}
	}

	protected void OnPlayerInput(IEvent evt)
	{
		AdventureInputActionOperate adventureInputActionOperate = (AdventureInputActionOperate)evt;
		if (ActionKey.A == adventureInputActionOperate.key || ActionKey.C == adventureInputActionOperate.key)
		{
			switch (adventureInputActionOperate.buttonState)
			{
			case ButtonState.Click:
			case ButtonState.Cancel:
				dodgeButtonHold = false;
				break;
			default:
				throw new ArgumentOutOfRangeException();
			case ButtonState.None:
			case ButtonState.Press:
			case ButtonState.Hold:
				break;
			}
		}
	}

	private void OnAccessElevator(IEvent evt)
	{
		if (this != SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor || !(evt is AdventureActorAccessElevatorEvent adventureActorAccessElevatorEvent))
		{
			return;
		}
		if (adventureActorAccessElevatorEvent.isEnter)
		{
			enterElevator = true;
			if (adventureActorAccessElevatorEvent.floorTrans != null)
			{
				elevatorFloor = adventureActorAccessElevatorEvent.floorTrans;
			}
			else if (!string.IsNullOrEmpty(adventureActorAccessElevatorEvent.floorPath))
			{
				elevatorFloor = GameObject.Find(adventureActorAccessElevatorEvent.floorPath)?.transform;
			}
		}
		else
		{
			if (elevatorFloor != null)
			{
				tsTransform.PositionY = elevatorFloor.position.y;
			}
			enterElevator = false;
			elevatorFloor = null;
			SyncMovementLocation();
		}
	}

	private void OnSkillHaveAmount(IEvent evt)
	{
		if (evt is AdventureActorSkillHaveSectionAmountEvent adventureActorSkillHaveSectionAmountEvent && adventureActorSkillHaveSectionAmountEvent.actorId == dataID && playerSkillCd.GetCurrentBindSkillId(ActionKey.A) == adventureActorSkillHaveSectionAmountEvent.skillId)
		{
			enableIndependentRushSkill = !adventureActorSkillHaveSectionAmountEvent.haveSectionAmount;
			MonoSingleton<LuaManager>.Instance.FireEvent("CanRush", enableIndependentRushSkill);
		}
	}

	public void Despawn()
	{
		OnShow(show: false);
		ActiveSelf = false;
	}

	public virtual void Recycle()
	{
		if (GroupId != null)
		{
			SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(GroupId)?.RemoveMember(this);
		}
		if (spawnPoolObj == null)
		{
			Debug.LogError("回收角色时poolObj为空");
			return;
		}
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.En_Player(spawnPoolObj);
		spawnPoolObj = null;
	}

	public void AddEnergy(FDP energy)
	{
		if (isAssist)
		{
			playerSkillCd?.AddEnergy(energy * energyConvertRatio * frontEnergyConvertRatio);
		}
		else
		{
			playerSkillCd?.AddEnergy(energy * frontEnergyConvertRatio);
		}
	}

	public string GetLocalData(string key)
	{
		return localData?.GetValueOrDefault(key, null);
	}

	public void SetLocalData(string key, string value)
	{
		if (localData == null)
		{
			localData = new SerializableDictionary<string, string>();
		}
		((Dictionary<string, string>)localData).set_Item(key, value);
	}

	public void RemoveLocalData(string key)
	{
		localData?.Remove(key);
	}

	public void ClearLocalData()
	{
		localData?.Clear();
	}

	public string LocalDataToJson()
	{
		if (localData != null)
		{
			return JsonUtility.ToJson(localData);
		}
		return null;
	}

	public void SetLocalDataFromJson(string json)
	{
		if (!string.IsNullOrEmpty(json))
		{
			localData = JsonUtility.FromJson<SerializableDictionary<string, string>>(json);
		}
	}

	internal static void DriveActiveInstancesLateUpdate()
	{
		for (int num = _activeInstances.Count - 1; num >= 0; num--)
		{
			try
			{
				_activeInstances.get_Item(num).DriveLateUpdate();
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
	}

	private void DriveLateUpdate()
	{
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		if (!actived || !actorHealthInfo.isAlive)
		{
			return;
		}
		if (enterElevator && elevatorFloor != null)
		{
			tsTransform.PositionY = elevatorFloor.position.y;
			transform.position = new Vector3(transform.position.x, elevatorFloor.position.y, transform.position.z);
		}
		if (SceneSingleton<AdventureModuleDebugHelper>.Instance.PlayerGizmo | flag)
		{
			Vector3 position = transform.position;
			float radius = (float)dtCollider.Radius;
			string actorName = $"player_{dataID}_{Id}";
			AdventureSkill firstSkill = actorSkillManage.FirstSkill;
			string stateName = $"{state} --> {movementState} --> {attackState}";
			string skillName = ((firstSkill != null) ? $"skill_{firstSkill.skillId}" : null);
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowPlayerGizmo(position, radius, actorName, stateName, skillName, Color.green);
		}
		if ((SceneSingleton<AdventureModuleDebugHelper>.Instance.HearingGizmoForPlayer || (flag & flag2)) && actorSearchTargetInfo.enableHearingLogic)
		{
			FP fP = actorSearchTargetInfo.hearRange + dtCollider.Radius;
			Vector3 position2 = transform.position;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCircleGizmo(position2, Vector3.up, (float)fP, AdventureModuleController.Config.SearchRangeGizmoColor);
			fP = actorSearchTargetInfo.hearAttackRange + dtCollider.Radius;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCircleGizmo(position2, Vector3.up, (float)fP, AdventureModuleController.Config.AttackRangeGizmoColor);
		}
		if ((SceneSingleton<AdventureModuleDebugHelper>.Instance.VisionGizmoForPlayer || (flag & flag3)) && actorSearchTargetInfo.enableVisionLogic)
		{
			FP fP2 = actorSearchTargetInfo.visionRange + dtCollider.Radius;
			Vector3 position3 = transform.position;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowFanGizmo(position3, (float)fP2, (float)actorSearchTargetInfo.visionDeg, (float)tsTransform.Forward.GetAngle(), AdventureModuleController.Config.SearchRangeGizmoColor);
			fP2 = actorSearchTargetInfo.visionAttackRange + dtCollider.Radius;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCircleGizmo(position3, Vector3.up, (float)fP2, AdventureModuleController.Config.AttackRangeGizmoColor);
		}
		if ((SceneSingleton<AdventureModuleDebugHelper>.Instance.InputAndVisionGizmo || (flag & flag3)) && SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
		{
			FP fP3 = actorSearchTargetInfo.visionRange + dtCollider.Radius;
			Vector3 position4 = transform.position;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowFanGizmo(position4, (float)fP3, (float)actorSearchTargetInfo.visionDeg, (float)SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection().GetAngle(), AdventureModuleController.Config.InputSearchRangeGizmoColor);
			fP3 = actorSearchTargetInfo.visionAttackRange + dtCollider.Radius;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCircleGizmo(position4, Vector3.up, (float)fP3, AdventureModuleController.Config.AttackRangeGizmoColor);
		}
		if (SceneSingleton<AdventureModuleDebugHelper>.Instance.PlayerPathGizmo || (flag & flag4))
		{
			float y = transform.position.y;
			if (movAgent.hasPath && !movAgent.reachedDestination)
			{
				movAgent.GetRemainingPath(points, out var _);
				SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowPathGizmo(points, y, 0.2f, color2);
			}
		}
	}

	bool IActorBehaviourState.IsAlive()
	{
		return IsAliveP();
	}

	void IActorBehaviourState.StartHurtAudioCD()
	{
		StartHurtAudioCD();
	}
}
