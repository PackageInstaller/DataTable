using System;

namespace ACT.Config;

[Serializable]
public class ExplorebranchMission
{
	public readonly int id;

	public readonly int branchMissionName;

	public readonly int belongSubArea;

	public readonly bool CanBeCalculate;

	public ExplorebranchMission(int id, int branchMissionName, int belongSubArea, bool CanBeCalculate)
	{
		this.id = id;
		this.branchMissionName = branchMissionName;
		this.belongSubArea = belongSubArea;
		this.CanBeCalculate = CanBeCalculate;
	}
}
