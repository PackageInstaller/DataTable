using System;

namespace ACT.Config;

[Serializable]
public class EquipFeatureLevelData
{
	public readonly int id;

	public readonly int feature;

	public readonly int name;

	public readonly int description;

	public readonly int level;

	public readonly int skillId;

	public EquipFeatureLevelData(int id, int feature, int name, int description, int level, int skillId)
	{
		this.id = id;
		this.feature = feature;
		this.name = name;
		this.description = description;
		this.level = level;
		this.skillId = skillId;
	}
}
