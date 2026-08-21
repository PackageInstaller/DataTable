#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class ObserverSkillDeriveCondition : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
		if (conditionParams != null)
		{
			if (conditionParams.Length >= 2)
			{
				conditionParams[1].OnParseInt();
			}
			if (conditionParams.Length >= 4)
			{
				conditionParams[3].OnParseInt();
			}
			if (conditionParams.Length >= 6)
			{
				conditionParams[5].OnParseBool();
			}
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverSkillDeriveWindowParams observerSkillDeriveWindowParams))
		{
			Log.Error("SkillDerive Param TypeError:" + param.GetType());
			return false;
		}
		bool flag = false;
		if (conditionParams.Length >= 1)
		{
			if (conditionParams[0].IsAny)
			{
				flag = true;
			}
			else
			{
				flag = ConditionUtility.ConditionHeroSkillTypeEnum(observerSkillDeriveWindowParams.SkillTypeEnum, conditionParams[0].ParamString);
				flag = flag == conditionParams[0].Compare;
			}
		}
		if (conditionParams.Length == 1)
		{
			return flag;
		}
		bool flag2 = conditionParams.Length >= 2 && (conditionParams[1].IsAny || observerSkillDeriveWindowParams.SkillData.Id == conditionParams[1].ParamInt);
		flag2 = flag2 == conditionParams[1].Compare;
		if (conditionParams.Length == 2)
		{
			return flag & flag2;
		}
		bool flag3 = false;
		if (conditionParams.Length >= 3)
		{
			List<string> skillLabelList = observerSkillDeriveWindowParams.SkillData.GetSkillLabelList();
			flag3 = conditionParams[2].IsAny || skillLabelList.Contains(conditionParams[2].ParamString) == conditionParams[2].Compare;
		}
		if (conditionParams.Length == 3)
		{
			return flag & flag2 & flag3;
		}
		bool flag4 = conditionParams.Length >= 4 && (conditionParams[3].IsAny || observerSkillDeriveWindowParams.DeriveSkillData.Id == conditionParams[3].ParamInt);
		flag4 = flag4 == conditionParams[3].Compare;
		if (conditionParams.Length == 4)
		{
			return flag & flag2 & flag3 & flag4;
		}
		bool flag5 = false;
		if (conditionParams.Length >= 5)
		{
			List<string> skillLabelList2 = observerSkillDeriveWindowParams.DeriveSkillData.GetSkillLabelList();
			flag5 = conditionParams[4].IsAny || skillLabelList2.Contains(conditionParams[4].ParamString) == conditionParams[4].Compare;
		}
		if (conditionParams.Length == 5)
		{
			return flag & flag2 & flag3 & flag4 & flag5;
		}
		bool flag6 = false;
		if (conditionParams.Length >= 6)
		{
			flag6 = conditionParams[5].ParamBool == observerSkillDeriveWindowParams.IsDervie;
		}
		if (conditionParams.Length == 6)
		{
			return flag & flag2 & flag3 & flag4 & flag5 & flag6;
		}
		return false;
	}
}
