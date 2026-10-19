using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct OverrideConfigMotion
{
	public ConfigMotion key;

	public ConfigMotion over;
}
