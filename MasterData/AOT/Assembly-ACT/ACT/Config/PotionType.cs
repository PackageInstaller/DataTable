using System;

namespace ACT.Config;

[Serializable]
public class PotionType
{
	public readonly int id;

	public readonly int tpyeName;

	public PotionType(int id, int tpyeName)
	{
		this.id = id;
		this.tpyeName = tpyeName;
	}
}
