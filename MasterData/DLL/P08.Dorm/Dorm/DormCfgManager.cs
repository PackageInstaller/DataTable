using System.Collections.Generic;
using UnityEngine;

namespace Dorm;

internal class DormCfgManager
{
	private Dictionary<int, FurnitureConfig> furnitureConfigS;

	private Dictionary<int, DormMapCfg> dormMapConfigS;

	private static DormCfgManager sInstance;

	public static DormCfgManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new DormCfgManager();
			}
			return sInstance;
		}
	}

	public void SetFurnitureConfig(FurnitureConfig[] config)
	{
		furnitureConfigS = new Dictionary<int, FurnitureConfig>();
		for (int i = 0; i < config.Length; i++)
		{
			furnitureConfigS.Add(config[i].id, config[i]);
		}
	}

	public FurnitureConfig GetFurnitureConfig(int id)
	{
		if (furnitureConfigS.ContainsKey(id))
		{
			return furnitureConfigS[id];
		}
		Debug.LogError("furniture id" + id + "not found !!!");
		return null;
	}

	public void SetDormMapConfig(DormMapCfg[] config)
	{
		dormMapConfigS = new Dictionary<int, DormMapCfg>();
		for (int i = 0; i < config.Length; i++)
		{
			dormMapConfigS.Add(config[i].id, config[i]);
		}
	}

	public DormMapCfg GetDormMapConfig(int id)
	{
		if (dormMapConfigS.ContainsKey(id))
		{
			return dormMapConfigS[id];
		}
		Debug.LogError("map id" + id + "not found !!!");
		return null;
	}

	public void ShutDown()
	{
		dormMapConfigS.Clear();
		furnitureConfigS.Clear();
		sInstance = null;
	}
}
