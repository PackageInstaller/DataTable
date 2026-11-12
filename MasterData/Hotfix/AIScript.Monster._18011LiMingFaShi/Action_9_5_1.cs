using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._18011LiMingFaShi;

public class Action_9_5_1 : MonsterActionBase
{
	private readonly int NormalAttack_Range = 1801101;

	private readonly int NormalAttack_Melee = 1801102;

	private readonly int SkillId_Shield = 1801103;

	private readonly int SkillId_FallingStar = 1801106;

	private readonly int SkillId_Teleport = 1801105;

	private readonly int SkillId_LookAt = 9999999;

	private readonly int testSkillId;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>
		{
			new PoolBranchInfo(_actor, 1, 70, 4, 0, active: true, 10, 180, 3, null, null, Skill_NormalAttack_Range)
		};
		AdventureActor actor = _actor;
		FP cd = 10;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Skill_NormalAttack_Melee;
		list2.Add(new PoolBranchInfo(actor, 2, 70, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		list2.Add(new PoolBranchInfo(_actor, 4, 70, 17, 4, active: true, 12, 30, 3, null, null, Skill2_FallingStar));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator Skill_NormalAttack_Range()
	{
		GotoCastSkill(NormalAttack_Range);
		yield return WaitSkillFinish();
	}

	private bool Condition01()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 4)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Skill_NormalAttack_Melee()
	{
		GotoCastSkill(NormalAttack_Melee);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill1_Shield()
	{
		GotoCastSkill(SkillId_Shield);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill2_FallingStar()
	{
		GotoCastSkill(SkillId_FallingStar);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill3_Teleport()
	{
		GotoCastSkill(SkillId_Teleport);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill99_LookAt()
	{
		GotoCastSkill(SkillId_LookAt);
		yield return WaitSkillFinish();
	}
}
