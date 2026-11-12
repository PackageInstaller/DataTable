using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._18001LiMingShuangDao;

public class Action : MonsterActionBase
{
	private readonly int SkillId_NormalAttack = 1800101;

	private readonly int SkillId_SpiralSlash = 1800102;

	private readonly int SkillId_DashSlash = 1800103;

	private readonly int SkillId_Dodge_F = 1800104;

	private readonly int SkillId_Dodge_B = 1800105;

	private readonly int SkillId_Dodge_L = 1800106;

	private readonly int SkillId_Dodge_R = 1800107;

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
			new PoolBranchInfo(_actor, 1, 70, 10, 0, active: true, 10, 180, 3, null, null, Skill_NormalAttack),
			new PoolBranchInfo(_actor, 2, 80, 15, 2, active: true, 10, 180, 3, null, null, Skill_SpiralSlash),
			new PoolBranchInfo(_actor, 3, 90, 17, 4, active: true, 10, 180, 3, null, null, Skill_DashSlash)
		};
		AdventureActor actor = _actor;
		FP cd = 5;
		FP initCd = 3;
		OperateDelegate operateIEnumerator = Skill_Wander;
		list2.Add(new PoolBranchInfo(actor, 4, 60, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
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

	private IEnumerator Skill_NormalAttack()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 3)
		{
			GotoCastSkill(SkillId_Dodge_F);
			yield return WaitSkillFinish();
		}
		GotoCastSkill(SkillId_NormalAttack);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_SpiralSlash()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 5)
		{
			GotoCastSkill(SkillId_Dodge_B);
			yield return WaitSkillFinish();
		}
		GotoCastSkill(SkillId_SpiralSlash);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_DashSlash()
	{
		GotoCastSkill(SkillId_DashSlash);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_Wander()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 3)
		{
			GotoCastSkill(SkillId_Dodge_B);
			yield return WaitSkillFinish();
		}
		else if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 6)
		{
			GotoCastSkill(SkillId_Dodge_F);
			yield return WaitSkillFinish();
		}
		if (GetRandomValue(1, 3, isInt: true) == 1)
		{
			GotoCastSkill(SkillId_Dodge_L);
			yield return WaitSkillFinish();
		}
		else
		{
			GotoCastSkill(SkillId_Dodge_R);
			yield return WaitSkillFinish();
		}
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 4)
		{
			GotoCastSkill(SkillId_Dodge_B);
			yield return WaitSkillFinish();
		}
		else if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 5)
		{
			GotoCastSkill(SkillId_Dodge_F);
			yield return WaitSkillFinish();
		}
	}
}
