using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EquipCreatMaterialData
{
	public readonly int id;

	public readonly List<ItemKv> equipMaterialItem;

	public readonly int coinEach;

	public readonly int[] keyItemIds = new int[0];

	public EquipCreatMaterialData(int id, List<ItemKv> equipMaterialItem, int coinEach, int[] keyItemIds)
	{
		this.id = id;
		this.equipMaterialItem = equipMaterialItem;
		this.coinEach = coinEach;
		this.keyItemIds = keyItemIds;
	}
}
