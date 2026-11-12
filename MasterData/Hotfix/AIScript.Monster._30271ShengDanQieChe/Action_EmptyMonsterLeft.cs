using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Action_EmptyMonsterLeft : MonsterActionBase
{
	private static readonly int AttackWave = 3027114;

	private FP StartTime;

	private FP DistanceToTarget;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
		StartTime = _actor.LogicTime;
	}

	private void GotoCastSkill(int ID)
	{
		CastSkill(ID);
	}

	private IEnumerator Cast1()
	{
		GotoCastSkill(AttackWave);
		yield return WaitSkillFinish();
	}
}
