using System;

namespace ACT.MissionSystem;

[Serializable]
public class SerializedMissionConditionGroup
{
	public MissionStageCheckMode logicMode;

	public MissionStageActionMode actionMode;

	public MissionConditionGroupTriggerType actionTriggerType;

	public int[] conditions = Array.Empty<int>();

	public int[] actions = Array.Empty<int>();
}
