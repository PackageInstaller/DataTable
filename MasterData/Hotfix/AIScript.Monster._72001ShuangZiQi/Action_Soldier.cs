using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Action_Soldier : MonsterActionBase
{
	private const int Skill_Atk = 7200302;

	private AdventureActor summoner;

	private CoroutineNode KillselfCor;

	private bool check_Attack;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		summoner.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		StartCor(ref KillselfCor, Killself());
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		summoner?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		check_Attack = false;
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
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void OnCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (adventureActorCustomEvent.sender as AdventureActor == summoner && adventureActorCustomEvent.eventHashCode == Config.soldierAtkEvt)
		{
			check_Attack = true;
		}
	}

	private bool Check_Attack()
	{
		return check_Attack;
	}

	private IEnumerator DoCast_Attack()
	{
		StopCor(KillselfCor);
		CastSkill(7200302);
		check_Attack = false;
		yield return WaitSkillFinish();
	}

	private IEnumerator Killself()
	{
		yield return WaitTime(3);
		_actor.DestroySelf();
	}
}
