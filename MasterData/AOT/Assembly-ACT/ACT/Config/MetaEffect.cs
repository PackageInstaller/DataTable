using System;

namespace ACT.Config;

[Serializable]
public class MetaEffect
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly int metaEffectType;

	public readonly int[] param = new int[0];

	public readonly int amount;

	public MetaEffect(int id, int name, int description, int metaEffectType, int[] param, int amount)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.metaEffectType = metaEffectType;
		this.param = param;
		this.amount = amount;
	}
}
