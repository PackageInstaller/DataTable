using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster.Activity.BreakOut;

public class Action_3_Boss : MonsterActionBase_Brick
{
	private static readonly int Attack = 8210203;

	private static readonly int Patrol = 8210204;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = SkillGroup01;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SkillGroup02;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001, 1002 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		SetLogicTagFpValue(_actor, "PositionListIndex", 0);
	}

	private void GotoCastSkill(int ID)
	{
		CastSkill(ID);
	}

	private IEnumerator SkillGroup01()
	{
		GotoCastSkill(Attack);
		yield return WaitSkillFinish();
		yield return WaitTime(2);
	}

	private IEnumerator SkillGroup02()
	{
		GotoCastSkill(Patrol);
		yield return WaitSkillFinish();
		yield return WaitTime(2);
	}
}
