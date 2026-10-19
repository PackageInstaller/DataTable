using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class CollectionPoint
{
	public readonly int id;

	public readonly int pointName;

	public readonly int desc;

	public readonly int rule;

	public readonly bool lua;

	public readonly List<ItemKv> collectionId;

	public readonly bool skipJumpTraverse;

	public CollectionPoint(int id, int pointName, int desc, int rule, bool lua, List<ItemKv> collectionId, bool skipJumpTraverse)
	{
		this.id = id;
		this.pointName = pointName;
		this.desc = desc;
		this.rule = rule;
		this.lua = lua;
		this.collectionId = collectionId;
		this.skipJumpTraverse = skipJumpTraverse;
	}
}
