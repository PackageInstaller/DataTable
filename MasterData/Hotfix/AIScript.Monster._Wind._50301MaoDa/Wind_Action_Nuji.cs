using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Action_Nuji : MonsterActionBase
{
	private readonly int Skill_Attack01 = 5030106;

	private readonly int Skill_Attack02 = 5030107;

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
		Func<bool> operationConditionFunc = BigCondition;
		FP releaseAngle = 360;
		OperateDelegate operateIEnumerator = BigAttack;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, initCd, active: true, releaseDistance, releaseAngle, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		FP releaseDistance2 = 100;
		operationConditionFunc = FastCondition;
		FP releaseAngle2 = 360;
		operateIEnumerator = FastAttack;
		list2.Add(new PoolBranchInfo(actor2, 1002, 888, cd2, initCd2, active: true, releaseDistance2, releaseAngle2, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 12;
		FP initCd3 = 0;
		FP releaseDistance3 = 100;
		operationConditionFunc = SmallCondition;
		FP releaseAngle3 = 360;
		operateIEnumerator = SmallAttack;
		list2.Add(new PoolBranchInfo(actor3, 1003, 50, cd3, initCd3, active: true, releaseDistance3, releaseAngle3, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		PoolBranchesInfo poolBranchesInfo2 = new PoolBranchesInfo
		{
			index = 2
		};
		List<PoolBranchInfo> list3 = new List<PoolBranchInfo>();
		AdventureActor actor4 = _actor;
		FP cd4 = 0;
		FP initCd4 = 0;
		FP releaseDistance4 = 100;
		operationConditionFunc = BigCondition;
		FP releaseAngle4 = 360;
		operateIEnumerator = BigAttack;
		list3.Add(new PoolBranchInfo(actor4, 2001, 999, cd4, initCd4, active: true, releaseDistance4, releaseAngle4, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 0;
		FP initCd5 = 0;
		FP releaseDistance5 = 100;
		operationConditionFunc = FastCondition;
		FP releaseAngle5 = 360;
		operateIEnumerator = FastAttack;
		list3.Add(new PoolBranchInfo(actor5, 2002, 888, cd5, initCd5, active: true, releaseDistance5, releaseAngle5, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 9;
		FP initCd6 = 0;
		FP releaseDistance6 = 100;
		operationConditionFunc = SmallCondition;
		FP releaseAngle6 = 360;
		operateIEnumerator = SmallAttack;
		list3.Add(new PoolBranchInfo(actor6, 2003, 50, cd6, initCd6, active: true, releaseDistance6, releaseAngle6, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo2.braches = list3;
		list.Add(poolBranchesInfo2);
		List<PoolBranchesInfo> poolBranches = list;
		LogicEntity logicEntity = GetTargetByTeammateIndex(0).get_Item(0);
		if (GetBuffNum(logicEntity, 503010004) >= 1)
		{
			InitPoolBranches(2, poolBranches);
		}
		else
		{
			InitPoolBranches(1, poolBranches);
		}
	}

	private bool SmallCondition()
	{
		if (GetBuffNum(_actor, 503010001) == 0 && GetBuffNum(_actor, 503010006) == 0)
		{
			return true;
		}
		return false;
	}

	private bool BigCondition()
	{
		if (GetBuffNum(_actor, 503010001) >= 1 && GetBuffNum(_actor, 503010006) == 0)
		{
			InterruptSkill();
			return true;
		}
		return false;
	}

	private bool FastCondition()
	{
		if (GetBuffNum(_actor, 503010005) >= 1 && GetBuffNum(_actor, 503010006) == 0)
		{
			InterruptSkill();
			return true;
		}
		return false;
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private IEnumerator FastAttack()
	{
		RemoveBuffFromTarget(_actor, 503010005);
		GotoCastskill(Skill_Attack01);
		SetPoolBranchCD(1003, 12);
		SetPoolBranchCD(2003, 9);
		yield return WaitSkillFinish();
	}

	private IEnumerator BigAttack()
	{
		GotoCastskill(Skill_Attack02);
		SetPoolBranchCD(1003, 12);
		SetPoolBranchCD(2003, 9);
		yield return WaitSkillFinish();
	}

	private IEnumerator SmallAttack()
	{
		GotoCastskill(Skill_Attack01);
		yield return WaitSkillFinish();
	}
}
