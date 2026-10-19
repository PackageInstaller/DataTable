using ACT.Model;
using Runtime.Model;

namespace ACT.MissionSystem;

public sealed class RoguelikeCompletionCondition : DungeonCompletionConditionBase
{
	private RoguelikeCompletionConditionParam ConditionParam => Param as RoguelikeCompletionConditionParam;

	protected override int SystemId => 1047;

	protected override bool CheckCondition()
	{
		RoguelikeCompletionConditionParam conditionParam = ConditionParam;
		if (conditionParam == null || conditionParam.count <= 0)
		{
			return false;
		}
		if (!Model<RogueNewModel>.HasInstance())
		{
			return false;
		}
		if (Model<RogueNewModel>.Interface.Info == null)
		{
			return false;
		}
		if (Model<RogueNewModel>.Interface.Info.ClearedMode == null)
		{
			return false;
		}
		if (conditionParam.difficulty == 0)
		{
			return Model<RogueNewModel>.Interface.Info.ClearedMode.Count >= conditionParam.count;
		}
		return Model<RogueNewModel>.Interface.Info.ClearedMode.Contains(conditionParam.difficulty);
	}
}
