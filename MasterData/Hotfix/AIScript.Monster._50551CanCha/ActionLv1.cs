using System.Collections.Generic;

namespace AIScript.Monster._50551CanCha;

public class ActionLv1 : ActionBase
{
	private Dictionary<int, List<int>> sequenceDict;

	private List<int> ultShootGroup = new List<int>();

	private List<int> teamShootGroup = new List<int>();

	protected override void SetConfig()
	{
		base.SetConfig();
		InitSequenceDict();
		sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = ultShootGroup,
			[2] = teamShootGroup
		};
		InitSequenceBranches(1, ActionBase.sequenceBranchesList, sequenceDict);
	}

	private void InitSequenceDict()
	{
		ultShootGroup = AssemblyList(ultShootGroup, wanderlAction, normalATK_2, ultShoot_1, wanderlAction, normalATK_2, normalATK_1);
		ultShootGroup = ToTargetKey(ultShootGroup, 2);
		teamShootGroup = AssemblyList(teamShootGroup, wanderlAction, normalATK_1, teamShoot_3, wanderlAction, normalATK_2, normalATK_2);
		teamShootGroup = ToTargetKey(teamShootGroup, 1);
	}
}
