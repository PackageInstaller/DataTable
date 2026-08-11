namespace Ase;

public class ObserverEntityDeadRebornConditon : ObserverConditionBase
{
	protected override void OnInit()
	{
		base.OnInit();
		if (conditionParams != null && conditionParams.Length == 1)
		{
			conditionParams[0].OnParseInt();
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		return param.Trigger.EntityId == conditionParams[0].ParamInt == conditionParams[0].Compare;
	}
}
