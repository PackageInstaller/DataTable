using System.Collections.Generic;
using ACT.World;
using UnityEngine;

namespace ACT.UI;

public class LargeMapViewData : UIViewData
{
	public int unlockFogId;

	public List<int> unlockFogIds;

	public int wantTrackMonsterPointId;

	public int selectBossId;

	public int selectPointId;

	public int collectionPointId;

	public bool missionOpen;

	public bool AreaOpen;

	public MapArea initMapArea;

	public Vector3 initPosition;

	public int templeDungeonId;

	public int jumpNpcId;

	public bool templeAreaOpen;
}
