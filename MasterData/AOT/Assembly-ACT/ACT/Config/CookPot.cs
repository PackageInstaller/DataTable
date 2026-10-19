using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class CookPot
{
	public readonly int id;

	public readonly List<ItemKv> unlockPrecondition;

	public readonly int capacityValue;

	public CookPot(int id, List<ItemKv> unlockPrecondition, int capacityValue)
	{
		this.id = id;
		this.unlockPrecondition = unlockPrecondition;
		this.capacityValue = capacityValue;
	}
}
