using ACT.Game;
using ACT.Game.Data;
using ACT.Model;

namespace ACT.MissionSystem;

public sealed class TrainingCompletionCondition : DungeonCompletionConditionBase
{
	private TrainingCompletionConditionParam ConditionParam => Param as TrainingCompletionConditionParam;

	protected override int SystemId => 1024;

	protected override bool CheckCondition()
	{
		TrainingCompletionConditionParam conditionParam = ConditionParam;
		AchievementInfo achievementInfo = G.localPlayer?.Achievements?.Info;
		if (conditionParam == null || conditionParam.raidId <= 0 || conditionParam.count <= 0 || achievementInfo == null)
		{
			return false;
		}
		int num = ((conditionParam.specifiedLevel > 0) ? conditionParam.specifiedLevel : conditionParam.raidId);
		if (achievementInfo.PassRaidByIdCount.TryGetValue(num, out var value) && value >= conditionParam.count)
		{
			return true;
		}
		if (num == conditionParam.raidId && achievementInfo.PassRaidByEntranceCount.TryGetValue(conditionParam.raidId, out var value2) && value2 >= conditionParam.count)
		{
			return true;
		}
		if (Model<RaidModel>.HasInstance())
		{
			return Model<RaidModel>.Interface.GetRaidCleanNum(num) >= conditionParam.count;
		}
		return false;
	}
}
