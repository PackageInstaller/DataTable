using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionWeaknessLvEvent : BuffConditionBase
{
	private bool cacheBuffEvent;

	private EntityTeamType teamType;

	private CompareMethodType methodType;

	private int level;

	public override BuffConditionType BuffConditionType => BuffConditionType.WeaknessLvEvent;

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

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		EventType = Utility.Convert.StringToEnum<BattleObserverEventEnum>(paramList[0]);
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[1]);
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[2]);
		level = Utility.Convert.StringToInt(paramList[3]);
	}

	protected override string OnGetDataString()
	{
		return $"{EventType},{teamType},{methodType},{level}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		ObserverDamageProgressParams observerDamageProgressParams = (ObserverDamageProgressParams)param;
		WeaknessComponent component = BuffExtension.GetTargetByTeamType(entityFrom, entityTarget, teamType, observerDamageProgressParams.Defender).GetComponent<WeaknessComponent>();
		int v = 0;
		if (component != null)
		{
			v = component.GetWeaknessLevel();
		}
		cacheBuffEvent = ConditionExtensions.CompareValueMethod(methodType, v, level);
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

	protected override void OnCheckSyncBattleSafeAction()
	{
		base.OnCheckSyncBattleSafeAction();
		if (teamType != EntityTeamType.Actor)
		{
			_ = teamType;
			_ = 12;
		}
	}

	protected override void OnDispose()
	{
		cacheBuffEvent = false;
	}
}
