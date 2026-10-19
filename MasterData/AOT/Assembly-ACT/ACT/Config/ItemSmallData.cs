using System;

namespace ACT.Config;

[Serializable]
public class ItemSmallData
{
	public readonly int id;

	public readonly int type;

	public readonly int subtype;

	public readonly int level;

	public readonly int customizeParameter1;

	public readonly int customizeParameter2;

	public readonly int customizeParameter3;

	public ItemSmallData(int id, int type, int subtype, int level, int customizeParameter1, int customizeParameter2, int customizeParameter3)
	{
		this.id = id;
		this.type = type;
		this.subtype = subtype;
		this.level = level;
		this.customizeParameter1 = customizeParameter1;
		this.customizeParameter2 = customizeParameter2;
		this.customizeParameter3 = customizeParameter3;
	}
}
