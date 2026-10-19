using System;

namespace ACT.Config;

[Serializable]
public class SoftHighLightSystem
{
	public readonly int id;

	public readonly int type;

	public readonly int missionGroupId;

	public SoftHighLightSystem(int id, int type, int missionGroupId)
	{
		this.id = id;
		this.type = type;
		this.missionGroupId = missionGroupId;
	}
}
