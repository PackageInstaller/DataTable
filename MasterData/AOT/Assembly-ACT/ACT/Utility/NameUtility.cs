using System;
using ACT.World;
using UnityEngine;

namespace ACT.Utility;

public static class NameUtility
{
	public static string GetMapUnlockFogAddress(int unlockFogId)
	{
		return $"Assets/Arts/UI/DynamicSpritesWithAddress/Map/UnlockFog/MapUnlockFog_{unlockFogId}";
	}

	public static string GetChunkUnlockFogAddress(int chunkUnlockFogId)
	{
		return $"Assets/Arts/UI/DynamicSpritesWithAddress/Map/NewUnlockFog/{chunkUnlockFogId}";
	}

	public static string GetUnlockMaskAddress(int unlockMaskId)
	{
		return $"Assets/Arts/UI/DynamicSpritesWithAddress/Map/MapUnlockMask/{unlockMaskId}";
	}

	public static string GetAreaExploreRatioPercentageText(float exploreRatio)
	{
		return $"{Mathf.FloorToInt(exploreRatio * 100f)}%";
	}

	public static string GetSyncLayerName(MapArea area, MapLayer layer)
	{
		return $"{area}_{layer}";
	}

	public static (MapArea area, MapLayer layer) GetAreaLayerByMapViewInfoLayerId(string layerId)
	{
		MapArea item = Enum.Parse<MapArea>(layerId.Substring(0, layerId.IndexOf('_')));
		MapLayer item2 = Enum.Parse<MapLayer>(layerId.Substring(layerId.IndexOf('_') + 1));
		return (area: item, layer: item2);
	}

	public static Vector2Int GetGridIdByGridStringId(string gridId)
	{
		int x = int.Parse(gridId.Substring(0, gridId.IndexOf(',')));
		int y = int.Parse(gridId.Substring(gridId.IndexOf(',') + 1));
		return new Vector2Int(x, y);
	}
}
