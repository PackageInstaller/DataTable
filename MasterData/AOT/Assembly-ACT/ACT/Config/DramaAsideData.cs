using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class DramaAsideData
{
	public readonly int id;

	public readonly int type;

	public readonly int[] check = new int[0];

	public readonly string eventAddress = "";

	public readonly List<ItemKv> content;

	public DramaAsideData(int id, int type, int[] check, string eventAddress, List<ItemKv> content)
	{
		this.id = id;
		this.type = type;
		this.check = check;
		this.eventAddress = eventAddress;
		this.content = content;
	}
}
