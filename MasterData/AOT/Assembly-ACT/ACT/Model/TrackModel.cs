using System;
using ACT.World;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class TrackModel : Model<TrackModel>
{
	private int _trackMonsterPointId;

	private Vector3 _trackMonsterPointWorldPos;

	private MapAreaLayerInfo _trackMonsterPointAreaLayerInfo;

	private int _trackCollectionPointId;

	private int _trackCollectionPointConfigId;

	private Vector3 _trackCollectionPointWorldPos;

	private MapArea _trackCollectionPointArea;

	private const int TrackCollectionPointSpriteId = 10904;

	private Action _onTrackMonsterPointChanged;

	private Action _onTrackCollectionPointChanged;

	public bool IsTrackingMonsterPoint => _trackMonsterPointId != 0;

	public bool IsTrackingCollectionPoint => _trackCollectionPointId != 0;

	public bool IsTrackingPoint
	{
		get
		{
			if (_trackMonsterPointId == 0)
			{
				return _trackCollectionPointId != 0;
			}
			return true;
		}
	}

	public event Action OnTrackMonsterPointChanged
	{
		add
		{
			_onTrackMonsterPointChanged = (Action)Delegate.Combine(_onTrackMonsterPointChanged, value);
		}
		remove
		{
			_onTrackMonsterPointChanged = (Action)Delegate.Remove(_onTrackMonsterPointChanged, value);
		}
	}

	public event Action OnTrackCollectionPointChanged
	{
		add
		{
			_onTrackCollectionPointChanged = (Action)Delegate.Combine(_onTrackCollectionPointChanged, value);
		}
		remove
		{
			_onTrackCollectionPointChanged = (Action)Delegate.Remove(_onTrackCollectionPointChanged, value);
		}
	}

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	public int GetTrackMonsterPointId()
	{
		return _trackMonsterPointId;
	}

	public int GetTrackCollectionPointId()
	{
		return _trackCollectionPointId;
	}

	public int GetTrackCollectionPointConfigId()
	{
		return _trackCollectionPointConfigId;
	}

	public Vector3 GetTrackMonsterPointWorldPos()
	{
		return _trackMonsterPointWorldPos;
	}

	public Vector3 GetTrackCollectionPointWorldPos()
	{
		return _trackCollectionPointWorldPos;
	}

	public MapArea GetTrackMonsterPointMapArea()
	{
		return _trackMonsterPointAreaLayerInfo.mapArea;
	}

	public MapArea GetTrackCollectionMapArea()
	{
		return _trackCollectionPointArea;
	}

	public int GetTrackCollectionSpriteId()
	{
		return 10904;
	}

	public MapLayer GetTrackMonsterPointMapLayer()
	{
		return _trackMonsterPointAreaLayerInfo.mapLayer;
	}

	public MapArea TrackingPointArea()
	{
		if (_trackMonsterPointId != 0)
		{
			return GetTrackMonsterPointMapArea();
		}
		if (_trackCollectionPointId != 0)
		{
			return GetTrackCollectionMapArea();
		}
		return MapArea.None;
	}

	public void TrackMonsterPoint(int monsterPointUid)
	{
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(monsterPointUid);
		if (worldStateAssetDataBySGOID != null)
		{
			_trackMonsterPointId = monsterPointUid;
			_trackMonsterPointWorldPos = worldStateAssetDataBySGOID.initPos;
			StateWorldAssetData worldStateAssetDataBySGOID2 = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(worldStateAssetDataBySGOID.stateWorldAssetUid);
			_trackMonsterPointAreaLayerInfo.mapArea = worldStateAssetDataBySGOID2.mapArea;
			_trackMonsterPointAreaLayerInfo.mapLayer = MapLayer.L0;
			_onTrackMonsterPointChanged?.Invoke();
		}
	}

	public void UnTrackMonsterPoint(bool canSendEvents = true)
	{
		_trackMonsterPointId = 0;
		_trackMonsterPointWorldPos = Vector3.zero;
		_trackMonsterPointAreaLayerInfo.mapArea = MapArea.None;
		_trackMonsterPointAreaLayerInfo.mapLayer = MapLayer.None;
		if (canSendEvents)
		{
			_onTrackMonsterPointChanged?.Invoke();
		}
	}

	public void TrackCollectPoint(int collectPointUid)
	{
		if (Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(collectPointUid) is CollectionPointData collectionPointData)
		{
			_trackCollectionPointId = collectPointUid;
			_trackCollectionPointConfigId = collectionPointData.collectionPointId;
			_trackCollectionPointWorldPos = collectionPointData.initPos;
			_trackCollectionPointArea = collectionPointData.mapArea;
			_onTrackCollectionPointChanged?.Invoke();
		}
	}

	public void UnTrackCollectPoint(bool canSendEvents = true)
	{
		_trackCollectionPointId = 0;
		_trackCollectionPointWorldPos = Vector3.zero;
		_trackCollectionPointArea = MapArea.None;
		_trackCollectionPointConfigId = 0;
		if (canSendEvents)
		{
			_onTrackCollectionPointChanged?.Invoke();
		}
	}

	public void SendCollectionPointChanged()
	{
		_onTrackCollectionPointChanged?.Invoke();
	}

	public void SendMonsterPointChanged()
	{
		_onTrackMonsterPointChanged?.Invoke();
	}
}
