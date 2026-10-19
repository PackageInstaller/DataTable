using System;

namespace ACT.Config;

[Serializable]
public class RogueTableBuffCard
{
	public readonly int id;

	public readonly int buffCardName;

	public readonly int buffCardDesc;

	public readonly int image;

	public readonly string abilityParm = "";

	public readonly int cardCost;

	public readonly int[] buffCardNameParm = new int[0];

	public RogueTableBuffCard(int id, int buffCardName, int buffCardDesc, int image, string abilityParm, int cardCost, int[] buffCardNameParm)
	{
		this.id = id;
		this.buffCardName = buffCardName;
		this.buffCardDesc = buffCardDesc;
		this.image = image;
		this.abilityParm = abilityParm;
		this.cardCost = cardCost;
		this.buffCardNameParm = buffCardNameParm;
	}
}
