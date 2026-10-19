using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class TaskItemSubmit
{
	public readonly int id;

	public readonly int type;

	public readonly List<SubmitItems> items;

	public TaskItemSubmit(int id, int type, List<SubmitItems> items)
	{
		this.id = id;
		this.type = type;
		this.items = items;
	}
}
