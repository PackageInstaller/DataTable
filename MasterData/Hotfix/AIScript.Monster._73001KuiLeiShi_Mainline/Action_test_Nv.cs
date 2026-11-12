using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Action_test_Nv : MonsterActionBase
{
	private static readonly int Skill01 = 7201201;

	private static readonly int Skill02 = 7201202;

	private static readonly int Skill03 = 7201203;

	private static readonly int Skill04 = 7201204;

	private static readonly int Skill05 = 7201205;

	private static readonly int Skill06 = 7201206;

	private static readonly int Skill07 = 7201207;

	private static readonly int Skill08 = 7201208;

	private static readonly int Skill09 = 7201209;

	private FP skillwaittime = 5.5f;

	private static readonly int Skill13 = 7201213;

	private static readonly int Skill14 = 7201214;

	private static readonly int Skill16 = 7201216;

	private static readonly int Skill17 = 7201217;

	private static readonly int Skill18 = 7201218;

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
		skillwaittime = 1.5f;
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
		CastSkill(Skill14);
		yield return WaitSkillFinish();
		yield return WaitTime(skillwaittime);
	}
}
