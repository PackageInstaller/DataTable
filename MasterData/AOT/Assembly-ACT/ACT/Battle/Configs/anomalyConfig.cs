using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct anomalyConfig
{
	public AnomalyType type;

	public int limit;
}
