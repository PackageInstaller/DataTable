using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Reward
{
	public readonly int id;

	public readonly List<Maybe> dropItem;

	public Reward(int id, List<Maybe> dropItem)
	{
		this.id = id;
		this.dropItem = dropItem;
	}
}
