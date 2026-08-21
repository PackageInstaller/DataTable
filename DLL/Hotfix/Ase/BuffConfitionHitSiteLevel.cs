using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConfitionHitSiteLevel : BuffConditionBase
{
	private bool cacheBuffEvent;

	private int hitLevel;

	private int level;

	private CompareMethodType methodType;

	public override BuffConditionType BuffConditionType => BuffConditionType.HitSiteLevel;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		level = Utility.Convert.StringToInt(paramList[0]);
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[1]);
		EventType = BattleObserverEventEnum.AttackBefore;
	}

	protected override string OnGetDataString()
	{
		return $"{level},{methodType}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		ObserverDamageProgressParams observerDamageProgressParams = (ObserverDamageProgressParams)param;
		cacheBuffEvent = false;
		if (((observerDamageProgressParams.Defender != null && observerDamageProgressParams.Defender.Id == entityFrom.Id) || (observerDamageProgressParams.Attacker != null && observerDamageProgressParams.Attacker.Id == entityTarget.Id)) && observerDamageProgressParams.Defender?.GetSystem<EntitySystem>() != null)
		{
			hitLevel = -1;
			if (observerDamageProgressParams.ContainsKey("SiteLevel"))
			{
				hitLevel = observerDamageProgressParams.Get<int>("SiteLevel");
				cacheBuffEvent = true;
			}
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (cacheBuffEvent)
		{
			return ConditionExtensions.CompareValueMethod(methodType, hitLevel, level);
		}
		return false;
	}

	protected override void OnReset()
	{
		cacheBuffEvent = false;
	}

	protected override void OnDispose()
	{
		cacheBuffEvent = false;
	}
}
