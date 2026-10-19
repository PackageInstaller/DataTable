using System;

namespace ACT.Config;

[Serializable]
public class EquipData
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly string name = "";

	public readonly int descLocal;

	public readonly string icon = "";

	public readonly int quality;

	public readonly int equipType;

	public readonly int space;

	public readonly int strengthen;

	public readonly int fixEquipAttrId;

	public readonly int ranEquipAttrGroupAId;

	public readonly int ranEquipAttrGroupBId;

	public readonly int CreatmaterialListID;

	public readonly int suitId;

	public EquipData(int id, int nameLocal, string name, int descLocal, string icon, int quality, int equipType, int space, int strengthen, int fixEquipAttrId, int ranEquipAttrGroupAId, int ranEquipAttrGroupBId, int CreatmaterialListID, int suitId)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.name = name;
		this.descLocal = descLocal;
		this.icon = icon;
		this.quality = quality;
		this.equipType = equipType;
		this.space = space;
		this.strengthen = strengthen;
		this.fixEquipAttrId = fixEquipAttrId;
		this.ranEquipAttrGroupAId = ranEquipAttrGroupAId;
		this.ranEquipAttrGroupBId = ranEquipAttrGroupBId;
		this.CreatmaterialListID = CreatmaterialListID;
		this.suitId = suitId;
	}
}
