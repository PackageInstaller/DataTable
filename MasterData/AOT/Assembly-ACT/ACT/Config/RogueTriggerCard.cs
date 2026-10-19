using System;

namespace ACT.Config;

[Serializable]
public class RogueTriggerCard
{
	public readonly int id;

	public readonly int trigger;

	public readonly int skillid;

	public readonly int weight;

	public readonly int rarity;

	public readonly int price;

	public readonly int scope;

	public readonly string[] types = new string[0];

	public readonly string[] conditions = new string[0];

	public readonly float[] parameters = new float[0];

	public readonly string ability = "";

	public readonly int suit;

	public RogueTriggerCard(int id, int trigger, int skillid, int weight, int rarity, int price, int scope, string[] types, string[] conditions, float[] parameters, string ability, int suit)
	{
		this.id = id;
		this.trigger = trigger;
		this.skillid = skillid;
		this.weight = weight;
		this.rarity = rarity;
		this.price = price;
		this.scope = scope;
		this.types = types;
		this.conditions = conditions;
		this.parameters = parameters;
		this.ability = ability;
		this.suit = suit;
	}
}
