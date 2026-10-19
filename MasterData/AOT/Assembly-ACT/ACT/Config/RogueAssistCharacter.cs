using System;

namespace ACT.Config;

[Serializable]
public class RogueAssistCharacter
{
	public readonly int id;

	public readonly int characterId;

	public readonly int entityCharacterDataId;

	public readonly int tier;

	public readonly int skID;

	public readonly int skillCd;

	public RogueAssistCharacter(int id, int characterId, int entityCharacterDataId, int tier, int skID, int skillCd)
	{
		this.id = id;
		this.characterId = characterId;
		this.entityCharacterDataId = entityCharacterDataId;
		this.tier = tier;
		this.skID = skID;
		this.skillCd = skillCd;
	}
}
