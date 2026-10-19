namespace ACT;

public struct WorldDataHandle(WorldData worldData)
{
	public int WorldID = worldData.WorldID;

	public int SceneID = worldData.WorldConfigId;
}
