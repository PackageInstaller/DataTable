using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Action_Special02 : MonsterActionBase
{
	private static readonly int Skill01 = 3027122;

	private static readonly int Skill02 = 3027123;

	private static readonly int Death = 3027125;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast2;
		list.Add(new BaseBranchInfo(2, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1, 2 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	private IEnumerator Cast1()
	{
		CastSkill(Skill01);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast2()
	{
		CastSkill(Death);
		yield return WaitSkillFinish();
	}
}
