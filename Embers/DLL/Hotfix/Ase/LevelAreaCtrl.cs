using System;
using System.Collections.Generic;
using Ase.ECS;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

[ExecuteInEditMode]
public class LevelAreaCtrl : SerializedMonoBehaviour, IInit, IStart
{
	public int serialId;

	public Dictionary<int, LevelArea> levelAreaList = new Dictionary<int, LevelArea>();

	private LevelMapData mapData;

	private List<int> taskUsedAreaIdArray = new List<int>();

	public void OnInit(object data = null)
	{
		foreach (KeyValuePair<int, LevelArea> levelArea in levelAreaList)
		{
			levelArea.Value.OnInit(data);
		}
	}

	public void OnStart(object data = null)
	{
		foreach (KeyValuePair<int, LevelArea> levelArea in levelAreaList)
		{
			levelArea.Value.OnStart(data);
		}
	}

	public void RegisterAreaCallback(EventHandler<LevelArea> OnEnterArea, EventHandler<LevelArea> OnExitArea)
	{
		foreach (KeyValuePair<int, LevelArea> levelArea in levelAreaList)
		{
			levelArea.Value.OnEnterArea = OnEnterArea;
			levelArea.Value.OnExitArea = OnExitArea;
		}
	}

	public LevelArea GetLevelArea(int areaId)
	{
		levelAreaList.TryGetValue(areaId, out var value);
		return value;
	}

	public void OnDispose()
	{
		foreach (KeyValuePair<int, LevelArea> levelArea in levelAreaList)
		{
			levelArea.Value.OnDispose();
		}
	}

	public void GetActiveAreaEntity(List<int> entityIds)
	{
		foreach (LevelArea value in levelAreaList.Values)
		{
			if (value.ActiveState)
			{
				value.monsterGroupCtrl.GetMonsterGroupEntity(entityIds);
			}
		}
	}

	public void OnGameSpeedChanged(float gameSpeed)
	{
		if (levelAreaList == null)
		{
			return;
		}
		foreach (LevelArea value in levelAreaList.Values)
		{
			value.OnGameSpeedChanged(gameSpeed);
		}
	}
}
