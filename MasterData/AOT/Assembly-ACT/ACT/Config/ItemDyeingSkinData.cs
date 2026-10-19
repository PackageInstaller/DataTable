using System;

namespace ACT.Config;

[Serializable]
public class ItemDyeingSkinData
{
	public readonly int id;

	public readonly int[] colorIds = new int[0];

	public readonly int[] initColor = new int[0];

	public readonly int sourceLocal;

	public readonly int assistBelong;

	public ItemDyeingSkinData(int id, int[] colorIds, int[] initColor, int sourceLocal, int assistBelong)
	{
		this.id = id;
		this.colorIds = colorIds;
		this.initColor = initColor;
		this.sourceLocal = sourceLocal;
		this.assistBelong = assistBelong;
	}
}
