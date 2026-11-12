using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._70031Huochui;

public class Action_FuYouJian_1 : MonsterActionBase
{
	private static readonly int Skill_01 = 7003181;

	private static readonly int Skill_02 = 7003182;

	private static readonly int Skill_03 = 7003183;

	private static readonly int Skill_04 = 7003189;

	private static readonly int Hide = 7003188;

	private static readonly int Dead = 7003185;

	private static readonly int AttackStart = 7003187;

	private static readonly int testSkillId = 0;

	private static readonly int intervaltime = 5;

	private int TmpSkillID;

	private bool SkillTips;

	private bool firstskill = true;

	private int Skilltimes;

	private int Skillchecktime = 1;

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
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001, 1001 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
	}

	protected override void OnActionDisable()
	{
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
		if (GetBuffNum(_actor, 700310040) > 0)
		{
			CastSkill(Dead);
			yield return WaitSkillFinish();
		}
		if (!firstskill)
		{
			CastSkill(AttackStart);
			yield return WaitSkillFinish();
		}
		firstskill = false;
		if (Skilltimes <= Skillchecktime)
		{
			if (!SkillTips)
			{
				CastSkill(Skill_01);
				yield return WaitSkillFinish();
				CastSkill(Skill_03);
				yield return WaitSkillFinish();
				SkillTips = true;
			}
			else
			{
				CastSkill(Skill_02);
				yield return WaitSkillFinish();
				CastSkill(Skill_04);
				yield return WaitSkillFinish();
				SkillTips = false;
			}
		}
		else
		{
			CastSkill(Skill_03);
			yield return WaitSkillFinish();
			CastSkill(Skill_02);
			yield return WaitSkillFinish();
			Skilltimes = 0;
		}
		CastSkill(Hide);
		yield return WaitSkillFinish();
		Skilltimes++;
		yield return WaitTime(intervaltime);
	}

	private IEnumerator Skill2Cast()
	{
		if (GetBuffNum(_actor, 700310050) > 0)
		{
			CastSkill(AttackStart);
			yield return WaitSkillFinish();
			if (Skilltimes <= Skillchecktime)
			{
				if (SkillTips)
				{
					CastSkill(Skill_01);
					yield return WaitSkillFinish();
					SkillTips = false;
				}
				else
				{
					CastSkill(Skill_02);
					yield return WaitSkillFinish();
				}
			}
			else
			{
				CastSkill(Skill_04);
				yield return WaitSkillFinish();
				Skilltimes = 0;
			}
			CastSkill(Hide);
			yield return WaitSkillFinish();
			Skilltimes++;
		}
		yield return WaitTime(intervaltime);
	}

	private IEnumerator Skill3Cast()
	{
		if (GetBuffNum(_actor, 700310050) > 0)
		{
			CastSkill(AttackStart);
			yield return WaitSkillFinish();
			if (Skilltimes <= Skillchecktime)
			{
				GotoCastSkill(Skill_03);
				yield return WaitSkillFinish();
			}
			else
			{
				CastSkill(Skill_04);
				yield return WaitSkillFinish();
				Skilltimes = 0;
			}
			CastSkill(Hide);
			yield return WaitSkillFinish();
			Skilltimes++;
		}
		yield return WaitTime(intervaltime);
	}
}
