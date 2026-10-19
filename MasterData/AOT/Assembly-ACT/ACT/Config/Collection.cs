using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Collection
{
	public readonly int id;

	public readonly string desc = "";

	public readonly string address = "";

	public readonly List<ItemKv> rewards;

	public readonly List<ItemKv> certain;

	public readonly int entityNeutralID;

	public readonly int collectionType;

	public readonly int rdmChips;

	public Collection(int id, string desc, string address, List<ItemKv> rewards, List<ItemKv> certain, int entityNeutralID, int collectionType, int rdmChips)
	{
		this.id = id;
		this.desc = desc;
		this.address = address;
		this.rewards = rewards;
		this.certain = certain;
		this.entityNeutralID = entityNeutralID;
		this.collectionType = collectionType;
		this.rdmChips = rdmChips;
	}
}
