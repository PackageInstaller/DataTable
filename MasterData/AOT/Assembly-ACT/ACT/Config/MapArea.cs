using System;

namespace ACT.Config;

[Serializable]
public class MapArea
{
	public readonly int id;

	public readonly int worldId;

	public readonly int name;

	public readonly string RectRoot = "";

	public readonly int environmentElementId;

	public readonly int mapSequence;

	public readonly int treasureList;

	public readonly int[] subMapArea = new int[0];

	public readonly int[] subSceneType = new int[0];

	public readonly int Unlock;

	public readonly int exploreType;

	public readonly int packLimit;

	public readonly int AudioData;

	public MapArea(int id, int worldId, int name, string RectRoot, int environmentElementId, int mapSequence, int treasureList, int[] subMapArea, int[] subSceneType, int Unlock, int exploreType, int packLimit, int AudioData)
	{
		this.id = id;
		this.worldId = worldId;
		this.name = name;
		this.RectRoot = RectRoot;
		this.environmentElementId = environmentElementId;
		this.mapSequence = mapSequence;
		this.treasureList = treasureList;
		this.subMapArea = subMapArea;
		this.subSceneType = subSceneType;
		this.Unlock = Unlock;
		this.exploreType = exploreType;
		this.packLimit = packLimit;
		this.AudioData = AudioData;
	}
}
