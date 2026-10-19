using System;

namespace ACT.Config;

[Serializable]
public class AchievementMain
{
	public readonly int id;

	public readonly int typeName;

	public readonly int sort;

	public AchievementMain(int id, int typeName, int sort)
	{
		this.id = id;
		this.typeName = typeName;
		this.sort = sort;
	}
}
