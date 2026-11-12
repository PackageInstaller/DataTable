using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Action_Artillery : MonsterActionBase
{
	private const int Skill_Atk = 7200402;

	private const int Skill_Atk1 = 7200404;

	private AdventureActor summoner;

	private bool isExtra;

	private bool check_Attack;

	private bool check_Attack1;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		summoner.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		isExtra = GetLogicTagToggleValue(_actor, "IsExtra");
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		summoner?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		check_Attack = false;
		check_Attack1 = false;
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 2;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Check_Attack;
		OperateDelegate operateIEnumerator = DoCast_Attack;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 2;
		FP initCd2 = 0;
		operationConditionFunc = Check_Attack1;
		operateIEnumerator = DoCast_Attack1;
		list2.Add(new PoolBranchInfo(actor2, 1002, 1, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void OnCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		AdventureActor adventureActor = adventureActorCustomEvent.sender as AdventureActor;
		AdventureActor adventureActor2 = adventureActorCustomEvent.target as AdventureActor;
		if (adventureActor == summoner && adventureActor2 == _actor)
		{
			int eventHashCode = adventureActorCustomEvent.eventHashCode;
			if (eventHashCode == Config.artilleryAtkEvt)
			{
				check_Attack = true;
			}
			else if (eventHashCode == Config.artillery1AtkEvt)
			{
				check_Attack1 = true;
			}
			else if (eventHashCode == Config.artillery1ExtraAtkEvt && isExtra)
			{
				check_Attack1 = true;
			}
		}
	}

	private bool Check_Attack()
	{
		return check_Attack;
	}

	private IEnumerator DoCast_Attack()
	{
		CastSkill(7200402);
		check_Attack = false;
		yield return WaitSkillFinish();
	}

	private bool Check_Attack1()
	{
		return check_Attack1;
	}

	private IEnumerator DoCast_Attack1()
	{
		CastSkill(7200404);
		check_Attack1 = false;
		yield return WaitSkillFinish();
	}
}
