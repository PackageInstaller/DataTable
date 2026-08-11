#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class ObserverInteractiveCondition : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
		if (conditionParams != null && conditionParams.Length >= 1)
		{
			for (int i = 0; i < conditionParams.Length; i++)
			{
				conditionParams[i].OnParseInt();
			}
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverInteractiveParams observerInteractiveParams))
		{
			Log.Error("Interactive Param TypeError:" + param.GetType());
			return false;
		}
		if (observerInteractiveParams.InteractiveEntity == null)
		{
			return false;
		}
		bool result = false;
		for (int i = 0; i < base.conditionParams.Length; i++)
		{
			if (conditionParams[i].ParamInt == observerInteractiveParams.InteractiveEntity.EntityId == conditionParams[i].Compare)
			{
				result = true;
				break;
			}
		}
		return result;
	}
}
