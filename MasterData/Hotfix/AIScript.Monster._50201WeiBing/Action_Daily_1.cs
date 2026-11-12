using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50201WeiBing;

public class Action_Daily_1 : MonsterActionBase
{
	private static readonly int Hengsao = 5020133;

	private static readonly int Tiaopi = 5020132;

	private static readonly int Stayidle = 5000104;

	private static readonly int testSkillId = 0;

	private static readonly int intervaltime = 0;

	private int TmpSkillID;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Skill1Cast;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill2Cast;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Skill3Cast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1002, 1003, 1002, 1003, 1001, 1003 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		TmpSkillID = ID;
		CastSkill(ID);
	}

	private IEnumerator Skill1Cast()
	{
		GotoCastSkill(Hengsao);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill2Cast()
	{
		GotoCastSkill(Tiaopi);
		yield return WaitSkillFinish();
		yield return WaitTime(0);
	}

	private IEnumerator Skill3Cast()
	{
		GotoCastSkill(Stayidle);
		yield return WaitSkillFinish();
	}
}
