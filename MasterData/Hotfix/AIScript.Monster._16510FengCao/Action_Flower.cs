using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._16510FengCao;

public class Action_Flower : MonsterActionBase
{
	private static readonly int Skill_01 = 1651050;

	private static readonly int Skill_02 = 1651051;

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
		OperateDelegate operateIEnumerator = InitialCast;
		list2.Add(new PoolBranchInfo(actor, 1000, 999, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		Func<bool> operationConditionFunc = FlowerCondition;
		operateIEnumerator = Flower;
		list2.Add(new PoolBranchInfo(actor2, 1001, 997, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0;
		FP initCd3 = 0;
		operateIEnumerator = WakeUp;
		list2.Add(new PoolBranchInfo(actor3, 1002, 998, cd3, initCd3, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private bool FlowerCondition()
	{
		if (GetBuffNum(_actor, 160510130) > 0)
		{
			return true;
		}
		return false;
	}

	private IEnumerator InitialCast()
	{
		SetBattleOutEnable();
		SetSearchedImmunityEnable();
		SetImmuneControlEnable();
		SetPoolBranchActive(1000, active: false);
		yield break;
	}

	private IEnumerator Flower()
	{
		GotoCastskill(Skill_01);
		yield return WaitSkillFinish();
	}

	private IEnumerator WakeUp()
	{
		GotoCastskill(Skill_02);
		yield return WaitSkillFinish();
		SetPoolBranchActive(1002, active: false);
	}
}
