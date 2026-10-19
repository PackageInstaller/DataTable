namespace ACT.MissionSystem;

public class MissionConditionGroupData
{
	public readonly SerializedMissionConditionGroup serializedData;

	public readonly MissionConditionData[] conditions;

	public readonly MissionActionData[] actions;

	public MissionStageCheckMode LogicMode => serializedData.logicMode;

	public MissionStageActionMode ActionMode => serializedData.actionMode;

	public MissionConditionGroupTriggerType ActionTriggerMode => serializedData.actionTriggerType;

	public MissionConditionGroupData(SerializedMissionConditionGroup serializedData)
	{
		this.serializedData = serializedData;
		conditions = new MissionConditionData[serializedData.conditions.Length];
		actions = new MissionActionData[serializedData.actions.Length];
	}
}
