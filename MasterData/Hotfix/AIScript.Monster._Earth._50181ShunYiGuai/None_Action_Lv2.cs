using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Earth._50181ShunYiGuai;

public class None_Action_Lv2 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 5018101;

	private static readonly int Skill_Attack02 = 5018102;

	private static readonly int Skill_Attack03 = 5018104;

	private static readonly int Skill_Attack04 = 5018106;

	private static readonly int Skill_Attack05 = 5018159;

	private static readonly int Skill_Teleport = 5018110;

	private FP SkillTimes;

	private int Listnum;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SkillTimes = 0;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Attack01;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack02;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack03;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack04;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack05;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Teleport;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Buff;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int>
			{
				1001, 1002, 1006, 1003, 1004, 1007, 1002, 1004, 1006, 1003,
				1001, 1002, 1005
			},
			[2] = new List<int> { 1003, 1001, 1006, 1002, 1004, 1006, 1001, 1002, 1005 },
			[3] = new List<int> { 1004, 1002, 1006, 1001, 1003, 1006, 1002, 1003, 1005 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private void GotoCastskill(int id)
	{
		CastSkill(id);
	}

	private IEnumerator Attack01()
	{
		GotoCastskill(Skill_Attack01);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05()
	{
		if (SkillTimes == 0)
		{
			SkillTimes = 1;
			SwitchSequence(2);
		}
		else if (SkillTimes == Listnum)
		{
			if (SkillTimes == 2)
			{
				Listnum = 3;
				SwitchSequence(Listnum);
			}
			else
			{
				Listnum = 2;
				SwitchSequence(Listnum);
			}
		}
		else
		{
			Listnum = (int)(long)GetRandomValue(2, 3, isInt: true);
			SkillTimes = Listnum;
			SwitchSequence(Listnum);
		}
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
	}

	private IEnumerator Teleport()
	{
		GotoCastskill(Skill_Teleport);
		yield return WaitSkillFinish();
	}

	private IEnumerator Buff()
	{
		AddBuffToTarget(_actor, 501810001);
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
	}
}
