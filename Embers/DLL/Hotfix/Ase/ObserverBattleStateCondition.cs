#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class ObserverBattleStateCondition : ObserverConditionBase
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
		if (!(param is ObserverBattleStateChangeParams observerBattleStateChangeParams))
		{
			Log.Error("ObserverBattleStateChange Param TypeError:" + param.GetType());
			return false;
		}
		if (conditionParams.Length >= 1)
		{
			return observerBattleStateChangeParams.InBattleState == conditionParams[0].ParamBool;
		}
		return false;
	}
}
