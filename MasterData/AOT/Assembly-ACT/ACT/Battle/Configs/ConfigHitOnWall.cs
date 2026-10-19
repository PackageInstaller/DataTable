using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigHitOnWall : ScriptableObject
{
	[HideInInspector]
	public float minSpeedLimit;

	public List<ConfigHitParameter> hitParameters;
}
