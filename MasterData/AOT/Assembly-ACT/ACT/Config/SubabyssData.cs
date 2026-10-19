using System;

namespace ACT.Config;

[Serializable]
public class SubabyssData
{
	public readonly int id;

	public readonly int sceneId;

	public readonly int buffId;

	public readonly int recommendedLevel;

	public SubabyssData(int id, int sceneId, int buffId, int recommendedLevel)
	{
		this.id = id;
		this.sceneId = sceneId;
		this.buffId = buffId;
		this.recommendedLevel = recommendedLevel;
	}
}
