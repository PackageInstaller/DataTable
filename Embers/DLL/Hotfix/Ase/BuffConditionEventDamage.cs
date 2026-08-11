using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionEventDamage : BuffConditionBase
{
	private EntityTeamType teamType;

	private bool conditionVal;

	private int count;

	private List<BaseEntity> eventEntityList = new List<BaseEntity>();

	private int tempCount;

	private bool cacheBuffEvent;

	public override BuffConditionType BuffConditionType => BuffConditionType.EventDamage;

	protected override int paramsMinCount => 4;

	protected override BattleObserverEventEnum EventType
	{
		get
		{
			return base.EventType;
		}
		set
		{
			base.EventType = value;
		}
	}

	protected override void OnInit(List<string> paramList)
	{
		EventType = Utility.Convert.StringToEnum<BattleObserverEventEnum>(paramList[0]);
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[1]);
		conditionVal = Utility.Convert.StringToBool(paramList[2]);
		count = Utility.Convert.StringToInt(paramList[3]);
		tempCount = count;
	}

	protected override string OnGetDataString()
	{
		return $"{EventType},{teamType},{conditionVal},{count}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		if (param is ObserverDamageProgressParams { Trigger: not null } observerDamageProgressParams && !eventEntityList.Contains(observerDamageProgressParams.Trigger))
		{
			eventEntityList.Add(observerDamageProgressParams.Trigger);
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (eventEntityList.IsNullOrEmpty())
		{
			return false;
		}
		foreach (BaseEntity eventEntity in eventEntityList)
		{
			if (ConditionUtility.CompareTargetInTeamType(eventEntity, entityFrom, entityTarget, teamType) == conditionVal)
			{
				tempCount--;
				break;
			}
		}
		return tempCount <= 0;
	}

	protected override void OnCheckSyncBattleSafeAction()
	{
		base.OnCheckSyncBattleSafeAction();
		if (teamType != EntityTeamType.Actor)
		{
			_ = teamType;
			_ = 12;
		}
	}

	protected override void OnReset()
	{
		cacheBuffEvent = false;
		tempCount = count;
		eventEntityList.Clear();
	}

	protected override void OnDispose()
	{
		cacheBuffEvent = false;
		eventEntityList.Clear();
	}
}
