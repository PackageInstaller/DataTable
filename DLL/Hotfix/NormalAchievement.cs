using System.Collections.Generic;
using Ase;

public class NormalAchievement : Achievement
{
	protected override void InitPrivateData(AchievementMedal medal)
	{
	}

	protected override bool InitCondition(List<int> conditionList, List<List<int>> targetList)
	{
		if (base.InitCondition(conditionList, targetList))
		{
			for (int i = 0; i < conditionList.Count - 1; i++)
			{
				ConditionParam.Add(conditionList[i], targetList[i]);
			}
			int index = conditionList.Count - 1;
			TargetParamType = conditionList[index];
			return true;
		}
		return false;
	}

	public override void VerityAchievement(Dictionary<int, int> conditionParams, Dictionary<int, int> targetParams)
	{
		if (!targetParams.TryGetValue(TargetParamType, out var value))
		{
			return;
		}
		int num = 0;
		foreach (int key in ConditionParam.Keys)
		{
			List<int> list = ConditionParam[key];
			if (list.Count == 0)
			{
				return;
			}
			if (!list.Contains(-1))
			{
				if (!conditionParams.TryGetValue(key, out var value2))
				{
					return;
				}
				for (int i = 0; i < list.Count; i++)
				{
					if (value2 == list[i])
					{
						num++;
						break;
					}
				}
			}
			else
			{
				num++;
			}
		}
		if (num == ConditionParam.Count)
		{
			targetSuccessValue += value;
		}
	}
}
