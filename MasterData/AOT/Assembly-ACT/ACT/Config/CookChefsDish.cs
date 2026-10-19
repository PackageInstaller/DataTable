using System;

namespace ACT.Config;

[Serializable]
public class CookChefsDish
{
	public readonly int id;

	public readonly int worldLevel;

	public readonly int[] menuType = new int[0];

	public CookChefsDish(int id, int worldLevel, int[] menuType)
	{
		this.id = id;
		this.worldLevel = worldLevel;
		this.menuType = menuType;
	}
}
