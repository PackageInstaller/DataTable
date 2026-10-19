using System;

namespace ACT.Config;

[Serializable]
public class EnvironmentElement
{
	public readonly int id;

	public readonly int weekAtlasId;

	public readonly int strongAtlasId;

	public readonly int worldMapAtlasId;

	public readonly int characterAtlasId;

	public readonly int environmentResonanceAtlasId;

	public readonly int localizeId;

	public EnvironmentElement(int id, int weekAtlasId, int strongAtlasId, int worldMapAtlasId, int characterAtlasId, int environmentResonanceAtlasId, int localizeId)
	{
		this.id = id;
		this.weekAtlasId = weekAtlasId;
		this.strongAtlasId = strongAtlasId;
		this.worldMapAtlasId = worldMapAtlasId;
		this.characterAtlasId = characterAtlasId;
		this.environmentResonanceAtlasId = environmentResonanceAtlasId;
		this.localizeId = localizeId;
	}
}
