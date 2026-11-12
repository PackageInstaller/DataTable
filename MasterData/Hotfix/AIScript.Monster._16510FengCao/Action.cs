using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._16510FengCao;

public class Action : MonsterActionBase
{
	private int branch_AttackQianCi = 1003;

	private static readonly int Skill_AttackQianCi = 1651013;

	private int branch_AttackSpecial = 1018;

	private static readonly int Skill_AttackSpecial = 1651005;

	private int branch_Writhe = 1004;

	private static readonly int Skill_Writhe = 1651006;

	private int branch_FarMove = 1006;

	private static readonly int Skill_FarMove = 1651002;

	private int branch_FarMove_2rd = 1007;

	private static readonly int Skill_FarMove_2rd = 1651022;

	private int branch_Attack3 = 1008;

	private static readonly int Skill_Attack3 = 1651072;

	private int branch_Cyclones = 2008;

	private static readonly int Skill_Cyclones = 1651007;

	private int branch_Cyclones_2rd = 2009;

	private static readonly int Skill_Cyclones_2rd = 1651027;

	private int branch_WindBall = 2010;

	private static readonly int Skill_WindBall = 1651008;

	private int branch_WindBall_2rd = 2011;

	private static readonly int Skill_WindBall_2rd = 1651073;

	private int branch_DiffusePollen = 2012;

	private static readonly int Skill_DiffusePollen = 1651009;

	private int branch_DiffusePollen_01_2rd = 2013;

	private static readonly int Skill_DiffusePollen_01_2rd = 1651029;

	private int branch_Ultra_3rd = 2015;

	private static readonly int Skill_Ultra_2rd = 1651031;

	private int branch_Ultra_2nd = 2016;

	private static readonly int Skill_Ultra_2rd_Hard = 1651061;

	private int branch_Ultra_1st = 2017;

	private static readonly int Skill_Ultra_2rd_Easy = 1651063;

	private readonly int branch_change1to2 = 3052;

	private readonly int Skill_Change1to2 = 1651070;

	private readonly int branch_change2to3 = 3051;

	private static readonly int Skill_Change2to3 = 1651071;

	private FP BossStage;

	private static readonly FP PlayerDistance = 5;

	private static readonly int Stage2RequireLevel = 20;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		BossStage = 1;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>
		{
			new BaseBranchInfo(branch_Attack3, 4, 360, 7, null, Attack3),
			new BaseBranchInfo(branch_AttackQianCi, 4, 360, 7, null, AttackQianCi),
			new BaseBranchInfo(branch_AttackSpecial, 4, 360, 7, null, AttackSpecial),
			new BaseBranchInfo(branch_Writhe, 4, 360, 7, null, Writhe)
		};
		OperateDelegate operateIEnumerator = WritheCyclones;
		list.Add(new BaseBranchInfo(1020, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack1Cyclones;
		list.Add(new BaseBranchInfo(1021, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack1Writhe;
		list.Add(new BaseBranchInfo(1022, default, default, default, null, operateIEnumerator));
		int id = branch_FarMove;
		operateIEnumerator = FarMove;
		list.Add(new BaseBranchInfo(id, default, default, default, null, operateIEnumerator));
		int id2 = branch_FarMove_2rd;
		operateIEnumerator = FarMove_2rd;
		list.Add(new BaseBranchInfo(id2, default, default, default, null, operateIEnumerator));
		int id3 = branch_Cyclones;
		operateIEnumerator = Cyclones;
		list.Add(new BaseBranchInfo(id3, default, default, default, null, operateIEnumerator));
		int id4 = branch_Cyclones_2rd;
		operateIEnumerator = Cyclones_2rd;
		list.Add(new BaseBranchInfo(id4, default, default, default, null, operateIEnumerator));
		int id5 = branch_WindBall;
		operateIEnumerator = WindBall;
		list.Add(new BaseBranchInfo(id5, default, default, default, null, operateIEnumerator));
		int id6 = branch_WindBall_2rd;
		operateIEnumerator = WindBall_2rd_Hard;
		list.Add(new BaseBranchInfo(id6, default, default, default, null, operateIEnumerator));
		int id7 = branch_DiffusePollen;
		operateIEnumerator = DiffusePollen;
		list.Add(new BaseBranchInfo(id7, default, default, default, null, operateIEnumerator));
		int id8 = branch_DiffusePollen_01_2rd;
		operateIEnumerator = DiffusePollen_01_2rd;
		list.Add(new BaseBranchInfo(id8, default, default, default, null, operateIEnumerator));
		int id9 = branch_Ultra_3rd;
		operateIEnumerator = Ultra_3rd;
		list.Add(new BaseBranchInfo(id9, default, default, default, null, operateIEnumerator));
		int id10 = branch_Ultra_2nd;
		operateIEnumerator = Ultra_2nd;
		list.Add(new BaseBranchInfo(id10, default, default, default, null, operateIEnumerator));
		int id11 = branch_Ultra_1st;
		operateIEnumerator = Ultra_1st;
		list.Add(new BaseBranchInfo(id11, default, default, default, null, operateIEnumerator));
		int id12 = branch_change1to2;
		operateIEnumerator = Change1to2Enumerator;
		list.Add(new BaseBranchInfo(id12, default, default, default, null, operateIEnumerator));
		int id13 = branch_change2to3;
		operateIEnumerator = Change2to3Enumerator;
		list.Add(new BaseBranchInfo(id13, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { branch_Attack3, branch_Writhe, branch_AttackQianCi, branch_FarMove, branch_Attack3, branch_WindBall, branch_AttackQianCi, branch_Ultra_1st },
			[2] = new List<int> { branch_change1to2, branch_FarMove, 1020, branch_DiffusePollen_01_2rd, branch_FarMove, 1021, branch_WindBall_2rd, branch_FarMove, 1022, branch_Ultra_2nd },
			[3] = new List<int> { branch_change2to3, branch_WindBall_2rd, branch_FarMove_2rd, branch_AttackSpecial, branch_WindBall_2rd, branch_DiffusePollen_01_2rd, branch_AttackSpecial, branch_Ultra_2nd },
			[4] = new List<int> { branch_Attack3 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.BattleLevelChange, active: true, LevelUp);
	}

	private void LevelUp(IEvent evt)
	{
		if ((evt as AdventureMonsterBattleLevelChangedEvent).newLevel == Stage2RequireLevel)
		{
			SwitchSequence(2);
		}
	}

	private IEnumerator Attack3()
	{
		GotoCastskill(Skill_Attack3);
		yield return WaitSkillFinish();
		int num = TSRandom.Range(0, 100);
		int num2 = 50;
		if (num < num2)
		{
			GotoCastskill(Skill_Cyclones);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Attack1Cyclones()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < PlayerDistance)
		{
			GotoCastskill(Skill_Attack3);
			yield return WaitSkillFinish();
			int num = TSRandom.Range(0, 100);
			int num2 = 50;
			if (num < num2)
			{
				GotoCastskill(Skill_Cyclones_2rd);
				yield return WaitSkillFinish();
			}
		}
		else
		{
			GotoCastskill(Skill_Cyclones_2rd);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator AttackQianCi()
	{
		if (CalcAngleBetweenSelfAndAttackTarget() > 90)
		{
			GotoCastskill(Skill_AttackQianCi);
			yield return WaitSkillFinish();
			int num = TSRandom.Range(0, 100);
			int num2 = 50;
			if (num < num2)
			{
				GotoCastskill(Skill_Cyclones);
				yield return WaitSkillFinish();
			}
		}
		else
		{
			GotoCastskill(Skill_Attack3);
			yield return WaitSkillFinish();
			int num3 = TSRandom.Range(0, 100);
			int num4 = 50;
			if (num3 < num4)
			{
				GotoCastskill(Skill_Cyclones);
				yield return WaitSkillFinish();
			}
		}
	}

	private IEnumerator AttackSpecial()
	{
		GotoCastskill(Skill_AttackSpecial);
		yield return WaitSkillFinish();
		GotoCastskill(Skill_Cyclones_2rd);
		yield return WaitSkillFinish();
	}

	private IEnumerator Writhe()
	{
		GotoCastskill(Skill_Writhe);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack1Writhe()
	{
		if (CalcAngleBetweenSelfAndAttackTarget() > 90)
		{
			GotoCastskill(Skill_Attack3);
			yield return WaitSkillFinish();
			int num = TSRandom.Range(0, 100);
			int num2 = 50;
			if (num < num2)
			{
				GotoCastskill(Skill_Cyclones_2rd);
				yield return WaitSkillFinish();
			}
		}
		else
		{
			GotoCastskill(Skill_Writhe);
			yield return WaitSkillFinish();
			int num3 = TSRandom.Range(0, 100);
			int num4 = 50;
			if (num3 < num4)
			{
				GotoCastskill(Skill_Cyclones_2rd);
				yield return WaitSkillFinish();
			}
		}
	}

	private IEnumerator WritheCyclones()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < PlayerDistance)
		{
			GotoCastskill(Skill_Writhe);
			yield return WaitSkillFinish();
			int num = TSRandom.Range(0, 100);
			int num2 = 50;
			if (num < num2)
			{
				GotoCastskill(Skill_Cyclones_2rd);
				yield return WaitSkillFinish();
			}
		}
		else
		{
			GotoCastskill(Skill_Cyclones_2rd);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator FarMove()
	{
		GotoCastskill(Skill_FarMove);
		yield return WaitSkillFinish();
	}

	private IEnumerator FarMove_2rd()
	{
		GotoCastskill(Skill_FarMove_2rd);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cyclones()
	{
		GotoCastskill(Skill_Cyclones);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cyclones_2rd()
	{
		GotoCastskill(Skill_Cyclones_2rd);
		yield return WaitSkillFinish();
	}

	private IEnumerator WindBall()
	{
		GotoCastskill(Skill_WindBall);
		yield return WaitSkillFinish();
	}

	private IEnumerator WindBall_2rd_Hard()
	{
		GotoCastskill(Skill_WindBall_2rd);
		yield return WaitSkillFinish();
	}

	private IEnumerator WindBall_2rd()
	{
		GotoCastskill(Skill_WindBall_2rd);
		yield return WaitSkillFinish();
	}

	private IEnumerator DiffusePollen()
	{
		GotoCastskill(Skill_DiffusePollen);
		yield return WaitSkillFinish();
		yield return WaitTime(5);
	}

	private IEnumerator DiffusePollen_01_2rd()
	{
		GotoCastskill(Skill_DiffusePollen_01_2rd);
		yield return WaitSkillFinish();
	}

	private IEnumerator Ultra_3rd()
	{
		GotoCastskill(Skill_Ultra_2rd);
		yield return WaitSkillFinish();
	}

	private IEnumerator Ultra_2nd()
	{
		GotoCastskill(Skill_Ultra_2rd_Hard);
		yield return WaitSkillFinish();
		SwitchSequence(3);
	}

	private IEnumerator Ultra_1st()
	{
		GotoCastskill(Skill_Ultra_2rd_Easy);
		yield return WaitSkillFinish();
		SwitchSequence(2);
	}

	private IEnumerator Change2to3Enumerator()
	{
		if (!(GetLogicTagFpValue(_actor, "BattleStage") == 3))
		{
			SetLogicTagFpValue(_actor, "BattleStage", 3);
			CastSkill(Skill_Change2to3);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Change1to2Enumerator()
	{
		if (!(GetLogicTagFpValue(_actor, "BattleStage") == 2))
		{
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			CastSkill(Skill_Change1to2);
			yield return WaitSkillFinish();
		}
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}
}
