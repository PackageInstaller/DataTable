using ACT.Battle;
using ACT.Model;
using ACT.UI;
using Fundamental;

namespace ACT.World;

public class ExplorePosManager : GameSubManager
{
	private int _explorePosLogTickCount;

	public override ContextType ContextType => ContextType.GAME;

	protected override void Init()
	{
		_explorePosLogTickCount = 0;
	}

	protected override void UnInit()
	{
		_explorePosLogTickCount = 0;
	}

	protected override void Update()
	{
		base.Update();
		_explorePosLogTickCount++;
		if (_explorePosLogTickCount >= 2)
		{
			_explorePosLogTickCount = 0;
			RecordPlayerPos();
		}
	}

	private void RecordPlayerPos()
	{
		int activeWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		if (MonoECS.instance.mainEntity != null && MonoECS.instance.isStartWorld && Model<MapModel>.HasInstance() && Model<MapModel>.Interface.MainWorldDataInitFinish && activeWorldId == 3 && MapUtility.playerMapArea != MapArea.None && MapUtility.playerMapLayer != MapLayer.None && !GameLoader.meta.mapConfig.IsDefaultUnlockArea(MapUtility.playerMapArea))
		{
			if (MapUtility.CanLogLocalExplorePos(MapUtility.playerMapArea, MapUtility.playerChunkId, MapUtility.playerPos))
			{
				Model<MapModel>.Interface.AddLocalMapViewLogInfo(MapUtility.playerMapArea, MapUtility.playerChunkId, MapUtility.playerPos);
				Model<MapModel>.Interface.RequestExploreCompleteCheck(MapUtility.playerMapArea, MapUtility.playerChunkId);
			}
			if (MapUtility.CanLogSyncExplorePos(MapUtility.playerMapArea, MapUtility.playerChunkId, MapUtility.playerVector2IntPos))
			{
				MapUtility.LogSyncExplorePos(MapUtility.playerMapArea, MapUtility.playerChunkId, MapUtility.playerVector2IntPos);
			}
		}
	}
}
