using System.Collections.Generic;
using UnityEngine;

namespace ChessBoard;

public class ChessBoardMapCfgManager
{
	private static ChessBoardMapCfgManager sInstance;

	public MapConfig MapConfig;

	private Dictionary<int, ChessBoardGridConfig> gridConfigS;

	private Dictionary<int, ChessBoardThingConfig> thingConfigS;

	public static ChessBoardMapCfgManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new ChessBoardMapCfgManager();
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

	public void SetGridConfig(ChessBoardGridConfig[] config)
	{
		gridConfigS = new Dictionary<int, ChessBoardGridConfig>();
		for (int i = 0; i < config.Length; i++)
		{
			gridConfigS.Add(config[i].id, config[i]);
		}
	}

	public ChessBoardGridConfig GetGridConfig(int id, int status)
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

	public void SetThingConfig(ChessBoardThingConfig[] config)
	{
		thingConfigS = new Dictionary<int, ChessBoardThingConfig>();
		for (int i = 0; i < config.Length; i++)
		{
			thingConfigS.Add(config[i].thingID, config[i]);
		}
	}

	public ChessBoardThingConfig GetThingConfig(int id)
	{
		if (thingConfigS.ContainsKey(id))
		{
			return thingConfigS[id];
		}
		Debug.LogError("thing id" + id + "not found !!!");
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
