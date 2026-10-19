using System;

namespace ACT.Config;

[Serializable]
public class RewardTimes
{
	public readonly int id;

	public readonly int condition;

	public RewardTimes(int id, int condition)
	{
		this.id = id;
		this.condition = condition;
	}
}
