using System;

namespace ACT.Config;

[Serializable]
public class TemporaryActivityData
{
	public readonly int id;

	public readonly int rewardType;

	public readonly int toggleImg;

	public readonly int nameImg;

	public readonly int cgImg;

	public readonly int[] GoalId = new int[0];

	public TemporaryActivityData(int id, int rewardType, int toggleImg, int nameImg, int cgImg, int[] GoalId)
	{
		this.id = id;
		this.rewardType = rewardType;
		this.toggleImg = toggleImg;
		this.nameImg = nameImg;
		this.cgImg = cgImg;
		this.GoalId = GoalId;
	}
}
