#define LOG_ERROR
using System.Collections.Generic;
using AIScript.Monster.Soldier;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class SoldierActor : DynamicActor
{
	public enum SoldierRole
	{
		Battle,
		Support
	}

	private int nPotentialLv;

	private int nEnemyCampLv;

	private int _configBlockPriority;

	public SoldierRole soldierRole;

	public int gridIndex;

	public bool isEnemyCamp;

	public SoldierBaseAI soldierAI;

	public bool isCastingSupport;

	public HotfixEnum.ChessAssistOnStageType onStageType;

	public int normalSkillId;

	public int mainSkillId;

	public int supportSkillId;

	public FP normalAttackRadius;

	public FP skillRadius;

	public bool stopNormalAttack;

	public int spawnSkillSkillId;

	public bool isAimAtTarget;

	private bool isHideBlood;

	private static readonly int kMoYuBuffTag = CommonHelper.StringToHash("Soldier_MoYu");

	public int energy;

	public int maxEnergy = 100;

	private FP _energyRecoverRateFP = 10;

	private FP _energyRecoverRateMulFP = FP.One;

	public bool isSkillEndStartRecover;

	private FP _energyAccum;

	private bool _suspendEnergyRegen;

	private FP _energyTickTimer;

	private static readonly FP kEnergyTickInterval = 0.2;

	public override bool UseInheritElementOnHit => true;

	public MonsterInfo monsterInfo { get; protected set; }

	public SoldierChessAI soldierChessAI { get; protected set; }

	public bool isSupport => soldierRole == SoldierRole.Support;

	public float energyRecoverRate
	{
		get
		{
			return _energyRecoverRateFP.AsFloat();
		}
		set
		{
			_energyRecoverRateFP = FP.FromConfigFloat(value);
		}
	}

	public FP EnergyRecoverRateFP => _energyRecoverRateFP;

	public bool isEnergyFull => energy >= maxEnergy;

	protected override void OnInit()
	{
		base.OnInit();
		monsterInfo = AddOrGetLogicComponent<MonsterInfo>();
	}

	public void LoadData(SoldierCharacter data, SoldierSkin skin, int potentialLv, int enemyCampLv, SoldierRole role = SoldierRole.Battle, SoldierActor summoner = null, bool inheritAttr = true)
	{
		soldierRole = role;
		actorSearchTargetInfo.monsterSearchRange = FP.FromMyriad(data.SearchRadius);
		normalAttackRadius = FP.FromMyriad(data.NormalAttackRadius);
		skillRadius = FP.FromMyriad(data.SkillRadius);
		stopNormalAttack = data.StopNormalAttack;
		dataID = data.Id;
		if (!string.IsNullOrEmpty(data.Name))
		{
			actorInfo.actorName = data.Name;
		}
		skinID = skin.Id;
		nPotentialLv = potentialLv;
		nEnemyCampLv = enemyCampLv;
		normalSkillId = data.Normal;
		mainSkillId = data.Skill;
		supportSkillId = data.Support;
		isAimAtTarget = data.AimAtTarget;
		isHideBlood = data.HideBlood;
		isSkillEndStartRecover = data.SkillEndStartRecover;
		_configBlockPriority = data.BlockPriority;
		if (isSupport)
		{
			onStageType = (HotfixEnum.ChessAssistOnStageType)data.AssistSkillOnStageType;
			actorInfo.originAssistSkillOnStageOrientation = (HotfixEnum.AssistOnStageOrientation)data.AssistSkillOnStageOrientation;
			actorInfo.assistSkillOnStageOrientation = actorInfo.originAssistSkillOnStageOrientation;
			actorInfo.originAssistSkillAngle = FP.FromMyriad(data.AssistSkillAngle);
			actorInfo.assistSkillAngle = actorInfo.originAssistSkillAngle;
			actorInfo.originAssistSkillRadius = FP.FromMyriad(data.AssistSkillRadius);
			actorInfo.assistSkillRadius = actorInfo.originAssistSkillRadius;
		}
		maxEnergy = data.Energy;
		energy = data.InitialEnergy;
		energyRecoverRate = data.Recovery;
		forbiddenBehitRot = skin.ForbiddenBehitRot;
		monsterInfo.barHeight = FP.FromMyriad(skin.BarHeight);
		actorScaleInfo.originModelScale = FP.FromMyriad(skin.ModelScale);
		actorScaleInfo.modelScale = actorScaleInfo.originModelScale;
		actorScaleInfo.originColliderScale = FP.FromMyriad(skin.ColliderScale);
		actorScaleInfo.colliderScale = actorScaleInfo.originColliderScale;
		actorInfo.originMoveType = HotfixEnum.actorMovType.WALK;
		actorInfo.moveType = actorInfo.originMoveType;
		actorInfo.factionID = data.Faction;
		actorInfo.originRunSpeed = FP.FromMyriad(data.RunSpd);
		actorInfo.runSpeed = actorInfo.originRunSpeed;
		actorInfo.fastRunSpeed = FP.FromMyriad(data.SpRunSpd);
		actorInfo.transSpd = FP.FromMyriad(data.TransSpd);
		actorInfo.transSpdScale = ((actorInfo.originRunSpeed > 0) ? (actorInfo.transSpd / actorInfo.originRunSpeed) : ((FP)0));
		actorInfo.walktoRunDuration = FP.FromMyriad(data.WalkToRunDuration);
		actorInfo.originWalkSpeed = FP.FromMyriad(data.WalkSpd);
		actorInfo.walkSpeed = actorInfo.originWalkSpeed;
		actorInfo.moveAcceleration = FP.FromMyriad(data.MovAcc);
		actorInfo.moveDeceleration = FP.FromMyriad(data.MovAcc);
		actorInfo.moveRotationSpeed = FP.FromMyriad(data.RotSpd);
		_energyRecoverRateMulFP = FP.One;
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		SoldierLevelController.SoldierMsg value;
		if ((summoner != null) & inheritAttr)
		{
			SetSummonerAttrInfo(summoner);
			maxEnergy = summoner.maxEnergy;
			energy = summoner.energy;
			_energyRecoverRateFP = summoner._energyRecoverRateFP;
			_energyRecoverRateMulFP = summoner._energyRecoverRateMulFP;
			attackTarget = summoner.attackTarget;
			soldierAttackTarget = summoner.soldierAttackTarget;
		}
		else if (!isEnemyCamp && soldierLevelController != null && soldierLevelController.dicSoldierMsg.TryGetValue(data.Id, out value))
		{
			SoldierLevelController.SoldierAttr soldierAttr = value.soldierAttr;
			maxEnergy = soldierAttr.Energy;
			energy = soldierAttr.InitialEnergy;
			energyRecoverRate = soldierAttr.Recovery;
			attributeList.SetOriginFloatValue(HotfixEnum.effectAttributeType.ATKSPD_P, FDP.FromMyriad(soldierAttr.ATKSPD_P), FDP.One);
			attributeList.SetOriginLongValue(HotfixEnum.effectAttributeType.MAXHP, soldierAttr.HpMax, FDP.One);
			actorHealthInfo.hp = soldierAttr.Hp;
			attributeList.SetOriginIntValue(HotfixEnum.effectAttributeType.ATK, soldierAttr.Atk, FDP.One);
			attributeList.SetOriginIntValue(HotfixEnum.effectAttributeType.DEF, soldierAttr.Def, FDP.One);
			attributeList.SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITRATE, soldierAttr.CritRate, FDP.One);
			attributeList.SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITRESIST, soldierAttr.CritResistance, FDP.One);
			attributeList.SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITPOWER_P, soldierAttr.CritPower, FDP.One);
			attributeList.SetOriginIntFloatValue(HotfixEnum.effectAttributeType.HITRATE, soldierAttr.HitRate, FDP.One);
			attributeList.SetOriginIntFloatValue(HotfixEnum.effectAttributeType.EVD, soldierAttr.Evd, FDP.One);
			attributeList.SetOriginIntValue(HotfixEnum.effectAttributeType.PENETRATE, soldierAttr.DefPierce, FDP.One);
			attributeList.SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEF_IGNORE, soldierAttr.DefIgnore, FDP.One);
			attributeList.SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SUPPRESS, soldierAttr.Suppress, FDP.One);
			SetElementType(7, null);
		}
		else
		{
			SetAttrInfo(data.Templete);
		}
		SetupPrimeFSM(data.AIID);
		LoadModel((float)dtCollider.Radius, (float)dtCollider.ColliderHeight);
		actorInfo.runAnimationSpd = FP.FromMyriad(skin.RunAnimationSpd);
		actorInfo.walkAnimationSpd = FP.FromMyriad(skin.WalkAnimationSpd);
		isDead = false;
		isDeclareDead = false;
		actorHealthInfo.isAlive = true;
		if (!isSupport)
		{
			OnShow(show: true);
		}
		if (!isEnemyCamp)
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("SoldierActor_Spawn", data.Id, Id);
			soldierLevelController?.SetSoldierDamageID(Id);
		}
		_energyTickTimer = 0;
		_energyAccum = 0;
		isCastingSupport = false;
		_suspendEnergyRegen = false;
		soldierAI = null;
		if (dtCollider != null)
		{
			ignoreDeterministicCollision = false;
		}
	}

	public int GetPotentialLv()
	{
		return nPotentialLv;
	}

	private bool SetSummonerAttrInfo(SoldierActor summoner, int percent = 100)
	{
		if (summoner == null || summoner.actorInfo == null || summoner.actorElementInfo == null || summoner.actorHealthInfo == null)
		{
			return false;
		}
		FDP fDP = FDP.FromPercent(percent);
		attributeList.CopyOwnerValue(summoner.attributeList, fDP);
		actorHealthInfo.SetOwnerValue(summoner.actorHealthInfo, fDP);
		SetElementType((int)summoner.actorElementInfo.elementType, null);
		if (summoner.actorInfo.attributeWithElementOrDamageTypeDict != null)
		{
			if (actorInfo.attributeWithElementOrDamageTypeDict == null)
			{
				actorInfo.attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();
			}
			else
			{
				actorInfo.attributeWithElementOrDamageTypeDict.Clear();
			}
			foreach (KeyValuePair<int, FDP> item in summoner.actorInfo.attributeWithElementOrDamageTypeDict)
			{
				actorInfo.attributeWithElementOrDamageTypeDict.set_Item(item.Key, item.Value * fDP);
			}
		}
		return true;
	}

	private bool SetAttrInfo(int templeteId, int percent = 100)
	{
		_ = ModuleController<AdventureModuleController>.Instance.levelLoadParams;
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(templeteId);
		if (monsterValueTempleteAdjust == null)
		{
			Debug.LogError($"Tower templeteInfo adjust config not exist, Templete:{templeteId} ");
			return false;
		}
		SetElementType(7, null);
		long num = 0L;
		num = (isEnemyCamp ? ((long)monsterValueTempleteAdjust.TemplateId * 1000L + 10 + nEnemyCampLv) : ((long)monsterValueTempleteAdjust.TemplateId * 1000L + 10 + nPotentialLv));
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
		if (isEnemyCamp)
		{
			SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
			int key = ((soldierLevelController != null) ? soldierLevelController.EnemyAmendLv : 0);
			int num2 = ((soldierLevelController != null) ? soldierLevelController.RatioStage : 0);
			SoldierDifficultyAdjustGrade soldierDifficultyAdjustGrade = Singleton<HotfixDataController>.Instance.GetSoldierDifficultyAdjustGrade(key);
			if (soldierDifficultyAdjustGrade != null)
			{
				switch (num2)
				{
				case 1:
					attributeList.ChangeValue(1, 2, FDP.FromMyriad(soldierDifficultyAdjustGrade.AtkRatio1));
					attributeList.ChangeValue(3, 2, FDP.FromMyriad(soldierDifficultyAdjustGrade.HpRatio1));
					break;
				case 2:
					attributeList.ChangeValue(1, 2, FDP.FromMyriad(soldierDifficultyAdjustGrade.AtkRatio2));
					attributeList.ChangeValue(3, 2, FDP.FromMyriad(soldierDifficultyAdjustGrade.HpRatio2));
					break;
				case 3:
					attributeList.ChangeValue(1, 2, FDP.FromMyriad(soldierDifficultyAdjustGrade.AtkRatio3));
					attributeList.ChangeValue(3, 2, FDP.FromMyriad(soldierDifficultyAdjustGrade.HpRatio3));
					break;
				}
			}
		}
		return true;
	}

	private void SetElementType(int elementType, IList<int> weakElementType)
	{
		actorElementInfo.originElementType = (HotfixEnum.elementType)elementType;
		actorElementInfo.elementType = actorElementInfo.originElementType;
	}

	private void OnBuffUIEvent(int uid, int buffID, int count, FP cd)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("BuffUIEvent", Id, uid, buffID, (float)cd, count);
	}

	protected void OnGetBuff(IEvent evt)
	{
		if (!isEnemyCamp)
		{
			AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
			if (!(adventureActorGetBuff.from != this) && adventureActorGetBuff.eventInfo.buffTags.Contains(kMoYuBuffTag))
			{
				MonoSingleton<LuaManager>.Instance?.FireEntityEvent("Event_SoldierMoYu", Id, a1: true);
			}
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (!isEnemyCamp)
		{
			AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
			if (evt is AdventureActorRemoveBuff && !(evt.sender as AdventureActor != this) && adventureActorRemoveBuff.eventInfo.buffTags.Contains(kMoYuBuffTag))
			{
				MonoSingleton<LuaManager>.Instance?.FireEntityEvent("Event_SoldierMoYu", Id, a1: false);
			}
		}
	}

	public LogicEntity FindNearestConfrontTarget()
	{
		if (soldierAI == null)
		{
			return null;
		}
		LogicEntity logicEntity = soldierAI.FindNearestConfrontTarget();
		if (logicEntity != null)
		{
			SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
			SoldierActor soldierActor = ((soldierLevelController != null) ? soldierLevelController.GetMainControlActor(isEnemyCamp) : null);
			if (soldierActor != null)
			{
				soldierActor.monsterTarget = logicEntity;
			}
			soldierAttackTarget = logicEntity;
		}
		return logicEntity;
	}

	public bool HasPartnerType(HotfixEnum.ChessPartnerType type)
	{
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		if (soldierLevelController != null && soldierLevelController.PartnerDic.ContainsKey((int)type))
		{
			List<int> list = soldierLevelController.PartnerDic.get_Item((int)type);
			for (int i = 0; i < list.Count; i++)
			{
				if (list.get_Item(i) == dataID)
				{
					return true;
				}
			}
		}
		return false;
	}

	public int GetTotalCost()
	{
		SoldierCharacter soldierCharacter = Singleton<HotfixDataController>.Instance.GetSoldierCharacter(dataID);
		return nPotentialLv switch
		{
			1 => soldierCharacter.Cost, 
			2 => soldierCharacter.Cost * 3, 
			3 => soldierCharacter.Cost * 9, 
			_ => 1, 
		};
	}

	public void ConsumeEnergy()
	{
		energy = 0;
		_energyAccum = 0;
		_energyTickTimer = 0;
		ReportEnergyToLua();
	}

	public void BeginEnergyRegenSuspend()
	{
		_suspendEnergyRegen = true;
	}

	public void EndEnergyRegenSuspend()
	{
		if (_suspendEnergyRegen)
		{
			_suspendEnergyRegen = false;
			_energyTickTimer = kEnergyTickInterval;
		}
	}

	private void TickEnergy()
	{
		if (_suspendEnergyRegen)
		{
			return;
		}
		_energyTickTimer += LogicDeltaTime;
		if (_energyTickTimer < kEnergyTickInterval)
		{
			return;
		}
		_energyTickTimer -= kEnergyTickInterval;
		if (energy < maxEnergy)
		{
			_energyAccum += kEnergyTickInterval * (_energyRecoverRateFP * _energyRecoverRateMulFP);
			if (_energyAccum >= 1)
			{
				int num = (int)(long)_energyAccum;
				energy += num;
				_energyAccum -= (FP)num;
				if (energy >= maxEnergy)
				{
					energy = maxEnergy;
					_energyAccum = 0;
				}
			}
		}
		else
		{
			energy = maxEnergy;
			_energyAccum = 0;
		}
		ReportEnergyToLua();
	}

	private void ReportEnergyToLua()
	{
		if (!isEnemyCamp && maxEnergy > 0)
		{
			MonoSingleton<LuaManager>.Instance?.FireEntityEvent("Soldier_EnergyChange", Id, energy, maxEnergy, energyRecoverRate);
		}
	}

	public void SetEnergy(int value)
	{
		if (value < 0)
		{
			value = 0;
		}
		else if (value > maxEnergy)
		{
			value = maxEnergy;
		}
		energy = value;
		_energyAccum = 0;
		ReportEnergyToLua();
	}

	public void SetMaxEnergy(int value)
	{
		if (value < 0)
		{
			value = 0;
		}
		maxEnergy = value;
		if (energy > maxEnergy)
		{
			energy = maxEnergy;
			_energyAccum = 0;
		}
		ReportEnergyToLua();
	}

	public void SetEnergyRecoverRate(float value)
	{
		if (value < 0f)
		{
			value = 0f;
		}
		energyRecoverRate = value;
		ReportEnergyToLua();
	}

	public void SetEnergyRecoverRateFP(FP value)
	{
		if (value < 0)
		{
			value = 0;
		}
		_energyRecoverRateFP = value;
		ReportEnergyToLua();
	}

	public void SetEnergyRecoverRatePercent(FP delta)
	{
		_energyRecoverRateMulFP += delta;
		if (_energyRecoverRateMulFP < FP.Zero)
		{
			_energyRecoverRateMulFP = FP.Zero;
		}
		ReportEnergyToLua();
	}

	public void ModifyEnergyRecoverRatePercent(FP value)
	{
		SetEnergyRecoverRatePercent(value);
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
		visualControl.materialController.MaterialsSetStencilMode(199, RendererMaterialStackComponent.StencilMode.Replace, setToOriginMaterial: true);
		visualControl.ResetRenderLayer();
	}

	protected override bool TryOverrideSkillLevel(HotfixEnum.levelTypeData type, out int overriddenLevel)
	{
		if (type == HotfixEnum.levelTypeData.SkillSlot)
		{
			overriddenLevel = nPotentialLv;
			return true;
		}
		return base.TryOverrideSkillLevel(type, out overriddenLevel);
	}

	public override void SetupPrimeFSM(int aiId)
	{
		soldierChessAI = Singleton<HotfixDataController>.Instance.GetSoldierChessAI(aiId);
		if (soldierChessAI == null)
		{
			NovaLogger.Error($"{name}, AutoChessAI not found:{aiId}");
			return;
		}
		spawnSkillSkillId = PickSpawnSkill(isEnemyCamp ? nEnemyCampLv : nPotentialLv);
		_comboGroupPath = soldierChessAI.ComboGroupPath;
		if (_primeFSM == null)
		{
			_primeFSM = new ActorPrimeFSM(gameObject);
			_nullState = new ActorNullState();
			_primeFSM.RegistState(_nullState);
			_actionState = new ActorActionState();
			_primeFSM.RegistState(_actionState, soldierChessAI.ActionAIPath);
			InitParallelAI(soldierChessAI.ParallelAIPath);
			base.SetupPrimeFSM(aiId);
			_spawnState = new SoldierActorSpawnState();
			_primeFSM.RegistState(_spawnState, "AIScript.Monster.Soldier.Spawn");
			_deathState = new SoldierActorDeathState();
			_primeFSM.RegistState(_deathState, "AIScript.Monster.Soldier.Death");
		}
	}

	private int PickSpawnSkill(int lv)
	{
		return lv switch
		{
			1 => soldierChessAI.SpawnSkill1, 
			2 => soldierChessAI.SpawnSkill2, 
			_ => soldierChessAI.SpawnSkill3, 
		};
	}

	public override void LevelStart()
	{
		if (!isDead)
		{
			EnableLogicUpdate();
			Spawn();
			if (isSupport)
			{
				ApplySupportImmunity();
			}
		}
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (!isDead)
		{
			if (actorHealthInfo.isAlive)
			{
				TickEnergy();
			}
			_primeFSM?.OnUpdate();
			UpdateParallelAI();
			actorSkillManage?.LogicUpdate(LogicDeltaTime);
			attackFSM?.OnUpdate();
			movementFSM?.OnUpdate();
			buffComponent?.LogicUpdate(LogicDeltaTime);
			effectManage?.LogicUpdate(LogicDeltaTime);
			updateTime();
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
		buffComponent.BuffUIEvent += OnBuffUIEvent;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		buffComponent.BuffUIEvent -= OnBuffUIEvent;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	protected override void UpdateNovementAgentAvoidanceBlockSetting()
	{
		if (movementAgentEnabled)
		{
			if (_configBlockPriority != 0)
			{
				_orginMovementBlockPriority = _configBlockPriority;
			}
			else
			{
				_orginMovementBlockPriority = (isEnemyCamp ? 2 : 3);
			}
			movAgent.blockPriority = _orginMovementBlockPriority;
			movAgent.blockDamp = 1;
		}
	}

	public void Despawn()
	{
		OnShow(show: false);
		ActiveSelf = false;
	}

	public void OnShowHud(bool show)
	{
		if (!isSupport)
		{
			if (!isEnemyCamp)
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("PlayerShow", Id, show);
			}
			else
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("MonsterHUDChange", Id, 1, show, dataID);
			}
		}
	}

	protected override void OnShow(bool show)
	{
		base.OnShow(show);
		if (!show || !isHideBlood)
		{
			OnShowHud(show);
		}
	}

	private void ApplySupportImmunity()
	{
		while (isHide)
		{
			Visible();
		}
		Hide();
		EnableSearchedImmunity();
		EnableUnparalleled();
		EnableCloseBlock();
		if (dtCollider != null)
		{
			ignoreDeterministicCollision = true;
		}
	}

	public void EnterSupportCastStance(TSVector2 position, TSVector2 forward = default(TSVector2))
	{
		tsTransform.Position = position;
		tsTransform.PositionY = 0;
		if (forward.x != 0 || forward.y != 0)
		{
			tsTransform.Forward = forward;
		}
		SyncMovementLocation();
		while (isHide)
		{
			Visible();
		}
		if (comboGroup != null && comboGroup.switchInEffect != null)
		{
			attackFSM?.PlayEffect(oneShot: true, -1, comboGroup.switchInEffect, tsTransform.Position, tsTransform.PositionY, tsTransform.Rotation, bindActor: false);
		}
	}

	public void ExitSupportCastStance()
	{
		if (comboGroup != null && comboGroup.switchOutEffect != null)
		{
			attackFSM?.PlayEffect(oneShot: true, -1, comboGroup.switchOutEffect, tsTransform.Position, tsTransform.PositionY, tsTransform.Rotation, bindActor: false);
		}
		if (!isHide)
		{
			Hide();
		}
	}

	public void PromoteToBattle()
	{
		if (isSupport)
		{
			soldierRole = SoldierRole.Battle;
			SoldierCharacter soldierCharacter = Singleton<HotfixDataController>.Instance.GetSoldierCharacter(dataID);
			if (soldierCharacter != null)
			{
				normalSkillId = soldierCharacter.Normal;
				mainSkillId = soldierCharacter.Skill;
			}
			supportSkillId = 0;
			onStageType = HotfixEnum.ChessAssistOnStageType.NotAppearing;
			energy = 0;
			_energyAccum = 0;
			_energyTickTimer = 0;
			EndEnergyRegenSuspend();
			isCastingSupport = false;
			DisableSearchedImmunity();
			DisableUnparalleled();
			if (dtCollider != null)
			{
				ignoreDeterministicCollision = false;
			}
			DisableCloseBlock();
			while (isHide)
			{
				Visible();
			}
			if (!isHideBlood)
			{
				OnShowHud(show: true);
			}
			(ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController)?.NotifySupportPromoted(this);
		}
	}
}
