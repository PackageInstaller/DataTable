using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Action_VeryHardRoom : MonsterActionBase
{
	private static readonly int Skill_NormalAttack = 1306102;

	private static readonly int Skill_NormalAttack_Upgrade = 1306101;

	private static readonly int Skill_Dash = 1306115;

	private static readonly int Skill_Dash_Upgrade = 1306105;

	private static readonly int Skill_Shoot = 1306117;

	private static readonly int Skill_Shoot_Upgrade = 1306106;

	private static readonly int Skill_Burst = 1306103;

	private static readonly FP NormalAttackDistance = 6;

	private static readonly FP DashDistance = 8;

	private static readonly FP ShootDistance = 12;

	private static readonly FP NearDistance = 6;

	private static readonly int testSkillId = 0;

	private bool IsPhase2;

	private bool IsPhase3;

	private bool ShootOpen;

	private bool DashOpen;

	private bool NormalAttackOpen;

	private int MonsterID1;

	private int MonsterID2;

	private int MonsterID3;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		MonsterID1 = GetTeammateIdByIndex(0);
		MonsterID2 = GetTeammateIdByIndex(1);
		MonsterID3 = GetTeammateIdByIndex(2);
		if (_actor.dataID == MonsterID1)
		{
			ShootOpen = false;
			DashOpen = true;
			NormalAttackOpen = true;
		}
		else if (_actor.dataID == MonsterID2)
		{
			ShootOpen = true;
			DashOpen = true;
			NormalAttackOpen = false;
		}
		else if (_actor.dataID == MonsterID3)
		{
			ShootOpen = false;
			DashOpen = true;
			NormalAttackOpen = true;
		}
		List<PoolBranchesInfo> poolBranches = new List<PoolBranchesInfo>
		{
			new PoolBranchesInfo
			{
				index = 1,
				braches = new List<PoolBranchInfo>
				{
					new PoolBranchInfo(_actor, 1001, 1, 5, 0, active: true, 999, 15, 99, null, null, ShootCast),
					new PoolBranchInfo(_actor, 1002, 1, 2, 0, active: true, 999, 15, 99, null, null, WaitCast)
				}
			},
			new PoolBranchesInfo
			{
				index = 2,
				braches = new List<PoolBranchInfo>
				{
					new PoolBranchInfo(_actor, 1101, 2, 5, 1, active: true, NormalAttackDistance, 15, 99, IsNear, null, NormalAttackCast),
					new PoolBranchInfo(_actor, 1102, 1, 4, 0, active: true, DashDistance, 15, 99, null, null, DashCast),
					new PoolBranchInfo(_actor, 1103, 0, 2, 0, active: true, NormalAttackDistance, 15, 99, null, null, WaitCast)
				}
			},
			new PoolBranchesInfo
			{
				index = 3,
				braches = new List<PoolBranchInfo>
				{
					new PoolBranchInfo(_actor, 2001, 3, 5, 0, active: true, 999, 360, 99, null, null, BurstCast),
					new PoolBranchInfo(_actor, 2002, 2, 11, 0, ShootOpen, ShootDistance, 15, 99, IsFar, null, ShootCast),
					new PoolBranchInfo(_actor, 2003, 2, 4, 0, DashOpen, DashDistance, 15, 99, null, null, DashCast),
					new PoolBranchInfo(_actor, 2005, 2, 5, 0, NormalAttackOpen, NormalAttackDistance, 15, 99, null, null, NormalAttackCast),
					new PoolBranchInfo(_actor, 2004, 1, 0.1, 0, active: true, NormalAttackDistance, 15, 99, null, null, WaitCast)
				}
			},
			new PoolBranchesInfo
			{
				index = 4,
				braches = new List<PoolBranchInfo>
				{
					new PoolBranchInfo(_actor, 3001, 4, 5, 0, active: true, 999, 360, 99, null, null, BurstCast),
					new PoolBranchInfo(_actor, 3002, 3, 9, 0, active: true, NormalAttackDistance, 15, 99, IsNear, null, NormalAttackCast),
					new PoolBranchInfo(_actor, 3003, 2, 7, 0, active: true, ShootDistance, 15, 99, IsFar, null, ShootCast),
					new PoolBranchInfo(_actor, 3004, 1, 3, 0, active: true, DashDistance, 15, 99, null, null, DashCast),
					new PoolBranchInfo(_actor, 3005, 0, 2, 0, active: true, NormalAttackDistance, 15, 99, null, null, WaitCast)
				}
			}
		};
		if (_actor.dataID == MonsterID1)
		{
			InitPoolBranches(1, poolBranches);
		}
		else
		{
			InitPoolBranches(2, poolBranches);
		}
		SetLogicTagFpValue(_actor, "Stage", 1);
		StartCoroutine(CheckMonsterAmount());
		IsPhase2 = false;
		IsPhase3 = false;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.MonsterDie, active: true, Burst);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	protected bool IsNear()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= NearDistance)
		{
			return true;
		}
		return false;
	}

	protected bool IsFar()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > NearDistance)
		{
			return true;
		}
		return false;
	}

	private IEnumerator NormalAttackCast()
	{
		if (!IsPhase2 && !IsPhase3)
		{
			GotoCastSkill(Skill_NormalAttack);
		}
		else
		{
			GotoCastSkill(Skill_NormalAttack_Upgrade);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator DashCast()
	{
		if (!IsPhase2 && !IsPhase3)
		{
			GotoCastSkill(Skill_Dash);
		}
		else
		{
			GotoCastSkill(Skill_Dash_Upgrade);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator ShootCast()
	{
		if (!IsPhase2 && !IsPhase3)
		{
			GotoCastSkill(Skill_Shoot);
		}
		else
		{
			GotoCastSkill(Skill_Shoot_Upgrade);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator BurstCast()
	{
		GotoCastSkill(Skill_Burst);
		if (GetLogicTagFpValue(_actor, "Stage") == 2)
		{
			SetPoolBranchActive(2001, active: false);
		}
		else
		{
			SetPoolBranchActive(3001, active: false);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator WaitCast()
	{
		GotoCastSkill(9999999);
		yield return WaitSkillFinish();
	}

	private void Burst(IEvent evt)
	{
		SwitchPool(2);
		SetMonsterListenEventActive(MonsterEventType.MonsterDie, active: false);
	}

	private IEnumerator CheckMonsterAmount()
	{
		while (true)
		{
			if (GetTargetsByFaction(isFriend: true).Count == 1 && !IsPhase2)
			{
				IsPhase2 = true;
				SetLogicTagFpValue(_actor, "Stage", 2);
				SwitchPool(3);
			}
			else if (GetTargetsByFaction(isFriend: true).Count == 0 && !IsPhase3)
			{
				IsPhase3 = true;
				SetLogicTagFpValue(_actor, "Stage", 3);
				SwitchPool(4);
			}
			yield return null;
		}
	}
}
