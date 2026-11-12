#define LOG_DEBUG
using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Dark._HardLevel._50020ShaYuFaShi;

public class HardLevel_Action_A : MonsterActionBase
{
	private static readonly int Dark_Attack01 = 5002050;

	private static readonly int Dark_Attack02 = 5002051;

	private static readonly int Dark_Attack03 = 5002052;

	private static readonly int Dark_Swim = 5002053;

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
		FP cd = 15;
		FP initCd = 10;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		OperateDelegate operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor, 1001, 100, cd, initCd, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 10;
		FP initCd2 = 8;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 360;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor2, 1002, 90, cd2, initCd2, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 5;
		FP initCd3 = 0;
		FP releaseDistance3 = 100;
		FP releaseAngle3 = 360;
		operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor3, 1003, 80, cd3, initCd3, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 3;
		FP initCd4 = 0;
		Func<bool> operationConditionFunc = ConditionSwim;
		operateIEnumerator = Swim;
		list2.Add(new PoolBranchInfo(actor4, 1004, 60, cd4, initCd4, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 12;
		FP initCd5 = 0;
		operationConditionFunc = ConditionSwim02;
		operateIEnumerator = SwimOut;
		list2.Add(new PoolBranchInfo(actor5, 1005, 50, cd5, initCd5, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private bool ConditionSwim()
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
		GetRandomValue(1, 2, isInt: true);
		FP LastNum = SkillTimes;
		GotoCastskill(Dark_Attack01);
		yield return WaitSkillFinish();
		SkillTimes = LastNum + 1;
	}

	private IEnumerator Attack02()
	{
		GetRandomValue(1, 2, isInt: true);
		FP LastNum = SkillTimes;
		GotoCastskill(Dark_Attack02);
		yield return WaitSkillFinish();
		SkillTimes = LastNum + 1;
		NovaLogger.Debug("ss");
	}

	private IEnumerator Attack03()
	{
		FP RanNum = GetRandomValue(1, 2, isInt: true);
		FP LastNum = SkillTimes;
		GotoCastskill(Dark_Attack03);
		yield return WaitSkillFinish();
		SkillTimes = LastNum + RanNum;
	}

	private IEnumerator Swim()
	{
		GotoCastskill(Dark_Swim);
		yield return WaitSkillFinish();
		SkillTimes = 0;
	}

	private IEnumerator SwimOut()
	{
		GotoCastskill(Dark_Swim);
		SetPoolBranchCD(1004, 10);
		yield return WaitSkillFinish();
	}
}
