using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class CharacterTutorialConfig : ScriptableObject
{
	public int id;

	public List<PromptProcessConfig> promptProcessConfigs;
}
