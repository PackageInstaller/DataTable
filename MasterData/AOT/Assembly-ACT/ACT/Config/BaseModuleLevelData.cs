using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class BaseModuleLevelData
{
	public readonly int id;

	public readonly int moduleId;

	public readonly int level;

	public readonly int centerLevelRequire;

	public readonly List<ItemKv> itemNeeded;

	public readonly List<ItemKv> itemgiven;

	public BaseModuleLevelData(int id, int moduleId, int level, int centerLevelRequire, List<ItemKv> itemNeeded, List<ItemKv> itemgiven)
	{
		this.id = id;
		this.moduleId = moduleId;
		this.level = level;
		this.centerLevelRequire = centerLevelRequire;
		this.itemNeeded = itemNeeded;
		this.itemgiven = itemgiven;
	}
}
