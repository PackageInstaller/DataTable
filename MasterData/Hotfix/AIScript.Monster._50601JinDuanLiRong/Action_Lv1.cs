using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Action_Lv1 : JinDuanLiRongActionBasetion
{
	private Dictionary<int, List<int>> sequenceDict;

	private List<int> initialSkillGroup = new List<int>();

	private List<int> jCSkillGroup = new List<int>();

	private List<int> sCSkillGroup = new List<int>();

	protected override void SetConfig()
	{
		base.SetConfig();
		InitSequenceDict();
		SetLogicTag();
		sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = initialSkillGroup,
			[2] = jCSkillGroup,
			[3] = sCSkillGroup
		};
		InitSequenceBranches(1, JinDuanLiRongActionBasetion.sequenceBranchesList, sequenceDict);
	}

	private void InitSequenceDict()
	{
		initialSkillGroup = AssemblyList(initialSkillGroup, wanderActionHandSkill, initialSkill);
		initialSkillGroup = SkillListAddSkill(initialSkillGroup, JinDuanLiRongActionBasetion.switchArms2JCBranchID);
		initialSkillGroup = ToTargetKey(initialSkillGroup, 2);
		jCSkillGroup = AssemblyList(jCSkillGroup, wanderActionFootSkill, jC_H3);
		jCSkillGroup = SkillListAddSkill(jCSkillGroup, JinDuanLiRongActionBasetion.switchArms2SCBranchID);
		jCSkillGroup = ToTargetKey(jCSkillGroup, 3);
		sCSkillGroup = AssemblyList(sCSkillGroup, wanderActionHandSkill, sC_H3);
		sCSkillGroup = SkillListAddSkill(sCSkillGroup, JinDuanLiRongActionBasetion.switchArms2JCBranchID);
		sCSkillGroup = ToTargetKey(sCSkillGroup, 2);
	}

	private void SetLogicTag()
	{
		SetLogicTagFpValue(_actor, "RepelAreaType", 1);
		SetLogicTagFpValue(_actor, "AttractAreaType", 1);
		SetAlertType(0);
	}

	protected override IEnumerator switchArms2SCEnumerator()
	{
		SetAlertType(1);
		yield return StartCor(switchArms2SCEnumeratorCor());
		yield return WaitSkillFinish();
	}

	protected override IEnumerator switchArms2JCEnumerator()
	{
		yield return StartCor(switchArms2JCEnumeratorCor());
		SetAlertType(1);
	}
}
