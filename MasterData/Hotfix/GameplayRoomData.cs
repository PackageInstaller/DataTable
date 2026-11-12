using System.Collections.Generic;
using Nova.Hotfix;

public class GameplayRoomData
{
	public HotfixEnum.worldLevelType worldLevelType;

	public int floorId;

	public StarTowerFloor fixedRoguelikeFloor;

	public StarTowerPorts ports;

	public int eventId;

	public List<MonsterSpawnWaveGizmo> monsterSpawnPointsGizmos;

	public List<VirtualMonsterSpawnWaveGizmo> virtualMonsterSpawnWaveGizmos;

	public List<TrapSpawnGroupGizmo> trapSpawnPointsGizmos;

	public List<TreasureBoxSpawnPoint> treasureBoxSpawnPoints;

	public StarTowerStage starTowerStage;

	public StarTowerMap starTowerMap;

	public bool isReconnected;

	public bool isBattleFinish;

	public TriggerCom[] triggerComs;

	public List<InteractiveNpc> npc;

	public List<InteractiveSimple> simple;
}
