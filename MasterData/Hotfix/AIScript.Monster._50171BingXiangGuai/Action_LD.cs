using System.Collections.Generic;

namespace AIScript.Monster._50171BingXiangGuai;

public class Action_LD : ActionBase
{
	private Dictionary<int, List<int>> sequenceDict;

	private List<int> attackStage = new List<int>();

	protected override void SetConfig()
	{
		base.SetConfig();
		InitSequenceDict();
		sequenceDict = new Dictionary<int, List<int>> { [2] = attackStage };
		InitSequenceBranches(2, ActionBase.sequenceBranchesList, sequenceDict);
	}

	private void InitSequenceDict()
	{
		attackStage = AssemblyList(attackStage, iceSkill);
	}

	private void SetLogicTag()
	{
	}
}
