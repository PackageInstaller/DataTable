using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class CharacterTeamTutorialConfigs : ScriptableObject
{
	public List<CharacterTeamTutorialConfigWrapper> characterTeamTutorialConfigs = new List<CharacterTeamTutorialConfigWrapper>();

	public CharacterTeamTutorialConfig GetConfig(int id)
	{
		for (int i = 0; i < characterTeamTutorialConfigs.Count; i++)
		{
			if (characterTeamTutorialConfigs[i].id == id)
			{
				return characterTeamTutorialConfigs[i].config;
			}
		}
		return null;
	}
}
