using System;

namespace ACT.Config;

[Serializable]
public class Avatar
{
	public readonly int id;

	public readonly int name;

	public readonly int iconID;

	public Avatar(int id, int name, int iconID)
	{
		this.id = id;
		this.name = name;
		this.iconID = iconID;
	}
}
