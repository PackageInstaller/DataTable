using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._13051GaoDa;

public class Action_Hand_Lv3Phantom : MonsterActionBase
{
	private static readonly int Skill_Attack = 1305205;

	private static readonly int testSkillId = 0;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001 } };
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

	private IEnumerator Cast1()
	{
		GotoCastSkill(Skill_Attack);
		yield return WaitSkillFinish();
	}
}
