using System;
using UnityEngine;

namespace ACT.World;

[Serializable]
public class MonsterTrackPointData
{
	public int monsterPointUid;

	public int monsterPointConfigId;

	public int entityEnemyId;

	public MapSubArea subAreaId;

	public MapArea mapArea;

	public Vector3 worldPos;
}
