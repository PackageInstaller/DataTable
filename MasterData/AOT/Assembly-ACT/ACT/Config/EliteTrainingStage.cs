using System;

namespace ACT.Config;

[Serializable]
public class EliteTrainingStage
{
	public readonly int id;

	public readonly int name;

	public readonly int[] commonId = new int[0];

	public readonly int icon;

	public EliteTrainingStage(int id, int name, int[] commonId, int icon)
	{
		this.id = id;
		this.name = name;
		this.commonId = commonId;
		this.icon = icon;
	}
}
