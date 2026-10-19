using System;

namespace ACT.Config;

[Serializable]
public class RogueSuit
{
	public readonly int id;

	public readonly int suitID;

	public readonly int num;

	public readonly float weight;

	public RogueSuit(int id, int suitID, int num, float weight)
	{
		this.id = id;
		this.suitID = suitID;
		this.num = num;
		this.weight = weight;
	}
}
