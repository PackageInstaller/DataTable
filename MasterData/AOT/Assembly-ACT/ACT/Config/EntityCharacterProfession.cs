using System;

namespace ACT.Config;

[Serializable]
public class EntityCharacterProfession
{
	public readonly int id;

	public readonly int characterProfessionName;

	public readonly int professionIcon;

	public readonly int professionDescLocal;

	public EntityCharacterProfession(int id, int characterProfessionName, int professionIcon, int professionDescLocal)
	{
		this.id = id;
		this.characterProfessionName = characterProfessionName;
		this.professionIcon = professionIcon;
		this.professionDescLocal = professionDescLocal;
	}
}
