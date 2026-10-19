using System;

namespace ACT.Config;

[Serializable]
public class BeaconEmoji
{
	public readonly int id;

	public BeaconEmoji(int id)
	{
		this.id = id;
	}
}
