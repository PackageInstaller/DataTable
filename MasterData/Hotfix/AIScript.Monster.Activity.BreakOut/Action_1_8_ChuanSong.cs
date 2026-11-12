using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace AIScript.Monster.Activity.BreakOut;

public class Action_1_8_ChuanSong : MonsterActionBase_Brick
{
	private static readonly int Skill1 = 8210081;

	private static readonly int Skill2 = 8210082;

	private static readonly int Skill3 = 8210083;

	private static readonly int testSkillId = 0;

	private static readonly int intervaltime = 0;

	private int TmpSkillID;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = SkillGroup01;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SkillGroup02;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SkillGroup03;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 1001, 1002, 1003 } };
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
		GotoCastSkill(Skill1);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup02()
	{
		GotoCastSkill(Skill2);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SkillGroup03()
	{
		GotoCastSkill(Skill3);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}
}
