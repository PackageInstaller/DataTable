using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Action_Score : JinDuanLiRongActionBasetion
{
	private Dictionary<int, List<int>> sequenceDict;

	private List<int> initialGroup_firstStage = new List<int>();

	private List<int> jCGroup_firstStage = new List<int>();

	private List<int> fAGroup_firstStage = new List<int>();

	private List<int> sCGroup_secondStage = new List<int>();

	private List<int> fAGroup_secondStage = new List<int>();

	private List<int> jCGroup_secondStage = new List<int>();

	private static readonly int Stage2RequireLevel = 20;

	protected override void SetConfig()
	{
		base.SetConfig();
		InitSequenceDict();
		SetLogicTag();
		sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = initialGroup_firstStage,
			[2] = jCGroup_firstStage,
			[3] = fAGroup_firstStage,
			[4] = sCGroup_secondStage,
			[5] = fAGroup_secondStage,
			[6] = jCGroup_secondStage
		};
		InitSequenceBranches(1, JinDuanLiRongActionBasetion.sequenceBranchesList, sequenceDict);
	}

	private void InitSequenceDict()
	{
		initialGroup_firstStage = AssemblyList(initialGroup_firstStage, initialSkill, wanderActionHandSkill, changePhaseSkill);
		initialGroup_firstStage = ToTargetKey(initialGroup_firstStage, 2);
		jCGroup_firstStage = SkillListAddSkill(jCGroup_firstStage, JinDuanLiRongActionBasetion.switchArms2JCBranchID);
		jCGroup_firstStage = AssemblyList(jCGroup_firstStage, jC_H2, changePhaseSkill, jC_H4, wanderActionFootSkill, changePhaseSkill);
		jCGroup_firstStage = ToTargetKey(jCGroup_firstStage, 3);
		fAGroup_firstStage = SkillListAddSkill(fAGroup_firstStage, JinDuanLiRongActionBasetion.faUltimateBranchID);
		fAGroup_firstStage = AssemblyList(fAGroup_firstStage, fA_N2, wanderActionHandSkill, changePhaseSkill, fA_N1, wanderActionHandSkill, changePhaseSkill);
		fAGroup_firstStage = ToTargetKey(fAGroup_firstStage, 2);
		sCGroup_secondStage = SkillListAddSkill(sCGroup_secondStage, JinDuanLiRongActionBasetion.switchArms2SCBranchID);
		sCGroup_secondStage = AssemblyList(sCGroup_secondStage, sC_H1, wanderActionHandSkill, sC_H2, jC_H5, sC_H4);
		sCGroup_secondStage = ToTargetKey(sCGroup_secondStage, 5);
		fAGroup_secondStage = SkillListAddSkill(fAGroup_secondStage, JinDuanLiRongActionBasetion.faUltimateBranchID);
		fAGroup_secondStage = AssemblyList(fAGroup_secondStage, fA_N2, wanderActionHandSkill, fA_N1, jC_H5);
		fAGroup_secondStage = ToTargetKey(fAGroup_secondStage, 6);
		jCGroup_secondStage = SkillListAddSkill(jCGroup_secondStage, JinDuanLiRongActionBasetion.switchArms2JCBranchID);
		jCGroup_secondStage = AssemblyList(jCGroup_secondStage, jC_H2, jC_H4, wanderActionFootSkill);
		jCGroup_secondStage = ToTargetKey(jCGroup_secondStage, 4);
	}

	private void SetLogicTag()
	{
		SetLogicTagFpValue(_actor, "CurrentPhase", 1);
		SetLogicTagFpValue(_actor, "RepelAreaType", 1);
		SetLogicTagFpValue(_actor, "AttractAreaType", 1);
		SetLogicTagFpValue(_actor, "AlertType", 0);
	}

	protected override IEnumerator faUltimateEnumerator()
	{
		yield return StartCor(faUltimateEnumeratorCor());
		yield return StartCor(breakATKEnumerator());
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.BattleLevelChange, active: true, LevelUp);
	}

	private void LevelUp(IEvent evt)
	{
		if ((evt as AdventureMonsterBattleLevelChangedEvent).newLevel == Stage2RequireLevel)
		{
			changePhase = true;
			SetLogicTagFpValue(_actor, "CurrentPhase", 2);
		}
	}
}
