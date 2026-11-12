using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Action_IceMaker : MonsterActionBase
{
	private readonly FP IceMaker_LifeTime = 20;

	private int skill_Normal = 3130127;

	private int skill_Active = 3130128;

	private bool _isReady;

	private CoroutineNode _readyNode;

	private AdventureActor summoner;

	private bool check_Attack;

	private bool check_Active;

	private CoroutineNode lifeTimerNode;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		summoner?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		check_Attack = true;
		check_Active = false;
		_isReady = false;
		StartCor(ref _readyNode, WaitReady());
		StartLifeTimer();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		summoner?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		summoner = null;
		check_Attack = false;
		check_Active = false;
		_isReady = false;
		StopCor(ref _readyNode);
		StopLifeTimer();
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
		FP cd = 8;
		FP initCd = 1;
		Func<bool> operationConditionFunc = Check_Attack;
		OperateDelegate operateIEnumerator = DoCast_Attack;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		operationConditionFunc = Check_Active;
		operateIEnumerator = DoCast_Active;
		list2.Add(new PoolBranchInfo(actor2, 1002, 1, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator WaitReady()
	{
		yield return WaitTime(1);
		_isReady = true;
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && !(adventureActorCustomEvent.sender as AdventureActor != summoner) && adventureActorCustomEvent.eventHashCode == Config.evt_ClearInactiveIceMaker)
		{
			_actor.DestroySelf();
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (!check_Active && evt is AdventureActorGetBuff adventureActorGetBuff && !(adventureActorGetBuff.sender as LogicEntity != _actor) && adventureActorGetBuff.eventInfo.buffId == 313010010)
		{
			InterruptSkill();
			StopLifeTimer();
			check_Active = true;
			check_Attack = false;
		}
	}

	private void StartLifeTimer()
	{
		StopLifeTimer();
		lifeTimerNode = _actor.StartLogicCoroutine(LifeTimer());
	}

	private void StopLifeTimer()
	{
		if (lifeTimerNode != null)
		{
			_actor.StopLogicCoroutine(lifeTimerNode);
			lifeTimerNode = null;
		}
	}

	private IEnumerator LifeTimer()
	{
		for (FP elapsed = 0; elapsed < IceMaker_LifeTime; elapsed += _actor.LogicDeltaTime)
		{
			yield return null;
		}
		_actor.DestroySelf();
	}

	private bool Check_Attack()
	{
		return check_Attack;
	}

	private IEnumerator DoCast_Attack()
	{
		CastSkill(skill_Normal);
		yield return WaitSkillFinish();
	}

	private bool Check_Active()
	{
		return check_Active;
	}

	private IEnumerator DoCast_Active()
	{
		CastSkill(skill_Active);
		yield return WaitSkillFinish();
	}
}
