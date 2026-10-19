using System;

namespace ACT.Config;

[Serializable]
public class RogueEventLibrary
{
	public readonly int id;

	public readonly int[] eventIdList = new int[0];

	public RogueEventLibrary(int id, int[] eventIdList)
	{
		this.id = id;
		this.eventIdList = eventIdList;
	}
}
