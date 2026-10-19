using System;

namespace ACT.Config;

[Serializable]
public class AreaStateObject
{
	public readonly int id;

	public readonly string groupName = "";

	public readonly int[] group = new int[0];

	public AreaStateObject(int id, string groupName, int[] group)
	{
		this.id = id;
		this.groupName = groupName;
		this.group = group;
	}
}
