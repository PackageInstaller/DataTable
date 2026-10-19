using System;

namespace ACT.MissionSystem;

[Serializable]
public class PlayDialogueUntilCompletedConditionParam
{
	public int storyGroupId;

	public bool blackScreenIn;

	public float blackScreenInTime;

	public bool waitIdle = true;
}
