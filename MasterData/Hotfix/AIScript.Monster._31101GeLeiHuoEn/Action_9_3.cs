using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Action_9_3 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 3110101;

	private static readonly int Skill_Attack02 = 3110103;

	private static readonly int Skill_Attack03 = 3110115;

	private static readonly int Skill_Attack04 = 3110105;

	private static readonly int Skill_Attack06 = 3110107;

	private static readonly int Skill_Attack08 = 3110111;

	private static readonly int Skill_Attack09 = 3110112;

	private static readonly int Skill_Attack10 = 3110113;

	private static readonly int Wander = 3110109;

	private FP SkillTimes04;

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
		FP cd = 10;
		FP initCd = 0;
		FP releaseDistance = 12;
		FP releaseAngle = 360;
		OperateDelegate operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor, 1001, 210, cd, initCd, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 8;
		FP initCd2 = 1;
		FP releaseDistance2 = 12;
		FP releaseAngle2 = 360;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor2, 1002, 210, cd2, initCd2, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 25;
		FP initCd3 = 10;
		FP releaseDistance3 = 100;
		FP releaseAngle3 = 360;
		operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor3, 1003, 300, cd3, initCd3, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 8;
		FP initCd4 = 1;
		Func<bool> operationConditionFunc = Condition02;
		operateIEnumerator = Attack08;
		list2.Add(new PoolBranchInfo(actor4, 1004, 310, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 999;
		FP initCd5 = 32;
		operationConditionFunc = Condition03;
		operateIEnumerator = Attack09;
		list2.Add(new PoolBranchInfo(actor5, 1005, 999, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 60;
		FP initCd6 = 65;
		FP releaseDistance4 = 100;
		FP releaseAngle4 = 360;
		operateIEnumerator = Attack10;
		list2.Add(new PoolBranchInfo(actor6, 1006, 999, cd6, initCd6, active: true, releaseDistance4, releaseAngle4, default, null, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 0.1;
		FP initCd7 = 0;
		operateIEnumerator = Walk;
		list2.Add(new PoolBranchInfo(actor7, 1007, 1, cd7, initCd7, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		SkillTimes04 = 0;
		AddBuffToTarget(_actor, 311010000);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	private void InterruptStrong(IEvent evt)
	{
		TriggerOpLisener("BB_2");
	}

	private bool Condition02()
	{
		if (Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) > 12)
		{
			return true;
		}
		return false;
	}

	private bool Condition03()
	{
		if (SkillTimes04 == 0)
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
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack09()
	{
		GotoCastskill(Skill_Attack09);
		TriggerOpLisener("BB_1");
		yield return WaitSkillFinish();
		SkillTimes04 = 1;
	}

	private IEnumerator Attack10()
	{
		GotoCastskill(Skill_Attack10);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack08()
	{
		GotoCastskill(Skill_Attack08);
		yield return WaitSkillFinish();
	}

	private IEnumerator Walk()
	{
		GotoCastskill(Wander);
		yield return WaitTime(1.1);
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		yield return WaitSkillFinish();
	}
}
