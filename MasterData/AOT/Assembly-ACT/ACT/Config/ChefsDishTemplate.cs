using System;

namespace ACT.Config;

[Serializable]
public class ChefsDishTemplate
{
	public readonly int id;

	public readonly int[] menuType = new int[0];

	public ChefsDishTemplate(int id, int[] menuType)
	{
		this.id = id;
		this.menuType = menuType;
	}
}
