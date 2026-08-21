using System;
using GameFramework;
using UnityEngine;

namespace Ase;

[Serializable]
public class TerrainSplitParam : IReference
{
	public readonly string MapName = "Map";

	public readonly string TerrainRegionName = "Region";

	public readonly string TerrainZoneName = "Terrain";

	private string terrainSplicePath = "Assets/Art/TerrainSplice";

	public static readonly string SCENE_DATA_PATH = "Battle/TerrainSceneData";

	private CustomVector3 _transPos;

	private int loadRadius = 1;

	private int cacheRadius = 2;

	public string TerrainSplicePath
	{
		get
		{
			return terrainSplicePath;
		}
		set
		{
			terrainSplicePath = value;
		}
	}

	public int XLen { get; private set; }

	public int ZLen { get; private set; }

	public float SplitOffsetSize { get; private set; }

	public float TileXSize { get; private set; }

	public float TileZSize { get; private set; }

	public int BakeSize { get; private set; }

	public static TerrainSplitParam Create(Vector3 _transPos, int meshSize, int xLen, int zLen, float splitOffsetSize, int bakeSize)
	{
		TerrainSplitParam terrainSplitParam = ReferencePool.Acquire<TerrainSplitParam>();
		terrainSplitParam._transPos = new CustomVector3(_transPos);
		terrainSplitParam.XLen = xLen;
		terrainSplitParam.ZLen = zLen;
		terrainSplitParam.TileXSize = meshSize / xLen;
		terrainSplitParam.TileZSize = meshSize / zLen;
		terrainSplitParam.SplitOffsetSize = splitOffsetSize;
		terrainSplitParam.BakeSize = bakeSize;
		return terrainSplitParam;
	}

	public Vector3 GetTerrainPoz()
	{
		return _transPos.GetValue();
	}

	public int GetLoadRadius()
	{
		return loadRadius;
	}

	public int GetCacheRadius()
	{
		return cacheRadius;
	}

	public void SetRadius(int loadRadius, int cacheRadius)
	{
		this.loadRadius = loadRadius;
		this.cacheRadius = cacheRadius;
	}

	public void Clear()
	{
	}
}
