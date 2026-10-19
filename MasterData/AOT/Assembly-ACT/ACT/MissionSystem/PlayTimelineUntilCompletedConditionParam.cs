using System;

namespace ACT.MissionSystem;

[Serializable]
public class PlayTimelineUntilCompletedConditionParam
{
	public int timelineId;

	public bool blackScreenIn;

	public float blackScreenInTime;
}
