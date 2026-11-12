using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13031XinYue;

public class Action_With3 : MonsterActionBase
{
	private static readonly int Skill_NormalAttack = 1303101;

	private static readonly int Skill_FanBomb = 1303102;

	private static readonly int Skill_BackBomb = 1303103;

	private static readonly int Skill_RoundBomb = 1303104;

	private static readonly int Skill_RPG = 1303105;

	private static readonly int Skill_Wander = 1303198;

	private static readonly int testSkillId = 0;

	private static readonly FP NearDistance = 3;

	private int BombWeight;

	private int RPGWeight;

	private int[] NormalAttackWeights;

	private int RandomResult;

	private int CurrentSequence;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		FP releaseDistance = 12;
		FP releaseAngle = 15;
		OperateDelegate operateIEnumerator = NormalAttackCast;
		list.Add(new BaseBranchInfo(1001, releaseDistance, releaseAngle, default, null, operateIEnumerator));
		FP releaseDistance2 = 10;
		FP releaseAngle2 = 15;
		operateIEnumerator = FanBombCast;
		list.Add(new BaseBranchInfo(1002, releaseDistance2, releaseAngle2, default, null, operateIEnumerator));
		operateIEnumerator = BackBombCast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = RoundBombCast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = WanderCast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1005, 1005, 1002, 1005, 1005 },
			[2] = new List<int> { 1003, 1005, 1005, 1004, 1005, 1005 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
		CurrentSequence = 1;
		BombWeight = 1;
		RPGWeight = 1;
		NormalAttackWeights = new int[2] { BombWeight, RPGWeight };
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator NormalAttackCast()
	{
		RandomResult = randomWeight(NormalAttackWeights);
		if (RandomResult == 0)
		{
			GotoCastSkill(Skill_RPG);
			NormalAttackWeights[1]++;
		}
		else
		{
			GotoCastSkill(Skill_RPG);
			NormalAttackWeights[0]++;
		}
		yield return WaitSkillFinish();
		CheckDistance();
	}

	private IEnumerator FanBombCast()
	{
		GotoCastSkill(Skill_FanBomb);
		yield return WaitSkillFinish();
		CheckDistance();
	}

	private IEnumerator BackBombCast()
	{
		GotoCastSkill(Skill_BackBomb);
		yield return WaitSkillFinish();
		CheckDistance();
	}

	private IEnumerator RoundBombCast()
	{
		GotoCastSkill(Skill_RoundBomb);
		yield return WaitSkillFinish();
		CheckDistance();
	}

	private IEnumerator WanderCast()
	{
		GotoCastSkill(Skill_Wander);
		yield return WaitSkillFinish();
		CheckDistance();
	}

	private void CheckDistance()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= NearDistance && CurrentSequence == 1)
		{
			SwitchSequence(2);
			CurrentSequence = 2;
		}
		else if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > NearDistance && CurrentSequence == 2)
		{
			SwitchSequence(1, initialIndex: false);
			CurrentSequence = 1;
		}
	}
}
