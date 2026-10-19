using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class CookMenu
{
	public readonly int id;

	public readonly int name;

	public readonly List<ItemKv> menu;

	public readonly int menuCost;

	public readonly bool unlockLicense;

	public readonly int menuType;

	public readonly int iconAddress;

	public CookMenu(int id, int name, List<ItemKv> menu, int menuCost, bool unlockLicense, int menuType, int iconAddress)
	{
		this.id = id;
		this.name = name;
		this.menu = menu;
		this.menuCost = menuCost;
		this.unlockLicense = unlockLicense;
		this.menuType = menuType;
		this.iconAddress = iconAddress;
	}
}
