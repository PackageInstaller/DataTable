using System;

namespace ACT.Config;

[Serializable]
public class BdCore
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly int seasonId;

	public readonly int iconAddress;

	public readonly int bdUnlockConditionId;

	public readonly int[] combatEffectIds = new int[0];

	public readonly int metaEffectId;

	public BdCore(int id, int name, int description, int seasonId, int iconAddress, int bdUnlockConditionId, int[] combatEffectIds, int metaEffectId)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.seasonId = seasonId;
		this.iconAddress = iconAddress;
		this.bdUnlockConditionId = bdUnlockConditionId;
		this.combatEffectIds = combatEffectIds;
		this.metaEffectId = metaEffectId;
	}
}
