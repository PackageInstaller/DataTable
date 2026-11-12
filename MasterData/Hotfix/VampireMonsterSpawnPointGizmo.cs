using System;
using TrueSync;

public class VampireMonsterSpawnPointGizmo : BaseSpawnPointGizmo
{
	public float pointRadius = 1f;

	public int monsterID;

	protected int monLevel;

	protected int levelChange;

	protected int waveNum;

	protected int groupNum;

	protected int setId;

	public bool enterActionWhenSpawned;

	public Action<long, int, int, HotfixEnum.monsterEpicType> spawnCallback;

	public void SetSpawnCallback(Action<long, int, int, HotfixEnum.monsterEpicType> spawnCallback, int monsterID, int monLevel, int levelChange, int waveNum, int groupNum, int setId)
	{
		this.spawnCallback = spawnCallback;
		this.monsterID = monsterID;
		this.monLevel = monLevel;
		this.waveNum = waveNum;
		this.groupNum = groupNum;
		this.setId = setId;
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
				if (spawnCallback != null)
				{
					component.gmSetId = setId;
					spawnCallback(component.Id, waveNum, groupNum, component.monsterInfo.epicType);
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
		actorSpawnInfo.monsterLevel = monLevel + levelChange;
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
