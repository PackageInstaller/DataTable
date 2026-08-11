#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class ObserverRecoverCondition : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
		if (conditionParams != null && conditionParams.Length >= 3)
		{
			conditionParams[2].OnParseFloat();
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverRecoverParams observerRecoverParams))
		{
			Log.Error("Recover Param TypeError:" + param.GetType());
			return false;
		}
		bool flag = conditionParams.Length >= 1;
		if (flag)
		{
			flag = CompareRelation(observerRecoverParams.DoctorEntity, conditionParams[0]);
		}
		if (conditionParams.Length == 1)
		{
			return flag;
		}
		if (conditionParams.Length == 3)
		{
			bool flag2 = ConditionExtensions.CompareValueMethod(conditionParams[1].ParamEnum<CompareMethodType>(), v2: conditionParams[2].ParamFloat, v1: observerRecoverParams.Recover);
			return flag & flag2;
		}
		return false;
	}
}
