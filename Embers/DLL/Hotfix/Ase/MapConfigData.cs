using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class MapConfigData
{
	public enum MapTypeEnum
	{
		LevelMap,
		CaveMap
	}

	private int m_Id;

	public MapTypeEnum MapType { get; private set; }

	public int Id => m_Id;

	public int LevelId { get; private set; }

	public List<float> MapSize { get; private set; }

	public string MapPrefabPath { get; private set; }

	public string MiniMapPath { get; private set; }

	public string MapMaskPath { get; private set; }

	public string MaskAlphaPath { get; private set; }

	public List<int> TransferPoint { get; private set; }

	public List<DRCavernPoint> CavernPoints { get; private set; }

	public List<float> InitPos { get; private set; }

	public float MapSenceScale { get; private set; }

	public Vector2 MapPosOffset { get; private set; }

	public MapConfigData(DRMap configData)
	{
		MapType = MapTypeEnum.LevelMap;
		m_Id = configData.Id;
		LevelId = configData.Id;
		MapSize = configData.MapSize;
		MapPrefabPath = configData.MapPrefabPath;
		MiniMapPath = configData.MiniMapPath;
		MapMaskPath = configData.MapMaskPath;
		MaskAlphaPath = configData.MaskAlphaPath;
		TransferPoint = configData.TransferPoint;
		InitPos = configData.InitPos;
		MapSenceScale = GameEntry.Base.GameConfig.minimap_UISceneRatio;
		MapPosOffset = new Vector2((configData.WorldPosOffset.Count > 0) ? configData.WorldPosOffset[0] : 0f, (configData.WorldPosOffset.Count > 1) ? configData.WorldPosOffset[1] : 0f);
		CavernPoints = new List<DRCavernPoint>();
		DRCavern[] dataRows = GameEntry.DataTable.GetDataRows((DRCavern p) => p.LevelId == configData.Id);
		if (dataRows == null)
		{
			return;
		}
		DRCavern[] array = dataRows;
		for (int num = 0; num < array.Length; num++)
		{
			foreach (int item in array[num].CavernPoint)
			{
				DRCavernPoint dataRow = GameEntry.DataTable.GetDataRow<DRCavernPoint>(item);
				if (dataRow != null)
				{
					CavernPoints.Add(dataRow);
				}
			}
		}
	}

	public MapConfigData(DRCavern configData)
	{
		MapType = MapTypeEnum.CaveMap;
		m_Id = configData.Id;
		LevelId = configData.LevelId;
		MapSize = configData.MapSize;
		MapPrefabPath = configData.MapPrefabPath;
		MiniMapPath = configData.MiniMapPath;
		MapMaskPath = configData.MapMaskPath;
		MaskAlphaPath = configData.MaskAlphaPath;
		TransferPoint = new List<int>();
		InitPos = configData.InitPos;
		MapSenceScale = configData.MapSenceScale;
		MapPosOffset = new Vector2((configData.Cavernpoint.Count > 0) ? configData.Cavernpoint[0] : 0f, (configData.Cavernpoint.Count > 1) ? configData.Cavernpoint[1] : 0f);
		CavernPoints = new List<DRCavernPoint>();
		foreach (int item in configData.CavernPoint)
		{
			DRCavernPoint dataRow = GameEntry.DataTable.GetDataRow<DRCavernPoint>(item);
			if (dataRow != null)
			{
				CavernPoints.Add(dataRow);
			}
		}
	}
}
