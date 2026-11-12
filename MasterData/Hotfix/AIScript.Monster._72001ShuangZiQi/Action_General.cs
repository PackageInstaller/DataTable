using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Action_General : MonsterActionBase
{
	private const int Skill_Atk = 7200602;

	private const int Skill_Atk2 = 7200604;

	private int Attack1002TimesMax_P12 = 3;

	private int Attack1002TimesMax_P3 = 2;

	private AdventureActor summoner;

	private int Attack1002Times;

	private int Attack1002TimesMax;

	private bool check_Attack1002;

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
		Func<bool> operationConditionFunc = Check_Attack1001;
		OperateDelegate operateIEnumerator = DoCast_Attack1001;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 2;
		FP initCd2 = 0;
		operationConditionFunc = Check_Attack1002;
		operateIEnumerator = DoCast_Attack1002;
		list2.Add(new PoolBranchInfo(actor2, 1002, 1, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		Attack1002Times = 0;
		if (GetLogicTagFpValue(_actor, "Phase") >= 3)
		{
			Attack1002TimesMax = Attack1002TimesMax_P3;
		}
		else
		{
			Attack1002TimesMax = Attack1002TimesMax_P12;
		}
		summoner = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		summoner?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		summoner?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		check_Attack1002 = false;
	}

	private IEnumerator DoCast_Attack1001()
	{
		CastSkill(7200602);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoCast_Attack1002()
	{
		Attack1002Times++;
		CastSkill(7200604);
		yield return WaitSkillFinish();
		if (Attack1002Times >= Attack1002TimesMax)
		{
			yield return WaitTime(0.5f);
			_actor.DestroySelf();
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		AdventureActor adventureActor = adventureActorCustomEvent.sender as AdventureActor;
		AdventureActor adventureActor2 = adventureActorCustomEvent.target as AdventureActor;
		if (adventureActor == summoner && adventureActor2 == _actor && adventureActorCustomEvent.eventHashCode == Config.general1AtkEvt)
		{
			check_Attack1002 = true;
		}
	}

	private bool Check_Attack1001()
	{
		return GetLogicTagFpValue(_actor, "Type") == 1;
	}

	private bool Check_Attack1002()
	{
		if (GetLogicTagFpValue(_actor, "Type") == 2)
		{
			return check_Attack1002;
		}
		return false;
	}
}
