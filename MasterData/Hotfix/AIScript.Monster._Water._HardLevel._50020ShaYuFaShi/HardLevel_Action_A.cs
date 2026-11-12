using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Water._HardLevel._50020ShaYuFaShi;

public class HardLevel_Action_A : MonsterActionBase
{
	private static readonly int Water_Attack01 = 5002054;

	private static readonly int Water_Attack02 = 5002055;

	private static readonly int Water_Swim = 5002056;

	private FP SkillTimes;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SkillTimes = 0;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 25;
		FP initCd = 15;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		OperateDelegate operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor, 1001, 100, cd, initCd, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 5;
		FP initCd2 = 0;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 360;
		operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor2, 1002, 90, cd2, initCd2, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 10;
		FP initCd3 = 0;
		Func<bool> operationConditionFunc = ConditionSwim01;
		operateIEnumerator = Swim01;
		list2.Add(new PoolBranchInfo(actor3, 1003, 80, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 15;
		FP initCd4 = 0;
		operationConditionFunc = ConditionSwim02;
		operateIEnumerator = Swim02;
		list2.Add(new PoolBranchInfo(actor4, 1004, 60, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private bool ConditionSwim01()
	{
		if (SkillTimes >= 4)
		{
			return true;
		}
		return false;
	}

	private bool ConditionSwim02()
	{
		if (Distance(GetPosition(), GetEntityPositionObsoleted(GetAttackTarget())) <= 5)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Attack01()
	{
		FP RanNum = GetRandomValue(1, 2, isInt: true);
		FP LastNum = SkillTimes;
		GotoCastskill(Water_Attack01);
		yield return WaitSkillFinish();
		SkillTimes = LastNum + RanNum;
	}

	private IEnumerator Attack02()
	{
		FP RanNum = GetRandomValue(1, 2, isInt: true);
		FP LastNum = SkillTimes;
		GotoCastskill(Water_Attack02);
		yield return WaitSkillFinish();
		SkillTimes = LastNum + RanNum;
	}

	private IEnumerator Swim01()
	{
		GotoCastskill(Water_Swim);
		yield return WaitSkillFinish();
		SkillTimes = 0;
	}

	private IEnumerator Swim02()
	{
		GotoCastskill(Water_Swim);
		SetPoolBranchCD(1003, 10);
		yield return WaitSkillFinish();
	}
}
