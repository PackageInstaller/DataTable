using System;

namespace ACT.Config;

[Serializable]
public class InteractEntryPriorityData
{
	public readonly int id;

	public readonly int priority;

	public InteractEntryPriorityData(int id, int priority)
	{
		this.id = id;
		this.priority = priority;
	}
}
