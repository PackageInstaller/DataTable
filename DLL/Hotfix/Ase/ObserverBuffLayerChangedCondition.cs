#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using UnityEngine;

namespace Ase;

public class ObserverBuffLayerChangedCondition : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
		if (conditionParams != null && conditionParams.Length >= 3)
		{
			conditionParams[2].OnParseInt();
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverBuffLayerChangedParams { ChangedBuff: not null } observerBuffLayerChangedParams))
		{
			Log.Error("BuffLayerChanged Param TypeError:" + param.GetType());
			return false;
		}
		bool flag = conditionParams.Length >= 1 && observerBuffLayerChangedParams.ChangedBuff.RuntimeConfigData?.BuffLabel?.Contains(conditionParams[0].ParamString) == true;
		flag = flag == conditionParams[0].Compare;
		if (conditionParams.Length == 1)
		{
			return flag;
		}
		bool flag2 = false;
		if (conditionParams.Length >= 2)
		{
			flag2 = conditionParams[1].ParamEnum<ChangeType>() == (ChangeType)((observerBuffLayerChangedParams.Layer > 0) ? 2 : 3);
			flag2 = flag2 == conditionParams[1].Compare;
		}
		if (conditionParams.Length == 2)
		{
			return flag & flag2;
		}
		bool flag3 = conditionParams.Length >= 3 && Mathf.Abs(observerBuffLayerChangedParams.Layer) == conditionParams[2].ParamInt;
		flag3 = flag3 == conditionParams[2].Compare;
		return flag & flag2 & flag3;
	}
}
