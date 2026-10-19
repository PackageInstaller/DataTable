using System;

namespace ACT.Config;

[Serializable]
public class Inscription
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly int[] synergyIds = new int[0];

	public readonly int iconAddress;

	public Inscription(int id, int name, int description, int[] synergyIds, int iconAddress)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.synergyIds = synergyIds;
		this.iconAddress = iconAddress;
	}
}
