namespace SceneStreamer;

public class SceneSplitBVHData : BvhObject
{
	public AABBData aabbData;

	public SceneHandler sceneHandler;

	public override AABBData GetAABB()
	{
		return aabbData;
	}
}
