using System;

namespace ACT.Config;

[Serializable]
public class ChipSelection
{
	public readonly int id;

	public readonly int fuction;

	public readonly ItemKv sectionType;

	public readonly int[] sectionContent = new int[0];

	public ChipSelection(int id, int fuction, ItemKv sectionType, int[] sectionContent)
	{
		this.id = id;
		this.fuction = fuction;
		this.sectionType = sectionType;
		this.sectionContent = sectionContent;
	}
}
