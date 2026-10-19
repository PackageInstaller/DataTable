using System;

namespace ACT.Config;

[Serializable]
public class BaseAquariumData
{
	public readonly int id;

	public readonly int fishLimit;

	public BaseAquariumData(int id, int fishLimit)
	{
		this.id = id;
		this.fishLimit = fishLimit;
	}
}
