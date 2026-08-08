using System.Collections.Generic;
using UnityEngine;

namespace Chess;

internal class ChessMapCfgManager
{
	private static ChessMapCfgManager sInstance;

	public MapConfig MapConfig;

	private Dictionary<int, GridConfig> gridConfigS;

	public static ChessMapCfgManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new ChessMapCfgManager();
			}
			return sInstance;
		}
	}

	public void SetMapConfig(MapConfig mapConfig)
	{
		MapConfig = mapConfig;
	}

	public MapConfig GetMapConfig()
	{
		return MapConfig;
	}

	public void SetGridConfig(GridConfig[] config)
	{
		gridConfigS = new Dictionary<int, GridConfig>();
		for (int i = 0; i < config.Length; i++)
		{
			gridConfigS.Add(config[i].id, config[i]);
		}
	}

	public GridConfig GetGridConfig(int id, int status)
	{
		if (status != 0)
		{
			int key = id * 10 + status;
			if (gridConfigS.ContainsKey(key))
			{
				return gridConfigS[key];
			}
		}
		if (gridConfigS.ContainsKey(id))
		{
			return gridConfigS[id];
		}
		Debug.LogError("grid id" + id + "not found !!!");
		return null;
	}

	public int GetRealTypeID(int id, int status)
	{
		int result = id;
		if (status != 0)
		{
			result = id * 10 + status;
		}
		return result;
	}
}
