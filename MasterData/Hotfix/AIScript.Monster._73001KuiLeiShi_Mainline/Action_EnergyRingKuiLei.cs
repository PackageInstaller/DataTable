using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Action_EnergyRingKuiLei : MonsterActionBase
{
	private int skill_EnergyRing = 7201305;

	private int skill_Wander = 9999970;

	private AdventureActor summoner;

	private bool check_EnergyRing;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		summoner?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		SetLogicTagToggleValue(_actor, Common_73001.EnergyRingSync_Tag, value: false);
		check_EnergyRing = true;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		summoner?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		summoner = null;
		check_EnergyRing = false;
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
		Func<bool> operationConditionFunc = Check_EnergyRing;
		OperateDelegate operateIEnumerator = DoCast_EnergyRing;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && !(adventureActorCustomEvent.sender as AdventureActor != summoner) && adventureActorCustomEvent.eventHashCode == Common_73001.evt_EnergyRingSync)
		{
			SetLogicTagToggleValue(_actor, Common_73001.EnergyRingSync_Tag, value: true);
		}
	}

	private bool Check_EnergyRing()
	{
		return check_EnergyRing;
	}

	private IEnumerator DoCast_EnergyRing()
	{
		check_EnergyRing = false;
		CastSkill(skill_Wander);
		yield return WaitTime(2.1f);
		InterruptSkill();
		yield return WaitTime(0.3f);
		CastSkill(skill_EnergyRing);
		yield return WaitSkillFinish();
		_actor.DestroySelf();
	}
}
