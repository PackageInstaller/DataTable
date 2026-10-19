using System;

namespace ACT.Config;

[Serializable]
public class PropertyData
{
	public readonly int id;

	public readonly int descLocal;

	public readonly int icon;

	public readonly int propertyId;

	public readonly int subType;

	public readonly bool judge;

	public readonly int sort;

	public PropertyData(int id, int descLocal, int icon, int propertyId, int subType, bool judge, int sort)
	{
		this.id = id;
		this.descLocal = descLocal;
		this.icon = icon;
		this.propertyId = propertyId;
		this.subType = subType;
		this.judge = judge;
		this.sort = sort;
	}
}
