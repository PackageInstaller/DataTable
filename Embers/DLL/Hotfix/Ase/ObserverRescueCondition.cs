#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class ObserverRescueCondition : ObserverConditionBase
{
	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverRescueParams observerRescueParams))
		{
			Log.Error("Rescue Param TypeError:" + param.GetType());
			return false;
		}
		bool result = true;
		if (conditionParams.Length >= 1)
		{
			result = ConditionUtility.ConditionRelationTypeEnum(AIUtility.GetRelation(observerRescueParams.Rescue, observerRescueParams.Wounded), conditionParams[0].ParamString);
		}
		return result;
	}
}
