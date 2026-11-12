using System;
using TrueSync;
using UnityEngine;

public class RandomMonsterSpawnPointGizmo : BaseSpawnPointGizmo
{
	public float pointRadius = 1f;

	public int monsterID;

	public Action<long, bool> spawnCallback;

	[HideInInspector]
	public bool enterActionWhenSpawned;

	private long spawnMonsterUniqueID;

	private bool isRep;

	public int callSpawnSrc;

	public MonsterStrollSchemes.MonsterStrollScheme strollScheme;

	public int indexOfSpawnWave;

	public void SetSpawnCallback(Action<long, bool> spawnCallbackTemp, bool isRepTemp)
	{
		spawnCallback = spawnCallbackTemp;
		isRep = isRepTemp;
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		if (ModuleController<AdventureModuleController>.Instance.banMonsterSpawn)
		{
			Debug.LogError("禁止怪物出生");
		}
		else
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
					AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = AdventureMonsterSpawnedEvent.Generate();
					adventureMonsterSpawnedEvent.sender = component;
					adventureMonsterSpawnedEvent.dataID = monsterID;
					AdventureRandomMonsterSpawnedEvent adventureRandomMonsterSpawnedEvent = AdventureRandomMonsterSpawnedEvent.Generate();
					adventureRandomMonsterSpawnedEvent.dataID = monsterID;
					MonsterAdventureActor monsterAdventureActor = component;
					spawnMonsterUniqueID = 0L;
					if (null != monsterAdventureActor)
					{
						spawnMonsterUniqueID = monsterAdventureActor.Id;
						adventureMonsterSpawnedEvent.id = spawnMonsterUniqueID;
						adventureRandomMonsterSpawnedEvent.id = spawnMonsterUniqueID;
						MonsterSpawnerInfo spawnerInfo = monsterAdventureActor.spawnerInfo;
						if (spawnerInfo != null)
						{
							adventureMonsterSpawnedEvent.callSpawnSrc = spawnerInfo.callSpawnSrc;
							adventureRandomMonsterSpawnedEvent.callSpawnSrc = spawnerInfo.callSpawnSrc;
						}
					}
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSpawnedEvent);
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureRandomMonsterSpawnedEvent);
					if (spawnCallback != null)
					{
						spawnCallback(spawnMonsterUniqueID, isRep);
						spawnCallback = null;
					}
					monsterID = 0;
				}
			});
			callSpawnSrc = 0;
		}
	}

	protected ActorSpawnInfo GetMonsterSpawnInfo(bool callbackImmediately = false)
	{
		ActorSpawnInfo actorSpawnInfo = new ActorSpawnInfo(monsterID);
		actorSpawnInfo.position = new TSVector2(transform.position.x, transform.position.z) + randomPos();
		actorSpawnInfo.positionY = transform.position.y;
		actorSpawnInfo.spawnGizmo = this;
		actorSpawnInfo.isRoguelikeMonster = true;
		actorSpawnInfo.monsterLevel = ModuleController<AdventureModuleController>.Instance.levelLoadParams.monsterLevel;
		actorSpawnInfo.callbackImmediately = callbackImmediately;
		actorSpawnInfo.posOfRogueX = x;
		actorSpawnInfo.posOfRogueY = y;
		actorSpawnInfo.jumpOverBornPerformance = jumpOverBornPerformance;
		actorSpawnInfo.enterActionWhenSpawn = enterActionWhenSpawned;
		actorSpawnInfo.callSpawnSrc = callSpawnSrc;
		ActorSpawnInfo result = actorSpawnInfo;
		result.rotation = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position - result.position).normalized.GetAngle();
		result.indexOfSpawnWave = indexOfSpawnWave;
		if (strollScheme != null)
		{
			result.strollPoints = strollScheme.GetPoints2();
			result.strollInCircle = strollScheme.runInCircle;
		}
		return result;
	}

	protected TSVector2 randomPos()
	{
		Vector2 vector = UnityEngine.Random.insideUnitCircle * pointRadius;
		return new TSVector2(vector.x, vector.y);
	}

	public override void KillAllSummoners()
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(spawnMonsterUniqueID);
		if (logicEntity != null)
		{
			(logicEntity as AdventureActor)?.DestroySelf();
		}
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
