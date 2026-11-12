using System.Collections.Generic;

namespace AIScript.Monster._50551CanCha;

public class ActionLv2 : ActionBase
{
	private Dictionary<int, List<int>> sequenceDict;

	private List<int> elfUltShootGroup = new List<int>();

	private List<int> teamShootGroup = new List<int>();

	protected override void SetConfig()
	{
		base.SetConfig();
		InitSequenceDict();
		sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = teamShootGroup,
			[2] = elfUltShootGroup
		};
		InitSequenceBranches(1, ActionBase.sequenceBranchesList, sequenceDict);
	}

	private void InitSequenceDict()
	{
		teamShootGroup = AssemblyList(teamShootGroup, wanderlAction, normalATK_1, teamShoot_3, normalATK_2, normalATK_1);
		teamShootGroup = ToTargetKey(teamShootGroup, 2);
		elfUltShootGroup = AssemblyList(elfUltShootGroup, wanderlAction, normalATK_1, elfUltShoot_3, normalATK_2);
		elfUltShootGroup = ToTargetKey(elfUltShootGroup, 1);
	}
}
