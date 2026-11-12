using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._70021MaoYan;

public class Action_01 : MonsterActionBase
{
	private static readonly int Skill01 = 7002101;

	private static readonly int Skill02 = 7002102;

	private static readonly int Skill03 = 7002103;

	private static readonly int Skill04 = 7002104;

	private static readonly int Skill05 = 7002105;

	private static readonly int Skill06 = 7002106;

	private static readonly int Skill07 = 7002107;

	private static readonly int Skill08 = 7002108;

	private static readonly int Skill09 = 7002109;

	private static readonly int Skill10 = 7002110;

	private static readonly int Skill11 = 7002111;

	private static readonly int Skill12 = 7002112;

	private static readonly int Skill13 = 7002113;

	private static readonly int Skill14 = 7002115;

	private static readonly int Skill15 = 7002116;

	private static readonly int Skill16 = 7002120;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast2;
		list.Add(new BaseBranchInfo(2, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast3;
		list.Add(new BaseBranchInfo(3, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast4;
		list.Add(new BaseBranchInfo(4, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast5;
		list.Add(new BaseBranchInfo(5, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast6;
		list.Add(new BaseBranchInfo(6, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast7;
		list.Add(new BaseBranchInfo(7, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast8;
		list.Add(new BaseBranchInfo(8, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast9;
		list.Add(new BaseBranchInfo(9, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast10;
		list.Add(new BaseBranchInfo(10, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int>
			{
				1, 2, 1, 10, 4, 6, 7, 9, 3, 2,
				1, 10, 6, 8, 5, 4, 7, 9, 2, 1,
				3, 10, 5, 7, 6
			},
			[2] = new List<int>
			{
				3, 4, 5, 6, 7, 5, 8, 9, 10, 4,
				5, 8, 6, 7, 5
			}
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
	}

	private IEnumerator Cast1()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_AutoShoot"))
		{
			CastSkill(Skill02);
			yield return WaitSkillFinish();
			CastSkill(Skill01);
		}
		else
		{
			CastSkill(Skill01);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast2()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_ShootWithCat"))
		{
			CastSkill(Skill04);
		}
		else
		{
			CastSkill(Skill03);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast3()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_MoreCatBullet"))
		{
			CastSkill(Skill06);
		}
		else
		{
			CastSkill(Skill05);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast4()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_LaserShoot"))
		{
			CastSkill(Skill07);
			yield return WaitSkillFinish();
			CastSkill(Skill08);
		}
		else
		{
			CastSkill(Skill07);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast5()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_AimLaser"))
		{
			CastSkill(Skill10);
			yield return WaitSkillFinish();
			CastSkill(Skill09);
		}
		else
		{
			CastSkill(Skill09);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast6()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_DevilEyesEx"))
		{
			CastSkill(Skill12);
		}
		else
		{
			CastSkill(Skill11);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast7()
	{
		CastSkill(Skill13);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast8()
	{
		CastSkill(Skill16);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast9()
	{
		CastSkill(Skill14);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast10()
	{
		CastSkill(Skill15);
		yield return WaitSkillFinish();
	}
}
