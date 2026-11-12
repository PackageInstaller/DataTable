using System.Collections.Generic;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Action_Lv3 : ActionBase
{
	private Dictionary<int, List<int>> sequenceDict;

	private List<int> initialSkillGroup = new List<int>();

	private List<int> combo_1_SkillGroup = new List<int>();

	private int combo1To2;

	private List<int> combo_2_SkillGroup = new List<int>();

	private List<int> combo_2_1_SkillGroup = new List<int>();

	private List<int> combo_3_SkillGroup = new List<int>();

	private List<int> combo_4_SkillGroup = new List<int>();

	protected override void SetConfig()
	{
		base.SetConfig();
		combo1To2 = ((GetRandomValue(0, 1) >= 0.5) ? 3 : 4);
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

	protected override void OnActionStart()
	{
		combo1To2 = ((GetRandomValue(0, 1) >= 0.5) ? 3 : 4);
	}

	private void InitSequenceDict()
	{
		initialSkillGroup = AssemblyList(initialSkillGroup, initialSkill);
		initialSkillGroup = ToTargetKey(initialSkillGroup, 2);
		combo_1_SkillGroup = AssemblyList(combo_1_SkillGroup, Combo_1);
		combo_1_SkillGroup = SkillListAddSkill(combo_1_SkillGroup, ActionBase.wait2);
		combo_1_SkillGroup = ToTargetKey(combo_1_SkillGroup, combo1To2);
		combo_2_SkillGroup = AssemblyList(combo_2_SkillGroup, Combo_2);
		combo_2_SkillGroup = SkillListAddSkill(combo_2_SkillGroup, ActionBase.wait2);
		combo_2_SkillGroup = ToTargetKey(combo_2_SkillGroup, 5);
		combo_2_1_SkillGroup = AssemblyList(combo_2_1_SkillGroup, Combo_2_1);
		combo_2_1_SkillGroup = SkillListAddSkill(combo_2_1_SkillGroup, ActionBase.wait2);
		combo_2_1_SkillGroup = ToTargetKey(combo_2_1_SkillGroup, 5);
		combo_3_SkillGroup = AssemblyList(combo_3_SkillGroup, Combo_3);
		combo_3_SkillGroup = SkillListAddSkill(combo_3_SkillGroup, ActionBase.wait2);
		combo_3_SkillGroup = ToTargetKey(combo_3_SkillGroup, 6);
		combo_4_SkillGroup = SkillListAddSkill(combo_4_SkillGroup, ActionBase.burstBranchID);
		combo_4_SkillGroup = SkillListAddSkill(combo_4_SkillGroup, ActionBase.wait2);
		combo_4_SkillGroup = ToTargetKey(combo_4_SkillGroup, 2);
	}
}
