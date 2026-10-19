using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class ConfigGroupAIList : ScriptableObject
{
	public List<ConfigGroupAI> configGroupAIs;
}
