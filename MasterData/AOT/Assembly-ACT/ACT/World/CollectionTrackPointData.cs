using System;
using UnityEngine;

namespace ACT.World;

[Serializable]
public class CollectionTrackPointData
{
	public int collectionPointId;

	public int collectionPointConfigId;

	public MapSubArea subAreaId;

	public MapArea mapArea;

	public Vector3 worldPos;
}
