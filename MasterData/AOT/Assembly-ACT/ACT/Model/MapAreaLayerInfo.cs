using System;
using ACT.World;

namespace ACT.Model;

[Serializable]
public struct MapAreaLayerInfo(MapArea mapArea)
{
	public MapArea mapArea = mapArea;

	public MapLayer mapLayer = MapLayer.L0;

	public static MapAreaLayerInfo None => new MapAreaLayerInfo
	{
		mapArea = MapArea.None,
		mapLayer = MapLayer.L0
	};

	public void SetMapAreaLayerInfo(MapArea mapArea)
	{
		this.mapArea = mapArea;
	}

	public static bool operator ==(MapAreaLayerInfo struct1, MapAreaLayerInfo struct2)
	{
		return struct1.mapArea == struct2.mapArea;
	}

	public static bool operator !=(MapAreaLayerInfo struct1, MapAreaLayerInfo struct2)
	{
		return struct1.mapArea != struct2.mapArea;
	}

	public static implicit operator (MapArea, MapLayer)(MapAreaLayerInfo info)
	{
		return (info.mapArea, info.mapLayer);
	}
}
