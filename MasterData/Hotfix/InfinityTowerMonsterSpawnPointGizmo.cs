using System;
using TrueSync;
using UnityEngine;

public class InfinityTowerMonsterSpawnPointGizmo : BaseSpawnPointGizmo
{
	[Space]
	public int pointIndex;

	public int monsterID;

	public int levelChange;

	private long spawnMonsterUniqueID;

	[HideInInspector]
	public bool enterActionWhenSpawned;

	public Action<long> spawnCallback;

	public void SetSpawnCallback(Action<long> spawnCallback)
	{
		this.spawnCallback = spawnCallback;
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
				spawnMonsterUniqueID = component.Id;
				AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = AdventureMonsterSpawnedEvent.Generate();
				adventureMonsterSpawnedEvent.sender = component;
				adventureMonsterSpawnedEvent.id = spawnMonsterUniqueID;
				adventureMonsterSpawnedEvent.dataID = monsterID;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSpawnedEvent);
				if (spawnCallback != null)
				{
					spawnCallback(spawnMonsterUniqueID);
					spawnCallback = null;
				}
				monsterID = 0;
			}
		});
	}

	protected ActorSpawnInfo GetMonsterSpawnInfo(bool callbackImmediately = false)
	{
		ActorSpawnInfo actorSpawnInfo = new ActorSpawnInfo(monsterID);
		actorSpawnInfo.position = new TSVector2(transform.position.x, transform.position.z);
		actorSpawnInfo.positionY = transform.position.y;
		actorSpawnInfo.spawnGizmo = this;
		actorSpawnInfo.isRoguelikeMonster = false;
		actorSpawnInfo.monsterLevel = ModuleController<AdventureModuleController>.Instance.levelLoadParams.monsterLevel + levelChange;
		actorSpawnInfo.callbackImmediately = callbackImmediately;
		actorSpawnInfo.posOfRogueX = x;
		actorSpawnInfo.posOfRogueY = y;
		actorSpawnInfo.jumpOverBornPerformance = jumpOverBornPerformance;
		actorSpawnInfo.enterActionWhenSpawn = enterActionWhenSpawned;
		ActorSpawnInfo result = actorSpawnInfo;
		result.rotation = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position - result.position).normalized.GetAngle();
		return result;
	}
}
