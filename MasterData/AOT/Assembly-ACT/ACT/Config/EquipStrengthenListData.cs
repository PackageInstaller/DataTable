using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EquipStrengthenListData
{
	public readonly int id;

	public readonly int[] equipHoleList0 = new int[0];

	public readonly int[] equipHoleList10 = new int[0];

	public readonly int[] equipHoleList20 = new int[0];

	public readonly List<ItemKv> equipFeature0;

	public readonly List<ItemKv> equipFeature10;

	public readonly List<ItemKv> equipFeature20;

	public EquipStrengthenListData(int id, int[] equipHoleList0, int[] equipHoleList10, int[] equipHoleList20, List<ItemKv> equipFeature0, List<ItemKv> equipFeature10, List<ItemKv> equipFeature20)
	{
		this.id = id;
		this.equipHoleList0 = equipHoleList0;
		this.equipHoleList10 = equipHoleList10;
		this.equipHoleList20 = equipHoleList20;
		this.equipFeature0 = equipFeature0;
		this.equipFeature10 = equipFeature10;
		this.equipFeature20 = equipFeature20;
	}
}
