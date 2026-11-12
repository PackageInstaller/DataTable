using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._15510FengNiao;

public class Action_SmallBird : MonsterActionBase
{
	private static readonly int Skill_Dash = 1551031;

	private static readonly int Skill_FlyUp = 1551032;

	private static readonly string Dash_Message = "CastDashSkill";

	private static readonly string FlyUp_Message = "CastFlyUpSkill";

	private static readonly int testSkillId = 0;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		SetLogicTagStringValue(_actor, "SkillMessage", "WaitSkill");
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = SkillCast;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001, 1001 } };
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

	private IEnumerator SkillCast()
	{
		while (true)
		{
			string logicTagStringValue = GetLogicTagStringValue(_actor, "SkillMessage");
			if (logicTagStringValue == Dash_Message)
			{
				GotoCastSkill(Skill_Dash);
				yield return WaitSkillFinish();
			}
			else if (logicTagStringValue == FlyUp_Message)
			{
				GotoCastSkill(Skill_FlyUp);
				yield return WaitSkillFinish();
			}
			else
			{
				yield return null;
			}
		}
	}
}
