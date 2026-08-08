using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class BlisterMap : MonoBehaviour
{
	[Tooltip("地图名称")]
	[Header("地图名称")]
	public string mapName;

	[Tooltip("关卡加水数目")]
	[Header("关卡加水数目")]
	public int blisterNum;

	[Tooltip("连击x奖励加水")]
	[Header("连击x奖励加水")]
	public int comboReward = 10;

	public BlisterData[,] mapData;

	public void LoadAsset(string fileFullName)
	{
		string text = "Map/BlisterMap/" + fileFullName;
		BlisterMapData blisterMapData = UnityEngine.Object.Instantiate(Asset.Load<BlisterMapData>(text));
		if (blisterMapData != null)
		{
			mapName = blisterMapData.name;
			int column = blisterMapData.column;
			int row = blisterMapData.row;
			List<BlisterData> list = blisterMapData.mapData;
			mapData = new BlisterData[column, row];
			blisterNum = blisterMapData.blisterNum;
			comboReward = blisterMapData.comboReward;
			for (int i = 0; i < column; i++)
			{
				for (int j = 0; j < row; j++)
				{
					mapData[i, j] = list[i * row + j];
				}
			}
			Debug.Log("Asset loaded successfully: " + blisterMapData.name);
		}
		else
		{
			Debug.LogError("Failed to load asset at path: " + text);
		}
	}
}
