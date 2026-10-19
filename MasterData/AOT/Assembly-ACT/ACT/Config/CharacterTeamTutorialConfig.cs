using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class CharacterTeamTutorialConfig : ScriptableObject
{
	public int id;

	public List<PromptProcessConfig> promptProcessConfigs;
}
