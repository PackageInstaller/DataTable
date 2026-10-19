using System;

namespace ACT.Config;

[Serializable]
public class ExploreType
{
	public readonly int id;

	public readonly int name;

	public readonly int itemId;

	public readonly int ObjectDesc;

	public readonly int imageAddress;

	public ExploreType(int id, int name, int itemId, int ObjectDesc, int imageAddress)
	{
		this.id = id;
		this.name = name;
		this.itemId = itemId;
		this.ObjectDesc = ObjectDesc;
		this.imageAddress = imageAddress;
	}
}
