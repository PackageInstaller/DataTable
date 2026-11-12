using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster.Activity.BreakOut;

public class Action_3_Common : MonsterActionBase_Brick
{
	private static readonly int Move = 8210201;

	private static readonly int Attack = 8210202;

	private readonly Dictionary<int, List<int>> MonsterID_SkillID_Dic = new Dictionary<int, List<int>>
	{
		[8210321] = new List<int> { Move, 2 },
		[8210322] = new List<int> { Move, 2 },
		[8210331] = new List<int> { Attack, 7 },
		[8210341] = new List<int> { Attack, 7 },
		[8210342] = new List<int> { Move, 2 },
		[8210372] = new List<int> { Attack, 7 }
	};

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = SkillGroup01;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		SetLogicTagTSVector2Value(_actor, "SpawnPos", GetPosition());
	}

	private void GotoCastSkill(int ID)
	{
		CastSkill(ID);
	}

	private IEnumerator SkillGroup01()
	{
		int iD = MonsterID_SkillID_Dic.get_Item(_actor.dataID).get_Item(0);
		int intervalTime = MonsterID_SkillID_Dic.get_Item(_actor.dataID).get_Item(1);
		GotoCastSkill(iD);
		yield return WaitSkillFinish();
		yield return WaitTime(intervalTime);
	}
}
