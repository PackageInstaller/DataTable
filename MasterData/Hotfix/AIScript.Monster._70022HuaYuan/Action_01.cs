using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._70022HuaYuan;

public class Action_01 : MonsterActionBase
{
	private static readonly int Skill01 = 7002200;

	private static readonly int Skill02 = 7002219;

	private static readonly int Skill03 = 7002205;

	private static readonly int Skill04 = 7002202;

	private static readonly int Skill05 = 7002201;

	private static readonly int Skill06 = 7002203;

	private static readonly int Skill07 = 7002214;

	private static readonly int Skill08 = 7002204;

	private static readonly int Skill09 = 7002213;

	private static readonly int Skill10 = 7002207;

	private static readonly int Skill14 = 7002221;

	private static readonly int Skill15 = 7002222;

	private static readonly int Skill11 = 7002215;

	private static readonly int Skill16 = 7002223;

	private static readonly int Skill12 = 7002208;

	private static readonly int Skill13 = 7002224;

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
		operateIEnumerator = Cast11;
		list.Add(new BaseBranchInfo(11, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast12;
		list.Add(new BaseBranchInfo(12, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int>
			{
				1, 3, 4, 5, 6, 7, 5, 8, 9, 10,
				4, 5, 8, 6, 7, 5, 12
			},
			[2] = new List<int>
			{
				3, 4, 5, 6, 7, 5, 8, 9, 10, 4,
				5, 8, 6, 7, 5, 12
			}
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private IEnumerator Cast1()
	{
		CastSkill(Skill01);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast2()
	{
		CastSkill(Skill02);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast3()
	{
		CastSkill(Skill03);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast4()
	{
		CastSkill(Skill04);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast5()
	{
		CastSkill(Skill05);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast6()
	{
		CastSkill(Skill06);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast7()
	{
		CastSkill(Skill07);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast8()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_SyncBunsin_SWC"))
		{
			CastSkill(Skill16);
		}
		else
		{
			CastSkill(Skill11);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast9()
	{
		CastSkill(Skill09);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast10()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_DashArea"))
		{
			CastSkill(Skill14);
		}
		else if (GetLogicTagToggleValue(_actor, "SkillTag_DashBunshin"))
		{
			CastSkill(Skill15);
		}
		else
		{
			CastSkill(Skill10);
		}
		yield return WaitSkillFinish();
		yield return WaitTime(5);
	}

	private IEnumerator Cast11()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_Illusion_Three"))
		{
			CastSkill(Skill13);
			SwitchSequence(2);
		}
		else
		{
			CastSkill(Skill12);
			SwitchSequence(2);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast12()
	{
		if (GetLogicTagToggleValue(_actor, "SkillTag_Illusion_Three"))
		{
			CastSkill(Skill13);
		}
		else
		{
			CastSkill(Skill12);
		}
		yield return WaitSkillFinish();
	}
}
