using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class Shadow_Action : MonsterActionBase
{
	private readonly int Skillid_TiaoPu = 5025142;

	private readonly int Skillid_Laser = 5025143;

	private readonly int Skillid_Dash = 5025144;

	private static readonly int testSkillId;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		InitListenEvent(MonsterEventType.CustomEventOnlySelfOrSummoner, active: true, OnCustomEvt);
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
		OperateDelegate operateIEnumerator = TiaoPu;
		list2.Add(new PoolBranchInfo(actor, 1001, 100, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (!(_actor == null) && !_actor.isDead && !_actor.inDying && !_actor.isDeclareDead && evt is AdventureActorCustomEvent adventureActorCustomEvent && !string.IsNullOrEmpty(adventureActorCustomEvent.eventName))
		{
			if (adventureActorCustomEvent.eventName.Equals("CastLaserSkill"))
			{
				GotoCastSkill(Skillid_Laser);
			}
			if (adventureActorCustomEvent.eventName.Equals("CastDashSkill"))
			{
				GotoCastSkill(Skillid_Dash);
			}
		}
	}

	private bool Condition01()
	{
		if (GetBuffNum(_actor, 502510012) >= 1)
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

	private IEnumerator TiaoPu()
	{
		GotoCastSkill(Skillid_TiaoPu);
		yield return WaitSkillFinish();
	}

	private IEnumerator Dash()
	{
		GotoCastSkill(Skillid_Dash);
		yield return WaitSkillFinish();
	}
}
