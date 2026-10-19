using System;

namespace ACT.Config;

[Serializable]
public class ItemFishBaitData
{
	public readonly int id;

	public readonly int[] availableRaces = new int[0];

	public ItemFishBaitData(int id, int[] availableRaces)
	{
		this.id = id;
		this.availableRaces = availableRaces;
	}
}
