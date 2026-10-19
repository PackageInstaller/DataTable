using System;

namespace ACT.Config;

[Serializable]
public class RaidMissionTarget
{
	public readonly int id;

	public readonly int mainTarget;

	public readonly int targetType;

	public readonly int targetIcon;

	public RaidMissionTarget(int id, int mainTarget, int targetType, int targetIcon)
	{
		this.id = id;
		this.mainTarget = mainTarget;
		this.targetType = targetType;
		this.targetIcon = targetIcon;
	}
}
