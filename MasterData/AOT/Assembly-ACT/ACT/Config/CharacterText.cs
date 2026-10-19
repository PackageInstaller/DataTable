using System;

namespace ACT.Config;

[Serializable]
public class CharacterText
{
	public readonly int id;

	public readonly int characterId;

	public readonly int type;

	public readonly int text;

	public readonly int audio;

	public readonly int unlockType;

	public readonly int weight;

	public CharacterText(int id, int characterId, int type, int text, int audio, int unlockType, int weight)
	{
		this.id = id;
		this.characterId = characterId;
		this.type = type;
		this.text = text;
		this.audio = audio;
		this.unlockType = unlockType;
		this.weight = weight;
	}
}
