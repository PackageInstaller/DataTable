using System;
using System.Collections.Generic;
using ACT.World.Asset;
using UnityEngine;

namespace ACT.World;

[Serializable]
public class MaterialTrackTransferData
{
	public int enemyTypeId;

	public int transferId;

	public MapArea transferMapArea;

	public Vector3 transferWorldPos;

	public Dictionary<MonsterPointCollectionLevel, List<MonsterTrackPointData>> eachLevelMonsterPoint;

	public MaterialTrackTransferData()
	{
		eachLevelMonsterPoint = new Dictionary<MonsterPointCollectionLevel, List<MonsterTrackPointData>>();
		eachLevelMonsterPoint.Add(MonsterPointCollectionLevel.L1, new List<MonsterTrackPointData>());
		eachLevelMonsterPoint.Add(MonsterPointCollectionLevel.L2, new List<MonsterTrackPointData>());
		eachLevelMonsterPoint.Add(MonsterPointCollectionLevel.L3, new List<MonsterTrackPointData>());
	}

	public void AddMonsterPoint(MonsterPointData monsterPointData)
	{
		MonsterPointCollectionLevel monsterPointCollectionLevel = TransferLinkTrackMonsterPointRule.GetMonsterPointCollectionLevel(Vector3.Distance(transferWorldPos, monsterPointData.initPos));
		if (monsterPointCollectionLevel != MonsterPointCollectionLevel.None)
		{
			eachLevelMonsterPoint[monsterPointCollectionLevel].Add(new MonsterTrackPointData
			{
				monsterPointUid = monsterPointData.stateWorldAssetUid,
				subAreaId = monsterPointData.mapSubArea,
				mapArea = monsterPointData.mapArea
			});
		}
	}
}
