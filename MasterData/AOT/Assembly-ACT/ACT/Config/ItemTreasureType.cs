using System;

namespace ACT.Config;

[Serializable]
public class ItemTreasureType
{
	public readonly int id;

	public readonly int name;

	public readonly int uiicon;

	public readonly int uientrance;

	public readonly int uitype;

	public ItemTreasureType(int id, int name, int uiicon, int uientrance, int uitype)
	{
		this.id = id;
		this.name = name;
		this.uiicon = uiicon;
		this.uientrance = uientrance;
		this.uitype = uitype;
	}
}
