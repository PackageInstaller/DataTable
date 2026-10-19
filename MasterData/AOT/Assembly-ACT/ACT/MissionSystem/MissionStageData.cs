using System.Collections.Generic;

namespace ACT.MissionSystem;

public class MissionStageData
{
	public readonly MissionStageType stageType;

	public readonly SerializedMissionStage serializedData;

	public readonly List<MissionConditionData> conditions;

	public readonly List<MissionActionData> actions;

	public readonly MissionConditionGroupData[] conditionGroups;

	public MissionStageCheckMode LogicMode => serializedData.logicMode;

	public MissionStageData(MissionStageType stageType, SerializedMissionStage serializedData)
	{
		this.stageType = stageType;
		this.serializedData = serializedData;
		conditions = new List<MissionConditionData>();
		actions = new List<MissionActionData>();
		conditionGroups = new MissionConditionGroupData[serializedData.conditionActionPairs.Length];
	}
}
