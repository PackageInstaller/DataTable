using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._None._50181ShunYiGuai;

public class None_FakeMonster : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 5018151;

	private static readonly int Skill_Attack02 = 5018152;

	private static readonly int Skill_Attack03 = 5018154;

	private static readonly int Skill_Attack04 = 5018106;

	private static readonly int Skill_Attack05 = 5018109;

	private static readonly int Skill_Teleport = 5018110;

	private FP SkillTimes;

	private int Listnum;

	private FP staytime = 8;

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
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001, 1002, 1003, 1002, 1003, 1001, 1002, 1003 } };
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
		yield return WaitTime(staytime);
	}

	private IEnumerator Attack02()
	{
		GotoCastskill(Skill_Attack02);
		yield return WaitSkillFinish();
		yield return WaitTime(staytime);
	}

	private IEnumerator Attack03()
	{
		GotoCastskill(Skill_Attack03);
		yield return WaitSkillFinish();
		yield return WaitTime(staytime);
	}

	private IEnumerator Attack04()
	{
		GotoCastskill(Skill_Attack04);
		yield return WaitSkillFinish();
		yield return WaitTime(staytime);
	}

	private IEnumerator Attack05()
	{
		GotoCastskill(Skill_Attack05);
		yield return WaitSkillFinish();
		yield return WaitTime(staytime);
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
