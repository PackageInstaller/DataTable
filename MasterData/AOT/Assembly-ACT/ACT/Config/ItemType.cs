using System;

namespace ACT.Config;

[Serializable]
public class ItemType
{
	public readonly int id;

	public readonly int typeLocal;

	public readonly int actionType;

	public readonly int actionParam;

	public readonly bool CanOverflowConvert;

	public readonly int CanBestack;

	public readonly bool IsShowCount;

	public ItemType(int id, int typeLocal, int actionType, int actionParam, bool CanOverflowConvert, int CanBestack, bool IsShowCount)
	{
		this.id = id;
		this.typeLocal = typeLocal;
		this.actionType = actionType;
		this.actionParam = actionParam;
		this.CanOverflowConvert = CanOverflowConvert;
		this.CanBestack = CanBestack;
		this.IsShowCount = IsShowCount;
	}
}
