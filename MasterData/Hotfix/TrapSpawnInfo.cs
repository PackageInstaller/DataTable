using TrueSync;

public struct TrapSpawnInfo(int id)
{
	public int id = id;

	public TSVector2 position = TSVector2.zero;

	public FP positionY = 0;

	public FP rotation = FP.Zero;

	public AdventureActor summoner = null;

	public int groupId = 0;

	public bool isRoguelike = false;

	public int Level = 0;
}
