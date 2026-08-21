#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class ObserverWeaknessBarCondition : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
		if (conditionParams != null && conditionParams.Length >= 1)
		{
			conditionParams[0].OnParseBool();
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverWeaknessBarParams observerWeaknessBarParams))
		{
			Log.Error("WeaknessBar Param TypeError:" + param.GetType());
			return false;
		}
		if (conditionParams.Length >= 1)
		{
			if (!conditionParams[0].IsAny)
			{
				return observerWeaknessBarParams.IsShow == conditionParams[0].ParamBool;
			}
			return true;
		}
		return false;
	}
}
