using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Action_ChongNengKuiLei : MonsterActionBase
{
	private static readonly int Skill01 = 7201401;

	private readonly FP skillwaittime = 0.5f;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Cast2;
		list.Add(new BaseBranchInfo(2, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 2 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
	}

	private IEnumerator Cast2()
	{
		CastSkill(Skill01);
		yield return WaitSkillFinish();
		yield return WaitTime(skillwaittime);
	}
}
