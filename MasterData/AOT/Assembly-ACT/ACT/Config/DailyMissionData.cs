using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class DailyMissionData
{
	public readonly int id;

	public readonly List<ItemKv> list;

	public readonly List<ItemKv> preconditionParam;

	public DailyMissionData(int id, List<ItemKv> list, List<ItemKv> preconditionParam)
	{
		this.id = id;
		this.list = list;
		this.preconditionParam = preconditionParam;
	}
}
