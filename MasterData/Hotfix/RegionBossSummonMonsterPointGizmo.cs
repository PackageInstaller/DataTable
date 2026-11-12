using TrueSync;

public class RegionBossSummonMonsterPointGizmo : BaseSpawnPointGizmo
{
	public int monsterID;

	private long spawnMonsterUniqueID;

	public void SetMonsterID(int id)
	{
		monsterID = id;
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		if (monsterID <= 0)
		{
			return;
		}
		if (Singleton<HotfixDataController>.Instance.GetMonster(monsterID) == null)
		{
			_logger.LogError($"ID={monsterID}的角色数据不存在");
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
				MonsterAdventureActor monsterAdventureActor = component;
				spawnMonsterUniqueID = 0L;
				if (null != monsterAdventureActor)
				{
					spawnMonsterUniqueID = monsterAdventureActor.Id;
				}
				AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = AdventureMonsterSpawnedEvent.Generate();
				adventureMonsterSpawnedEvent.sender = monsterAdventureActor;
				adventureMonsterSpawnedEvent.id = spawnMonsterUniqueID;
				adventureMonsterSpawnedEvent.dataID = monsterID;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSpawnedEvent);
				monsterID = 0;
			}
		});
	}

	protected ActorSpawnInfo GetMonsterSpawnInfo(bool callbackImmediately = false)
	{
		ActorSpawnInfo result = new ActorSpawnInfo(monsterID);
		result.position = new TSVector2(transform.position.x, transform.position.z);
		result.positionY = transform.position.y;
		result.rotation = 0f - transform.rotation.eulerAngles.y;
		result.spawnGizmo = this;
		result.isRoguelikeMonster = false;
		result.monsterLevel = ModuleController<AdventureModuleController>.Instance.levelLoadParams.monsterLevel;
		result.callbackImmediately = callbackImmediately;
		result.posOfRogueX = x;
		result.posOfRogueY = y;
		result.jumpOverBornPerformance = jumpOverBornPerformance;
		result.enterActionWhenSpawn = false;
		return result;
	}

	public override void KillAllSummoners()
	{
		(ModuleController<AdventureModuleController>.Instance.QueryEntityByID(spawnMonsterUniqueID) as AdventureActor).DestroySelf();
	}

	public override bool IsSpwanState()
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(spawnMonsterUniqueID);
		if (logicEntity != null)
		{
			return (logicEntity as AdventureActor).state == ActorState.Spawn;
		}
		return false;
	}
}
