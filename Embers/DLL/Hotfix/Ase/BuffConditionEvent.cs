using System.Collections.Generic;

namespace Ase;

public class BuffConditionEvent : BuffConditionBase
{
	private RelationTypeEnum _relationTypeEnum;

	protected bool cacheBuffEvent;

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

	public override BuffConditionType BuffConditionType => BuffConditionType.Event;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		EventType = Utility.Convert.StringToEnum<BattleObserverEventEnum>(paramList[0]);
		_relationTypeEnum = Utility.Convert.StringToEnum<RelationTypeEnum>(paramList[1]);
	}

	protected override string OnGetDataString()
	{
		return $"{EventType},{_relationTypeEnum}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		if (param.Trigger != null && param.Trigger.Id == entityTarget.Id)
		{
			cacheBuffEvent = false;
			if (_relationTypeEnum == RelationTypeEnum.Unknown)
			{
				cacheBuffEvent = true;
			}
			else
			{
				cacheBuffEvent = AIUtility.GetRelation(param.Trigger, entityTarget) == _relationTypeEnum;
			}
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		return cacheBuffEvent;
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
