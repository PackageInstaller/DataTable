using System;

namespace ACT.Config;

[Serializable]
public class TalentNode
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly int seasonId;

	public readonly int type;

	public readonly int maxLevel;

	public readonly int parentId;

	public readonly int unlockLevel;

	public readonly int nodeIdx;

	public readonly int iconAddress;

	public TalentNode(int id, int name, int description, int seasonId, int type, int maxLevel, int parentId, int unlockLevel, int nodeIdx, int iconAddress)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.seasonId = seasonId;
		this.type = type;
		this.maxLevel = maxLevel;
		this.parentId = parentId;
		this.unlockLevel = unlockLevel;
		this.nodeIdx = nodeIdx;
		this.iconAddress = iconAddress;
	}
}
