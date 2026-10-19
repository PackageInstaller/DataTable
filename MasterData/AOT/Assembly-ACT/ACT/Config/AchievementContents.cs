using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class AchievementContents
{
	public readonly int id;

	public readonly int groupName;

	public readonly int description;

	public readonly int groupID;

	public readonly int groupSort;

	public readonly int inoperative;

	public readonly int unlockPreconditionID;

	public readonly int unlockID;

	public readonly int level;

	public readonly int type;

	public readonly int preconditionID;

	public readonly List<ItemKv> achievementsRewards;

	public AchievementContents(int id, int groupName, int description, int groupID, int groupSort, int inoperative, int unlockPreconditionID, int unlockID, int level, int type, int preconditionID, List<ItemKv> achievementsRewards)
	{
		this.id = id;
		this.groupName = groupName;
		this.description = description;
		this.groupID = groupID;
		this.groupSort = groupSort;
		this.inoperative = inoperative;
		this.unlockPreconditionID = unlockPreconditionID;
		this.unlockID = unlockID;
		this.level = level;
		this.type = type;
		this.preconditionID = preconditionID;
		this.achievementsRewards = achievementsRewards;
	}
}
