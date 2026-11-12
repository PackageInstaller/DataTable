using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using Pathfinding.RVO;
using TrueSync;
using UnityEngine;

public class TrapAdventureActor : AdventureActor
{
	[Space]
	public AdventureLevelObjPoolMgr.PoolObj spawnPoolObj;

	public Trap trapCfg;

	public DeterministicShape ShapeCfg;

	public List<int> ActiveBuffs = new List<int>();

	public List<int> InActiveBuffs = new List<int>();

	public List<int> BornBuffs = new List<int>();

	public bool isIgnoreCollison;

	public bool isMove;

	public bool isBlock;

	public string trapTag;

	private AdventureObstacle obstacle;

	private FP orginalMoveSpd;

	private FP orginalMoveAcc;

	public MonsterAIInfo monsterAIInfo { get; protected set; }

	public bool IsActive { get; set; }

	public HashSet<int> FilterDic { get; } = new HashSet<int>();

	public int TrapGroupId { get; set; }

	protected override void OnInit()
	{
		base.OnInit();
		obstacle = GetComponentInChildren<AdventureObstacle>(includeInactive: true);
		monsterAIInfo = AddOrGetLogicComponent<MonsterAIInfo>();
		dtCollider.priority = 2;
	}

	protected override void OnActive()
	{
		base.OnActive();
	}

	public void LoadData(Trap data, bool isRoguelike, int Level)
	{
		trapCfg = data;
		dataID = data.Id;
		base.actorInfo.actorName = data.Name;
		orginalMoveSpd = FP.FromMyriad(data.MoveSpd);
		orginalMoveAcc = FP.FromMyriad(data.MovAcc);
		isIgnoreCollison = data.IgnoreCollision;
		isMove = data.IsMove;
		isBlock = data.IsBlock;
		ActiveBuffs.Clear();
		InActiveBuffs.Clear();
		BornBuffs.Clear();
		for (int i = 0; i < data.TurnOnBuffIds.Count; i++)
		{
			ActiveBuffs.Add(data.TurnOnBuffIds.get_Item(i));
		}
		for (int j = 0; j < data.TurnOffBuffIds.Count; j++)
		{
			InActiveBuffs.Add(data.TurnOffBuffIds.get_Item(j));
		}
		for (int k = 0; k < data.BuffIds.Count; k++)
		{
			BornBuffs.Add(data.BuffIds.get_Item(k));
		}
		actorScaleInfo.originModelScale = FP.FromMyriad(data.ModelScale);
		actorScaleInfo.modelScale = actorScaleInfo.originModelScale;
		ActorInfo actorInfo = base.actorInfo;
		int factionID = (base.actorInfo.originFactionID = data.Faction);
		actorInfo.factionID = factionID;
		base.actorInfo.moveAcceleration = FP.FromMyriad(data.MovAcc);
		base.actorInfo.moveRotationSpeed = FP.FromMyriad(data.RotSpd);
		trapTag = data.Tag1;
		SetRoguelikeAttrInfo(data.Templete, isRoguelike, Level);
		FilterDic.Clear();
		foreach (int item in data.Filter)
		{
			FilterDic.Add(item);
		}
		SetSearchInfo();
		SetupPrimeFSM(data.FCId);
		LoadModel((float)dtCollider.Radius, (float)dtCollider.ColliderHeight);
		for (int l = 0; l < data.BuffIds.Count; l++)
		{
			buffComponent.AddBuff(data.BuffIds.get_Item(l), this);
		}
		isDead = false;
		isDeclareDead = false;
	}

	private void SetSearchInfo()
	{
		Trap trap = trapCfg;
		TSVector2 point = TSVector2.zero;
		if (trap.Offset.Count != 0)
		{
			point = new TSVector2(trap.Offset.get_Item(0), trap.Offset.get_Item(1));
		}
		if (trap.ShapeType == 0)
		{
			ShapeCfg.shapeType = DeterministicShape.ShapeType.Rectangle;
			ShapeCfg.width = trap.Width;
			ShapeCfg.length = trap.Length;
			ShapeCfg.position = tsTransform.TransformLocalPointToWorldSpace(point);
			ShapeCfg.rotation = tsTransform.Rotation;
		}
		else if (trap.ShapeType == 1)
		{
			ShapeCfg.shapeType = DeterministicShape.ShapeType.Circle;
			ShapeCfg.radius = trap.Radius;
			ShapeCfg.position = tsTransform.TransformLocalPointToWorldSpace(point);
		}
		else if (trap.ShapeType == 2)
		{
			ShapeCfg.shapeType = DeterministicShape.ShapeType.Fan;
			ShapeCfg.innerRadius = trap.InnerRadius;
			ShapeCfg.radius = trap.Radius;
			ShapeCfg.rotation = tsTransform.Rotation;
			ShapeCfg.position = tsTransform.TransformLocalPointToWorldSpace(point);
		}
	}

	private bool SetRoguelikeAttrInfo(long templeteId, bool isRoguelike, int Level, int percent = 100)
	{
		AdventureModuleLevelLoadParams levelLoadParams = ModuleController<AdventureModuleController>.Instance.levelLoadParams;
		MonsterValueTempleteAdjust monsterValueTempleteAdjust = Singleton<HotfixDataController>.Instance.GetMonsterValueTempleteAdjust(templeteId);
		if (monsterValueTempleteAdjust == null)
		{
			Debug.LogError($"Trap templeteInfo adjust config not exist, Templete:{templeteId} ");
			return false;
		}
		SetElementType(monsterValueTempleteAdjust.EET, monsterValueTempleteAdjust.WeakEET);
		long key = ((!isRoguelike) ? ((long)monsterValueTempleteAdjust.TemplateId * 1000L + Level * 10 + 1) : ((long)monsterValueTempleteAdjust.TemplateId * 1000L + Level * 10 + levelLoadParams.levelDifficultLv));
		MonsterValueTemplete monsterValueTemplete = Singleton<HotfixDataController>.Instance.GetMonsterValueTemplete(key);
		if (monsterValueTemplete != null)
		{
			FDP ratio = FDP.FromPercent(percent);
			actorHealthInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, ratio);
			actorInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, ratio);
			actorElementInfo.SetOriginAttributeData(monsterValueTemplete, monsterValueTempleteAdjust, ratio);
			return true;
		}
		Debug.LogError($"Roguelike trap templeteInfo config not exist, TempleteId:{templeteId}, Spawnlevel:{Level}, levelDifficult:{levelLoadParams.levelDifficultLv}");
		return false;
	}

	private void SetElementType(int elementType, IList<int> weakElementType)
	{
		actorElementInfo.originElementType = (HotfixEnum.elementType)elementType;
		actorElementInfo.elementType = actorElementInfo.originElementType;
	}

	public override void SetupPrimeFSM(int aiId)
	{
		if (_primeFSM == null)
		{
			MonsterAI monsterAI = Singleton<HotfixDataController>.Instance.GetMonsterAI(aiId);
			if (!string.IsNullOrEmpty(monsterAI.ActionAIPath))
			{
				_trapActionAIPath = monsterAI.ActionAIPath;
			}
			if (!string.IsNullOrEmpty(monsterAI.IdleAIPath))
			{
				_trapIdleAIPath = monsterAI.IdleAIPath;
			}
			if (!string.IsNullOrEmpty(monsterAI.SpawnAIPath))
			{
				_trapSpawnAIPath = monsterAI.SpawnAIPath;
			}
			if (!string.IsNullOrEmpty(monsterAI.ParallelAIPath))
			{
				_trapParallelAIPath = monsterAI.ParallelAIPath;
			}
			_comboGroupPath = monsterAI.ComboGroupPath;
			monsterAIInfo.actionBranchIds = monsterAI.ActionBranchIds.ToList();
			base.SetupPrimeFSM(aiId);
			_primeFSM = new ActorPrimeFSM(gameObject);
			_nullState = new ActorNullState();
			_primeFSM.RegistState(_nullState);
			_spawnState = new MonsterSpawnState();
			_primeFSM.RegistState(_spawnState, _trapSpawnAIPath);
			_idleState = new MonsterIdleState();
			_primeFSM.RegistState(_idleState, _trapIdleAIPath);
			_actionState = new MonsterActionState();
			_primeFSM.RegistState(_actionState, _trapActionAIPath);
			_lostControlState = new MonsterLostControlState();
			_primeFSM.RegistState(_lostControlState, _trapLostcontrolAIPath);
			_deathState = new MonsterDeathState();
			_primeFSM.RegistState(_deathState, _trapDeathAIPath);
			_clearState = new MonsterClearState();
			_primeFSM.RegistState(_clearState, _trapClearAIPath);
			InitParallelAI(_trapParallelAIPath);
		}
	}

	private void SetCollision()
	{
		if (!isIgnoreCollison)
		{
			DisableIgnoreDeterministicCollision();
		}
		else
		{
			EnableIgnoreDeterministicCollision();
		}
	}

	private void SetMoveAgent()
	{
		movAgent.maxSpeed = orginalMoveSpd;
		movAgent.acceleration = orginalMoveAcc;
		movAgent.enableRotation = false;
		movAgent.canMove = isMove;
		movAgent.cachedSeeker.graphMask = NavAgentTypeNames.HumanoidGraphMask;
		movAgent.groundMask = 2048;
		movAgent.canBlock = isBlock;
		if (isBlock)
		{
			movAgent.blockLayer = RVOLayer.Layer2;
			movAgent.blockWith = RVOLayer.DefaultAgent | RVOLayer.DefaultObstacle | RVOLayer.Layer2;
			movAgent.blockPriority = 10;
			movAgent.blockDamp = 1;
		}
	}

	protected override void OnLogicUpdate()
	{
		_primeFSM.OnUpdate();
		UpdateParallelAI();
		buffComponent.LogicUpdate(LogicDeltaTime);
		effectManage?.LogicUpdate(LogicDeltaTime);
		actorSkillManage?.LogicUpdate(LogicDeltaTime);
		updateTime();
		_attackFSM.OnUpdate();
		_movementFSM.OnUpdate();
	}

	public override void LevelStart()
	{
		EnableLogicUpdate();
		Spawn();
		SetCollision();
		SetMoveAgent();
	}

	public override void LevelEnd()
	{
		Despawn();
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
		OnShow(show: false);
		gameObject.SetActive(value: false);
	}

	public override void OnEnterDeterministicCollision(DeterministicCollider other)
	{
		base.OnEnterDeterministicCollision(other);
		AdventureTrapCollisionEvent adventureTrapCollisionEvent = AdventureTrapCollisionEvent.Generate();
		adventureTrapCollisionEvent.form = other.Entity;
		adventureTrapCollisionEvent.to = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureTrapCollisionEvent);
	}

	public override void OnExitDeterministicCollision(DeterministicCollider other)
	{
		base.OnExitDeterministicCollision(other);
		AdventureTrapCollisionEvent adventureTrapCollisionEvent = AdventureTrapCollisionEvent.Generate();
		adventureTrapCollisionEvent.form = other.Entity;
		adventureTrapCollisionEvent.to = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureTrapCollisionEvent);
	}

	protected override void SetupVisualComponents(float visibleRadius, float visibleHeight)
	{
		base.SetupVisualComponents(visibleRadius, visibleHeight);
		visualControl.SetupRendererMaterialStackComponent();
	}
}
