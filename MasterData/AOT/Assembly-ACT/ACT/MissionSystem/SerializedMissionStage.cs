using System;

namespace ACT.MissionSystem;

[Serializable]
public class SerializedMissionStage
{
	public MissionStageCheckMode logicMode;

	public SerializedMissionConditionGroup[] conditionActionPairs = Array.Empty<SerializedMissionConditionGroup>();
}
