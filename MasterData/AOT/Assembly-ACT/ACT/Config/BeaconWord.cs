using System;

namespace ACT.Config;

[Serializable]
public class BeaconWord
{
	public readonly int id;

	public readonly int type;

	public readonly int text;

	public readonly int unlockItem;

	public BeaconWord(int id, int type, int text, int unlockItem)
	{
		this.id = id;
		this.type = type;
		this.text = text;
		this.unlockItem = unlockItem;
	}
}
