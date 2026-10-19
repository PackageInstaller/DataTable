using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class MaterialTrackModel : Model<MaterialTrackModel>
{
	private int _trackEnemyId;

	private int _trackMonsterPointId;

	private ACT.World.MapArea _trackMonsterPointMapArea;

	private MapLayer _trackMonsterPointMapLayer;

	private int _trackCollectionPointId;

	private int _trackCollectionConfigId;

	private ACT.World.MapArea _trackCollectionPointMapArea;

	private Dictionary<int, EnemyTypeInfo> _enemyIdInfos;

	private Dictionary<int, List<EnemyTypeInfo>> _item2EnemyId;

	private List<int> enemyTypreRewardExclusiveItem = new List<int> { 1, 2 };

	public bool IsTrackingEnemyId => _trackEnemyId != 0;

	protected override void Init()
	{
		_trackEnemyId = 0;
		_trackMonsterPointId = 0;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, OnMonsterPointStateRefresh);
		if (_enemyIdInfos == null)
		{
			_enemyIdInfos = new Dictionary<int, EnemyTypeInfo>();
		}
		int i;
		foreach (KeyValuePair<int, EntityEnemyData> entityEnemyData2 in RuntimeConfigs.data.entityEnemyDatas)
		{
			entityEnemyData2.Deconstruct(out i, out var value);
			EntityEnemyData entityEnemyData = value;
			if (_enemyIdInfos.ContainsKey(entityEnemyData.id))
			{
				continue;
			}
			_enemyIdInfos.Add(entityEnemyData.id, new EnemyTypeInfo(entityEnemyData));
			int[] collectionId = entityEnemyData.collectionId;
			for (i = 0; i < collectionId.Length; i++)
			{
				Collection data = CoreUtils.GetData(collectionId[i], RuntimeConfigs.data.collections);
				if (data == null)
				{
					continue;
				}
				foreach (ItemKv item in data.certain)
				{
					_enemyIdInfos[entityEnemyData.id].reward.TryAdd(item.id);
				}
				foreach (ItemKv reward in data.rewards)
				{
					Reward data2 = CoreUtils.GetData(reward.id, RuntimeConfigs.data.rewards);
					if (data2 == null)
					{
						continue;
					}
					foreach (Maybe item2 in data2.dropItem)
					{
						_enemyIdInfos[entityEnemyData.id].reward.TryAdd(item2.id);
					}
				}
			}
			_enemyIdInfos[entityEnemyData.id].reward.Sort();
		}
		if (_item2EnemyId == null)
		{
			_item2EnemyId = new Dictionary<int, List<EnemyTypeInfo>>();
		}
		foreach (KeyValuePair<int, EnemyTypeInfo> enemyIdInfo in _enemyIdInfos)
		{
			enemyIdInfo.Deconstruct(out i, out var value2);
			EnemyTypeInfo enemyTypeInfo = value2;
			foreach (int item3 in enemyTypeInfo.reward)
			{
				if (_item2EnemyId.TryGetValue(item3, out var value3))
				{
					value3.Add(enemyTypeInfo);
					continue;
				}
				_item2EnemyId.Add(item3, new List<EnemyTypeInfo> { enemyTypeInfo });
			}
		}
	}

	protected override void UnInit()
	{
		_enemyIdInfos.Clear();
		_item2EnemyId.Clear();
		UnTrackEnemyType();
		UnTrackCollectionPoint();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, OnMonsterPointStateRefresh);
	}

	public EnemyType GetMonsterTypeEnemyType(int enemyId)
	{
		if (!_enemyIdInfos.TryGetValue(enemyId, out var value))
		{
			return EnemyType.None;
		}
		return value.enemyType;
	}

	public ACT.World.MapArea GetEnemyTypeArea(int enemyId)
	{
		if (!_enemyIdInfos.TryGetValue(enemyId, out var value))
		{
			return ACT.World.MapArea.None;
		}
		return value.enemyArea;
	}

	public int GetMonsterTypeIconAtlasId(int enemyId)
	{
		return CoreUtils.GetData(enemyId, RuntimeConfigs.data.entityEnemyDatas)?.monsterIcon ?? 0;
	}

	public int GetMonsterTypeName(int enemyId)
	{
		if (!_enemyIdInfos.TryGetValue(enemyId, out var value))
		{
			return 0;
		}
		return value.typeName;
	}

	public int GetMonsterTypeDescribe(int enemyId)
	{
		if (!_enemyIdInfos.TryGetValue(enemyId, out var value))
		{
			return 0;
		}
		return value.typeDescribe;
	}

	public void GetMonsterTypeReward(int enemyId, out List<int> reward)
	{
		reward = (_enemyIdInfos.TryGetValue(enemyId, out var value) ? value.reward : null);
	}

	public int GetMonsterTypeRegion(int enemyId)
	{
		if (!_enemyIdInfos.TryGetValue(enemyId, out var value))
		{
			return 0;
		}
		return value.enemyRegion;
	}

	public void GerMonsterTypeInfoByItemId(int itemId, out List<EnemyTypeInfo> enemyIdInfo)
	{
		enemyIdInfo = _item2EnemyId.GetValueOrDefault(itemId);
	}

	public int GetWorldBossId(int enemyId)
	{
		if (!_enemyIdInfos.TryGetValue(enemyId, out var value))
		{
			return 0;
		}
		return value.worldBossId;
	}

	public int GetTrackEnemyId()
	{
		return _trackEnemyId;
	}

	public int GetTrackMonsterPointId()
	{
		return _trackMonsterPointId;
	}

	public void TrackEnemyPoint(LargeMapMonsterPointIcon monsterPointIcon)
	{
		if (!(monsterPointIcon == null))
		{
			if (Model<TrackModel>.Interface.IsTrackingCollectionPoint)
			{
				UnTrackCollectionPoint();
			}
			_trackEnemyId = monsterPointIcon.GetEnemyId();
			_trackMonsterPointId = monsterPointIcon.GetUid();
			Model<TrackModel>.Interface.TrackMonsterPoint(monsterPointIcon.GetUid());
		}
	}

	public void GetCollectionPointRewardType(int configId, out List<int> reward)
	{
		List<int> list = new List<int>();
		CollectionPoint data = CoreUtils.GetData(configId, RuntimeConfigs.data.collectionPoints);
		if (data != null)
		{
			foreach (ItemKv item in data.collectionId)
			{
				Collection data2 = CoreUtils.GetData(item.id, RuntimeConfigs.data.collections);
				if (data2 == null)
				{
					continue;
				}
				foreach (ItemKv item2 in data2.certain)
				{
					list.Add(item2.id);
				}
			}
		}
		reward = list;
	}

	public void TrackCollectionPoint(LargeMapCollectionPointIcon collectionPointIcon)
	{
		if (!(collectionPointIcon == null))
		{
			if (Model<TrackModel>.Interface.IsTrackingMonsterPoint)
			{
				UnTrackEnemyType();
			}
			_trackCollectionConfigId = collectionPointIcon.GetConfigId();
			_trackCollectionPointId = collectionPointIcon.GetId();
			_trackCollectionPointMapArea = collectionPointIcon.mapArea;
			Model<TrackModel>.Interface.TrackCollectPoint(collectionPointIcon.GetId());
		}
	}

	public CollectionTrackPointData GetFirstCollectionPoint(List<CollectionTrackPointData> collectionTrackPointDatas, Vector3 playerWorldPos)
	{
		if (collectionTrackPointDatas == null || collectionTrackPointDatas.Count == 0)
		{
			return null;
		}
		float num = float.MaxValue;
		CollectionTrackPointData result = null;
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		foreach (CollectionTrackPointData collectionTrackPointData in collectionTrackPointDatas)
		{
			if (!MapUtility.AreaUnlock(collectionTrackPointData.mapArea))
			{
				continue;
			}
			StateWorldAssetData worldStateAssetDataBySGOID = worldManager.GetWorldStateAssetDataBySGOID(collectionTrackPointData.collectionPointId);
			if (worldStateAssetDataBySGOID.stateId == 0)
			{
				float num2 = Vector3.Distance(worldStateAssetDataBySGOID.initPos, playerWorldPos);
				if (num2 < num)
				{
					num = num2;
					result = collectionTrackPointData;
				}
			}
		}
		return result;
	}

	public CollectionTrackPointData GetFirstCanGetRewardCollectionPointData(int collectionConfigId)
	{
		List<CollectionTrackPointData> collectionPointsByConfigId = MapUtility.ConfigWorldMapGraph.GetCollectionPointsByConfigId(collectionConfigId);
		int num = int.MaxValue;
		CollectionTrackPointData result = null;
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		foreach (CollectionTrackPointData item in collectionPointsByConfigId)
		{
			if (!MapUtility.AreaUnlock(item.mapArea))
			{
				continue;
			}
			CoreUtils.TryGetServiceCleanedTs(worldManager.ActiveWorldId, item.collectionPointId, out var cleanedTs);
			if (MonoECS.instance.ruleManager.SharedGetState(item.collectionPointId) == 1 && MonoECS.instance.ruleManager.GetStateWorldAssetData(item.collectionPointId) is CollectionPointData && RuntimeConfigs.data.collectionPoints.TryGetValue(item.collectionPointConfigId, out var value) && RuntimeConfigs.data.enemyRespawnRules.TryGetValue(value.rule, out var value2) && value2.respawn)
			{
				int num2 = cleanedTs + value2.countdonw - CoreUtils.UnixTimeSeconds();
				if (num2 < num)
				{
					num = num2;
					result = item;
				}
			}
		}
		return result;
	}

	public CollectionTrackPointData GetActiveMinAreaIdCollectionPointData(int collectionConfigId)
	{
		List<CollectionTrackPointData> collectionPointsByConfigId = MapUtility.ConfigWorldMapGraph.GetCollectionPointsByConfigId(collectionConfigId);
		if (collectionPointsByConfigId == null || collectionPointsByConfigId.Count == 0)
		{
			return null;
		}
		CollectionTrackPointData result = null;
		int num = int.MaxValue;
		foreach (CollectionTrackPointData item in collectionPointsByConfigId)
		{
			if (MonoECS.instance.ruleManager.SharedGetState(item.collectionPointId) == 0 && MonoECS.instance.ruleManager.GetStateWorldAssetData(item.collectionPointId) is CollectionPointData { mapSubArea: not MapSubArea.Unknow } && (int)item.mapArea < num)
			{
				num = (int)item.mapArea;
				result = item;
			}
		}
		return result;
	}

	private (bool hasTargetMonsterPoint, MonsterTrackPointData targetTrackMonsterPointData) GetFirstMonsterPoint(List<MonsterTrackPointData> dataList, Vector3 playerWorldPos)
	{
		bool item = false;
		float num = float.MaxValue;
		MonsterTrackPointData item2 = null;
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		foreach (MonsterTrackPointData data in dataList)
		{
			if (!MapUtility.AreaUnlock(data.mapArea) || !CheckMonsterPointInWorldLevel(data.monsterPointConfigId) || !MonsterPointIsShow(data.monsterPointUid))
			{
				continue;
			}
			StateWorldAssetData worldStateAssetDataBySGOID = worldManager.GetWorldStateAssetDataBySGOID(data.monsterPointUid);
			if (worldStateAssetDataBySGOID != null)
			{
				float num2 = Vector3.Distance(worldStateAssetDataBySGOID.initPos, playerWorldPos);
				if (num2 < num)
				{
					item = true;
					num = num2;
					item2 = data;
				}
			}
		}
		return (hasTargetMonsterPoint: item, targetTrackMonsterPointData: item2);
	}

	public void UnTrackEnemyType(bool canSendEvents = true)
	{
		if (_trackEnemyId != 0)
		{
			_trackEnemyId = 0;
			_trackMonsterPointId = 0;
			_trackMonsterPointMapArea = ACT.World.MapArea.None;
			_trackMonsterPointMapLayer = MapLayer.None;
			Model<TrackModel>.Interface.UnTrackMonsterPoint(canSendEvents);
		}
	}

	public void UnTrackCollectionPoint(bool canSendEvents = true)
	{
		if (_trackCollectionPointId != 0)
		{
			_trackCollectionConfigId = 0;
			_trackCollectionPointId = 0;
			_trackCollectionPointMapArea = ACT.World.MapArea.None;
			Model<TrackModel>.Interface.UnTrackCollectPoint(canSendEvents);
		}
	}

	public MonsterTrackPointData GetFirstMonsterPointDataByEnemyId(int enemyId)
	{
		return GetFirstMonsterPointDataByEnemyId(enemyId, MapUtility.playerPos);
	}

	private MonsterTrackPointData GetFirstMonsterPointDataByEnemyId(int enemyId, Vector3 playerWorldPos)
	{
		List<MonsterTrackPointData> allMonsterTrackPointDataByEnemyId = GetAllMonsterTrackPointDataByEnemyId(enemyId);
		if (allMonsterTrackPointDataByEnemyId == null)
		{
			return null;
		}
		var (flag, result) = GetFirstMonsterPoint(allMonsterTrackPointDataByEnemyId, playerWorldPos);
		if (flag)
		{
			return result;
		}
		return null;
	}

	public List<MonsterTrackPointData> GetAllMonsterTrackPointDataByEnemyId(int enemyId)
	{
		if (MapUtility.ConfigWorldMapGraph == null)
		{
			return null;
		}
		if (!RuntimeConfigs.data.entityEnemyDatas.ContainsKey(enemyId))
		{
			return null;
		}
		return MapUtility.ConfigWorldMapGraph.GetMonsterPointsByEntityEnemyId(enemyId);
	}

	public List<MonsterTrackPointData> GetShowMonsterTrackPointDataByEnemyIdAndArea(int enemyId, ACT.World.MapArea area)
	{
		List<MonsterTrackPointData> list = new List<MonsterTrackPointData>();
		List<MonsterTrackPointData> allMonsterTrackPointDataByEnemyId = GetAllMonsterTrackPointDataByEnemyId(enemyId);
		if (allMonsterTrackPointDataByEnemyId == null)
		{
			return list;
		}
		foreach (MonsterTrackPointData item in allMonsterTrackPointDataByEnemyId)
		{
			if (item.mapArea == area && MonsterPointIsShow(item.monsterPointUid) && CheckMonsterPointInWorldLevel(item.monsterPointConfigId))
			{
				list.Add(item);
			}
		}
		return list;
	}

	public Dictionary<MapSubArea, List<MonsterTrackPointData>> GetShowMonsterTrackPointDataGroupBySubArea(int enemyId, ACT.World.MapArea area)
	{
		Dictionary<MapSubArea, List<MonsterTrackPointData>> dictionary = new Dictionary<MapSubArea, List<MonsterTrackPointData>>();
		List<MonsterTrackPointData> showMonsterTrackPointDataByEnemyIdAndArea = GetShowMonsterTrackPointDataByEnemyIdAndArea(enemyId, area);
		if (showMonsterTrackPointDataByEnemyIdAndArea == null)
		{
			return dictionary;
		}
		foreach (MonsterTrackPointData item in showMonsterTrackPointDataByEnemyIdAndArea)
		{
			if (item.subAreaId != MapSubArea.Unknow)
			{
				MapSubArea subAreaId = item.subAreaId;
				if (!dictionary.TryGetValue(subAreaId, out var value))
				{
					value = (dictionary[subAreaId] = new List<MonsterTrackPointData>());
				}
				value.Add(item);
			}
		}
		return dictionary;
	}

	public bool MonsterPointIsShow(int monsterPointUid)
	{
		if (!(Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(monsterPointUid) is MonsterPointData monsterPointData))
		{
			return false;
		}
		if (monsterPointData.stateId == 0)
		{
			return monsterPointData.mapSubArea != MapSubArea.Unknow;
		}
		return false;
	}

	public MonsterTrackPointData GetFirstCanGetRewardMaterialTrackMonsterPointData(int enemyId)
	{
		List<MonsterTrackPointData> allMonsterTrackPointDataByEnemyId = GetAllMonsterTrackPointDataByEnemyId(enemyId);
		int num = 60;
		MonsterTrackPointData result = null;
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		foreach (MonsterTrackPointData item in allMonsterTrackPointDataByEnemyId)
		{
			if (!MapUtility.AreaUnlock(item.mapArea) || !CheckMonsterPointInWorldLevel(item.monsterPointConfigId))
			{
				continue;
			}
			CoreUtils.TryGetServiceCleanedTs(worldManager.ActiveWorldId, item.monsterPointUid, out var cleanedTs);
			if (MonoECS.instance.ruleManager.SharedGetState(item.monsterPointUid) == 1 && MonoECS.instance.ruleManager.GetStateWorldAssetData(item.monsterPointUid) is MonsterPointData { mapSubArea: not MapSubArea.Unknow } monsterPointData && RuntimeConfigs.data.enemySpawns.TryGetValue(monsterPointData.monsterPointId, out var value) && RuntimeConfigs.data.enemyRespawnRules.TryGetValue(value.rule, out var value2) && value2.respawn)
			{
				int num2 = cleanedTs + value2.countdonw - CoreUtils.UnixTimeSeconds();
				if (num2 < num)
				{
					num = num2;
					result = item;
				}
			}
		}
		return result;
	}

	public bool CheckMonsterPointInWorldLevel(int monsterPointConfigId)
	{
		EnemySpawn data = CoreUtils.GetData(monsterPointConfigId, RuntimeConfigs.data.enemySpawns);
		_ = data.worldEnemyLevel;
		_ = data.enemyLevelType;
		return true;
	}

	public MonsterTrackPointData GetActiveMinAreaIdMaterialTrackMonsterPointData(int enemyId)
	{
		List<MonsterTrackPointData> allMonsterTrackPointDataByEnemyId = GetAllMonsterTrackPointDataByEnemyId(enemyId);
		if (allMonsterTrackPointDataByEnemyId == null)
		{
			return null;
		}
		int num = int.MaxValue;
		MonsterTrackPointData monsterTrackPointData = null;
		foreach (MonsterTrackPointData item in allMonsterTrackPointDataByEnemyId)
		{
			if (MonoECS.instance.ruleManager.SharedGetState(item.monsterPointUid) == 0 && MonoECS.instance.ruleManager.GetStateWorldAssetData(item.monsterPointUid) is MonsterPointData { mapSubArea: not MapSubArea.Unknow })
			{
				if (monsterTrackPointData == null)
				{
					num = (int)item.mapArea;
					monsterTrackPointData = item;
				}
				else if (!MapUtility.AreaUnlock(monsterTrackPointData.mapArea) && MapUtility.AreaUnlock(item.mapArea))
				{
					num = (int)item.mapArea;
					monsterTrackPointData = item;
				}
				else if (MapUtility.AreaUnlock(monsterTrackPointData.mapArea) && MapUtility.AreaUnlock(item.mapArea) && (int)item.mapArea < num)
				{
					num = (int)item.mapArea;
					monsterTrackPointData = item;
				}
			}
		}
		return monsterTrackPointData;
	}

	public Dictionary<MapSubArea, List<CollectionTrackPointData>> GetCollectionPointDataByConfigIdAndArea(int collectionPointConfigId, ACT.World.MapArea area)
	{
		Dictionary<MapSubArea, List<CollectionTrackPointData>> dictionary = new Dictionary<MapSubArea, List<CollectionTrackPointData>>();
		if (MapUtility.ConfigWorldMapGraph == null)
		{
			return dictionary;
		}
		List<CollectionTrackPointData> collectionPointsByConfigId = MapUtility.ConfigWorldMapGraph.GetCollectionPointsByConfigId(collectionPointConfigId);
		if (collectionPointsByConfigId == null)
		{
			return dictionary;
		}
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		foreach (CollectionTrackPointData item in collectionPointsByConfigId)
		{
			if (item.mapArea == area && worldManager.GetWorldStateAssetDataBySGOID(item.collectionPointId).stateId == 0)
			{
				MapSubArea subAreaId = item.subAreaId;
				if (!dictionary.TryGetValue(subAreaId, out var value))
				{
					value = (dictionary[subAreaId] = new List<CollectionTrackPointData>());
				}
				value.Add(item);
			}
		}
		return dictionary;
	}

	private void OnMonsterPointStateRefresh(BaseEventContent evt)
	{
		ServiceStateRefresh serviceStateRefresh = evt as ServiceStateRefresh;
		int stateId;
		if (serviceStateRefresh.swid == _trackMonsterPointId)
		{
			stateId = serviceStateRefresh.stateId;
			if (stateId == 1 || stateId == -2)
			{
				MonsterTrackPointData firstMonsterPointDataByEnemyId = GetFirstMonsterPointDataByEnemyId(_trackEnemyId);
				if (firstMonsterPointDataByEnemyId == null)
				{
					UnTrackEnemyType();
				}
				else
				{
					_trackMonsterPointId = firstMonsterPointDataByEnemyId.monsterPointUid;
					Model<TrackModel>.Interface.TrackMonsterPoint(_trackMonsterPointId);
				}
			}
		}
		if (serviceStateRefresh.swid != _trackCollectionPointId)
		{
			return;
		}
		stateId = serviceStateRefresh.stateId;
		if (stateId == 1 || stateId == -2)
		{
			List<CollectionTrackPointData> collectionTrackPointDatas = MapUtility.ConfigWorldMapGraph?.GetCollectionPointsByConfigId(_trackCollectionConfigId);
			CollectionTrackPointData firstCollectionPoint = GetFirstCollectionPoint(collectionTrackPointDatas, MapUtility.playerPos);
			if (firstCollectionPoint == null)
			{
				UnTrackCollectionPoint();
				return;
			}
			_trackCollectionConfigId = firstCollectionPoint.collectionPointConfigId;
			_trackCollectionPointId = firstCollectionPoint.collectionPointId;
			_trackCollectionPointMapArea = firstCollectionPoint.mapArea;
			Model<TrackModel>.Interface.TrackCollectPoint(firstCollectionPoint.collectionPointId);
		}
	}
}
