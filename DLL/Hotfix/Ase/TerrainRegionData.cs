using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class TerrainRegionData : IReference
{
	private string name;

	private int xIdx;

	private int zIdx;

	public List<string> terrainList;

	public string Name => name;

	public static TerrainRegionData Create(RegionIdxStruct regionIdxStruct, TerrainListData listData)
	{
		TerrainRegionData terrainRegionData = ReferencePool.Acquire<TerrainRegionData>();
		terrainRegionData.name = listData.name;
		terrainRegionData.xIdx = regionIdxStruct.RegionX;
		terrainRegionData.zIdx = regionIdxStruct.RegionZ;
		terrainRegionData.terrainList = new List<string>(listData.terrainList.ToArray());
		return terrainRegionData;
	}

	public void Clear()
	{
		name = "";
		xIdx = -1;
		zIdx = -1;
		terrainList.Clear();
	}
}
