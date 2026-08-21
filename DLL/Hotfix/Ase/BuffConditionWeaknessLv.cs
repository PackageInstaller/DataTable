using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionWeaknessLv : BuffConditionBase
{
	private bool cacheBuffEvent;

	private CompareMethodType methodType;

	private int level;

	public override BuffConditionType BuffConditionType => BuffConditionType.WeaknessLv;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[0]);
		level = Utility.Convert.StringToInt(paramList[1]);
		EventType = BattleObserverEventEnum.AttackBefore;
	}

	protected override string OnGetDataString()
	{
		return $"{methodType},{level}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		ObserverDamageProgressParams observerDamageProgressParams = (ObserverDamageProgressParams)param;
		if (observerDamageProgressParams.Defender != null)
		{
			cacheBuffEvent = false;
			WeaknessComponent weaknessComponent = observerDamageProgressParams.Defender?.GetComponent<WeaknessComponent>();
			int v = 0;
			if (weaknessComponent != null)
			{
				v = weaknessComponent.GetWeaknessLevel();
			}
			cacheBuffEvent = ConditionExtensions.CompareValueMethod(methodType, v, level);
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		return CompareLv();
	}

	protected override void OnReset()
	{
		cacheBuffEvent = false;
	}

	private bool CompareLv()
	{
		return cacheBuffEvent;
	}

	protected override void OnDispose()
	{
		cacheBuffEvent = false;
	}
}
