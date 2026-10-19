using System;

namespace ACT.Config;

[Serializable]
public class SubmitItems
{
	public readonly int id;

	public readonly int num;

	public readonly int type;

	public SubmitItems(int id, int num, int type)
	{
		this.id = id;
		this.num = num;
		this.type = type;
	}
}
