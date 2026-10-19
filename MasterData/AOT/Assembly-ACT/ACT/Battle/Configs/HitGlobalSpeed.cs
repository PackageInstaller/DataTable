using System;

namespace ACT.Battle.Configs;

[Serializable]
public struct HitGlobalSpeed
{
	public HitType type;

	public SystemTime.ConfigChangeGlobalSpeed config;
}
