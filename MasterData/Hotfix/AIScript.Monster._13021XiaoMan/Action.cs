using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13021XiaoMan;

public class Action : MonsterActionBase
{
	private static readonly int Skill_3RowAttack = 1302101;

	private static readonly int Skill_Attack = 1302102;

	private static readonly int Skill_DragonPunch = 1302103;

	private static readonly int Skill_Alert = 1302198;

	private static readonly FP SkillNearRadius = 4;

	private static readonly int testSkillId = 0;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		FP releaseDistance = 8;
		FP releaseAngle = 15;
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1001, releaseDistance, releaseAngle, default, null, operateIEnumerator));
		FP releaseAngle2 = 15;
		FP traceDuration = 5;
		operateIEnumerator = Cast2;
		list.Add(new BaseBranchInfo(1002, default, releaseAngle2, traceDuration, null, operateIEnumerator));
		FP releaseDistance2 = 12;
		FP releaseAngle3 = 15;
		operateIEnumerator = Cast3;
		list.Add(new BaseBranchInfo(1003, releaseDistance2, releaseAngle3, default, null, operateIEnumerator));
		traceDuration = 15;
		operateIEnumerator = Cast4;
		list.Add(new BaseBranchInfo(1004, default, traceDuration, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001, 1002, 1002, 1003, 1004 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator Cast1()
	{
		GotoCastSkill(Skill_3RowAttack);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast2()
	{
		if (!(GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= SkillNearRadius))
		{
			GotoCastSkill(Skill_Attack);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Cast3()
	{
		GotoCastSkill(Skill_DragonPunch);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast4()
	{
		GotoCastSkill(Skill_Alert);
		yield return WaitSkillFinish();
	}
}
