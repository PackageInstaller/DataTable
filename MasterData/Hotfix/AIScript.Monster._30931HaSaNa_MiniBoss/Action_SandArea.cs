using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Action_SandArea : MonsterActionBase
{
	private static readonly int SkillId = 3093159;

	private readonly FP IntervalTime = 5;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Operate1_S1;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private IEnumerator Operate1_S1()
	{
		if (GetLogicTagToggleValue(_actor, "IsActive"))
		{
			yield return WaitTime(IntervalTime);
			if (GetLogicTagToggleValue(_actor, "IsActive"))
			{
				CastSkill(SkillId);
				yield return WaitSkillFinish();
			}
		}
	}
}
