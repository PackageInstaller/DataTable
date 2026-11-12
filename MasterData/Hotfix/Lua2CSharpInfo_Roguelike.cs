public struct Lua2CSharpInfo_Roguelike(int RoguelikeId, int floorDifficultLv, int mapId, int floorId, ActorInfo_Roguelike[] team, int[] arrHistoryMapId, bool floorComplete, bool isLevelBossDied = false)
{
	public int nRoguelikeId = RoguelikeId;

	public int nMapId = mapId;

	public int nFloorId = floorId;

	public ActorInfo_Roguelike[] team = team;

	public int[] arrHistoryMapId = arrHistoryMapId;

	public bool floorComplete = floorComplete;

	public int floorDifficultLv = floorDifficultLv;

	public bool isLevelBossDied = isLevelBossDied;

	public void SetData(int RoguelikeId, int floorDifficultLv, int mapId, int floorId, ActorInfo_Roguelike[] team, int[] arrHistoryMapId, bool floorComplete, bool isLevelBossDied = false)
	{
		nRoguelikeId = RoguelikeId;
		nMapId = mapId;
		nFloorId = floorId;
		this.team = team;
		this.arrHistoryMapId = arrHistoryMapId;
		this.floorComplete = floorComplete;
		this.floorDifficultLv = floorDifficultLv;
		this.isLevelBossDied = isLevelBossDied;
	}
}
