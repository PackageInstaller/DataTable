using System.Collections.Generic;
using UnityEngine;

namespace NewChess;

public class NewChessMapCfgManager
{
	private static NewChessMapCfgManager sInstance;

	public NewMapConfig MapConfig;

	private Dictionary<int, NewGridConfig> gridConfigS;

	private Dictionary<int, NewWarChessThingConfig> thingConfigS;

	public int[] ConveyorIDList;

	public int[] ReverseConveyorIDList;

	public static NewChessMapCfgManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new NewChessMapCfgManager();
			}
			return sInstance;
		}
	}

	public void SetMapConfig(NewMapConfig mapConfig)
	{
		MapConfig = mapConfig;
	}

	public NewMapConfig GetMapConfig()
	{
		return MapConfig;
	}

	public void SetGridConfig(NewGridConfig[] config)
	{
		gridConfigS = new Dictionary<int, NewGridConfig>();
		for (int i = 0; i < config.Length; i++)
		{
			gridConfigS.Add(config[i].id, config[i]);
		}
	}

	public NewGridConfig GetGridConfig(int id, int status)
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

	public void SetThingConfig(NewWarChessThingConfig[] config)
	{
		thingConfigS = new Dictionary<int, NewWarChessThingConfig>();
		for (int i = 0; i < config.Length; i++)
		{
			thingConfigS.Add(config[i].thingID, config[i]);
		}
	}

	public NewWarChessThingConfig GetThingConfig(int id)
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

	public void SetConveyorIDList(int[] conveyorIDList)
	{
		ConveyorIDList = new int[conveyorIDList.Length];
		for (int i = 0; i < conveyorIDList.Length; i++)
		{
			ConveyorIDList[i] = conveyorIDList[i];
		}
	}

	public bool CheckGridTypeIsConveyorIDList(int realId)
	{
		return ConveyorIDList.contains(realId);
	}

	public void SetReverseConveyorIDList(int[] reverseConveyorIDList)
	{
		ReverseConveyorIDList = new int[reverseConveyorIDList.Length];
		for (int i = 0; i < reverseConveyorIDList.Length; i++)
		{
			ReverseConveyorIDList[i] = reverseConveyorIDList[i];
		}
	}

	public bool CheckGridTypeIsReverseConveyorIDList(int realId)
	{
		return ReverseConveyorIDList.contains(realId);
	}
}
