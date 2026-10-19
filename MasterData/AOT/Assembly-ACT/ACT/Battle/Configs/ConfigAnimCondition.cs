using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct ConfigAnimCondition
{
	public ConfigAnimConditionMode mode;

	public string parameter;

	public float threshold;
}
