using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50271FengMeiGuai;

public class Action_LD : MonsterActionBase
{
	private readonly int idOneShoot;

	private readonly int Skill_OneShoot = 5027107;

	private readonly int idSplitBullet = 1;

	private readonly int Skill_SplitBullet = 5027102;

	private readonly int idDartle = 2;

	private readonly int Skill_Dartle = 5027103;

	private readonly int idTurnShoot = 3;

	private readonly int Skill_TurnShoot = 5027104;

	private readonly int idCircularAttack = 4;

	private readonly int Skill_CircularAttack = 5027105;

	private readonly int idWind = 5;

	private readonly int Skill_Wind = 5027106;

	private readonly int idRun = 6;

	private readonly int Skill_Run = 5027110;

	private readonly int idBranchSkill = 7;

	private bool branchSwitch;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		branchSwitch = false;
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		_thinkInterval = 0.05;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		int id = idRun;
		FP cd = 2;
		FP initCd = 2;
		OperateDelegate operateIEnumerator = RunCondition;
		list2.Add(new PoolBranchInfo(actor, id, 1, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		int id2 = idOneShoot;
		FP cd2 = 7;
		FP initCd2 = 1;
		operateIEnumerator = OneShootCondition;
		list2.Add(new PoolBranchInfo(actor2, id2, 2, cd2, initCd2, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		int id3 = idSplitBullet;
		FP cd3 = 15;
		FP initCd3 = 7.5;
		operateIEnumerator = SplitBulletCondition;
		list2.Add(new PoolBranchInfo(actor3, id3, 3, cd3, initCd3, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		int id4 = idBranchSkill;
		FP cd4 = 25;
		FP initCd4 = 13;
		operateIEnumerator = BranchSkillCondition;
		list2.Add(new PoolBranchInfo(actor4, id4, 4, cd4, initCd4, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		int id5 = idDartle;
		FP cd5 = 35;
		FP initCd5 = 30;
		operateIEnumerator = DartleCondition;
		list2.Add(new PoolBranchInfo(actor5, id5, 5, cd5, initCd5, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		int id6 = idWind;
		FP cd6 = 40;
		FP initCd6 = 40;
		operateIEnumerator = WindCondition;
		list2.Add(new PoolBranchInfo(actor6, id6, 6, cd6, initCd6, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator OneShootCondition()
	{
		CastSkill(Skill_OneShoot);
		yield return WaitSkillFinish();
	}

	private IEnumerator SplitBulletCondition()
	{
		CastSkill(Skill_SplitBullet);
		yield return WaitSkillFinish();
		CastSkill(Skill_Run);
		yield return WaitSkillFinish();
	}

	private IEnumerator DartleCondition()
	{
		CastSkill(Skill_Dartle);
		yield return WaitSkillFinish();
		CastSkill(Skill_Run);
		yield return WaitSkillFinish();
	}

	private IEnumerator TurnShootCondition()
	{
		CastSkill(Skill_TurnShoot);
		yield break;
	}

	private IEnumerator CircularAttackCondition()
	{
		CastSkill(Skill_CircularAttack);
		yield return WaitSkillFinish();
	}

	private IEnumerator BranchSkillCondition()
	{
		FP fP = Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
		if (!branchSwitch)
		{
			if (fP > 5)
			{
				CastSkill(Skill_TurnShoot);
			}
			else
			{
				CastSkill(Skill_CircularAttack);
			}
		}
		else if (fP > 5)
		{
			CastSkill(Skill_CircularAttack);
		}
		else
		{
			CastSkill(Skill_TurnShoot);
		}
		yield return WaitSkillFinish();
		branchSwitch = !branchSwitch;
	}

	private IEnumerator WindCondition()
	{
		CastSkill(Skill_Wind);
		yield return WaitSkillFinish();
	}

	private IEnumerator RunCondition()
	{
		CastSkill(Skill_Run);
		yield return WaitSkillFinish();
	}
}
