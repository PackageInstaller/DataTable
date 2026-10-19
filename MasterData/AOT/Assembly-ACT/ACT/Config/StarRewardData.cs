using System;

namespace ACT.Config;

[Serializable]
public class StarRewardData
{
	public readonly int id;

	public readonly int starGoal;

	public readonly int starCollection;

	public readonly int starRefresh;

	public StarRewardData(int id, int starGoal, int starCollection, int starRefresh)
	{
		this.id = id;
		this.starGoal = starGoal;
		this.starCollection = starCollection;
		this.starRefresh = starRefresh;
	}
}
