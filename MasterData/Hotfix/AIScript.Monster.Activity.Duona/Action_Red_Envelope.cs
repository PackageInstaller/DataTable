using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AIScript.Monster.Activity.Duona;

public class Action_Red_Envelope : MonsterActionBase
{
	private static readonly int Attack = 3080304;

	private static readonly int testSkillId = 0;

	private static readonly int intervaltime = 0;

	private int TmpSkillID;

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
		base.OnActionEnable();
		Debug.Log("进入Action");
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}

	protected override void SetListenEvents()
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

	private IEnumerator SkillGroup01()
	{
		GotoCastSkill(Attack);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}
}
