using System;

namespace ACT.Config;

[Serializable]
public class CookRandomName
{
	public readonly int id;

	public readonly int name;

	public readonly int imageGroup;

	public readonly int menu;

	public readonly int iconAddress;

	public CookRandomName(int id, int name, int imageGroup, int menu, int iconAddress)
	{
		this.id = id;
		this.name = name;
		this.imageGroup = imageGroup;
		this.menu = menu;
		this.iconAddress = iconAddress;
	}
}
