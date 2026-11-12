using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30911NuShou;

public class Action : MonsterActionBase
{
	private readonly int SkillId_Shoot = 3091101;

	private readonly int SkillId_Shoot_3 = 3091102;

	private readonly int SkillId_TripleShoot = 3091103;

	private readonly int SkillId_Wander = 9999971;

	private readonly int testSkillId;

	private int Skill_Count;

	private FP PowerShootRandom;

	private FP ShootModeRandom;

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
		FP initCd = 2;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Skill_PowerShoot;
		list2.Add(new PoolBranchInfo(actor, 1, 90, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 7;
		FP initCd2 = 0;
		operateIEnumerator = Skill_Shoot;
		list2.Add(new PoolBranchInfo(actor2, 2, 80, cd2, initCd2, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0;
		FP initCd3 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Skill_Wander;
		list2.Add(new PoolBranchInfo(actor3, 3, 70, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		Skill_Count = 0;
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private bool Condition01()
	{
		PowerShootRandom = GetRandomValue(0, 10);
		if (PowerShootRandom <= 6)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (Skill_Count >= 1)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Skill_Shoot()
	{
		GotoCastSkill(SkillId_Shoot);
		yield return WaitSkillFinish();
		Skill_Count++;
	}

	private IEnumerator Skill_PowerShoot()
	{
		ShootModeRandom = GetRandomValue(0, 10);
		if (ShootModeRandom <= 5)
		{
			GotoCastSkill(SkillId_Shoot_3);
		}
		else
		{
			GotoCastSkill(SkillId_TripleShoot);
		}
		yield return WaitSkillFinish();
		Skill_Count++;
	}

	private IEnumerator Skill_Wander()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(SkillId_Wander);
		yield return WaitSkillFinish();
		Skill_Count = 0;
	}
}
