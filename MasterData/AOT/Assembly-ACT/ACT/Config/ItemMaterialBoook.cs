using System;

namespace ACT.Config;

[Serializable]
public class ItemMaterialBoook
{
	public readonly int id;

	public readonly int[] itemIdGroup = new int[0];

	public readonly int materialType;

	public readonly int GroupName;

	public ItemMaterialBoook(int id, int[] itemIdGroup, int materialType, int GroupName)
	{
		this.id = id;
		this.itemIdGroup = itemIdGroup;
		this.materialType = materialType;
		this.GroupName = GroupName;
	}
}
