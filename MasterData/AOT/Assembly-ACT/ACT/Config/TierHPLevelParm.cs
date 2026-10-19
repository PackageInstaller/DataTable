using System;

namespace ACT.Config;

[Serializable]
public class TierHPLevelParm
{
	public readonly int id;

	public readonly float tierHPLevelParm;

	public TierHPLevelParm(int id, float tierHPLevelParm)
	{
		this.id = id;
		this.tierHPLevelParm = tierHPLevelParm;
	}
}
