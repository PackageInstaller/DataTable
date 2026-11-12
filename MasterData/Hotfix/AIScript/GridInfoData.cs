using TrueSync;

namespace AIScript;

public class GridInfoData
{
	public int gridIndex;

	public bool isSprayed;

	public bool isOnFire;

	public int playerID;

	public TSVector2 position;

	public bool isLit;

	public GridInfoData(int gridIndex, bool isSprayed, bool isOnFire, int playerID, TSVector2 position, bool isLit = false)
	{
		this.gridIndex = gridIndex;
		this.isSprayed = isSprayed;
		this.isOnFire = isOnFire;
		this.playerID = playerID;
		this.position = position;
		this.isLit = isLit;
	}
}
