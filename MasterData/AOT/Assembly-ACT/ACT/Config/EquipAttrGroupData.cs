using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EquipAttrGroupData
{
	public readonly int id;

	public readonly List<ItemKv> equipAttrList;

	public EquipAttrGroupData(int id, List<ItemKv> equipAttrList)
	{
		this.id = id;
		this.equipAttrList = equipAttrList;
	}
}
