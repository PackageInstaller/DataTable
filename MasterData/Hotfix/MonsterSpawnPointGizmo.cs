using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class MonsterSpawnPointGizmo : BaseSpawnPointGizmo
{
	public enum SpawnMonsterState
	{
		UnSpawned,
		Spawned,
		Died,
		Cleared,
		UnKnown
	}

	public int monsterBornGroupID;

	public int monsterID;

	[ReadOnly]
	public bool isInstable;

	[ReadOnly]
	public int monsterLevel;

	protected FP refRng = 0;

	[ReadOnly]
	public SpawnMonsterState spawnMonsterState;

	protected Monster monsterData;

	private LogicEntity curSpawnMonsterEntity;

	protected List<long> spawnSummonners;

	private bool quitSettlement;

	protected FP delayEnableSpawn = 0f;

	protected bool enableDelaySpawn;

	protected bool enterActionWhenSpawn;

	public bool isSelected { get; protected set; }

	public bool isRouglikeMonster { get; protected set; }

	public long spawnMonsterUniqueID { get; protected set; }

	public WaveCfg waveCfg { get; set; }

	protected override void OnDeactive()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (!(null == instance))
		{
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DESPAWNED", MonsterDespawned);
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
			instance.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", MonsterSpawned);
		}
	}

	public void DelayEnableSpawnLogic(FP delayTime)
	{
		delayEnableSpawn = delayTime;
		if (delayEnableSpawn > FP.Zero)
		{
			enableDelaySpawn = true;
		}
	}

	public override void MarkQuitSettlementMonster(bool mark)
	{
		quitSettlement = mark;
	}

	public void EnterActionWhenSpawn()
	{
		enterActionWhenSpawn = true;
	}

	public override void EnableSpawnLogic()
	{
		if (ModuleController<AdventureModuleController>.Instance.banMonsterSpawn || !ActiveSelf || isSpawnEnabled)
		{
			return;
		}
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null == instance)
		{
			return;
		}
		instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DESPAWNED", MonsterDespawned);
		instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", MonsterSpawned);
		instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARSELF", MonsterCleared);
		isSpawnEnabled = true;
		spawnSummonners = new List<long>();
		HotfixEnum.worldLevelType levelType = ModuleController<AdventureModuleController>.Instance.levelType;
		isRouglikeMonster = levelType == HotfixEnum.worldLevelType.StarTower;
		if (monsterID <= 0)
		{
			spawnMonsterState = SpawnMonsterState.UnKnown;
			_logger.LogError("刷怪点" + transform.name + "未配置怪物Id或怪物组Id");
			return;
		}
		monsterData = Singleton<HotfixDataController>.Instance.GetMonster(monsterID);
		if (monsterData == null)
		{
			_logger.LogError($"ID={monsterID}的角色数据不存在");
		}
		else
		{
			refRng = FP.FromMyriad(monsterData.RefRng);
		}
	}

	public override void ResetSpawnState()
	{
		base.ResetSpawnState();
		curSpawnMonsterEntity = null;
		delayEnableSpawn = 0;
		enableDelaySpawn = false;
		isSpawnEnabled = false;
		isSpawnActived = false;
		spawnMonsterState = SpawnMonsterState.UnSpawned;
	}

	public override void UpdateSpawnLogic()
	{
		if (enableDelaySpawn)
		{
			delayEnableSpawn -= LockStepManager.deltaTime;
			if (delayEnableSpawn <= FP.Zero)
			{
				EnableSpawnLogic();
				enableDelaySpawn = false;
			}
		}
		if (!isSpawnEnabled || isSpawnActived)
		{
			return;
		}
		SpawnMonsterState spawnMonsterState = this.spawnMonsterState;
		if (spawnMonsterState == SpawnMonsterState.Died || spawnMonsterState == SpawnMonsterState.Cleared)
		{
			return;
		}
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (null != activedPlayerActor)
		{
			Vector3 position = transform.position;
			if (TSVector2.Distance(new TSVector2(position.x, position.z), activedPlayerActor.tsTransform.Position) <= refRng && ModuleController<AdventureModuleController>.Instance.monsterActors.Count < 60)
			{
				ExecuteSpawnLogic();
			}
		}
		else
		{
			ExecuteSpawnLogic();
		}
	}

	public void SelectInstableGizmo()
	{
		isSelected = true;
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		if (ModuleController<AdventureModuleController>.Instance.banMonsterSpawn || !isSpawnEnabled || monsterID <= 0 || spawnMonsterUniqueID != 0L)
		{
			return;
		}
		ModuleController<AdventureModuleController>.Instance.SpawnMonster(GetMonsterSpawnInfo(), (AdventureLevelObjPoolMgr.PoolObj obj, bool isRoguelikeMonster) =>
		{
			MonsterAdventureActor component = obj.gameObject.GetComponent<MonsterAdventureActor>();
			if (null == component)
			{
				_logger.LogError("monster is null");
			}
			else
			{
				curSpawnMonsterEntity = component;
				if (null != curSpawnMonsterEntity)
				{
					spawnMonsterUniqueID = curSpawnMonsterEntity.Id;
				}
				spawnMonsterState = SpawnMonsterState.Spawned;
				AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = AdventureMonsterSpawnedEvent.Generate();
				adventureMonsterSpawnedEvent.sender = curSpawnMonsterEntity;
				adventureMonsterSpawnedEvent.id = spawnMonsterUniqueID;
				adventureMonsterSpawnedEvent.dataID = monsterID;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSpawnedEvent);
				if (enterActionWhenSpawn)
				{
					SpawnMonsterEnterAction();
				}
			}
		});
		isSpawnActived = true;
	}

	protected ActorSpawnInfo GetMonsterSpawnInfo(bool callbackImmediately = false)
	{
		Transform transform = base.transform;
		Vector3 position = transform.position;
		float num = 0f - transform.rotation.eulerAngles.y;
		if (waveCfg != null)
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null && waveCfg.posType == PosType.Player)
			{
				TSVector2 position2 = activedPlayerActor.tsTransform.Position;
				FP rotation = 0;
				switch (waveCfg.fanDirType)
				{
				case FanDirType.ActorDir:
					rotation = activedPlayerActor.tsTransform.Rotation;
					break;
				case FanDirType.InputDir:
					if (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
					{
						rotation = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection().GetAngle();
					}
					break;
				}
				DeterministicShape shape = default;
				shape.shapeType = waveCfg.shapeType;
				shape.radius = waveCfg.radius;
				shape.innerRadius = waveCfg.innerRadius;
				shape.angle = ((waveCfg.shapeType == DeterministicShape.ShapeType.Circle) ? ((FP)360f) : waveCfg.angle);
				shape.width = waveCfg.width;
				shape.length = waveCfg.length;
				shape.rotation = rotation;
				shape.position = position2;
				TSVector2 tSVector = ((AdventureActor)activedPlayerActor).RandomActorReachablePointInsideShape(shape);
				position.x = tSVector.x.AsFloat();
				position.z = tSVector.y.AsFloat();
				num = (activedPlayerActor.tsTransform.Position - tSVector).GetAngle().AsFloat();
			}
		}
		ActorSpawnInfo result = new ActorSpawnInfo(monsterID);
		result.position = new TSVector2(position.x, position.z);
		result.positionY = position.y;
		result.rotation = num;
		result.spawnGizmo = this;
		result.isRoguelikeMonster = isRouglikeMonster;
		result.monsterLevel = ModuleController<AdventureModuleController>.Instance.levelLoadParams.monsterLevel;
		result.callbackImmediately = callbackImmediately;
		result.posOfRogueX = x;
		result.posOfRogueY = y;
		result.jumpOverBornPerformance = jumpOverBornPerformance;
		result.enterActionWhenSpawn = enterActionWhenSpawn;
		result.quitSettlement = quitSettlement;
		return result;
	}

	public override bool IsAllActived()
	{
		return isSpawnActived;
	}

	public override bool IsAllActivedAndDied()
	{
		if (spawnMonsterState == SpawnMonsterState.UnKnown)
		{
			return true;
		}
		if (!isSpawnActived)
		{
			return false;
		}
		if (spawnMonsterState == SpawnMonsterState.Died || spawnMonsterState == SpawnMonsterState.Cleared)
		{
			if (spawnSummonners != null)
			{
				return spawnSummonners.Count == 0;
			}
			return true;
		}
		return false;
	}

	public override bool IsAllActivedAndDied_NoSummons()
	{
		if (spawnMonsterState == SpawnMonsterState.UnKnown)
		{
			return true;
		}
		if (!isSpawnActived)
		{
			return false;
		}
		if (spawnMonsterState != SpawnMonsterState.Died)
		{
			return spawnMonsterState == SpawnMonsterState.Cleared;
		}
		return true;
	}

	public override void SetAllActiveAndDied()
	{
		isSpawnEnabled = true;
		isSpawnActived = true;
		spawnMonsterState = SpawnMonsterState.UnKnown;
	}

	public override void JumpOverBornPerformance(bool jumpOver = false)
	{
		jumpOverBornPerformance = jumpOver;
	}

	protected void MonsterDeclareDeath(IEvent ievent)
	{
		if (ievent != null)
		{
			AdventureMonsterDeclareDiedEvent adventureMonsterDeclareDiedEvent = (AdventureMonsterDeclareDiedEvent)ievent;
			MonsterDied(adventureMonsterDeclareDiedEvent.id, SpawnMonsterState.Died);
		}
	}

	protected void MonsterCleared(IEvent ievent)
	{
		if (ievent != null)
		{
			AdventureMonsterClearSelfEvent adventureMonsterClearSelfEvent = (AdventureMonsterClearSelfEvent)ievent;
			MonsterDied(adventureMonsterClearSelfEvent.id, SpawnMonsterState.Cleared);
		}
	}

	private bool MonsterDied(long id, SpawnMonsterState changeState)
	{
		if (spawnMonsterUniqueID != id)
		{
			for (int i = 0; i < spawnSummonners.Count; i++)
			{
				if (id == spawnSummonners.get_Item(i))
				{
					spawnSummonners.RemoveAt(i);
					break;
				}
			}
			return false;
		}
		spawnMonsterUniqueID = 0L;
		monsterData = null;
		curSpawnMonsterEntity = null;
		if (ModuleController<AdventureModuleController>.Instance.limitlessMode)
		{
			isSpawnEnabled = true;
			isSpawnActived = false;
			spawnMonsterState = SpawnMonsterState.UnSpawned;
			return false;
		}
		spawnMonsterState = changeState;
		if (parentGizmo is MonsterSpawnGroupGizmo monsterSpawnGroupGizmo)
		{
			monsterSpawnGroupGizmo.ChildMonsterDied();
		}
		return true;
	}

	private void MonsterSpawned(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent = (AdventureMonsterSummonerSpawnedEvent)ievent;
		if (spawnMonsterUniqueID == 0L || adventureMonsterSummonerSpawnedEvent.summonerId != spawnMonsterUniqueID)
		{
			return;
		}
		if (spawnSummonners == null)
		{
			Debug.LogError("列表为空");
			return;
		}
		if (enterActionWhenSpawn)
		{
			SpawnMonsterEnterAction();
		}
		spawnSummonners.Add(adventureMonsterSummonerSpawnedEvent.id);
	}

	private void MonsterDespawned(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		AdventureMonsterDespawnedEvent adventureMonsterDespawnedEvent = (AdventureMonsterDespawnedEvent)ievent;
		if (spawnMonsterUniqueID == adventureMonsterDespawnedEvent.id)
		{
			spawnMonsterUniqueID = 0L;
			isSpawnActived = false;
			return;
		}
		long summonId = adventureMonsterDespawnedEvent.summonId;
		if (summonId == 0L)
		{
			return;
		}
		bool flag = false;
		if (summonId == spawnMonsterUniqueID)
		{
			flag = true;
		}
		else if (spawnMonsterState == SpawnMonsterState.Died)
		{
			flag = true;
		}
		else if (spawnMonsterState == SpawnMonsterState.Cleared)
		{
			flag = true;
		}
		if (!flag)
		{
			return;
		}
		for (int i = 0; i < spawnSummonners.Count; i++)
		{
			if (summonId == spawnSummonners.get_Item(i))
			{
				spawnSummonners.RemoveAt(i);
				break;
			}
		}
	}

	public override void KillAllSummoners()
	{
		LogicEntity logicEntity = curSpawnMonsterEntity;
		if (logicEntity != null)
		{
			(logicEntity as AdventureActor)?.DestroySelf();
		}
	}

	public override bool IsSpwanState()
	{
		LogicEntity logicEntity = curSpawnMonsterEntity;
		if (logicEntity != null)
		{
			return (logicEntity as AdventureActor).state == ActorState.Spawn;
		}
		return false;
	}

	public override void SpawnMonsterEnterAction()
	{
		LogicEntity logicEntity = curSpawnMonsterEntity;
		if (!(logicEntity == null))
		{
			logicEntity.GetLogicComponent<MonsterActiveScheme>()?.ActiveActor(forceActive: true);
			ActorSearchTarget logicComponent = logicEntity.GetLogicComponent<ActorSearchTarget>();
			if (logicComponent != null)
			{
				logicComponent.hearRange = 999;
				logicComponent.visionRange = 999;
			}
		}
	}

	public override int DiedMonsterCount()
	{
		if (!isSpawnEnabled)
		{
			return 0;
		}
		if (!isSpawnActived)
		{
			return 0;
		}
		if (spawnMonsterState != SpawnMonsterState.Died && spawnMonsterState != SpawnMonsterState.Cleared)
		{
			return 0;
		}
		return 1;
	}

	public override int RemindMonsterCount()
	{
		if (!isSpawnEnabled)
		{
			return 0;
		}
		return 1 - DiedMonsterCount();
	}
}
