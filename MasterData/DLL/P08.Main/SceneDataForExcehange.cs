public class SceneDataForExcehange
{
	public int customLoading = -1;

	public int mSceneID;

	public int mMissionClearTimes;

	public int[] typeIDListAffix;

	public int[] levelList;

	public int[] enemyTypes;

	public RoleDataForExchange[] roleDataInLua = new RoleDataForExchange[3];

	public int challengeFactor;

	public int adaptiveEnemyLevel;

	public int difficulty;

	public bool needResurrect;

	public long coinNumber;

	public long maxCoinNumber;

	public long coinConsume;

	public int resurrectHP;

	public bool resurrectImmediately;

	public int cooperateUniqueSkillID;

	public int cooperateUniqueSkillLevel;

	public int maxRaceID;

	public int maxRacePlayerCount;

	public Int3 attributeFactor = new Int3(1000, 1000, 1000);

	public long battleID;

	public ulong Uuid;

	public bool isMultiplayer;

	public int leftTime;

	public int targetEnemyID;

	public string nickName;

	public int[] VHLSkillID;

	public int VHLResult;

	public MasterSkillDataForExchange masterSkill;
}
