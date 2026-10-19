using System;

namespace ACT.Config;

[Serializable]
public class EquipFeatureData
{
	public readonly int id;

	public readonly int name;

	public readonly int description;

	public readonly int icon;

	public readonly int skillGroupData;

	public readonly int quality;

	public readonly int maxLv;

	public EquipFeatureData(int id, int name, int description, int icon, int skillGroupData, int quality, int maxLv)
	{
		this.id = id;
		this.name = name;
		this.description = description;
		this.icon = icon;
		this.skillGroupData = skillGroupData;
		this.quality = quality;
		this.maxLv = maxLv;
	}
}
