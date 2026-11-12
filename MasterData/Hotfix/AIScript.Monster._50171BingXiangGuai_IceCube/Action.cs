using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai_IceCube;

public class Action : MonsterActionBase
{
	private static readonly int Skillid_Skating = 5017121;

	private static readonly int Skillid_KillMyself = 5017122;

	private static readonly int Skillid_SkatingFromIce = 5017125;

	private static readonly int testSkillId = 0;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
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
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Skating;
		list2.Add(new PoolBranchInfo(actor, 1001, 100, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = SkatingFromIce;
		list2.Add(new PoolBranchInfo(actor2, 1002, 100, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.CustomEventOnlySelfOrSummoner, active: true, OnCustomEvt);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (!(_actor == null) && !_actor.isDead && !_actor.inDying && !_actor.isDeclareDead && evt is AdventureActorCustomEvent adventureActorCustomEvent && !string.IsNullOrEmpty(adventureActorCustomEvent.eventName) && adventureActorCustomEvent.eventName.Equals("IceBoom"))
		{
			CastSkill(Skillid_KillMyself);
		}
	}

	private bool Condition01()
	{
		if (GetBuffNum(_actor, 501710002) >= 1)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (GetBuffNum(_actor, 501710003) >= 1)
		{
			return true;
		}
		return false;
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator Skating()
	{
		GotoCastSkill(Skillid_Skating);
		yield return WaitSkillFinish();
	}

	private IEnumerator SkatingFromIce()
	{
		GotoCastSkill(Skillid_SkatingFromIce);
		yield return WaitSkillFinish();
	}
}
