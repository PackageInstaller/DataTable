using System;

namespace ACT.Config;

[Serializable]
public class TrialPotion
{
	public readonly int id;

	public readonly int potionid;

	public readonly int level;

	public readonly int[] additives = new int[0];

	public TrialPotion(int id, int potionid, int level, int[] additives)
	{
		this.id = id;
		this.potionid = potionid;
		this.level = level;
		this.additives = additives;
	}
}
