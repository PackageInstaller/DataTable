using System;

namespace ACT.Config;

[Serializable]
public class AchievementGroup
{
	public readonly int id;

	public readonly int groupName;

	public readonly int typeID;

	public readonly int[] collectionId = new int[0];

	public readonly int backgroundIcon;

	public readonly int sort;

	public AchievementGroup(int id, int groupName, int typeID, int[] collectionId, int backgroundIcon, int sort)
	{
		this.id = id;
		this.groupName = groupName;
		this.typeID = typeID;
		this.collectionId = collectionId;
		this.backgroundIcon = backgroundIcon;
		this.sort = sort;
	}
}
