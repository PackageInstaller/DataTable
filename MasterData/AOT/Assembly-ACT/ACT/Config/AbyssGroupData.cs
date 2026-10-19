using System;

namespace ACT.Config;

[Serializable]
public class AbyssGroupData
{
	public readonly int id;

	public readonly int abyssType;

	public readonly long abyssGroupEndTs;

	public readonly int[] abyssInclude = new int[0];

	public AbyssGroupData(int id, int abyssType, long abyssGroupEndTs, int[] abyssInclude)
	{
		this.id = id;
		this.abyssType = abyssType;
		this.abyssGroupEndTs = abyssGroupEndTs;
		this.abyssInclude = abyssInclude;
	}
}
