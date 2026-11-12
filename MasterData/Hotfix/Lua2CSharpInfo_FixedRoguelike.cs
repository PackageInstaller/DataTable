public struct Lua2CSharpInfo_FixedRoguelike
{
	public int startowerId;

	public int startowerStageId;

	public int[] team;

	public int[] teamSkin;

	public int[] arrHistoryGroupIds;

	public int nMapId;

	public int dangerRoom;

	public int floorId;

	public int scenePrefabId;

	public string extension;

	public int battleLv;

	public int eventId;

	public int ExitsCount;

	public int levelId;

	public bool isRanking;

	public Lua2CSharpInfo_FixedRoguelike(int floorId, int battleLv, int[] arrHistoryGroupIds, int eventId, int func, int[] team, int[] teamSkin, int nMapId, int ExitsCount, int levelId, bool isRanking)
	{
		this.floorId = floorId;
		this.battleLv = battleLv;
		this.team = team;
		this.eventId = eventId;
		this.arrHistoryGroupIds = arrHistoryGroupIds;
		this.nMapId = nMapId;
		this.ExitsCount = ExitsCount;
		this.teamSkin = teamSkin;
		this.levelId = levelId;
		startowerStageId = 0;
		startowerId = 0;
		dangerRoom = -1;
		extension = "";
		this.isRanking = isRanking;
		scenePrefabId = 0;
	}

	public Lua2CSharpInfo_FixedRoguelike(int floorId, int battleLv, int[] arrHistoryGroupIds, int eventId, int[] team, int[] teamSkin, int nMapId, int ExitsCount, int levelId, bool isRanking)
	{
		this.floorId = floorId;
		this.battleLv = battleLv;
		this.team = team;
		this.eventId = eventId;
		this.arrHistoryGroupIds = arrHistoryGroupIds;
		this.nMapId = nMapId;
		this.ExitsCount = ExitsCount;
		this.teamSkin = teamSkin;
		this.levelId = levelId;
		startowerStageId = 0;
		startowerId = 0;
		dangerRoom = -1;
		extension = "";
		this.isRanking = isRanking;
		scenePrefabId = 0;
	}

	public Lua2CSharpInfo_FixedRoguelike(int startowerId, int startowerStageId, int[] arrHistoryGroupIds, int[] team, int[] teamSkin, int nMapId, string extension, int floorId, int dangerRoom, bool isRanking, int scenePrefabId)
	{
		this.startowerId = startowerId;
		this.startowerStageId = startowerStageId;
		this.teamSkin = teamSkin;
		this.team = team;
		this.nMapId = nMapId;
		this.arrHistoryGroupIds = arrHistoryGroupIds;
		this.dangerRoom = dangerRoom;
		this.floorId = floorId;
		this.extension = extension;
		eventId = 0;
		ExitsCount = 1;
		levelId = 0;
		startowerStageId = 0;
		battleLv = 0;
		this.isRanking = isRanking;
		this.scenePrefabId = scenePrefabId;
	}
}
