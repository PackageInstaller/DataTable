using System;
using ACT.Game.Data;

namespace ACT.Game;

[Serializable]
public struct LocalTeam
{
	public string teamName;

	public int[] characterIds;

	public PresetTeam ToPB()
	{
		PresetTeam presetTeam = new PresetTeam();
		for (int i = 0; i < characterIds.Length; i++)
		{
			presetTeam.CharacterIds.Add(characterIds[i]);
		}
		presetTeam.Name = teamName;
		return presetTeam;
	}
}
