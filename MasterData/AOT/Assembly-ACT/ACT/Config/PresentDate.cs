using System;

namespace ACT.Config;

[Serializable]
public class PresentDate
{
	public readonly int id;

	public readonly int itemId;

	public readonly int type;

	public readonly int value;

	public PresentDate(int id, int itemId, int type, int value)
	{
		this.id = id;
		this.itemId = itemId;
		this.type = type;
		this.value = value;
	}
}
