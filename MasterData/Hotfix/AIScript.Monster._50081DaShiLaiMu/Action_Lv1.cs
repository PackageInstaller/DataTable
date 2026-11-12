using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Action_Lv1 : ActionBase
{
	private int ultimateSkillTimes;

	private Dictionary<int, List<int>> sequenceDict;

	private List<int> initialSkillGroup = new List<int>();

	private List<int> combo_1_SkillGroup = new List<int>();

	private List<int> combo_2_SkillGroup = new List<int>();

	private List<int> combo_2_1_SkillGroup = new List<int>();

	private List<int> combo_3_SkillGroup = new List<int>();

	private List<int> combo_4_SkillGroup = new List<int>();

	protected override void SetConfig()
	{
		base.SetConfig();
		InitSequenceDict();
		sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = initialSkillGroup,
			[2] = combo_1_SkillGroup,
			[3] = combo_2_SkillGroup,
			[4] = combo_2_1_SkillGroup,
			[5] = combo_3_SkillGroup,
			[6] = combo_4_SkillGroup
		};
		InitSequenceBranches(2, ActionBase.sequenceBranchesList, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		ultimateSkillTimes = 0;
	}

	private void InitSequenceDict()
	{
		initialSkillGroup = AssemblyList(initialSkillGroup, initialSkill);
		initialSkillGroup = ToTargetKey(initialSkillGroup, 2);
		initialSkillGroup = ToTargetKey(initialSkillGroup, 1);
		combo_1_SkillGroup = AssemblyList(combo_1_SkillGroup, Combo_1);
		combo_1_SkillGroup = SkillListAddSkill(combo_1_SkillGroup, ActionBase.wait1);
		combo_1_SkillGroup = ToTargetKey(combo_1_SkillGroup, 3);
		combo_2_SkillGroup = AssemblyList(combo_2_SkillGroup, Combo_2);
		combo_2_SkillGroup = SkillListAddSkill(combo_2_SkillGroup, ActionBase.wait1);
		combo_2_SkillGroup = ToTargetKey(combo_2_SkillGroup, 5);
		combo_2_1_SkillGroup = AssemblyList(combo_2_1_SkillGroup, Combo_2_1);
		combo_2_1_SkillGroup = SkillListAddSkill(combo_2_1_SkillGroup, ActionBase.wait1);
		combo_2_1_SkillGroup = ToTargetKey(combo_2_1_SkillGroup, 5);
		combo_3_SkillGroup = AssemblyList(combo_3_SkillGroup, Combo_3);
		combo_3_SkillGroup = SkillListAddSkill(combo_3_SkillGroup, ActionBase.wait1);
		combo_3_SkillGroup = ToTargetKey(combo_3_SkillGroup, 6);
		combo_4_SkillGroup = SkillListAddSkill(combo_4_SkillGroup, ActionBase.burstBranchID);
		combo_4_SkillGroup = SkillListAddSkill(combo_4_SkillGroup, ActionBase.wait1);
		combo_4_SkillGroup = ToTargetKey(combo_4_SkillGroup, 2);
	}

	protected override IEnumerator BurstIEnumerator()
	{
		if (ultimateSkillTimes == 0)
		{
			combo_3_SkillGroup = ToTargetKey(combo_3_SkillGroup, 2);
			ultimateSkillTimes = 1;
			yield return StartCor(BurstIEnumeratorCor());
		}
	}
}
