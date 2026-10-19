using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class LevelReward
{
	public readonly int id;

	public readonly int battlepasid;

	public readonly int level;

	public readonly List<ItemKv> item;

	public readonly List<ItemKv> itempro;

	public readonly int type;

	public LevelReward(int id, int battlepasid, int level, List<ItemKv> item, List<ItemKv> itempro, int type)
	{
		this.id = id;
		this.battlepasid = battlepasid;
		this.level = level;
		this.item = item;
		this.itempro = itempro;
		this.type = type;
	}
}
