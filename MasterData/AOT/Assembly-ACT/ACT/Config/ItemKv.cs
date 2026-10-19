using System;

namespace ACT.Config;

[Serializable]
public class ItemKv
{
	public readonly int id;

	public readonly int count;

	public ItemKv(int id, int count)
	{
		this.id = id;
		this.count = count;
	}
}
