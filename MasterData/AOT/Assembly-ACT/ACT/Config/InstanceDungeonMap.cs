using System;

namespace ACT.Config;

[Serializable]
public class InstanceDungeonMap
{
	public readonly int id;

	public readonly int areaId;

	public readonly string areaMapPic = "";

	public readonly int[] instanceList = new int[0];

	public readonly int maxStar;

	public InstanceDungeonMap(int id, int areaId, string areaMapPic, int[] instanceList, int maxStar)
	{
		this.id = id;
		this.areaId = areaId;
		this.areaMapPic = areaMapPic;
		this.instanceList = instanceList;
		this.maxStar = maxStar;
	}
}
