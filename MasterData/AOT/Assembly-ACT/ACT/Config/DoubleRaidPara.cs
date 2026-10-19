using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class DoubleRaidPara
{
	public readonly int id;

	public readonly int zoomType;

	public readonly int zoomLevel;

	public readonly List<ItemKv> customUnlockEntry;

	public readonly List<Properties> playerProperty;

	public readonly List<Properties> enemyProperty;

	public DoubleRaidPara(int id, int zoomType, int zoomLevel, List<ItemKv> customUnlockEntry, List<Properties> playerProperty, List<Properties> enemyProperty)
	{
		this.id = id;
		this.zoomType = zoomType;
		this.zoomLevel = zoomLevel;
		this.customUnlockEntry = customUnlockEntry;
		this.playerProperty = playerProperty;
		this.enemyProperty = enemyProperty;
	}
}
