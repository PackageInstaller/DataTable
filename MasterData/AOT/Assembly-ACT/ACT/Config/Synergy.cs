using System;

namespace ACT.Config;

[Serializable]
public class Synergy
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly int inscriptionId;

	public readonly int threshold;

	public readonly int[] combatEffectIds = new int[0];

	public readonly int metaEffectId;

	public Synergy(int id, int name, int description, int inscriptionId, int threshold, int[] combatEffectIds, int metaEffectId)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.inscriptionId = inscriptionId;
		this.threshold = threshold;
		this.combatEffectIds = combatEffectIds;
		this.metaEffectId = metaEffectId;
	}
}
