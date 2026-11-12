using System.Collections.Generic;
using Nova.Hotfix;

public class StarTowerSpecialMode_Goblin : StarTowerSpecialMode
{
	public readonly int GoblinDataId = 5090001;

	private bool isKillGoblin;

	public override void InitRoom(GameplayRoomData roomData, StarTowerCombatEvent eventData)
	{
		base.InitRoom(roomData, eventData);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("SPECIALMODE_GOBLINS_FAIL", GoblinFail);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
	}

	public override void ActiveEvent()
	{
		if (isActived)
		{
			return;
		}
		base.ActiveEvent();
		if (roomData.isReconnected && (!roomData.isReconnected || roomData.isBattleFinish))
		{
			return;
		}
		List<MonsterSpawnWaveGizmo> monsterSpawnPointsGizmos = roomData.monsterSpawnPointsGizmos;
		for (int i = 0; i < monsterSpawnPointsGizmos.Count; i++)
		{
			MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = monsterSpawnPointsGizmos.get_Item(i);
			if (monsterSpawnWaveGizmo.waveType == MonsterSpawnWaveGizmo.WaveType.Goblin && monsterSpawnWaveGizmo.isTriggerActived && !monsterSpawnWaveGizmo.IsAllActived())
			{
				monsterSpawnWaveGizmo.EnableSpawnLogic();
				monsterSpawnWaveGizmo.ExecuteSpawnLogic();
			}
		}
	}

	private void GoblinFail(IEvent evt)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_Fail");
		isKillGoblin = true;
		isComplete = true;
	}

	private void MonsterDeath(IEvent evt)
	{
		if (((AdventureMonsterDiedEvent)evt).monsterID == GoblinDataId)
		{
			isKillGoblin = true;
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_Goblin_Success");
			isComplete = true;
		}
	}

	protected override void MonsterClear(IEvent evt)
	{
		HotfixEnum.starTowerRoomType starTowerRoomType = roomType;
		if ((starTowerRoomType == HotfixEnum.starTowerRoomType.BattleRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.BossRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.DangerRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.HorrorRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.EliteBattleRoom || starTowerRoomType == HotfixEnum.starTowerRoomType.FinalBossRoom) && totalAlivePlayerActorCount > 0 && isKillGoblin)
		{
			Complete(HotfixEnum.levelState.Success);
		}
	}

	public override void LeaveRoom()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("SPECIALMODE_GOBLINS_FAIL", GoblinFail);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (adventureMonsterSpawnedEvent.dataID == GoblinDataId)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Roguelike_SpecialMode_Goblin_UniqueID", adventureMonsterSpawnedEvent.id);
		}
	}
}
