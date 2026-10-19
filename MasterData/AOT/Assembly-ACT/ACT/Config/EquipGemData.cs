using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EquipGemData
{
	public readonly int id;

	public readonly string name = "";

	public readonly int nameLocal;

	public readonly int description;

	public readonly int quality;

	public readonly int icon;

	public readonly List<ItemKv> equipFeature;

	public readonly int recycleValue;

	public EquipGemData(int id, string name, int nameLocal, int description, int quality, int icon, List<ItemKv> equipFeature, int recycleValue)
	{
		this.id = id;
		this.name = name;
		this.nameLocal = nameLocal;
		this.description = description;
		this.quality = quality;
		this.icon = icon;
		this.equipFeature = equipFeature;
		this.recycleValue = recycleValue;
	}
}
