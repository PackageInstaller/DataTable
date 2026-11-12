using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50531DaGuanZi;

public class Action_Lv1 : MonsterActionBase
{
	private readonly int Skill01 = 5053101;

	private readonly int Skill02 = 5053102;

	private readonly int Skill03 = 5053103;

	private readonly int Skill04 = 5053111;

	private readonly int Skill05 = 5053112;

	private readonly int Change01 = 5053105;

	private readonly int Skill06 = 5053106;

	private readonly int Skill07 = 5053107;

	private readonly int Skill08 = 5053108;

	private readonly int Skill09 = 5053113;

	private readonly int Change02 = 5053109;

	private readonly int SkillWalk = 9999999;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

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
		operateIEnumerator = ChangeStage01;
		list.Add(new BaseBranchInfo(10, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ChangeStage02;
		list.Add(new BaseBranchInfo(11, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Walk;
		list.Add(new BaseBranchInfo(12, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1, 2, 3, 12, 10, 7, 6, 12, 11, 5 } };
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
		CastSkill(Skill08);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast9()
	{
		CastSkill(Skill09);
		yield return WaitSkillFinish();
	}

	private IEnumerator ChangeStage01()
	{
		CastSkill(Change01);
		yield return WaitSkillFinish();
	}

	private IEnumerator ChangeStage02()
	{
		CastSkill(Change02);
		yield return WaitSkillFinish();
	}

	private IEnumerator Walk()
	{
		CastSkill(SkillWalk);
		yield return WaitSkillFinish();
	}
}
