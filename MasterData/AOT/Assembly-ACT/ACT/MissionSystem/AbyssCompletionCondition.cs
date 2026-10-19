using System.Collections.Generic;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;

namespace ACT.MissionSystem;

public sealed class AbyssCompletionCondition : DungeonCompletionConditionBase
{
	private AbyssCompletionConditionParam ConditionParam => Param as AbyssCompletionConditionParam;

	protected override int SystemId => 1015;

	protected override bool CheckCondition()
	{
		AbyssCompletionConditionParam conditionParam = ConditionParam;
		AchievementInfo achievementInfo = G.localPlayer?.Achievements?.Info;
		if (conditionParam == null || achievementInfo == null)
		{
			return false;
		}
		if (conditionParam.raidId == 0)
		{
			int num = 0;
			foreach (KeyValuePair<int, bool> completedAbyssStage in achievementInfo.CompletedAbyssStages)
			{
				if (completedAbyssStage.Value)
				{
					num++;
				}
			}
			return num >= conditionParam.count;
		}
		return CountCompletedStages(conditionParam.raidId, achievementInfo.CompletedAbyssStages) >= conditionParam.count;
	}

	private static int CountCompletedStages(int abyssGroupId, IDictionary<int, bool> completedStages)
	{
		if (RuntimeConfigs.data?.abyssGroupDatas != null && RuntimeConfigs.data.abyssGroupDatas.TryGetValue(abyssGroupId, out var value))
		{
			int num = 0;
			int[] abyssInclude = value.abyssInclude;
			for (int i = 0; i < abyssInclude.Length; i++)
			{
				if (!RuntimeConfigs.data.abyssDatas.TryGetValue(abyssInclude[i], out var value2))
				{
					continue;
				}
				int[] subabyss = value2.subabyss;
				for (int j = 0; j < subabyss.Length; j++)
				{
					if (completedStages.TryGetValue(subabyss[j], out var value3) & value3)
					{
						num++;
					}
				}
			}
			return num;
		}
		if (!(completedStages.TryGetValue(abyssGroupId, out var value4) & value4))
		{
			return 0;
		}
		return 1;
	}
}
