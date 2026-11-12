#define LOG_DEBUG
#define LOG_ERROR
using System;
using System.Collections.Generic;
using System.Linq;
using AdventureBehaviour;
using Google.Protobuf.Collections;
using Nova.Hotfix;
using Pathfinding.RVO;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Actor/Monster Actor")]
public class MonsterAdventureActor : AdventureActor, IGroupMessage
{
	[Space]
	public AdventureLevelObjPoolMgr.PoolObj spawnPoolObj;

	private List<int> initBuffIds;

	private int battleLevel;

	private PlayFX battleLevelUpFx;

	public bool summonMonsterUseBattleLevelAsDifficultLevel;

	private readonly AttributeEntry[] monsterEntries = new AttributeEntry[1];

	public int testSkillId;

	[HideInInspector]
	public int gmSetId;

	protected bool delayEnterAction;

	private readonly List<TSVector> points = new List<TSVector>();

	private static readonly Color color1 = new Color(0f, 0f, 0.9f);

	private static readonly Color color2 = new Color(1f, 0.6f, 0.3f);

	private static readonly Color color3 = new Color(1f, 0.8f, 0.2f);

	private static readonly Color color4 = new Color(0.9f, 0f, 0.9f);

	private static readonly Color color5 = new Color(0.6f, 0f, 0.6f);

	private static readonly Color color6 = new Color(0f, 0.9f, 0.9f);

	private static readonly Color color7 = new Color(0f, 0.6f, 0.6f);

	public MonsterInfo monsterInfo { get; protected set; }

	public MonsterSpawnerInfo spawnerInfo { get; protected set; }

	public MonsterActiveScheme monsterActiveScheme { get; protected set; }

	public MonsterAIInfo monsterAIInfo { get; protected set; }

	public MonsterSummonInfo monsterSummonInfo { get; protected set; }

	public MonsterToughnessInfo monsterToughnessInfo { get; protected set; }

	public bool HasLoadData { get; protected set; }

	public int ScoreBossBehavior { get; private set; }

	public bool ToughnessBrokenToIdle { get; set; }

	public FDP aiBranchCDRatio => GetAttributeValue(HotfixEnum.monsterAttributeType.MONSTER_AIBRANCH_CD);

	public bool HasBattleLevelUp
	{
		get
		{
			if (monsterInfo.epicType != HotfixEnum.monsterEpicType.BOSSRUSH)
			{
				if (monsterInfo.epicType == HotfixEnum.monsterEpicType.LORD)
				{
					return monsterInfo.subBossType == HotfixEnum.subBossType.HUNTBOSS;
				}
				return false;
			}
			return true;
		}
	}

	public int BattleLevel
	{
		get
		{
			return battleLevel;
		}
		set
		{
			if (battleLevel != value)
			{
				int oldLevel = battleLevel;
				battleLevel = value;
				OnBattleLevelChange(oldLevel);
			}
		}
	}

	public FDP GetAttributeValue(HotfixEnum.monsterAttributeType type)
	{
		if (type == HotfixEnum.monsterAttributeType.MAX)
		{
			return FDP.Zero;
		}
		return monsterEntries[(int)type].AmendValue;
	}

	public void SetOriginIntValue(HotfixEnum.monsterAttributeType type, int val, FDP ratio)
	{
		if (type != HotfixEnum.monsterAttributeType.MAX)
		{
			monsterEntries[(int)type].SetOrigin(val * ratio);
		}
	}

	public void ChangeMonsterAttrValue(int firstSubType, int secondSubType, FDP value)
	{
		if (firstSubType != 1)
		{
			monsterEntries[firstSubType].ChangeValue((HotfixEnum.parameterType)secondSubType, value);
		}
	}

	protected override void OnInit()
	{
		base.OnInit();
		monsterInfo = AddOrGetLogicComponent<MonsterInfo>();
		spawnerInfo = AddOrGetLogicComponent<MonsterSpawnerInfo>();
		monsterActiveScheme = AddOrGetLogicComponent<MonsterActiveScheme>();
		monsterAIInfo = AddOrGetLogicComponent<MonsterAIInfo>();
		monsterSummonInfo = AddOrGetLogicComponent<MonsterSummonInfo>();
		monsterToughnessInfo = AddOrGetLogicComponent<MonsterToughnessInfo>();
		SetOriginIntValue(HotfixEnum.monsterAttributeType.MONSTER_AIBRANCH_CD, 1, FDP.One);
		dtCollider.priority = 2;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_CHANGE_PLAYER_ACTOR", OnChangePlayerActor);
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure_Monster");
	}

	protected void OnChangePlayerActor(IEvent e)
	{
		if (_attackTarget != null)
		{
			_attackTarget = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		}
	}

	protected void OnGetBuff(IEvent evt)
	{
		if (monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSS || monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSSRUSH || monsterInfo.bloodType == HotfixEnum.monsterBloodType.JOINTDRILLBOSS)
		{
			int buffId = (evt as AdventureActorGetBuff).eventInfo.buffId;
			if (IsShowBuff(buffId))
			{
				MonoSingleton<LuaManager>.Instance?.FireEntityEvent("BossBuffChanged", Id, buffId, a2: true);
			}
		}
	}

	protected void OnRemoveBuff(IEvent evt)
	{
		if (monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSS || monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSSRUSH || monsterInfo.bloodType == HotfixEnum.monsterBloodType.JOINTDRILLBOSS)
		{
			int buffId = (evt as AdventureActorRemoveBuff).eventInfo.buffId;
			if (IsShowBuff(buffId))
			{
				MonoSingleton<LuaManager>.Instance?.FireEntityEvent("BossBuffChanged", Id, buffId, a2: false);
			}
		}
	}

	protected bool IsShowBuff(int buffId)
	{
		return Singleton<HotfixDataController>.Instance.GetBuff(buffId).IsShow;
	}

	protected override void OnActive()
	{
		base.OnActive();
		monsterToughnessInfo.ToughnessValueChangedEvent += OnToughnessValueChanged;
		monsterToughnessInfo.ToughnessStateChangedEvent += OnToughnessStateChanged;
		buffComponent.BuffUIEvent += OnBuffUIEvent;
	}

	private void DoInit()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("MonsterActive", Id, dataID, a3: true);
		if (monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSS || monsterInfo.bloodType == HotfixEnum.monsterBloodType.MINIBOSS || monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSSRUSH || monsterInfo.bloodType == HotfixEnum.monsterBloodType.JOINTDRILLBOSS)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		}
		ShowBlood(isShow: true);
		ModuleController<AdventureModuleController>.Instance.ShowMinimap(transform, show: true);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		initBuffIds?.Clear();
		monsterToughnessInfo.ToughnessValueChangedEvent -= OnToughnessValueChanged;
		monsterToughnessInfo.ToughnessStateChangedEvent -= OnToughnessStateChanged;
		MonoSingleton<LuaManager>.Instance.FireEvent("MonsterActive", Id, dataID, a3: false);
		if (monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSS || monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSSRUSH || monsterInfo.bloodType == HotfixEnum.monsterBloodType.JOINTDRILLBOSS)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		}
		if (monsterInfo.bloodType != HotfixEnum.monsterBloodType.NONE)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("MonsterHUDChange", Id, (int)monsterInfo.bloodType, a3: false, dataID);
		}
		buffComponent.BuffUIEvent -= OnBuffUIEvent;
		battleLevel = 1;
		summonMonsterUseBattleLevelAsDifficultLevel = false;
		testSkillId = 0;
		ToughnessBrokenToIdle = false;
	}

	private void OnBuffUIEvent(int uid, int buffID, int count, FP cd)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("BuffUIEvent", Id, uid, buffID, (float)cd, count);
	}

	protected void OnToughnessValueChanged(long toughness, long toughnessMax)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("ToughnessValueChanged", Id, toughness, toughnessMax);
	}

	protected void OnToughnessStateChanged(bool toughnessBroken)
	{
		long toughness = monsterToughnessInfo.toughness;
		long toughnessMax = monsterToughnessInfo.toughnessMax;
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("ToughnessStateChanged", Id, toughnessBroken, toughness, toughnessMax);
		MonoSingleton<LuaManager>.Instance?.FireEvent("ToughnessStateChangedForGlobal", Id, toughnessBroken);
	}

	public void AttackHintShow()
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("AttackHintShow", Id);
	}

	public void AttackHintHide()
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("AttackHintHide", Id);
	}

	public void AttackHint()
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("AttackHint", Id);
	}

	public void AttackHintCancel()
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("AttackHintCancel", Id);
	}

	public void AttackHintEnd()
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("AttackHintEnd", Id);
	}

	protected override void OnHpChangedEvent(long hp, long hpMax)
	{
		base.OnHpChangedEvent(hp, hpMax);
	}

	protected override void OnAliveChangedEvent(bool alive)
	{
		base.OnAliveChangedEvent(alive);
		if (!alive && spawnerInfo?.monsterDied != null)
		{
			spawnerInfo.monsterDied();
			spawnerInfo.monsterDied = null;
		}
	}

	protected override void OnShow(bool show)
	{
		base.OnShow(show);
		if (Id <= 0)
		{
			Debug.LogError("OnShow 出现在错误的调用时间: " + name);
		}
		if (!isBattleOut)
		{
			ShowBlood(show);
		}
		ModuleController<AdventureModuleController>.Instance.ShowMinimap(transform, show);
	}

	private void OnBattleLevelChange(int oldLevel)
	{
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("BossRushMonsterLevelChanged", Id, oldLevel, battleLevel);
		if (oldLevel < battleLevel)
		{
			for (int i = oldLevel + 1; i <= battleLevel; i++)
			{
				ModifyBattleAttr(i, out var fxKey);
				if (!string.IsNullOrEmpty(fxKey))
				{
					if (battleLevelUpFx == null)
					{
						battleLevelUpFx = new PlayFX();
					}
					else
					{
						battleLevelUpFx.Clear();
					}
					battleLevelUpFx.Play(this, null, fxKey, default, tsTransform.Position, default);
				}
			}
		}
		else
		{
			for (int num = oldLevel; num > battleLevel; num--)
			{
				ModifyBattleAttr(num, out var _, isAdd: false);
			}
		}
		NovaLogger.Debug($"怪物（{name}）的局内战斗等级变化（{oldLevel}->{battleLevel}），当前最大生命值为{actorHealthInfo.hpMax}");
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("BossRushMonsterBattleAttrChanged", Id);
		AdventureMonsterBattleLevelChangedEvent adventureMonsterBattleLevelChangedEvent = AdventureMonsterBattleLevelChangedEvent.Generate();
		adventureMonsterBattleLevelChangedEvent.sender = this;
		adventureMonsterBattleLevelChangedEvent.oldLevel = oldLevel;
		adventureMonsterBattleLevelChangedEvent.newLevel = battleLevel;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterBattleLevelChangedEvent);
	}

	public void ShowBlood(bool isShow)
	{
		if (actorHealthInfo.isAlive && monsterInfo.bloodType != HotfixEnum.monsterBloodType.NONE)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("MonsterHUDChange", Id, (int)monsterInfo.bloodType, isShow, dataID);
		}
	}

	public void ShowCenterHpBar(bool isShow)
	{
		if (actorHealthInfo.isAlive)
		{
			if (monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSS || monsterInfo.bloodType == HotfixEnum.monsterBloodType.JOINTDRILLBOSS || monsterInfo.bloodType == HotfixEnum.monsterBloodType.BOSSRUSH)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("ShowCenterHpBar", Id, (int)monsterInfo.bloodType, isShow, dataID);
			}
			if (monsterInfo.epicType == HotfixEnum.monsterEpicType.LORD)
			{
				MonoSingleton<WwiseAudioManager>.Instance.SetState("combat", "combatBoss");
			}
		}
	}

	public virtual void LoadData(Monster data, MonsterSkin skin, ActorSpawnInfo actorSpawnInfo, bool isSummonMonster = false, SummonCfg cfg = null)
	{
		HasLoadData = true;
		dataID = data.Id;
		skinID = skin.Id;
		base.actorInfo.actorName = data.Name;
		attrTempleteID = data.Templete;
		battleLevel = 1;
		base.actorInfo.originMoveType = (HotfixEnum.actorMovType)data.MovType;
		base.actorInfo.moveType = base.actorInfo.originMoveType;
		base.actorInfo.originRunSpeed = FP.FromMyriad(data.RunSpd);
		base.actorInfo.runSpeed = base.actorInfo.originRunSpeed;
		base.actorInfo.transSpdScale = FP.FromMyriad(data.TransSpdScale);
		base.actorInfo.transSpd = base.actorInfo.originRunSpeed * base.actorInfo.transSpdScale;
		base.actorInfo.dodgeToRushAcceleration = true;
		base.actorInfo.originWalkSpeed = FP.FromMyriad(data.WalkSpd);
		base.actorInfo.walkSpeed = base.actorInfo.originWalkSpeed;
		base.actorInfo.moveAcceleration = FP.FromMyriad(data.MovAcc);
		base.actorInfo.moveRotationSpeed = FP.FromMyriad(data.RotSpd);
		base.actorInfo.skillRotationSpeed = FP.FromMyriad(data.RotSpdInSkill);
		actorSearchTargetInfo.IsShowRng = data.IsShowRng;
		actorSearchTargetInfo.originVisionRange = FP.FromMyriad(data.VisionRng);
		actorSearchTargetInfo.visionRange = actorSearchTargetInfo.originVisionRange;
		actorSearchTargetInfo.originVisionDeg = FP.FromMyriad(data.VisionDeg);
		actorSearchTargetInfo.visionDeg = actorSearchTargetInfo.originVisionDeg;
		actorSearchTargetInfo.originHearRange = FP.FromMyriad(data.HearRng);
		actorSearchTargetInfo.hearRange = actorSearchTargetInfo.originHearRange;
		actorSearchTargetInfo.monsterSearchRange = FP.FromMyriad(data.SearchRng);
		forbiddenBehitRot = skin.ForbiddenBehitRot;
		actorScaleInfo.originModelScale = FP.FromMyriad(skin.ModelScale);
		actorScaleInfo.modelScale = actorScaleInfo.originModelScale;
		actorScaleInfo.overrideEffectScale = (float)FP.FromMyriad(skin.EffectScaleValue);
		actorScaleInfo.overrideTagEffectScale = (float)FP.FromMyriad(skin.TagEffectScaleValue);
		actorScaleInfo.originColliderScale = FP.FromMyriad(skin.ColliderScale);
		actorScaleInfo.colliderScale = actorScaleInfo.originColliderScale;
		movAgent.radius = dtCollider.Radius * AdventureModuleController.Config.Actor_NavAgentAvoidRadiusRate;
		movAgent.height = dtCollider.ColliderHeight;
		base.actorInfo.runAnimationSpd = FP.FromMyriad(skin.RunAnimationSpd);
		base.actorInfo.walkAnimationSpd = FP.FromMyriad(skin.WalkAnimationSpd);
		RepeatedField<int> hitFxRadialOffset = skin.HitFxRadialOffset;
		if (hitFxRadialOffset != null && hitFxRadialOffset.Count > 0)
		{
			base.actorInfo.hurtFxRadialOffsets = new List<FP> { FP.FromMyriad(skin.HitFxRadialOffset.get_Item(0)) };
			if (skin.HitFxRadialOffset.Count > 1)
			{
				base.actorInfo.hurtFxRadialOffsets.Add(FP.FromMyriad(skin.HitFxRadialOffset.get_Item(1)));
			}
			else
			{
				base.actorInfo.hurtFxRadialOffsets.Add(0);
			}
		}
		monsterToughnessInfo.toughnessBrokenTime = FP.FromMyriad(data.ToughnessBrokenTime);
		monsterToughnessInfo.toughnessCanRecover = data.IsToughnessRecorver;
		spawnerInfo.refRng = FP.FromMyriad(data.RefRng);
		spawnerInfo.actRng = FP.FromMyriad(data.ActRng);
		spawnerInfo.disActRng = FP.FromMyriad(data.DisActRng);
		monsterInfo.originEpicType = (HotfixEnum.monsterEpicType)data.EpicLv;
		monsterInfo.epicType = monsterInfo.originEpicType;
		monsterInfo.subBossType = (HotfixEnum.subBossType)data.SubBossType;
		monsterInfo.Tag1 = data.Tag1;
		monsterInfo.Tag2 = data.Tag2;
		monsterInfo.Tag3 = data.Tag3;
		monsterInfo.Tag4 = data.Tag4;
		monsterInfo.Tag5 = data.Tag5;
		monsterInfo.force = data.Force;
		monsterInfo.teamId = data.MonsterTeamId;
		monsterInfo.bloodType = (HotfixEnum.monsterBloodType)data.BloodType;
		monsterInfo.barHeight = FP.FromMyriad(skin.BarHeight);
		monsterInfo.trapTagIds = data.TrapTagIds.ToArray();
		isBorn = true;
		actorHealthInfo.isAlive = true;
		isDead = false;
		isDeclareDead = false;
		if (data.BlockPriority != 0)
		{
			_orginMovementBlockPriority = data.BlockPriority;
		}
		else
		{
			_orginMovementBlockPriority = ((base.actorInfo.moveType == HotfixEnum.actorMovType.STATIC) ? NavAgentTypeNames.UnmoveableAgentPriority : NavAgentTypeNames.MonsterAgentPriority);
		}
		ActorInfo actorInfo = base.actorInfo;
		int factionID = (base.actorInfo.originFactionID = data.Faction);
		actorInfo.factionID = factionID;
		monsterInfo.subType = (HotfixEnum.monsterSubType)data.SubType;
		base.actorInfo.supCharge = FP.FromMyriad(data.SupCharge);
		base.actorInfo.SetOriginAttributeData(data, FDP.One);
		if (!isSummonMonster)
		{
			if (actorSpawnInfo.isRoguelikeMonster)
			{
				AdventureModuleLevelLoadParams levelLoadParams = ModuleController<AdventureModuleController>.Instance.levelLoadParams;
				if (!SetRoguelikeAttrInfo(data.Templete, levelLoadParams.levelDifficultLv))
				{
					Debug.LogError($"roguelike monster templateInfo config not exist, TemplateId:{data.Templete}, spawnerInfo.level:{spawnerInfo.level}, levelDifficult:{levelLoadParams.levelDifficultLv}");
				}
			}
			else if (!SetRoguelikeAttrInfo(data.Templete, 1))
			{
				Debug.LogError($"mainline monster templateInfo config not exist, TemplateId:{data.Templete}, spawnerInfo.level:{1}");
			}
		}
		else
		{
			monsterSummonInfo?.ParseSummonCfg(cfg, actorSpawnInfo);
		}
		ModifyBattleAttr(battleLevel, out var _);
		AdventureMonsterSpawnedBeforeEvent adventureMonsterSpawnedBeforeEvent = AdventureMonsterSpawnedBeforeEvent.Generate();
		adventureMonsterSpawnedBeforeEvent.MonsterActor = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSpawnedBeforeEvent);
		SetupPrimeFSM(data.FCId);
		actorSearchTargetInfo.InitAlertRngComponent();
		UpdateNovementAgentTraversableType();
		UpdateNovementAgentAvoidanceBlockSetting();
		LoadModel((float)dtCollider.Radius, (float)dtCollider.ColliderHeight);
		monsterToughnessInfo.InitComponent();
		actorSearchTargetInfo.EnableHearingLogic();
		actorSearchTargetInfo.EnableVisionLogic();
		initBuffIds = data.BuffIds.ToList();
		_attackFSM.SetRootMotionScale(actorScaleInfo.modelScale);
		DoInit();
	}

	private void SetElementType(int elementType, IList<int> weakElementType)
	{
		if (elementType == 0)
		{
			Debug.LogError($"怪物元素类型配置错误,不能配置为继承属性,DataId:{dataID}");
		}
		actorElementInfo.originElementType = (HotfixEnum.elementType)elementType;
		actorElementInfo.elementType = actorElementInfo.originElementType;
		SetMonsterSoundType();
		if (weakElementType == null || weakElementType.Count <= 0)
		{
			return;
		}
		actorElementInfo.weakElementType.Clear();
		foreach (int item in weakElementType.ToHashSet())
		{
			if (item != 7)
			{
				if (item != elementType)
				{
					actorElementInfo.weakElementType.Add((HotfixEnum.elementType)item);
				}
				else
				{
					Debug.LogError($"弱点元素配置有误,与元素属性冲突,DataId:{dataID}");
				}
			}
		}
	}

	private void SetMonsterSoundType()
	{
		string stateName = "default";
		if (skinID > 0)
		{
			MonsterSkin monsterSkin = Singleton<HotfixDataController>.Instance.GetMonsterSkin(skinID);
			if (monsterSkin != null && monsterSkin.MonsterManual > 0)
			{
				MonsterManual monsterManual = Singleton<HotfixDataController>.Instance.GetMonsterManual(monsterSkin.MonsterManual);
				if (monsterManual != null)
				{
					RepeatedField<int> eET = monsterManual.EET;
					if (eET != null && eET.Count > 0)
					{
						stateName = (HotfixEnum.elementType)monsterManual.EET.get_Item(0) switch
						{
							HotfixEnum.elementType.AE => "wind", 
							HotfixEnum.elementType.DE => "dark", 
							HotfixEnum.elementType.FE => "fire", 
							HotfixEnum.elementType.LE => "light", 
							HotfixEnum.elementType.SE => "earth", 
							HotfixEnum.elementType.WE => "water", 
							_ => "default", 
						};
					}
				}
			}
		}
		MonoSingleton<WwiseAudioManager>.Instance?.SetSwicth("monsterType", stateName, gameObject);
	}

	public bool SetRoguelikeAttrInfo(int id, int levelDifficultLv, int percent = 100)
	{
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(id);
		if (monsterValueTempleteAdjust == null)
		{
			Debug.LogError($"找不到怪物模板校正数据，ID：{id}");
			return false;
		}
		SetElementType(monsterValueTempleteAdjust.EET, monsterValueTempleteAdjust.WeakEET);
		long num = (long)monsterValueTempleteAdjust.TemplateId * 1000L + spawnerInfo.level * 10 + levelDifficultLv;
		MonsterValueTemplete monsterValueTemplete = Singleton<HotfixDataController>.Instance.GetMonsterValueTemplete(num);
		if (monsterValueTemplete == null)
		{
			Debug.LogError($"找不到怪物模板数据，ID：{num}");
			return false;
		}
		FDP ratio = FDP.FromPercent(percent);
		actorHealthInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, ratio);
		actorInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, ratio);
		actorElementInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, ratio);
		monsterToughnessInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, ratio);
		return true;
	}

	public bool ModifyBattleAttr(int battleLevel, out string fxKey, bool isAdd = true)
	{
		fxKey = null;
		if (!HasBattleLevelUp || battleLevel <= 0)
		{
			return false;
		}
		MonsterAttributeContact monsterAttributeContact = Singleton<HotfixDataController>.Instance.GetMonsterAttributeContact(dataID);
		if (monsterAttributeContact == null)
		{
			Debug.LogError($"MonsterAttributeContact表中未找到该数据，ID：{dataID}");
			return false;
		}
		int num = monsterAttributeContact.GroupId * 1000 + Math.Clamp(battleLevel, 1, monsterAttributeContact.MaxLevel);
		MonsterValueTempleteModify monsterValueTempleteModify = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteModify(num);
		if (monsterValueTempleteModify == null)
		{
			Debug.LogError($"MonsterValueTempleteModify中未找到该数据，ID：{num}");
			return false;
		}
		fxKey = monsterValueTempleteModify.LvUpEffect;
		FDP value = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.HpFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.HpFix)));
		FDP value2 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.AtkFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.AtkFix)));
		FDP value3 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.ToughnessFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.ToughnessFix)));
		FDP value4 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.DefFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.DefFix)));
		FDP value5 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.WERFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.WERFix)));
		FDP value6 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.FERFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.FERFix)));
		FDP value7 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.SERFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.SERFix)));
		FDP value8 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.AERFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.AERFix)));
		FDP value9 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.LERFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.LERFix)));
		FDP value10 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.DERFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.DERFix)));
		FDP value11 = (isAdd ? FDP.FromConfigFloat(monsterValueTempleteModify.ENVAMENDFix) : (-FDP.FromConfigFloat(monsterValueTempleteModify.ENVAMENDFix)));
		attributeList.ChangeValue(3, 3, value);
		attributeList.ChangeValue(1, 3, value2);
		attributeList.ChangeValue(42, 3, value3);
		attributeList.ChangeValue(2, 3, value4);
		attributeList.ChangeValue(11, 3, value5);
		attributeList.ChangeValue(12, 3, value6);
		attributeList.ChangeValue(13, 3, value7);
		attributeList.ChangeValue(14, 3, value8);
		attributeList.ChangeValue(15, 3, value9);
		attributeList.ChangeValue(16, 3, value10);
		attributeList.ChangeValue(96, 3, value11);
		actorHealthInfo.hp = actorHealthInfo.hpMax;
		if (actorHealthInfo.hpMax <= 0)
		{
			Debug.LogError("战斗属性设置有误,最大血量低于0");
		}
		if (monsterInfo.subBossType == HotfixEnum.subBossType.HUNTBOSS)
		{
			int num2 = monsterAttributeContact.AtkTemplateId * 1000 + Math.Clamp(battleLevel, 1, monsterAttributeContact.MaxLevel);
			MonsterAttackAjust monsterAttackAjust = Singleton<HotfixDataController>.Instance.GetMonsterAttackAjust(num2);
			float value12 = (isAdd ? monsterAttackAjust.SwitchRate : (0f - monsterAttackAjust.SwitchRate));
			if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor)
			{
				value2 = playerAdventureActor.actorHealthInfo.hpMax * FDP.FromConfigFloat(value12);
				attributeList.ChangeValue(1, 1, value2);
			}
		}
		return true;
	}

	public bool SetAttrInfo(string attrId, int percent = 100)
	{
		Nova.Hotfix.Attribute attribute = Singleton<HotfixDataController>.Instance.GetAttribute(attrId);
		if (attribute == null)
		{
			return false;
		}
		FDP ratio = FDP.FromPercent(percent);
		actorHealthInfo.SetOriginAttributeData(attribute, ratio);
		actorInfo.SetOriginAttributeData(attribute, ratio);
		actorElementInfo.SetOriginAttributeData(attribute, ratio);
		monsterToughnessInfo.SetOriginAttributeData(attribute, ratio);
		return true;
	}

	public bool SetPlayerSummonAttrInfo(AdventureActor player, int percent = 100)
	{
		if (player == null || player.actorInfo == null || player.actorElementInfo == null || player.actorHealthInfo == null || player.actorShield == null)
		{
			return false;
		}
		FDP fDP = FDP.FromPercent(percent);
		attributeList.CopyOwnerValue(player.attributeList, fDP);
		actorHealthInfo.SetOwnerValue(player.actorHealthInfo, fDP);
		SetElementType((int)player.actorElementInfo.elementType, null);
		if (player.actorInfo.attributeWithElementOrDamageTypeDict != null)
		{
			if (actorInfo.attributeWithElementOrDamageTypeDict == null)
			{
				actorInfo.attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();
			}
			else
			{
				actorInfo.attributeWithElementOrDamageTypeDict.Clear();
			}
			foreach (KeyValuePair<int, FDP> item in player.actorInfo.attributeWithElementOrDamageTypeDict)
			{
				actorInfo.attributeWithElementOrDamageTypeDict.set_Item(item.Key, item.Value * fDP);
			}
		}
		return true;
	}

	public bool SetPlayerSummonAttrInfoBySnapshot(PlayerAdventureActor player, int percent = 100)
	{
		if (player == null)
		{
			return false;
		}
		FDP fDP = FDP.FromPercent(percent);
		attributeList.CopyOwnerValue(player.attributeListOfInitialSnapshot, fDP);
		attributeList.SetOriginIntValue(HotfixEnum.effectAttributeType.DEF, (int)(long)player.attributeList.GetBaseValue(HotfixEnum.effectAttributeType.DEF), fDP);
		attributeList.SetOriginLongValue(HotfixEnum.effectAttributeType.MAXHP, (long)player.attributeList.GetBaseValue(HotfixEnum.effectAttributeType.MAXHP), fDP);
		actorHealthInfo.hp = actorHealthInfo.hpMax;
		SetElementType((int)player.actorElementInfo.originElementType, null);
		if (player.attributeWithElementOrDamageTypeDictOfInitialSnapshot != null)
		{
			if (actorInfo.attributeWithElementOrDamageTypeDict == null)
			{
				actorInfo.attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();
			}
			else
			{
				actorInfo.attributeWithElementOrDamageTypeDict.Clear();
			}
			foreach (KeyValuePair<int, FDP> item in player.attributeWithElementOrDamageTypeDictOfInitialSnapshot)
			{
				actorInfo.attributeWithElementOrDamageTypeDict.set_Item(item.Key, item.Value * fDP);
			}
		}
		return true;
	}

	public override void SetupPrimeFSM(int aiId)
	{
		if (_primeFSM != null)
		{
			SetStateSpecialEnable(_actionState);
			return;
		}
		MonsterAI monsterAI = Singleton<HotfixDataController>.Instance.GetMonsterAI(aiId);
		if (monsterAI == null)
		{
			AI aI = Singleton<HotfixDataController>.Instance.GetAI(aiId);
			if (aI == null)
			{
				Debug.LogError($"{name},ai id not found:{aiId}");
				return;
			}
			_spawnAIPath = aI.FCSpawn;
			_actionAIPath = aI.FCAction;
			_idleAIPath = aI.FCIdle;
			_lostcontrolAIPath = aI.FCLostControl;
			_deathAIPath = aI.FCDeath;
			_parallelAIPath = aI.FCGlobal;
			_comboGroupPath = aI.FCComboGroup;
		}
		else
		{
			if (!string.IsNullOrEmpty(monsterAI.ActionAIPath))
			{
				_actionAIPath = monsterAI.ActionAIPath;
			}
			if (!string.IsNullOrEmpty(monsterAI.IdleAIPath))
			{
				_idleAIPath = monsterAI.IdleAIPath;
			}
			if (!string.IsNullOrEmpty(monsterAI.SpawnAIPath))
			{
				_spawnAIPath = monsterAI.SpawnAIPath;
			}
			if (!string.IsNullOrEmpty(monsterAI.ParallelAIPath))
			{
				_parallelAIPath = monsterAI.ParallelAIPath;
			}
			_comboGroupPath = monsterAI.ComboGroupPath;
			monsterAIInfo.checkAchievement = monsterAI.CheckAchievement;
			monsterAIInfo.spawnSkillId = monsterAI.SpawnShowSkillId;
			monsterAIInfo.idleShowSkillId = monsterAI.IdleShowSkillId;
			monsterAIInfo.deathSkillId = monsterAI.DieSkillId;
			monsterAIInfo.thinkInterval = FP.FromMyriad(monsterAI.ThinkInterval);
			monsterAIInfo.wanderInterval = FP.FromMyriad(monsterAI.WanderInterval);
			monsterAIInfo.wanderRange = FP.FromMyriad(monsterAI.WanderRange);
			monsterAIInfo.wanderRate = FP.FromMyriad(monsterAI.WanderRate);
			monsterAIInfo.actionBranchIds = monsterAI.ActionBranchIds.ToList();
			AdventureMonsterSetSFMEvent adventureMonsterSetSFMEvent = AdventureMonsterSetSFMEvent.Generate();
			adventureMonsterSetSFMEvent.owner = this;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSetSFMEvent);
		}
		base.SetupPrimeFSM(aiId);
		_primeFSM = new ActorPrimeFSM(gameObject);
		_nullState = new ActorNullState();
		_primeFSM.RegistState(_nullState);
		_spawnState = new MonsterSpawnState();
		_primeFSM.RegistState(_spawnState, _spawnAIPath);
		_idleState = new MonsterIdleState();
		_primeFSM.RegistState(_idleState, _idleAIPath);
		_actionState = new MonsterActionState();
		_primeFSM.RegistState(_actionState, _actionAIPath);
		_lostControlState = new MonsterLostControlState();
		_primeFSM.RegistState(_lostControlState, _lostcontrolAIPath);
		_deathState = new MonsterDeathState();
		_primeFSM.RegistState(_deathState, _deathAIPath);
		_clearState = new MonsterClearState();
		_primeFSM.RegistState(_clearState, _clearAIPath);
		InitParallelAI(_parallelAIPath);
		SetStateSpecialEnable(_actionState);
	}

	public void ResetPrimeFSMAI(int aiId)
	{
		if (_primeFSM == null)
		{
			return;
		}
		MonsterAI monsterAI = Singleton<HotfixDataController>.Instance.GetMonsterAI(aiId);
		if (monsterAI == null)
		{
			NovaLogger.Error($"{name},reset, ai id not found:{aiId}");
			return;
		}
		_actionAIPath = "AIScript.Monster.Template.Action";
		_spawnAIPath = "AIScript.Monster.Template.Spawn";
		_idleAIPath = "AIScript.Monster.Template.Idle";
		_lostcontrolAIPath = "";
		_deathAIPath = "AIScript.Monster.Template.Death";
		_parallelAIPath = "AIScript.Monster.Template.Parallel";
		_clearAIPath = "";
		if (!string.IsNullOrEmpty(monsterAI.ActionAIPath))
		{
			_actionAIPath = monsterAI.ActionAIPath;
		}
		if (!string.IsNullOrEmpty(monsterAI.IdleAIPath))
		{
			_idleAIPath = monsterAI.IdleAIPath;
		}
		if (!string.IsNullOrEmpty(monsterAI.SpawnAIPath))
		{
			_spawnAIPath = monsterAI.SpawnAIPath;
		}
		if (!string.IsNullOrEmpty(monsterAI.ParallelAIPath))
		{
			_parallelAIPath = monsterAI.ParallelAIPath;
		}
		_spawnState?.ResetAI(_spawnAIPath);
		_idleState?.ResetAI(_idleAIPath);
		_actionState?.ResetAI(_actionAIPath);
		_lostControlState?.ResetAI(_lostcontrolAIPath);
		_deathState?.ResetAI(_deathAIPath);
		_clearState?.ResetAI(_clearAIPath);
		SetStateSpecialEnable(_actionState);
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
		case 6:
			_clearState?.ForceStartAI();
			break;
		}
		ResetParallelAI(_parallelAIPath);
	}

	private void SetStateSpecialEnable(ActorActionState state)
	{
		state?.SetAISpecialEnable();
	}

	public override void LevelStart()
	{
		if (isDead)
		{
			return;
		}
		EnableLogicUpdate();
		Spawn();
		List<int> list = initBuffIds;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < initBuffIds.Count; i++)
			{
				buffComponent.AddBuff(initBuffIds.get_Item(i), this);
			}
		}
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
		List<int> list2 = new List<int>();
		foreach (KeyValuePair<int, int> item in dictionary)
		{
			foreach (KeyValuePair<int, RegionBossAffix> regionBossAffixDatum in Singleton<HotfixDataController>.Instance.RegionBossAffixData)
			{
				if (regionBossAffixDatum.Value.GroupId != item.Key || regionBossAffixDatum.Value.Level != item.Value)
				{
					continue;
				}
				bool flag = regionBossAffixDatum.Value.AddCamp.Contains(actorInfo.factionID);
				bool flag2 = false;
				foreach (int item2 in regionBossAffixDatum.Value.AddClass)
				{
					if (monsterInfo.epicType == (HotfixEnum.monsterEpicType)item2 || 1 == item2)
					{
						flag2 = true;
						break;
					}
				}
				if (flag2 & flag)
				{
					list2.Add(regionBossAffixDatum.Value.SkillId);
				}
				break;
			}
		}
		foreach (int item3 in list2)
		{
			buffComponent.AddBuff(item3, this);
		}
	}

	public override void LevelEnd()
	{
		Despawn();
	}

	public void EnableAlertRng()
	{
		actorSearchTargetInfo?.EnableAlertRng();
	}

	public void DisableAlertRng()
	{
		actorSearchTargetInfo?.DisableAlertRng();
	}

	public virtual void Recycle()
	{
		if (spawnPoolObj == null)
		{
			Debug.LogError("回收怪物时poolObj为空");
			return;
		}
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.En_Monster(spawnPoolObj);
		spawnPoolObj = null;
	}

	public void Despawn()
	{
		SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(this, add: false);
		if (GroupId != null)
		{
			SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(GroupId)?.RemoveMember(this);
		}
		OnShow(show: false);
		ActiveSelf = false;
	}

	protected override void UpdateNovementAgentAvoidanceBlockSetting()
	{
		if (movementAgentEnabled)
		{
			movAgent.blockLayer = RVOLayer.Layer2;
			movAgent.blockWith = RVOLayer.DefaultAgent | RVOLayer.DefaultObstacle | RVOLayer.Layer2;
			movAgent.blockPriority = _orginMovementBlockPriority;
			movAgent.blockDamp = 1;
		}
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (!isDead)
		{
			_primeFSM.OnUpdate();
			UpdateParallelAI();
			buffComponent.LogicUpdate(LogicDeltaTime);
			effectManage?.LogicUpdate(LogicDeltaTime);
			actorSkillManage?.LogicUpdate(LogicDeltaTime);
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
		visualControl.occlusionRendererOccludee.occlusionVisibleDetectEnabled = false;
		visualControl.SetCustomStencilMode(199, RendererMaterialStackComponent.StencilMode.Replace);
		visualControl.ResetRenderLayer();
		InitializeTransparentFade();
	}

	public override void PlayHurtCueEffect(GameObject source, GameObject hurtEffectPrefab, bool isHurtEffectScale, bool playFlashTint, Vector3 hitPoint = default(Vector3), Quaternion hitRotation = default(Quaternion), HotfixEnum.hurtFlashTintType flashTintType = HotfixEnum.hurtFlashTintType.NONE, bool effectIgnoreTimeScale = true)
	{
		if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.VampireInstance && monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL && hurtEffectPrefab != null)
		{
			hurtEffectPrefab = ModuleController<AdventureModuleController>.Instance.FX_VampireSurvivorSimplifyHurtFXPrefab;
		}
		base.PlayHurtCueEffect(source, hurtEffectPrefab, isHurtEffectScale, playFlashTint, hitPoint, hitRotation, flashTintType, effectIgnoreTimeScale);
	}

	public void OnMessage(IEvent evt)
	{
		if (!(evt.type != "ADVENTURE_ACTOR_GROUP_ATTACK_THREAT_ALERT"))
		{
			switch (state)
			{
			case ActorState.Idle:
				EnterAction();
				break;
			case ActorState.Spawn:
				delayEnterAction = true;
				break;
			}
		}
	}

	public void CheckDelayEnterAction()
	{
		if (delayEnterAction)
		{
			delayEnterAction = false;
			EnterAction();
		}
	}

	protected void EnterAction()
	{
		Action(makeThreatAlert: false);
		SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(this);
	}

	public void SetScoreBossBehaviour(int behavior)
	{
		ScoreBossBehavior = behavior;
	}

	public bool CheckScoreBossBehaviour(int behavior)
	{
		return ScoreBossBehavior == behavior;
	}

	public void TriggerScoreBossBehaviour(int behavior)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("ScoreBoss_BehaviorScore", Id, behavior);
	}

	private void LateUpdate()
	{
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		if (SceneSingleton<AdventureModuleDebugHelper>.Instance.MonsterGizmo | flag)
		{
			Transform transform = base.transform;
			Vector3 position = transform.position;
			Vector3 forward = transform.forward;
			float radius = (float)dtCollider.Radius;
			AdventureSkill firstSkill = actorSkillManage.FirstSkill;
			string stateName = $"{state} --> {movementState} --> {attackState}";
			string skillName = ((firstSkill != null) ? $"skill_{firstSkill.skillId}" : null);
			string actorName = $"monster_{dataID}_{Id}_setId{gmSetId}";
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowMonsterGizmo(position, forward, Vector3.up, radius, actorName, stateName, skillName, color1);
		}
		if (SceneSingleton<AdventureModuleDebugHelper>.Instance.MonsterPathGizmo || (flag & flag4))
		{
			Transform transform2 = base.transform;
			float y = transform2.position.y;
			if (movAgent.hasPath && !movAgent.reachedDestination)
			{
				movAgent.GetRemainingPath(points, out var _);
				SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowPathGizmo(points, y, 0.2f, color2);
			}
			else if (_movementFSM.GetCurStateID() != 7 && _movementFSM.moveMode == ActorMoveState.MoveMode.MoveToTarget)
			{
				Vector3 position2 = transform2.position;
				points.Clear();
				points.Add(new TSVector(position2.x, 0f, position2.z));
				if (_movementFSM.trackTarget != null)
				{
					position2 = _movementFSM.trackTarget.gameObject.transform.position;
					points.Add(new TSVector(position2.x, 0, position2.z));
				}
				else
				{
					points.Add(new TSVector(_movementFSM.targetPosition.x, 0, _movementFSM.targetPosition.y));
				}
				SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowPathGizmo(points, y, 0.2f, color3);
			}
		}
		if ((SceneSingleton<AdventureModuleDebugHelper>.Instance.HearingGizmoForMonster || (flag & flag2)) && actorSearchTargetInfo.enableHearingLogic)
		{
			FP fP = actorSearchTargetInfo.hearRange + dtCollider.Radius;
			Vector3 position3 = base.transform.position;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCircleGizmo(position3, Vector3.up, (float)fP, AdventureModuleController.Config.SearchRangeGizmoColor);
			fP = actorSearchTargetInfo.hearAttackRange + dtCollider.Radius;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCircleGizmo(position3, Vector3.up, (float)fP, AdventureModuleController.Config.AttackRangeGizmoColor);
		}
		if ((SceneSingleton<AdventureModuleDebugHelper>.Instance.VisionGizmoForMonster || (flag & flag3)) && actorSearchTargetInfo.enableVisionLogic)
		{
			FP fP2 = actorSearchTargetInfo.visionRange + dtCollider.Radius;
			Vector3 position4 = base.transform.position;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowFanGizmo(position4, (float)fP2, (float)actorSearchTargetInfo.visionDeg, (float)tsTransform.Forward.GetAngle(), AdventureModuleController.Config.SearchRangeGizmoColor);
			fP2 = actorSearchTargetInfo.visionAttackRange + dtCollider.Radius;
			SceneSingleton<AdventureModuleDebugHelper>.Instance.ShowCircleGizmo(position4, Vector3.up, (float)fP2, AdventureModuleController.Config.AttackRangeGizmoColor);
		}
	}
}
