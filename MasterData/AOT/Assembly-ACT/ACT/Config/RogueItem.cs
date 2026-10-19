using System;

namespace ACT.Config;

[Serializable]
public class RogueItem
{
	public readonly int id;

	public readonly int rarity;

	public readonly int[] inscriptionIds = new int[0];

	public readonly int talentNodeLevelDataId;

	public RogueItem(int id, int rarity, int[] inscriptionIds, int talentNodeLevelDataId)
	{
		this.id = id;
		this.rarity = rarity;
		this.inscriptionIds = inscriptionIds;
		this.talentNodeLevelDataId = talentNodeLevelDataId;
	}
}
