using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class ActionScript_Device_CommonLevel : MonsterActionBase
{
	private readonly int AttackSkillID = 3093122;

	private readonly FP IntervalTime = 2;

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

	protected override void OnActionEnable()
	{
	}

	private IEnumerator Operate1_S1()
	{
		if (GetLogicTagToggleValue(_actor, "IsActive"))
		{
			CastSkill(AttackSkillID);
			yield return WaitSkillFinish();
		}
		yield return WaitTime(IntervalTime);
	}
}
