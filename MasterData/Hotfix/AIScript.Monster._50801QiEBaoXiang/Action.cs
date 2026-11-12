using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50801QiEBaoXiang;

public class Action : MonsterActionBase
{
	private static readonly int Skill_Rest = 5080101;

	private static readonly int Skill_RunningAway = 5080103;

	private static readonly int Skill_PresentBomb = 5080104;

	private static readonly int Skill_RunAwayBomb = 5080105;

	private static readonly int Skill_Observing = 5080106;

	private static readonly FP SkillNearRadius = 3;

	private static readonly int testSkillId = 0;

	private FP StartTime;

	private FP DistanceToTarget;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		FP releaseAngle = 15;
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1001, default, releaseAngle, default, null, operateIEnumerator));
		releaseAngle = 15;
		operateIEnumerator = Cast2;
		list.Add(new BaseBranchInfo(1002, default, releaseAngle, default, null, operateIEnumerator));
		releaseAngle = 15;
		operateIEnumerator = Cast3;
		list.Add(new BaseBranchInfo(1003, default, releaseAngle, default, null, operateIEnumerator));
		operateIEnumerator = Cast4;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast5;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001, 1002, 1003, 1004, 1005 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
		StartTime = _actor.LogicTime;
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
		GotoCastSkill(Skill_Observing);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast2()
	{
		DistanceToTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		if (DistanceToTarget <= SkillNearRadius)
		{
			GotoCastSkill(Skill_RunningAway);
		}
		else
		{
			GotoCastSkill(Skill_PresentBomb);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast3()
	{
		GotoCastSkill(Skill_Observing);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast4()
	{
		GotoCastSkill(Skill_RunAwayBomb);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast5()
	{
		GotoCastSkill(Skill_Rest);
		yield return WaitSkillFinish();
	}
}
