using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Action_ChongFengKuiLei : MonsterActionBase
{
	private const int skill_ChongFeng_Attack = 7201301;

	private AdventureActor summoner;

	private bool check_Attack;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		summoner?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		SetLogicTagToggleValue(_actor, Common_73001.PuppetSync_Tag, value: false);
		check_Attack = true;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		summoner?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		summoner = null;
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
		FP cd = 0;
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
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && !(adventureActorCustomEvent.sender as AdventureActor != summoner) && adventureActorCustomEvent.eventHashCode == Common_73001.evt_PuppetSyncAttack)
		{
			SetLogicTagToggleValue(_actor, Common_73001.PuppetSync_Tag, value: true);
		}
	}

	private bool Check_Attack()
	{
		return check_Attack;
	}

	private IEnumerator DoCast_Attack()
	{
		check_Attack = false;
		CastSkill(7201301);
		yield return WaitSkillFinish();
		_actor.DestroySelf();
	}
}
