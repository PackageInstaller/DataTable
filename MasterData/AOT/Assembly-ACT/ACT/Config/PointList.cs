using System;

namespace ACT.Config;

[Serializable]
public class PointList
{
	public readonly int id;

	public readonly int name;

	public readonly int areaId;

	public readonly int[] characterId = new int[0];

	public PointList(int id, int name, int areaId, int[] characterId)
	{
		this.id = id;
		this.name = name;
		this.areaId = areaId;
		this.characterId = characterId;
	}
}
