using System;

namespace ACT.MissionSystem;

[Serializable]
public class TPWithWorldActionParam
{
	public int worldId;

	public int chunkId;

	public float positionX;

	public float positionY;

	public float positionZ;

	public bool openBattleMain = true;
}
