using System.Collections.Generic;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Config;

public class ConfigRoleClimbCompensation : ScriptableObject
{
	public Dictionary<CharacterWeightType, float> keyValuePairs = new Dictionary<CharacterWeightType, float>();
}
