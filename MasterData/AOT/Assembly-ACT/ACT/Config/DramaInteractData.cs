using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class DramaInteractData
{
	public readonly int id;

	public readonly List<ItemKv> content;

	public DramaInteractData(int id, List<ItemKv> content)
	{
		this.id = id;
		this.content = content;
	}
}
