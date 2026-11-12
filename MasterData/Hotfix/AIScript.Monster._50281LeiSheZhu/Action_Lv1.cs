using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50281LeiSheZhu;

public class Action_Lv1 : MonsterActionBase
{
	private static readonly int Attack01 = 5028101;

	private static readonly int Attack02 = 5028102;

	private static readonly int Skill_01 = 5028103;

	private static readonly int Skill_02 = 5028104;

	private static readonly int Skill_03 = 5028105;

	private static readonly int Skill_04_Ultra = 5028106;

	private static readonly int Skill_Spawn = 5028107;

	private static readonly int Skill_09 = 5028108;

	private static readonly int skill_movement = 5028109;

	private static readonly FP PlayerDistance = 3;

	private bool SkipSkillSpawn;

	protected override void OnActionEnable()
	{
		SkipSkillSpawn = false;
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = NormalAttackCast;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = RandomSkillCast_01;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = RandomSkillCast_02;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = RangeSkillCast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = UltraSkillCast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SkillSpawn;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = RangeSkillCast_90;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = AlerMovement;
		list.Add(new BaseBranchInfo(1008, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int>
		{
			1006, 1001, 1008, 1002, 1008, 1007, 1008, 1002, 1008, 1001,
			1008, 1004, 1008, 1002, 1008, 1001, 1008, 1003, 1008, 1001,
			1008, 1002, 1008
		} };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private void GotoCastSkill(int id)
	{
		CastSkill(id);
	}

	private IEnumerator NormalAttackCast()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= PlayerDistance)
		{
			GotoCastSkill(Attack01);
		}
		else
		{
			GotoCastSkill(Attack02);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator RandomSkillCast_01()
	{
		GotoCastSkill(Skill_01);
		yield return WaitSkillFinish();
	}

	private IEnumerator RandomSkillCast_02()
	{
		GotoCastSkill(Skill_03);
		yield return WaitSkillFinish();
	}

	private IEnumerator RangeSkillCast()
	{
		GotoCastSkill(Skill_02);
		yield return WaitSkillFinish();
	}

	private IEnumerator UltraSkillCast()
	{
		GotoCastSkill(Skill_04_Ultra);
		yield return WaitSkillFinish();
	}

	private IEnumerator RangeSkillCast_90()
	{
		GotoCastSkill(Skill_09);
		yield return WaitSkillFinish();
	}

	private IEnumerator SkillSpawn()
	{
		if (!SkipSkillSpawn)
		{
			SkipSkillSpawn = true;
			GotoCastSkill(Skill_Spawn);
			yield return WaitSkillFinish();
			yield return WaitTime(1);
		}
	}

	private IEnumerator AlerMovement()
	{
		GotoCastSkill(skill_movement);
		yield return WaitSkillFinish();
	}
}
