using System;

namespace ACT.Config;

[Serializable]
public class BeaconWordType
{
	public readonly int id;

	public readonly int text;

	public BeaconWordType(int id, int text)
	{
		this.id = id;
		this.text = text;
	}
}
