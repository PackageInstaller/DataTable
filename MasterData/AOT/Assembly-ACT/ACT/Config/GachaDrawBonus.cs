using System;

namespace ACT.Config;

[Serializable]
public class GachaDrawBonus
{
	public readonly int id;

	public readonly int gachaId;

	public readonly int num;

	public readonly int rewardId;

	public readonly int isHighlight;

	public GachaDrawBonus(int id, int gachaId, int num, int rewardId, int isHighlight)
	{
		this.id = id;
		this.gachaId = gachaId;
		this.num = num;
		this.rewardId = rewardId;
		this.isHighlight = isHighlight;
	}
}
