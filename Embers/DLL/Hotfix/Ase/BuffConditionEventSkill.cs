using System.Collections.Generic;

namespace Ase;

public class BuffConditionEventSkill : BuffConditionBase
{
	private int skillId;

	private EntityTeamType teamType;

	private bool conditionVal;

	private bool cacheBuffEvent;

	public override BuffConditionType BuffConditionType => BuffConditionType.EventSkill;

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
		skillId = Utility.Convert.StringToInt(paramList[1]);
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[2]);
		conditionVal = Utility.Convert.StringToBool(paramList[3]);
	}

	protected override string OnGetDataString()
	{
		return $"{EventType},{skillId},{teamType},{conditionVal}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		ObserverDamageProgressParams observerDamageProgressParams = (ObserverDamageProgressParams)param;
		cacheBuffEvent = false;
		if (observerDamageProgressParams.Trigger != null && (observerDamageProgressParams.Attacker.Id == entityTarget.Id || observerDamageProgressParams.Defender.Id == entityTarget.Id))
		{
			bool flag = ConditionUtility.CompareTargetInTeamType(observerDamageProgressParams.Defender, entityFrom, entityTarget, teamType);
			bool flag2 = observerDamageProgressParams.Get<int>("SkillId") == skillId;
			cacheBuffEvent = flag & flag2;
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		return cacheBuffEvent == conditionVal;
	}

	protected override void OnReset()
	{
		cacheBuffEvent = false;
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
