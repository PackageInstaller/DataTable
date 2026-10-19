using System;

namespace ACT.Config;

[Serializable]
public class RogueEffectCard
{
	public readonly int id;

	public readonly int skillid;

	public readonly int weight;

	public readonly int suit;

	public readonly int rarity;

	public readonly int[] triggerList = new int[0];

	public readonly int price;

	public readonly int[] effectEnum = new int[0];

	public readonly int scope;

	public readonly string ability = "";

	public readonly int desc;

	public RogueEffectCard(int id, int skillid, int weight, int suit, int rarity, int[] triggerList, int price, int[] effectEnum, int scope, string ability, int desc)
	{
		this.id = id;
		this.skillid = skillid;
		this.weight = weight;
		this.suit = suit;
		this.rarity = rarity;
		this.triggerList = triggerList;
		this.price = price;
		this.effectEnum = effectEnum;
		this.scope = scope;
		this.ability = ability;
		this.desc = desc;
	}
}
