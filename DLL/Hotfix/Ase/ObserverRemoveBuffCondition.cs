#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class ObserverRemoveBuffCondition : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverRemoveBuffParams { RemoveBuff: not null } observerRemoveBuffParams))
		{
			Log.Error("AddBuff Param TypeError:" + param.GetType());
			return false;
		}
		bool flag = conditionParams.Length >= 1 && observerRemoveBuffParams.RemoveBuff.RuntimeConfigData?.BuffLabel?.Contains(conditionParams[0].ParamString) == true;
		flag = flag == conditionParams[0].Compare;
		if (conditionParams.Length == 1)
		{
			return flag;
		}
		return false;
	}
}
