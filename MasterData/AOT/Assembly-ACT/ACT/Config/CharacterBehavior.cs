using System;

namespace ACT.Config;

[Serializable]
public class CharacterBehavior
{
	public readonly int id;

	public readonly int[] characterId = new int[0];

	public CharacterBehavior(int id, int[] characterId)
	{
		this.id = id;
		this.characterId = characterId;
	}
}
