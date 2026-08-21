using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0CrocodileGameContext
{
	public string gameDataPath = "T0World/Data/Other/104402CrocodileData";

	public T0CrocodileData gameData;

	public T0CrocodileGameStateEnum gameState = T0CrocodileGameStateEnum.waitSelect;

	public Transform itemContent;

	public Transform pressAnimNode;

	public List<T0CrocodileGameItem> itemList;

	public int currentPressIndex = -1;

	public int playCount
	{
		get
		{
			int num = 0;
			foreach (T0CrocodileGameItem item in itemList)
			{
				if (item.isPress)
				{
					num++;
				}
			}
			return num;
		}
	}

	public void Init()
	{
		gameData = Asset.Load<T0CrocodileData>(gameDataPath);
		itemList = new List<T0CrocodileGameItem>();
		for (int i = 0; i < itemContent.childCount; i++)
		{
			T0CrocodileGameItem component = itemContent.GetChild(i).GetComponent<T0CrocodileGameItem>();
			component.Init();
			component.InitData(i + 1);
			itemList.Add(component);
		}
	}

	public void Dispose()
	{
		if (itemList != null)
		{
			itemList.Clear();
		}
	}
}
