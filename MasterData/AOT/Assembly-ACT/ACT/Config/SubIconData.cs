using System;

namespace ACT.Config;

[Serializable]
public class SubIconData
{
	public readonly int id;

	public readonly int name;

	public readonly int iconAddress;

	public SubIconData(int id, int name, int iconAddress)
	{
		this.id = id;
		this.name = name;
		this.iconAddress = iconAddress;
	}
}
