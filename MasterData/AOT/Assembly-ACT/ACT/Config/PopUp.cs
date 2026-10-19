using System;

namespace ACT.Config;

[Serializable]
public class PopUp
{
	public readonly int id;

	public readonly int targetId;

	public readonly int timetargetId;

	public readonly int endType;

	public readonly int enabled;

	public readonly int priority;

	public readonly int cycleType;

	public readonly int maxShowTimes;

	public readonly int buttonActionType;

	public readonly int[] jumpParam = new int[0];

	public readonly string prefebPath = "";

	public readonly int offMissongroup;

	public PopUp(int id, int targetId, int timetargetId, int endType, int enabled, int priority, int cycleType, int maxShowTimes, int buttonActionType, int[] jumpParam, string prefebPath, int offMissongroup)
	{
		this.id = id;
		this.targetId = targetId;
		this.timetargetId = timetargetId;
		this.endType = endType;
		this.enabled = enabled;
		this.priority = priority;
		this.cycleType = cycleType;
		this.maxShowTimes = maxShowTimes;
		this.buttonActionType = buttonActionType;
		this.jumpParam = jumpParam;
		this.prefebPath = prefebPath;
		this.offMissongroup = offMissongroup;
	}
}
