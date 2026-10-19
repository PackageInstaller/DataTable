namespace ACT.MissionSystem;

public interface IMissionStage
{
	int ConditionCount { get; }

	int ActionCount { get; }

	MissionCondition GetConditionByIndex(int index);

	MissionCondition GetConditionById(int id);

	MissionAction GetActionByIndex(int index);

	MissionAction GetActionById(int id);
}
