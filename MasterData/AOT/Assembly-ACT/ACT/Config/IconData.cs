using System;

namespace ACT.Config;

[Serializable]
public class IconData
{
	public readonly int id;

	public readonly int mapIcon;

	public readonly int nameLocal;

	public readonly int mapDescription;

	public readonly int pointType;

	public readonly int typeParm;

	public readonly bool unlockTransfer;

	public IconData(int id, int mapIcon, int nameLocal, int mapDescription, int pointType, int typeParm, bool unlockTransfer)
	{
		this.id = id;
		this.mapIcon = mapIcon;
		this.nameLocal = nameLocal;
		this.mapDescription = mapDescription;
		this.pointType = pointType;
		this.typeParm = typeParm;
		this.unlockTransfer = unlockTransfer;
	}
}
