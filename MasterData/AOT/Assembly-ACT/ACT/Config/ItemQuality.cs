using System;

namespace ACT.Config;

[Serializable]
public class ItemQuality
{
	public readonly int id;

	public readonly int name;

	public readonly int monsterName;

	public ItemQuality(int id, int name, int monsterName)
	{
		this.id = id;
		this.name = name;
		this.monsterName = monsterName;
	}
}
