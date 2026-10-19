using System;

namespace ACT.Config;

[Serializable]
public class Rules
{
	public readonly int id;

	public readonly int rulesId;

	public readonly int number;

	public readonly int[] param = new int[0];

	public readonly int missionDescription;

	public Rules(int id, int rulesId, int number, int[] param, int missionDescription)
	{
		this.id = id;
		this.rulesId = rulesId;
		this.number = number;
		this.param = param;
		this.missionDescription = missionDescription;
	}
}
