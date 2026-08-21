using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

[Serializable]
[CreateAssetMenu(menuName = "CharacterClimbSetting")]
public class CharacterClimbSetting : SerializedScriptableObject
{
	[SerializeField]
	private List<CharacterClimbConfig> _climbConfigs;

	public CharacterClimbConfig GetConfigByHeroId(int id)
	{
		if (_climbConfigs == null)
		{
			return null;
		}
		CharacterClimbConfig characterClimbConfig = null;
		for (int i = 0; i < _climbConfigs.Count; i++)
		{
			if (_climbConfigs[i].HeroId == 0)
			{
				characterClimbConfig = _climbConfigs[i];
			}
			else if (_climbConfigs[i].HeroId == id)
			{
				return _climbConfigs[i];
			}
		}
		if (characterClimbConfig == null)
		{
			return null;
		}
		return characterClimbConfig;
	}
}
