#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverAddBuffCondition : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
		if (conditionParams != null && conditionParams.Length >= 6)
		{
			conditionParams[5].OnParseFloat();
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverAddBuffParams { AddBuff: not null } observerAddBuffParams))
		{
			Log.Error("AddBuff Param TypeError:" + param.GetType());
			return false;
		}
		bool flag = conditionParams.Length >= 2;
		if (flag)
		{
			flag = ConditionUtility.ConditionRelationTypeEnum(AIUtility.GetRelation(observerAddBuffParams.AddBuff.BuffOwner, observerAddBuffParams.AddBuff.BuffFrom), conditionParams[0].ParamString);
			flag &= observerAddBuffParams.AddBuff.RuntimeConfigData?.BuffLabel?.Contains(conditionParams[1].ParamString) == true == conditionParams[1].Compare;
		}
		if (conditionParams.Length == 2)
		{
			return flag;
		}
		if (conditionParams.Length == 6)
		{
			Ase.ECS.PropertyData propertyData = observerAddBuffParams.AddBuff.BuffOwner.GetPropertyData(conditionParams[2].ParamString);
			if (propertyData == null)
			{
				return false;
			}
			CompareMethodType methodType = conditionParams[3].ParamEnum<CompareMethodType>();
			NumericalValueType numericalValueType = conditionParams[4].ParamEnum<NumericalValueType>();
			float v = 0f;
			switch (numericalValueType)
			{
			case NumericalValueType.FixedValue:
				v = propertyData.CurValue;
				break;
			case NumericalValueType.Percentage:
				v = propertyData.ScaleValue;
				break;
			}
			if (flag)
			{
				return ConditionExtensions.CompareValueMethod(methodType, v, conditionParams[5].ParamFloat);
			}
			return false;
		}
		return false;
	}
}
