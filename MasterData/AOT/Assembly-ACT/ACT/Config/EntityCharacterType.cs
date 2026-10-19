using System;

namespace ACT.Config;

[Serializable]
public class EntityCharacterType
{
	public readonly int id;

	public readonly int typeTitle;

	public readonly int typeDescLocal;

	public EntityCharacterType(int id, int typeTitle, int typeDescLocal)
	{
		this.id = id;
		this.typeTitle = typeTitle;
		this.typeDescLocal = typeDescLocal;
	}
}
