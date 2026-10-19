using System;
using System.Collections.Generic;
using ACT.UI;
using ACT.World;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Config;

public class MapConfig : LuminSerializedScriptableObject
{
	[Serializable]
	public class AreaConfigData
	{
		public YooAssetReference areaGridPrefabAssetID;

		public Vector2Int size;

		public MapLayer defaultLayer;

		public List<MapLayer> containLayer;

		public Vector2 leftBottomWorldPos;

		public int unlockId;
	}

	[Serializable]
	public class UnlockFogConfigData
	{
		public ACT.World.MapArea area;

		public MapLayer layer;

		public Vector2[] cornerUV;
	}

	[Serializable]
	public class BossRoomIconConfigData
	{
		public int worldBossId;

		public int unlockInteractObjUid;

		public int unlockFogId;

		public GameObject largeMapBossRoomIconPrefab;

		public GameObject minimapBossRoomIconPrefab;

		public Vector2 iconWorldPos;
	}

	[Serializable]
	public class NodeBoundsData
	{
		public int chunkId;

		public Vector2 worldCenter;

		public Vector2 localCenterPixel;

		public Vector2Int sliceSize;
	}

	[Serializable]
	public class AreaScrollRectData
	{
		public float maxScale = 1f;

		public float minScale = 0.2f;

		public float defaultScale = 0.6f;

		public float scaleDelta = 0.02f;

		public float sliderBtnScaleDelta = 0.05f;

		public float horizontalScrollMargin = 2000f;

		public float verticalScrollMargin = 1000f;
	}

	public float largeMapRatio;

	public float miniMapRatio;

	public int cellPixelSize;

	[FormerlySerializedAs("areaScaleData")]
	public Dictionary<ACT.World.MapArea, AreaScrollRectData> areaScrollRectData;

	public Dictionary<ACT.World.MapArea, Vector2> originalAreaMapUnderLeftWorldPos = new Dictionary<ACT.World.MapArea, Vector2>();

	public Dictionary<ACT.World.MapArea, Dictionary<int, NodeBoundsData>> chunkBoundData = new Dictionary<ACT.World.MapArea, Dictionary<int, NodeBoundsData>>();

	public GameObject navBtnPrefab;

	public float navBtnHorizontalMargin;

	public float navBtnVerticalMargin;

	public float navTime;

	public AnimationCurve navCurve;

	public YooAssetReference largeMapInteractObjIconPrefabAssetD;

	public YooAssetReference largeMapNpcIconPrefabAssetD;

	public YooAssetReference largeMapMonsterPointPrefabAssetID;

	public YooAssetReference largeMapCollectPointPrefabAssetID;

	public YooAssetReference largeMapWorldBossPrefabAssetD;

	public YooAssetReference largeMapMissionIconPrefabAssetD;

	public YooAssetReference largeMapAreaBlockIconPrefabAssetD;

	public YooAssetReference largeMapChunkExplorePrefabAssetD;

	public YooAssetReference largeMapSelfNodeIconPrefabAssetD;

	public YooAssetReference largeMapRewardBoxPrefabAssetD;

	public YooAssetReference largeMapReceiveSideMissionIconPrefabAssetID;

	public Vector2 largeMapIconOffset;

	public float iconFixedScale;

	public float vagueSelectRadius;

	public GameObject vagueSelectCellPrefab;

	public Material contourMaterial;

	public Vector2 contourMoveRatio = Vector2.one;

	public YooAssetReference miniMapInteractObjIconPrefabAssetID;

	public YooAssetReference miniMapNpcIconPrefabAssetID;

	public YooAssetReference miniMapMonsterPointIconPrefabAssetID;

	public YooAssetReference miniMapCollectPointIconPrefabAssetID;

	public YooAssetReference miniMapWorldBossIconPrefabAssetID;

	public YooAssetReference miniMapMissionIconPrefabAssetID;

	public YooAssetReference miniMapSelfNodeIconPrefabAssetD;

	public YooAssetReference miniMapReceiveSideMissionIconPrefabAssetID;

	public Vector2 miniMapIconOffset;

	public YooAssetReference miniMapSingleGridAssetID;

	public YooAssetReference miniMapUnlockMaskAssetID;

	public Dictionary<(ACT.World.MapArea area, MapLayer layer, string imageType), HashSet<Vector2Int>> hasImageGridId;

	public ComputeShader mapFogCs;

	public Texture2D unlockAnimationTestTexture;

	public Material miniMapRoomMaterial;

	public Material miniMapDetailMaterial;

	public Material largeMapRoomMaterial;

	public Material largeMapDetailMaterial;

	public Dictionary<int, UnlockFogConfigData> unlockFogConfigData = new Dictionary<int, UnlockFogConfigData>();

	public Dictionary<ACT.World.MapArea, List<SpecialFogOutPutData>> specialFogConfigData = new Dictionary<ACT.World.MapArea, List<SpecialFogOutPutData>>();

	public Dictionary<ACT.World.MapArea, List<UnlockMaskOutPutData>> unlockMaskConfigData = new Dictionary<ACT.World.MapArea, List<UnlockMaskOutPutData>>();

	public Vector2 worldExploreFogOffset;

	public float localExplorePosSpace;

	[OdinSerialize]
	private Dictionary<ACT.World.MapArea, Dictionary<int, Vector2>> areaBlockV2Pos = new Dictionary<ACT.World.MapArea, Dictionary<int, Vector2>>();

	[OdinSerialize]
	private Dictionary<MapIconScaleType, float> iconScaleType2Scale = new Dictionary<MapIconScaleType, float>();

	[OdinSerialize]
	private Dictionary<MapIconType, MapIconScaleType> iconType2ScaleType = new Dictionary<MapIconType, MapIconScaleType>();

	[OdinSerialize]
	private Dictionary<ACT.World.MapArea, AreaConfigData> areaConfigData = new Dictionary<ACT.World.MapArea, AreaConfigData>();

	public HashSet<ACT.World.MapArea> defaultUnlockArea;

	public HashSet<MapSubArea> defaultUnlockSubArea;

	public List<(ACT.World.MapArea area, MapLayer layer)> GetAllAreaLayer()
	{
		List<(ACT.World.MapArea, MapLayer)> list = new List<(ACT.World.MapArea, MapLayer)>();
		foreach (ACT.World.MapArea key in areaConfigData.Keys)
		{
			foreach (MapLayer item in areaConfigData[key].containLayer)
			{
				list.Add((key, item));
			}
		}
		return list;
	}

	public List<ACT.World.MapArea> GetAllArea()
	{
		List<ACT.World.MapArea> list = new List<ACT.World.MapArea>();
		foreach (ACT.World.MapArea key in areaConfigData.Keys)
		{
			list.Add(key);
		}
		return list;
	}

	public YooAssetReference GetAreaGridPrefab(ACT.World.MapArea area)
	{
		return areaConfigData.GetValueOrDefault(area)?.areaGridPrefabAssetID;
	}

	public MapLayer GetAreaDefaultLayer(ACT.World.MapArea area)
	{
		return areaConfigData.GetValueOrDefault(area)?.defaultLayer ?? MapLayer.None;
	}

	public List<MapLayer> GetAreaContainLayer(ACT.World.MapArea area)
	{
		return areaConfigData.GetValueOrDefault(area)?.containLayer;
	}

	public Vector2 GetAreaLeftBottomWorldPos(ACT.World.MapArea area)
	{
		return areaConfigData.GetValueOrDefault(area)?.leftBottomWorldPos ?? Vector2.zero;
	}

	public Vector2Int GetAreaWidthHeightCellNum(ACT.World.MapArea area)
	{
		return areaConfigData.GetValueOrDefault(area)?.size ?? Vector2Int.zero;
	}

	public Vector2Int GetAreaUISize(ACT.World.MapArea area)
	{
		return cellPixelSize * GetAreaWidthHeightCellNum(area);
	}

	public int GetAreaUnlockId(ACT.World.MapArea area)
	{
		return areaConfigData.GetValueOrDefault(area)?.unlockId ?? 0;
	}

	public bool IsDefaultUnlockArea(ACT.World.MapArea area)
	{
		return defaultUnlockArea.Contains(area);
	}

	public bool IsDefaultUnlockSubArea(MapSubArea area)
	{
		return defaultUnlockSubArea.Contains(area);
	}

	public (float horizontalScrollMargin, float verticalScrollMargin) GetAreaScrollRectMargin(ACT.World.MapArea area)
	{
		AreaScrollRectData valueOrDefault = areaScrollRectData.GetValueOrDefault(area);
		if (valueOrDefault == null)
		{
			return (horizontalScrollMargin: 0f, verticalScrollMargin: 0f);
		}
		return (horizontalScrollMargin: valueOrDefault.horizontalScrollMargin, verticalScrollMargin: valueOrDefault.verticalScrollMargin);
	}

	public float GetAreaScrollRectDefaultScale(ACT.World.MapArea area)
	{
		return areaScrollRectData.GetValueOrDefault(area)?.defaultScale ?? 0.5f;
	}

	public (float minScale, float maxScale) GetAreaScrollRectMinMaxScale(ACT.World.MapArea area)
	{
		AreaScrollRectData valueOrDefault = areaScrollRectData.GetValueOrDefault(area);
		if (valueOrDefault == null)
		{
			return (minScale: 0f, maxScale: 0f);
		}
		return (minScale: valueOrDefault.minScale, maxScale: valueOrDefault.maxScale);
	}

	public float GetAreaScrollRectScaleDelta(ACT.World.MapArea area)
	{
		return areaScrollRectData.GetValueOrDefault(area)?.scaleDelta ?? 0f;
	}

	public float GetAreaScrollRectSliderBtnScaleDelta(ACT.World.MapArea area)
	{
		return areaScrollRectData.GetValueOrDefault(area)?.sliderBtnScaleDelta ?? 0f;
	}

	public bool IsValidUnlockFog(int unlockFogId)
	{
		return unlockFogConfigData.ContainsKey(unlockFogId);
	}

	public bool IsValidUnlockFogAll(List<int> unlockFogIds)
	{
		if (unlockFogIds == null)
		{
			return false;
		}
		foreach (int unlockFogId in unlockFogIds)
		{
			if (!IsValidUnlockFog(unlockFogId))
			{
				return false;
			}
		}
		return true;
	}

	public (ACT.World.MapArea area, MapLayer layer) GetUnlockFogAreaLayer(int unlockFogId)
	{
		UnlockFogConfigData valueOrDefault = unlockFogConfigData.GetValueOrDefault(unlockFogId);
		if (valueOrDefault == null)
		{
			return (area: ACT.World.MapArea.None, layer: MapLayer.None);
		}
		return (area: valueOrDefault.area, layer: valueOrDefault.layer);
	}

	public Vector2[] GetUnlockFogCornerUVPos(int unlockFogId)
	{
		return unlockFogConfigData.GetValueOrDefault(unlockFogId)?.cornerUV;
	}

	public void SetChunkBoundData(ACT.World.MapArea area, Dictionary<int, NodeBoundsData> dataList)
	{
		if (chunkBoundData.TryGetValue(area, out var _))
		{
			chunkBoundData[area] = dataList;
		}
		else
		{
			chunkBoundData.Add(area, dataList);
		}
	}

	public Dictionary<int, NodeBoundsData> GetChunkBoundData(ACT.World.MapArea area)
	{
		return chunkBoundData.GetValueOrDefault(area);
	}

	public bool IsValidGridId(ACT.World.MapArea area, MapLayer layer, string imageType, int row, int col)
	{
		if (hasImageGridId == null)
		{
			return false;
		}
		return hasImageGridId.GetValueOrDefault((area, layer, imageType))?.Contains(new Vector2Int(row, col)) ?? false;
	}

	public List<UnlockMaskOutPutData> GetMapAreaUnlockMask(ACT.World.MapArea area)
	{
		return unlockMaskConfigData?.GetValueOrDefault(area);
	}

	public List<SpecialFogOutPutData> GetMapAreaSpecialFog(ACT.World.MapArea area)
	{
		return specialFogConfigData.GetValueOrDefault(area);
	}

	public Dictionary<int, Vector2> GetMapAreaBlockPos(ACT.World.MapArea area)
	{
		if (areaBlockV2Pos.TryGetValue(area, out var value))
		{
			return value;
		}
		return null;
	}

	public float GetMapIconScale(MapIconType iconType)
	{
		if (iconType2ScaleType.TryGetValue(iconType, out var value) && iconScaleType2Scale.TryGetValue(value, out var value2))
		{
			return value2;
		}
		return 1f;
	}
}
