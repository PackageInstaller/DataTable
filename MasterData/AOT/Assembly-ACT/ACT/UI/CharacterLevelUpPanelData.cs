using System.Collections.Generic;
using ACT.Config;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class CharacterLevelUpPanelData : LevelUpPanelData
{
	public int CharacterId { get; }

	public new int FinallyMaxLevel { get; set; }

	public CharacterLevelUpPanelData(int minLevel, int maxLevel, int curLevel, int addLevel, List<Properties> properties, int finallyMaxLevel, ImageAssetStation station, int itemEnoughLevel, int characterId, int normalSelectLevel)
		: base(minLevel, maxLevel, curLevel, addLevel, properties, finallyMaxLevel, station, itemEnoughLevel, normalSelectLevel)
	{
		CharacterId = characterId;
		FinallyMaxLevel = finallyMaxLevel;
	}

	public CharacterLevelUpPanelData()
	{
	}
}
