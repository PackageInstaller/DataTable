using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffConditionObserverParam : BuffConditionBase
{
	private string[] args = new string[0];

	protected bool cacheBuffEvent;

	protected ObserverConditionBase observerCondition;

	public override BuffConditionType BuffConditionType => BuffConditionType.ObserverParam;

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

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
		EventType = Utility.Convert.StringToEnum<BattleObserverEventEnum>(paramList[0]);
		runtimeData = new BuffConditionRuntimeObserverData();
		cacheBuffEvent = false;
		args = new string[paramList.Count - 1];
		for (int i = 0; i < args.Length; i++)
		{
			args[i] = paramList[i + 1];
		}
		observerCondition = ObserverUtility.GetObserverCondition(EventType);
		observerCondition.Init(entityTarget, EventType, args);
	}

	protected override string OnGetDataString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append($"{EventType}");
		if (args != null)
		{
			for (int i = 0; i < args.Length; i++)
			{
				stringBuilder.Append("," + args[i]);
			}
		}
		return stringBuilder.ToString();
	}

	protected override void OnMessage(IObserverParams param)
	{
		if (observerCondition != null && observerCondition.CheckCondition(param))
		{
			cacheBuffEvent = true;
			(runtimeData as BuffConditionRuntimeObserverData).observerParams = param.Copy();
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
		args = null;
		observerCondition = null;
	}
}
