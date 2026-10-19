using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.World;
using UnityEngine;

namespace ACT.Model;

public class MapGridData
{
	public Vector2Int id;

	public HashSet<BakeStaticMapIconData> staticMapIconData;

	public HashSet<MapModelDynamicNpcData> dynamicNpcData;

	public HashSet<MissionPointData> missionPointData;

	public static MapGridData None => new MapGridData
	{
		id = Vector2Int.one * -1,
		staticMapIconData = new HashSet<BakeStaticMapIconData>(),
		dynamicNpcData = new HashSet<MapModelDynamicNpcData>(),
		missionPointData = new HashSet<MissionPointData>()
	};

	public void AddStaticInteractObjUid(BakeStaticMapIconData bakeData)
	{
		if (staticMapIconData == null)
		{
			staticMapIconData = new HashSet<BakeStaticMapIconData>();
		}
		staticMapIconData.Add(bakeData);
	}

	public void AddDynamicNpcData(MapModelDynamicNpcData dynamicNpcData)
	{
		if (this.dynamicNpcData == null)
		{
			this.dynamicNpcData = new HashSet<MapModelDynamicNpcData>();
		}
		this.dynamicNpcData.Add(dynamicNpcData);
	}

	public void RemoveDynamicNpcData(int npcUid)
	{
		dynamicNpcData?.RemoveWhere((MapModelDynamicNpcData _) => _.uid == npcUid);
	}

	public void AddMissionPointData(MissionPointData missionPointData)
	{
		if (this.missionPointData == null)
		{
			this.missionPointData = new HashSet<MissionPointData>();
		}
		this.missionPointData.Add(missionPointData);
	}

	public void RemoveMissionPointData(int pointId)
	{
		missionPointData?.RemoveWhere((MissionPointData _) => _.PointId == pointId);
	}
}
