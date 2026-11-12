using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Action_Lv2 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 3110101;

	private static readonly int Skill_Attack02 = 3110103;

	private static readonly int Skill_Attack03 = 3110104;

	private static readonly int Skill_Attack04 = 3110105;

	private static readonly int Skill_Attack05 = 3110106;

	private static readonly int Skill_Attack06 = 3110107;

	private static readonly int Skill_Attack07 = 3110108;

	private static readonly int Wander = 3110109;

	private FP SkillTimes01;

	private int SkillTimes02;

	private FP SkillTimes03;

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
		FP cd = 15;
		FP initCd = 0;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		OperateDelegate operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor, 1001, 210, cd, initCd, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 8;
		FP initCd2 = 1;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 360;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor2, 1002, 210, cd2, initCd2, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 35;
		FP initCd3 = 10;
		Func<bool> operationConditionFunc = Condition02;
		operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor3, 1003, 300, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 0;
		FP initCd4 = 7;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack04;
		list2.Add(new PoolBranchInfo(actor4, 1004, 350, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 50;
		FP initCd5 = 40;
		FP releaseDistance3 = 100;
		FP releaseAngle3 = 360;
		operateIEnumerator = Attack05;
		list2.Add(new PoolBranchInfo(actor5, 1005, 999, cd5, initCd5, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 0.1;
		FP initCd6 = 0;
		operateIEnumerator = Walk;
		list2.Add(new PoolBranchInfo(actor6, 1007, 1, cd6, initCd6, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
		SkillTimes02 = 0;
		SkillTimes03 = 0;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, HpChange);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	private void HpChange(IEvent custom)
	{
	}

	private void InterruptStrong(IEvent evt)
	{
	}

	private bool Condition01()
	{
		if (SkillTimes02 >= 2 && SkillTimes03 == 0)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (SkillTimes02 != 0 && SkillTimes03 == 1)
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
		SkillTimes02++;
		if (SkillTimes01 == 0)
		{
			GotoCastskill(Skill_Attack06);
			yield return WaitSkillFinish();
			SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
		}
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
		SkillTimes02++;
		GotoCastskill(Skill_Attack06);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		yield return WaitSkillFinish();
		SkillTimes02--;
		SkillTimes03 = 0;
		GotoCastskill(Skill_Attack07);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		yield return WaitSkillFinish();
		SkillTimes02 = 0;
		SkillTimes03 = 1;
	}

	private IEnumerator Attack05()
	{
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
		SkillTimes02 = 0;
		GotoCastskill(Skill_Attack06);
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
