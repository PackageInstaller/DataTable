using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Action_A : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 5010120;

	private static readonly int Skill_Attack02 = 5010121;

	private static readonly int Skill_Attack03 = 5010122;

	private static readonly int Skill_Attack04 = 5010123;

	private static readonly int Skill_Attack05 = 5010124;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 25;
		FP initCd = 0;
		Func<bool> operationConditionFunc = ConditionSkill01;
		OperateDelegate operateIEnumerator = Change;
		list2.Add(new PoolBranchInfo(actor, 1006, 80, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 15;
		FP initCd2 = 10;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor2, 1001, 90, cd2, initCd2, active: true, releaseDistance, releaseAngle, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 25;
		FP initCd3 = 8;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 360;
		operateIEnumerator = Attack05;
		list2.Add(new PoolBranchInfo(actor3, 1005, 80, cd3, initCd3, active: true, releaseDistance2, releaseAngle2, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 25;
		FP initCd4 = 6;
		FP releaseDistance3 = 100;
		FP releaseAngle3 = 360;
		operateIEnumerator = Attack04;
		list2.Add(new PoolBranchInfo(actor4, 1004, 70, cd4, initCd4, active: true, releaseDistance3, releaseAngle3, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 25;
		FP initCd5 = 3;
		FP releaseDistance4 = 100;
		FP releaseAngle4 = 360;
		operateIEnumerator = Attack03;
		list2.Add(new PoolBranchInfo(actor5, 1003, 60, cd5, initCd5, active: true, releaseDistance4, releaseAngle4, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 10;
		FP initCd6 = 0;
		FP releaseDistance5 = 100;
		FP releaseAngle5 = 360;
		operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor6, 1002, 50, cd6, initCd6, active: true, releaseDistance5, releaseAngle5, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		PoolBranchesInfo poolBranchesInfo2 = new PoolBranchesInfo
		{
			index = 2
		};
		List<PoolBranchInfo> list3 = new List<PoolBranchInfo>();
		AdventureActor actor7 = _actor;
		FP cd7 = 20;
		FP initCd7 = 3;
		FP releaseDistance6 = 100;
		FP releaseAngle6 = 360;
		operateIEnumerator = Attack05;
		list3.Add(new PoolBranchInfo(actor7, 2005, 80, cd7, initCd7, active: true, releaseDistance6, releaseAngle6, default, null, null, operateIEnumerator));
		AdventureActor actor8 = _actor;
		FP cd8 = 20;
		FP initCd8 = 0;
		FP releaseDistance7 = 100;
		FP releaseAngle7 = 360;
		operateIEnumerator = Attack04;
		list3.Add(new PoolBranchInfo(actor8, 2004, 70, cd8, initCd8, active: true, releaseDistance7, releaseAngle7, default, null, null, operateIEnumerator));
		AdventureActor actor9 = _actor;
		FP cd9 = 15;
		FP initCd9 = 0;
		FP releaseDistance8 = 100;
		FP releaseAngle8 = 360;
		operateIEnumerator = Attack03;
		list3.Add(new PoolBranchInfo(actor9, 2003, 60, cd9, initCd9, active: true, releaseDistance8, releaseAngle8, default, null, null, operateIEnumerator));
		AdventureActor actor10 = _actor;
		FP cd10 = 10;
		FP initCd10 = 0;
		FP releaseDistance9 = 100;
		FP releaseAngle9 = 360;
		operateIEnumerator = Attack02;
		list3.Add(new PoolBranchInfo(actor10, 2002, 50, cd10, initCd10, active: true, releaseDistance9, releaseAngle9, default, null, null, operateIEnumerator));
		poolBranchesInfo2.braches = list3;
		list.Add(poolBranchesInfo2);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private bool ConditionSkill01()
	{
		if (GetBuffNum(_actor, 501010001) >= 1 || GetBuffNum(_actor, 501010002) >= 1)
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

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05()
	{
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
	}

	private IEnumerator Change()
	{
		GotoCastskill(Skill_Attack05);
		SwitchPool(2);
		yield return WaitSkillFinish();
	}
}
