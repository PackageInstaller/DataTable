#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class ObserverReleaseSkillCondition : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
		if (conditionParams != null && conditionParams.Length >= 1)
		{
			conditionParams[0].OnParseInt();
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverReleaseSkillParams observerReleaseSkillParams))
		{
			Log.Error("ReleaseSkill Param TypeError:" + param.GetType());
			return false;
		}
		bool flag = conditionParams.Length >= 1 && (conditionParams[0].IsAny || observerReleaseSkillParams.SkillId == conditionParams[0].ParamInt);
		flag = flag == conditionParams[0].Compare;
		if (conditionParams.Length == 1)
		{
			return flag;
		}
		bool flag2 = false;
		if (conditionParams.Length >= 2)
		{
			flag2 = ConditionUtility.ConditionSkillExecuteStateEnum(observerReleaseSkillParams.ExecuteState, conditionParams[1].ParamString);
			flag2 = flag2 == conditionParams[1].Compare;
		}
		if (conditionParams.Length == 2)
		{
			return flag & flag2;
		}
		bool flag3 = false;
		if (conditionParams.Length >= 3)
		{
			List<string> skillLabelList = observerReleaseSkillParams.SkillData.GetSkillLabelList();
			for (int i = 2; i < conditionParams.Length; i++)
			{
				if (skillLabelList.Contains(conditionParams[i].ParamString) == conditionParams[i].Compare)
				{
					flag3 = true;
					break;
				}
			}
		}
		if (conditionParams.Length >= 3)
		{
			return flag & flag2 & flag3;
		}
		return false;
	}
}
