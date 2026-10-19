using System.Collections.Generic;
using ACT.Game;
using Fundamental;

namespace ACT.Battle;

public class SetTeamCharacterNum : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		HashSet<int> hashSet = HashSetPool<int>.Get();
		for (int i = 0; i < G.localPlayer.teamInfo.PresetTeams.Count; i++)
		{
			foreach (int characterId in G.localPlayer.teamInfo.PresetTeams[i].CharacterIds)
			{
				if (characterId != 0)
				{
					hashSet.Add(characterId);
				}
			}
		}
		return hashSet.Count >= param[0];
	}

	public override int GetCompleteCount(int[] param)
	{
		HashSet<int> hashSet = HashSetPool<int>.Get();
		for (int i = 0; i < G.localPlayer.teamInfo.PresetTeams.Count; i++)
		{
			foreach (int characterId in G.localPlayer.teamInfo.PresetTeams[i].CharacterIds)
			{
				if (characterId != 0)
				{
					hashSet.Add(characterId);
				}
			}
		}
		return hashSet.Count;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
