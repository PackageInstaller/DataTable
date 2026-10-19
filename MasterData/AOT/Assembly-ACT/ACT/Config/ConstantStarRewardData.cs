using System;

namespace ACT.Config;

[Serializable]
public class ConstantStarRewardData
{
	public readonly int id;

	public readonly int starGoal;

	public readonly int starCollection;

	public readonly bool isOpen;

	public ConstantStarRewardData(int id, int starGoal, int starCollection, bool isOpen)
	{
		this.id = id;
		this.starGoal = starGoal;
		this.starCollection = starCollection;
		this.isOpen = isOpen;
	}
}
