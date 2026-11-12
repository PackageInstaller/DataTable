using System;
using System.Collections.Generic;
using AIScript.Utils;
using Nova.Hotfix;
using Pathfinding.RVO;
using TrueSync;
using UnityEngine;

namespace AIScript.DynamicLevel;

public class TowerDefenseCharacterActor : DynamicActor
{
	private static string spawnAIPath = "AIScript.Monster.TowerDefense.TowerCharacterSpawn";

	private static string deathAIPath = "AIScript.Monster.TowerDefense.TowerCharacterDeath";

	public FP SearchRange;

	private FP _extraSearchRange;

	public Action<TowerDefenseCharacterActor> onEffectiveSearchRangeChanged;

	public FP perTargetExtraSearchRange;

	public Predicate<LogicEntity> perTargetExtraSearchRangeFilter;

	public HotfixEnum.characterSearchTargetTypeTowerDefense SearchType;

	public int deathSkillId;

	public int spawnSkillId;

	public int normalSkillId;

	public int mainSkillId;

	public FP maxEnergy;

	public bool beginEnergyOnCast;

	public TowerCharacterSkillCom skillMgr;

	private bool isActive;

	public FP startEnergy;

	public bool IsShapeshifter;

	private bool isHotLevel;

	public FP fireHeatValue;

	private bool IsInSpray;

	private bool _isHeatstroke;

	private bool _isHotWarning;

	private FP fireDelta;

	private FP SprayDelta;

	private FP curTime;

	private FP deltaHeatValue;

	private bool _isBreak;

	private List<LogicEntity> entities = new List<LogicEntity>();

	private LogicEntity lastTarget;

	private TowerMonsterInfo lastCom;

	public FP extraSearchRange
	{
		get
		{
			return _extraSearchRange;
		}
		set
		{
			if (!(_extraSearchRange == value))
			{
				_extraSearchRange = value;
				onEffectiveSearchRangeChanged?.Invoke(this);
			}
		}
	}

	public FP EffectiveSearchRange => SearchRange + _extraSearchRange;

	public bool IsActive => isActive;

	public bool IsHotLevel => isHotLevel;

	public bool IsBreak => _isBreak;

	protected override void OnInit()
	{
		base.OnInit();
		skillMgr = AddOrGetLogicComponent<TowerCharacterSkillCom>();
	}

	public void LoadData(TowerDefenseCharacter data, MonsterSkin skin, bool isHotLevel)
	{
		this.isHotLevel = isHotLevel;
		dataID = data.Id;
		skinID = skin.Id;
		normalSkillId = data.NormalAtkId;
		mainSkillId = data.SkillId;
		maxEnergy = FP.FromMyriad(data.SkillCd);
		beginEnergyOnCast = data.CdStartTime;
		actorScaleInfo.originModelScale = FP.FromMyriad(skin.ModelScale);
		actorScaleInfo.modelScale = actorScaleInfo.originModelScale;
		base.actorInfo.originMoveType = HotfixEnum.actorMovType.STATIC;
		base.actorInfo.moveType = base.actorInfo.originMoveType;
		UpdateNovementAgentAvoidanceBlockSetting();
		ActorInfo actorInfo = base.actorInfo;
		int factionID = (base.actorInfo.originFactionID = data.Faction);
		actorInfo.factionID = factionID;
		base.actorInfo.moveAcceleration = 99999;
		base.actorInfo.moveRotationSpeed = 10;
		SearchRange = FP.FromMyriad(data.SearchRadius);
		startEnergy = FP.FromMyriad(data.SkillStartCharge);
		IsShapeshifter = data.IsShapeshifter;
		SetAttrInfo(data.Templete);
		SetSearchInfo((HotfixEnum.characterSearchTargetTypeTowerDefense)data.SearchTargetType);
		SetupPrimeFSM(data.AIId);
		LoadModel((float)dtCollider.Radius, (float)dtCollider.ColliderHeight);
		attackFSM.SetRootMotionScale(actorScaleInfo.modelScale);
		isDead = false;
		isDeclareDead = false;
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
		SetElementType(monsterValueTempleteAdjust.EET, monsterValueTempleteAdjust.WeakEET);
		long num = (long)monsterValueTempleteAdjust.TemplateId * 1000L + 10 + 1;
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
		return true;
	}

	protected override void UpdateNovementAgentAvoidanceBlockSetting()
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

	private void SetElementType(int elementType, IList<int> weakElementType)
	{
		actorElementInfo.originElementType = (HotfixEnum.elementType)elementType;
		actorElementInfo.elementType = actorElementInfo.originElementType;
	}

	private void SetSearchInfo(HotfixEnum.characterSearchTargetTypeTowerDefense searchType)
	{
		SearchType = searchType;
	}

	public override void SetupPrimeFSM(int aiId)
	{
		if (_primeFSM == null)
		{
			TowerDefenceCharacterAI towerDefenceCharacterAI = Singleton<HotfixDataController>.Instance.GetTowerDefenceCharacterAI(aiId);
			if (towerDefenceCharacterAI != null)
			{
				_comboGroupPath = towerDefenceCharacterAI.ComboGroupPath;
				deathSkillId = towerDefenceCharacterAI.DieSkillId;
				spawnSkillId = towerDefenceCharacterAI.SpawnShowSkillId;
				_primeFSM = new ActorPrimeFSM(gameObject);
				_nullState = new ActorNullState();
				_primeFSM.RegistState(_nullState);
				_spawnState = new ActorSpawnState();
				_primeFSM.RegistState(_spawnState, spawnAIPath);
				_actionState = new ActorActionState();
				_primeFSM.RegistState(_actionState, towerDefenceCharacterAI.ActionAIPath);
				_deathState = new TowerCharacterDeathState();
				_primeFSM.RegistState(_deathState, deathAIPath);
				InitParallelAI(towerDefenceCharacterAI.ParallelAIPath);
			}
			base.SetupPrimeFSM(aiId);
		}
	}

	public void UpdateFireBaseValue(FP baseFireDelta)
	{
		fireDelta = baseFireDelta;
		Debug.Log($"==>{dataID}: 当前升温率:{fireDelta}");
	}

	public void UpdateSparayBaseValue(FP syaryFireDelta)
	{
		SprayDelta += syaryFireDelta;
		Debug.Log($"==>{dataID}: 当前降温率:{SprayDelta}");
		if (SprayDelta > 0)
		{
			IsInSpray = true;
			buffComponent.AddBuff(TowerDefenseConfig.buffId_Cool, this);
			if (_isHeatstroke)
			{
				buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_Heatstroke);
			}
		}
		else
		{
			IsInSpray = false;
			buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_Cool);
			if (_isHeatstroke)
			{
				buffComponent.AddBuff(TowerDefenseConfig.buffId_Heatstroke, this);
			}
		}
	}

	private void UpdateHeatTick()
	{
		if (curTime > TowerDefenseConfig.interval_HotOrCool)
		{
			curTime -= TowerDefenseConfig.interval_HotOrCool;
			FP delta = (_isHeatstroke ? (-TowerDefenseConfig.Spray_Cool) : fireDelta);
			delta += (IsInSpray ? (-SprayDelta) : ((FP)0));
			UpdateFire(delta);
		}
		curTime += LogicDeltaTime;
	}

	public void UpdateFire(FP delta)
	{
		if (!isHotLevel)
		{
			return;
		}
		fireHeatValue += delta;
		fireHeatValue = TSMath.Clamp(fireHeatValue, TowerDefenseConfig.HEATSTROKE_MIN, TowerDefenseConfig.HEATSTROKE_THRESHOLD);
		deltaHeatValue += delta;
		int num = TSMath.Abs(deltaHeatValue).AsInt();
		int num2 = ((deltaHeatValue >= 0) ? num : (-num));
		deltaHeatValue -= (FP)num2;
		UpdateHotWarning();
		int buffID = (_isHotWarning ? TowerDefenseConfig.buffId_HotUp_Warning : TowerDefenseConfig.buffId_HotUp);
		if (num2 > 0)
		{
			if (_isHeatstroke)
			{
				buffComponent.AddBuffNum(TowerDefenseConfig.buffId_HotDown, num2, this);
			}
			else
			{
				buffComponent.AddBuffNum(buffID, num2, this);
			}
		}
		else if (num2 < 0)
		{
			if (_isHeatstroke)
			{
				int buffNumByID = buffComponent.GetBuffNumByID(TowerDefenseConfig.buffId_HotDown);
				if (buffNumByID > TowerDefenseConfig.HEATSTROKE_MIN)
				{
					int reduceNum = Mathf.Min(buffNumByID - TowerDefenseConfig.HEATSTROKE_MIN, -num2);
					buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_HotDown, reduceNum);
				}
			}
			else
			{
				int buffNumByID2 = buffComponent.GetBuffNumByID(buffID);
				if (buffNumByID2 > TowerDefenseConfig.HEATSTROKE_MIN)
				{
					int reduceNum2 = Mathf.Min(buffNumByID2 - TowerDefenseConfig.HEATSTROKE_MIN, -num2);
					buffComponent.RemoveBuffByBuffId(buffID, reduceNum2);
				}
			}
		}
		if (!_isHeatstroke && fireHeatValue >= TowerDefenseConfig.HEATSTROKE_THRESHOLD)
		{
			EnterHeatstroke();
		}
		else if (_isHeatstroke && fireHeatValue <= TowerDefenseConfig.HEATSTROKE_MIN)
		{
			ExitHeatstroke();
		}
		if (fireHeatValue > TowerDefenseConfig.HEATSTROKE_MIN)
		{
			buffComponent.AddBuff(TowerDefenseConfig.buffId_Fire, this);
		}
		else
		{
			buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_Fire);
		}
	}

	private void UpdateHotWarning()
	{
		bool flag = !_isHeatstroke && fireHeatValue > TowerDefenseConfig.fire_HotUp_Warning;
		if (flag != _isHotWarning)
		{
			int buffID = (_isHotWarning ? TowerDefenseConfig.buffId_HotUp_Warning : TowerDefenseConfig.buffId_HotUp);
			int buffID2 = (flag ? TowerDefenseConfig.buffId_HotUp_Warning : TowerDefenseConfig.buffId_HotUp);
			int buffNumByID = buffComponent.GetBuffNumByID(buffID);
			buffComponent.RemoveBuffByBuffId(buffID);
			if (buffNumByID > 0)
			{
				buffComponent.AddBuffNum(buffID2, buffNumByID, this);
			}
			_isHotWarning = flag;
		}
	}

	private void EnterHeatstroke()
	{
		_isHeatstroke = true;
		InterruptAttack(force: true);
		actorSkillManage.DestoryAllSkill();
		foreach (int allSkillId in skillMgr.GetAllSkillIds())
		{
			skillMgr.PauseEnergy(allSkillId);
		}
		buffComponent.AddBuffNum(TowerDefenseConfig.buffId_HotDown, TowerDefenseConfig.HEATSTROKE_THRESHOLD, this);
		buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_HotUp);
		buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_HotUp_Warning);
		_isHotWarning = false;
		if (!IsInSpray)
		{
			buffComponent.AddBuff(TowerDefenseConfig.buffId_Heatstroke, this);
		}
	}

	private void ExitHeatstroke()
	{
		_isHeatstroke = false;
		fireHeatValue = TowerDefenseConfig.HEATSTROKE_MIN;
		deltaHeatValue = 0;
		if (!_isBreak)
		{
			foreach (int allSkillId in skillMgr.GetAllSkillIds())
			{
				skillMgr.BeginEnergy(allSkillId);
			}
		}
		buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_HotDown);
		buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_Heatstroke);
		_isHotWarning = false;
		buffComponent.AddBuffNum(TowerDefenseConfig.buffId_HotUp, TowerDefenseConfig.HEATSTROKE_MIN, this);
	}

	private void UpdateBreakTick()
	{
		bool flag = buffComponent.CheckBuffByBuffID(TowerDefenseConfig.buffId_RoleDarken);
		if (!_isBreak & flag)
		{
			EnterBreak();
		}
		else if (_isBreak && !flag)
		{
			ExitBreak();
		}
	}

	public void EnterBreak()
	{
		if (_isBreak)
		{
			return;
		}
		_isBreak = true;
		InterruptAttack(force: true);
		actorSkillManage.DestoryAllSkill();
		foreach (int allSkillId in skillMgr.GetAllSkillIds())
		{
			skillMgr.PauseEnergy(allSkillId);
		}
	}

	public void ExitBreak()
	{
		if (!_isBreak)
		{
			return;
		}
		_isBreak = false;
		if (_isHeatstroke)
		{
			return;
		}
		foreach (int allSkillId in skillMgr.GetAllSkillIds())
		{
			skillMgr.BeginEnergy(allSkillId);
		}
	}

	public void LogicActive()
	{
		SceneSingleton<DeterministicCollisionManager>.Instance.UnRegisterCollider(dtCollider, ignoreLock: true);
		SceneSingleton<DeterministicCollisionManager>.Instance.RegisterCollider(dtCollider, ignoreLock: true);
		isActive = true;
		extraSearchRange = 0;
		perTargetExtraSearchRange = 0;
		perTargetExtraSearchRangeFilter = null;
		EnableMovementAgent();
		skillMgr.LogicActive();
		lastTarget = null;
		lastCom = null;
		fireHeatValue = TowerDefenseConfig.HEATSTROKE_MIN;
		if (isHotLevel)
		{
			buffComponent.AddBuffNum(TowerDefenseConfig.buffId_HotUp, TowerDefenseConfig.HEATSTROKE_MIN, this);
		}
		_isHeatstroke = false;
		_isHotWarning = false;
		_isBreak = false;
		deltaHeatValue = 0;
		curTime = 0;
		fireDelta = 0;
		SprayDelta = 0;
	}

	protected override void OnActive()
	{
		base.OnActive();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		isActive = false;
		extraSearchRange = 0;
		perTargetExtraSearchRange = 0;
		perTargetExtraSearchRangeFilter = null;
		_isHeatstroke = false;
		_isHotWarning = false;
		_isBreak = false;
		fireHeatValue = TowerDefenseConfig.HEATSTROKE_MIN;
		entities.Clear();
	}

	public override void LevelStart()
	{
		EnableLogicUpdate();
		Spawn();
		DisableMovementAgent();
	}

	public override void LevelEnd()
	{
	}

	protected override void OnLogicUpdate()
	{
		if (!isActive)
		{
			return;
		}
		if (!isDead)
		{
			if (isHotLevel)
			{
				UpdateHeatTick();
				skillMgr.OnLogicUpdate(LogicDeltaTime);
			}
			else
			{
				skillMgr.OnLogicUpdate(LogicDeltaTime);
			}
			UpdateBreakTick();
			_primeFSM.OnUpdate();
			UpdateParallelAI();
			buffComponent.LogicUpdate(LogicDeltaTime);
			effectManage?.LogicUpdate(LogicDeltaTime);
			updateTime();
		}
		attackFSM.OnUpdate();
		movementFSM.OnUpdate();
		CheckBrokenLineBulletBack();
	}

	public void Despawn()
	{
		OnShow(show: false);
		ActiveSelf = false;
	}

	public LogicEntity SearchTarget()
	{
		if (SearchType == HotfixEnum.characterSearchTargetTypeTowerDefense.NORMAL)
		{
			bool flag = perTargetExtraSearchRangeFilter != null && perTargetExtraSearchRange > 0;
			FP range = (flag ? (EffectiveSearchRange + perTargetExtraSearchRange) : EffectiveSearchRange);
			CommonUtils.SearchNearTargetsByCircleInTD(this, tsTransform.Position, range, entities, isConfront: true);
			if (entities.Count > 0)
			{
				TowerMonsterInfo towerMonsterInfo = null;
				int num = 0;
				bool flag2 = false;
				for (int i = 0; i < entities.Count; i++)
				{
					if (flag && !CheckPerTargetSearchRange(entities.get_Item(i)))
					{
						continue;
					}
					TowerMonsterInfo logicComponent = entities.get_Item(i).GetLogicComponent<TowerMonsterInfo>();
					if (logicComponent != null && logicComponent.CanSelect(this))
					{
						if (lastTarget != null && lastTarget.Id == entities.get_Item(i).Id)
						{
							flag2 = true;
						}
						if (num > logicComponent.leftRouteLen || towerMonsterInfo == null)
						{
							num = logicComponent.leftRouteLen;
							towerMonsterInfo = logicComponent;
						}
					}
				}
				if (flag2 && num >= lastCom.leftRouteLen)
				{
					return lastTarget;
				}
				if (towerMonsterInfo == null)
				{
					return null;
				}
				lastTarget = towerMonsterInfo.Entity;
				lastCom = towerMonsterInfo;
				return towerMonsterInfo.Entity;
			}
		}
		return null;
	}

	private bool CheckPerTargetSearchRange(LogicEntity entity)
	{
		if (TSVector2.Distance(tsTransform.Position, entity.tsTransform.Position) - entity.GetRadius() <= EffectiveSearchRange)
		{
			return true;
		}
		return perTargetExtraSearchRangeFilter(entity);
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
		visualControl.SetCustomStencilMode(200, RendererMaterialStackComponent.StencilMode.Replace);
		visualControl.ResetRenderLayer();
		InitializeTransparentFade();
	}
}
