using System.Collections.Generic;
using ACT.Config;
using Bamboo.ImageCenter;
using Bamboo.Pool;

namespace ACT.UI;

public abstract class LevelUpPanelData : IRecycle
{
	public ImageAssetStation _station;

	public int MinLevel { get; set; }

	public int MaxLevel { get; set; }

	public int CurLevel { get; set; }

	public int AddLevel { get; set; }

	public List<Properties> Properties { get; set; }

	public int FinallyMaxLevel { get; set; }

	public int ItemEnoughLevel { get; set; }

	public bool ReachMax => CurLevel >= MaxLevel;

	public int NormalSelectLevel { get; set; }

	public bool IsRecycled { get; set; }

	public LevelUpPanelData()
	{
	}

	public LevelUpPanelData(int minLevel, int maxLevel, int curLevel, int addLevel, List<Properties> properties, int finallyMaxLevel = -1, ImageAssetStation station = null, int itemEnoughLevel = 0, int normalSelectLevel = 0)
	{
		MinLevel = minLevel;
		MaxLevel = maxLevel;
		CurLevel = curLevel;
		AddLevel = addLevel;
		Properties = properties;
		FinallyMaxLevel = ((finallyMaxLevel == -1) ? maxLevel : finallyMaxLevel);
		ItemEnoughLevel = ((itemEnoughLevel >= maxLevel) ? maxLevel : itemEnoughLevel);
		_station = station;
		NormalSelectLevel = normalSelectLevel;
	}

	public void SeGenericVal(int minLevel, int maxLevel, int curLevel, int addLevel, int itemEnough, List<Properties> properties)
	{
		MinLevel = minLevel;
		MaxLevel = maxLevel;
		CurLevel = curLevel;
		AddLevel = addLevel;
		Properties = properties;
		ItemEnoughLevel = itemEnough;
	}

	public void SetDataByUpgradeSuccess(int curLevel, int addLevel)
	{
		CurLevel = curLevel;
		AddLevel = addLevel;
	}

	public virtual void Recycle()
	{
		MinLevel = 0;
		MaxLevel = 0;
		CurLevel = 0;
		AddLevel = 0;
		Properties = null;
	}
}
