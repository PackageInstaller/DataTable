using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Earth._50311DaWuGui;

public class Earth_Action_Jiejin : MonsterActionBase
{
	private readonly int Skill_Attack01 = 5031111;

	private readonly int Skill_Attack02 = 5031112;

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
		FP cd = 0;
		FP initCd = 0;
		FP releaseDistance = 100;
		FP releaseAngle = 360;
		Func<bool> operationConditionFunc = Condition02;
		OperateDelegate operateIEnumerator = Attack02;
		list2.Add(new PoolBranchInfo(actor, 1001, 100, cd, initCd, active: true, releaseDistance, releaseAngle, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		FP releaseDistance2 = 100;
		FP releaseAngle2 = 360;
		operationConditionFunc = Condition01;
		operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor2, 1002, 90, cd2, initCd2, active: true, releaseDistance2, releaseAngle2, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private bool Condition01()
	{
		if (GetBuffNum(_actor, 503110000) >= 1)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (GetBuffNum(_actor, 503110001) >= 1)
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
		SetPoolBranchCD(1001, 999);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		SetPoolBranchCD(1002, 999);
		yield return WaitSkillFinish();
	}
}
