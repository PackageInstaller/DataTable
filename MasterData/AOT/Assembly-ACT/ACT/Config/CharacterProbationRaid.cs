using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class CharacterProbationRaid
{
	public readonly int id;

	public readonly List<ItemKv> typeRaidID;

	public CharacterProbationRaid(int id, List<ItemKv> typeRaidID)
	{
		this.id = id;
		this.typeRaidID = typeRaidID;
	}
}
