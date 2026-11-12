using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._99900EmptyMonster;

public class Action_9_5 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 9990022;

	private static readonly int Skill_Attack02 = 9990023;

	private int SkillTimes01;

	private int SkillTimes02;

	private int SkillTimes03;

	private int Listnum;

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
		FP cd = 30;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor, 1006, 300, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 30;
		FP initCd2 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor2, 1007, 300, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, HpChange);
	}

	private void HpChange(IEvent custom)
	{
		FDP hpPercentage = _actor.actorHealthInfo.hpPercentage;
		if ((FP)hpPercentage <= FDP.FromDouble(0.97) && (FP)hpPercentage > FDP.FromDouble(0.5))
		{
			TriggerOpLisener("BB_High");
		}
		else if ((FP)hpPercentage <= FDP.FromDouble(0.5) && (FP)hpPercentage > FDP.FromDouble(0.1))
		{
			TriggerOpLisener("BB_Middle");
			SkillTimes02 = 1;
		}
		else if ((FP)hpPercentage <= FDP.FromDouble(0.1))
		{
			InterruptSkill();
			SkillTimes01 = 1;
			SkillTimes02 = 0;
			TriggerOpLisener("BB_Low");
		}
	}

	private bool Condition01()
	{
		if (SkillTimes01 >= 1)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (SkillTimes02 >= 1)
		{
			return true;
		}
		return false;
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private IEnumerator Attack01()
	{
		GotoCastskill(Skill_Attack01);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
		SkillTimes01++;
	}
}
