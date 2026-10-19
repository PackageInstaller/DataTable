using System;

namespace ACT.Config;

[Serializable]
public class BeaconType
{
	public readonly int id;

	public readonly int unlockItem;

	public BeaconType(int id, int unlockItem)
	{
		this.id = id;
		this.unlockItem = unlockItem;
	}
}
