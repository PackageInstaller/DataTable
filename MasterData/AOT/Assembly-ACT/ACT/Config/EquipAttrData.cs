using System;

namespace ACT.Config;

[Serializable]
public class EquipAttrData
{
	public readonly int id;

	public readonly int attrId;

	public readonly int attrGroup;

	public readonly float[] attrList = new float[0];

	public EquipAttrData(int id, int attrId, int attrGroup, float[] attrList)
	{
		this.id = id;
		this.attrId = attrId;
		this.attrGroup = attrGroup;
		this.attrList = attrList;
	}
}
