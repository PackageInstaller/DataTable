using TrueSync;

public struct ActorSpawnInfo(int id)
{
	public int id = id;

	public int posOfRogueX = -1;

	public int posOfRogueY = -1;

	public TSVector2 position = TSVector2.zero;

	public FP positionY = 0;

	public FP rotation = FP.Zero;

	public AdventureActor summoner = null;

	public string summonGroupSuffix = null;

	public bool isRoguelikeMonster = false;

	public int monsterLevel = 0;

	public bool callbackImmediately = false;

	public bool jumpOverBornPerformance = false;

	public bool enterActionWhenSpawn = false;

	public int maxCout = 0;

	public int callSpawnSrc = 0;

	public BaseSpawnPointGizmo spawnGizmo = null;

	public ActorTalentAttr talentAttr = default;

	public TSVector2[] strollPoints = null;

	public bool strollInCircle = false;

	public bool quitSettlement = false;

	public int indexOfSpawnWave = 0;
}
