using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Action_Lv1 : MonsterActionBase
{
	private readonly int Skill_Attack01 = 5031102;

	private readonly int Skill_Attack02 = 5031103;

	private readonly int Skill_Attack03 = 5031104;

	private readonly int Skill_Attack04 = 5031105;

	private readonly int Skill_Attack05 = 5031106;

	private readonly int Skill_Attack06 = 5031107;

	private readonly int Skill_Attack07 = 5031108;

	private readonly int Skill_Linger = 5031199;

	private int SkillTimes01;

	private int SkillTimes02;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SkillTimes01 = 0;
		SkillTimes02 = 0;
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
		FP cd = 30;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition03;
		OperateDelegate operateIEnumerator = Attack07;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 2;
		FP initCd2 = 0;
		operationConditionFunc = Condition04;
		operateIEnumerator = Attack08;
		list2.Add(new PoolBranchInfo(actor2, 1002, 888, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 26;
		FP initCd3 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor3, 1003, 90, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 24;
		FP initCd4 = 7;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		operateIEnumerator = Attack04;
		list2.Add(new PoolBranchInfo(actor4, 1004, 80, cd4, initCd4, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 22;
		FP initCd5 = 4;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack05;
		list2.Add(new PoolBranchInfo(actor5, 1006, 60, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 20;
		FP initCd6 = 0;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 180;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor6, 1007, 50, cd6, initCd6, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor7 = _actor;
		FP cd7 = 18;
		FP initCd7 = 0;
		FP releaseDistance3 = 100;
		FP releaseAngle3 = 360;
		operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor7, 1008, 40, cd7, initCd7, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
	}

	private void InterruptStrong(IEvent evt)
	{
		SkillTimes02 = 0;
	}

	private bool Condition01()
	{
		if (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) <= 5)
		{
			if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 90)
			{
				return true;
			}
			return false;
		}
		return false;
	}

	private bool Condition02()
	{
		if (Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer())) <= 5)
		{
			if ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 90 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= 180) || (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= -180 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) <= -90))
			{
				return true;
			}
			return false;
		}
		return false;
	}

	private bool Condition03()
	{
		if (SkillTimes01 >= 6)
		{
			return true;
		}
		return false;
	}

	private bool Condition04()
	{
		if (SkillTimes02 >= 3)
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
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		SkillTimes01++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05()
	{
		GotoCastskill(Skill_Attack05);
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack06()
	{
		GotoCastskill(Skill_Attack06);
		SkillTimes01++;
		SkillTimes02++;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack07()
	{
		GotoCastskill(Skill_Attack07);
		SkillTimes01 = 0;
		SkillTimes02 = 3;
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack08()
	{
		GotoCastskill(Skill_Linger);
		SkillTimes02 = 0;
		yield return WaitSkillFinish();
	}
}
