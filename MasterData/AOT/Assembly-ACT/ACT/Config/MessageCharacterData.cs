using System;

namespace ACT.Config;

[Serializable]
public class MessageCharacterData
{
	public readonly int id;

	public readonly int characterName;

	public readonly int characterIcon;

	public readonly int characterDes;

	public readonly bool inRight;

	public MessageCharacterData(int id, int characterName, int characterIcon, int characterDes, bool inRight)
	{
		this.id = id;
		this.characterName = characterName;
		this.characterIcon = characterIcon;
		this.characterDes = characterDes;
		this.inRight = inRight;
	}
}
