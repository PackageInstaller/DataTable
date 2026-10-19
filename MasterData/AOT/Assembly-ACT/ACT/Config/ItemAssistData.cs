using System;

namespace ACT.Config;

[Serializable]
public class ItemAssistData
{
	public readonly int id;

	public readonly int[] skinIds = new int[0];

	public readonly int[] initSkin = new int[0];

	public readonly int nameLocal;

	public readonly int descLocal;

	public ItemAssistData(int id, int[] skinIds, int[] initSkin, int nameLocal, int descLocal)
	{
		this.id = id;
		this.skinIds = skinIds;
		this.initSkin = initSkin;
		this.nameLocal = nameLocal;
		this.descLocal = descLocal;
	}
}
