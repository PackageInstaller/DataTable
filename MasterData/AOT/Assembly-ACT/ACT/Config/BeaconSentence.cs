using System;

namespace ACT.Config;

[Serializable]
public class BeaconSentence
{
	public readonly int id;

	public readonly int text;

	public readonly int unlockItem;

	public BeaconSentence(int id, int text, int unlockItem)
	{
		this.id = id;
		this.text = text;
		this.unlockItem = unlockItem;
	}
}
