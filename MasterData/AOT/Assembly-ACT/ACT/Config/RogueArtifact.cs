using System;

namespace ACT.Config;

[Serializable]
public class RogueArtifact
{
	public readonly int id;

	public readonly int artifactName;

	public readonly int icon;

	public readonly int skillid;

	public readonly int weight;

	public readonly int rarity;

	public readonly int price;

	public readonly string artifactDesc = "";

	public readonly int effectEnum;

	public readonly int scope;

	public readonly string ability = "";

	public readonly int effectDesc;

	public readonly string[] skillParam = new string[0];

	public readonly float[] dynamicFloat = new float[0];

	public RogueArtifact(int id, int artifactName, int icon, int skillid, int weight, int rarity, int price, string artifactDesc, int effectEnum, int scope, string ability, int effectDesc, string[] skillParam, float[] dynamicFloat)
	{
		this.id = id;
		this.artifactName = artifactName;
		this.icon = icon;
		this.skillid = skillid;
		this.weight = weight;
		this.rarity = rarity;
		this.price = price;
		this.artifactDesc = artifactDesc;
		this.effectEnum = effectEnum;
		this.scope = scope;
		this.ability = ability;
		this.effectDesc = effectDesc;
		this.skillParam = skillParam;
		this.dynamicFloat = dynamicFloat;
	}
}
