using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class CharacterTutorialConfigs : ScriptableObject
{
	public List<CharacterTutorialConfigWrapper> characterTutorialConfigs = new List<CharacterTutorialConfigWrapper>();

	public CharacterTutorialConfig GetConfig(int id)
	{
		for (int i = 0; i < characterTutorialConfigs.Count; i++)
		{
			if (characterTutorialConfigs[i].id == id)
			{
				return characterTutorialConfigs[i].config;
			}
		}
		return null;
	}
}
