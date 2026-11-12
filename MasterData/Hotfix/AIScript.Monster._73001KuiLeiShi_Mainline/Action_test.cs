using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Action_test : MonsterActionBase
{
	private static readonly int Skill01 = 7201101;

	private static readonly int Skill02 = 7201102;

	private static readonly int Skill03 = 7201103;

	private static readonly int Skill04 = 7201104;

	private static readonly int Skill05 = 7201105;

	private static readonly int Skill06 = 7201106;

	private readonly FP skillwaittime = 2.5f;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast2;
		list.Add(new BaseBranchInfo(2, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>> { [1] = new List<int> { 2 } };
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		SetBattleOutEnable();
	}

	private IEnumerator Cast1()
	{
		CastSkill(Skill01);
		yield return WaitSkillFinish();
		yield return WaitTime(skillwaittime);
		CastSkill(Skill02);
		yield return WaitSkillFinish();
		yield return WaitTime(skillwaittime);
		CastSkill(Skill03);
		yield return WaitSkillFinish();
		yield return WaitTime(skillwaittime);
		CastSkill(Skill04);
		yield return WaitSkillFinish();
		yield return WaitTime(skillwaittime);
	}

	private IEnumerator Cast2()
	{
		CastSkill(Skill06);
		yield return WaitSkillFinish();
		yield return WaitTime(skillwaittime);
	}
}
