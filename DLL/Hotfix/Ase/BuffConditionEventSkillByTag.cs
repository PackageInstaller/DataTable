using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionEventSkillByTag : BuffConditionBase
{
	private string skillTag;

	private EntityTeamType teamType;

	private bool conditionVal;

	private bool cacheBuffEvent;

	public override BuffConditionType BuffConditionType => BuffConditionType.EventSkillByTag;

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
		skillTag = paramList[1];
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[2]);
		conditionVal = Utility.Convert.StringToBool(paramList[3]);
		runtimeData = new BuffConditionRuntimeObserverData();
	}

	protected override string OnGetDataString()
	{
		return $"{EventType},{skillTag},{teamType},{conditionVal}";
	}

	protected override void OnMessage(IObserverParams param)
	{
		ObserverDamageProgressParams observerDamageProgressParams = (ObserverDamageProgressParams)param;
		cacheBuffEvent = false;
		if (observerDamageProgressParams.Trigger == null || (observerDamageProgressParams.Attacker.Id != entityTarget.Id && observerDamageProgressParams.Defender.Id != entityTarget.Id))
		{
			return;
		}
		bool flag = ConditionUtility.CompareTargetInTeamType(observerDamageProgressParams.Trigger, entityFrom, entityTarget, teamType);
		int skillId = observerDamageProgressParams.Get<int>("SkillId");
		HeroSkillData heroSkillData = observerDamageProgressParams.Trigger.GetComponent<SkillComponent>()?.GetSkillData(skillId);
		if (heroSkillData != null)
		{
			bool flag2 = heroSkillData.GetSkillLabelList().Contains(skillTag);
			if (flag & flag2)
			{
				cacheBuffEvent = true;
				(runtimeData as BuffConditionRuntimeObserverData).observerParams = param.Copy();
			}
		}
	}

	public override bool OnCheck(Buff buff = null)
	{
		return cacheBuffEvent == conditionVal;
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
	}

	protected override void OnDispose()
	{
		cacheBuffEvent = false;
	}
}
