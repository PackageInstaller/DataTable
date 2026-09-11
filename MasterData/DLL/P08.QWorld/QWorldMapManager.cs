using System.Collections.Generic;
using P08.QWorld.Misc;
using UnityEngine;

public class QWorldMapManager
{
	public static int NewElementId = 10000;

	private QWorldMapData map_data;

	public int map_id;

	public List<QWorldMapEntity> elementList;

	private Dictionary<int, QWorldMapEntity> elementDict;

	private Queue<int> elementIdPool;

	public QWorldMapManager()
	{
		elementList = new List<QWorldMapEntity>();
		elementIdPool = new Queue<int>();
		elementDict = new Dictionary<int, QWorldMapEntity>();
	}

	public void Init(QWorldMapData mapData)
	{
		map_data = mapData;
		foreach (QWorldThingEntityData thingEntityData in mapData.thingEntityDatas)
		{
			if (thingEntityData.spawn_type == QworldEntitySpawnType.Always)
			{
				LuaHelper.CallFunction("QWorldSpawnPrefab", thingEntityData.script_name, thingEntityData.id, thingEntityData.configId);
			}
			else if (QworldEntitySpawnType.Aftser_Task_Over == thingEntityData.spawn_type)
			{
				LuaHelper.CallFunction("QWorldSpawnPrefabAterQuestId", thingEntityData.spawn_task_id, thingEntityData.id);
			}
		}
		foreach (QWorldTeleportEntityData teleportEntityData in mapData.teleportEntityDatas)
		{
			QWorldScene.Scene.teleportManager.RegisterTeleport(teleportEntityData.type, new TeleportContext
			{
				id = teleportEntityData.id,
				position = teleportEntityData.position,
				rotation = teleportEntityData.rotation,
				teleportType = teleportEntityData.type
			});
		}
		QWorldLODControlledLogicScheduler lodComScheduler = QWorldScene.Scene.lodComScheduler;
		foreach (QWorldBirdGroupData birdData in mapData.birdDatas)
		{
			lodComScheduler.RegisterLogic(QWorldEntityDataMono<QWorldBirdGroupData>.CreateFromData<QWorldBirdsOnGround>(birdData));
		}
		foreach (QWorldWalkingPeopleGroupData walkingPeopleData in mapData.walkingPeopleDatas)
		{
			lodComScheduler.RegisterLogic(QWorldEntityDataMono<QWorldWalkingPeopleGroupData>.CreateFromData<QWorldWalkingPeopleGroup>(walkingPeopleData));
		}
		foreach (QWorldPopMsgPeopleGroupData popMsgPeopleData in mapData.popMsgPeopleDatas)
		{
			lodComScheduler.RegisterLogic(QWorldEntityDataMono<QWorldPopMsgPeopleGroupData>.CreateFromData<QWorldPopMsgPeopleGroup>(popMsgPeopleData));
		}
		foreach (QWorldBubbleMgrData npcTalkingDatum in mapData.npcTalkingData)
		{
			lodComScheduler.RegisterLogic(QWorldEntityDataMono<QWorldBubbleMgrData>.CreateFromData<QWorldTalkBubbleMgr>(npcTalkingDatum));
		}
	}

	public void Dispose()
	{
		int count = elementList.Count;
		for (int i = 0; i < count; i++)
		{
			QWorldMapEntity mapEnity = elementList[i];
			ReleaseElement(mapEnity);
		}
		elementList = null;
	}

	public QWorldMapEntity GetMapEntityByEntityId(int entityId)
	{
		if (entityId == 0)
		{
			return null;
		}
		_ = elementList.Count;
		elementDict.TryGetValue(entityId, out var value);
		return value;
	}

	public QWorldMapEntity CreateMapEntity(int entityId)
	{
		GameObject gameObject = new GameObject("entity");
		QWorldMapEntity qWorldMapEntity = U3DUtil.Get<QWorldMapEntity>(gameObject);
		QWAgent qWAgent = gameObject.AddComponent<QWAgent>();
		gameObject.AddComponent<QWBlackboard>();
		gameObject.AddComponent<QWBubbleBehvaiour>();
		gameObject.AddComponent<QWHudBehaviour>();
		qWorldMapEntity.Init();
		if (entityId != 0)
		{
			QWorldThingEntityData mapEntityData = GetMapEntityData(entityId);
			if (mapEntityData != null)
			{
				qWorldMapEntity.InitEntityData(mapEntityData);
			}
		}
		qWAgent.Initialize();
		AddElement(qWorldMapEntity);
		return qWorldMapEntity;
	}

	public QWorldMapEntity CreateNpcEntity(int entityId)
	{
		GameObject gameObject = Asset.Instantiate("QWWorld/NPC/QW_NPC_ROOT");
		QWorldMapEntity qWorldMapEntity = U3DUtil.Get<QWorldMapEntity>(gameObject);
		qWorldMapEntity.Init();
		QWorldThingEntityData qWorldThingEntityData = null;
		if (entityId != 0)
		{
			qWorldThingEntityData = GetMapEntityData(entityId);
			if (qWorldThingEntityData != null)
			{
				qWorldMapEntity.InitEntityData(qWorldThingEntityData);
			}
		}
		QWNPCAgent component = gameObject.GetComponent<QWNPCAgent>();
		component.Initialize();
		AddElement(qWorldMapEntity);
		if (qWorldThingEntityData != null && qWorldThingEntityData.customIdle != null)
		{
			component.NpcBlackBoard.locomotion.AppendState(qWorldThingEntityData.customIdle);
		}
		return qWorldMapEntity;
	}

	public QWorldMapEntity CreateFunitureEntity(int entityId)
	{
		GameObject gameObject = Asset.Instantiate("QWWorld/Furniture/QWFurniture");
		QWorldMapEntity qWorldMapEntity = U3DUtil.Get<QWorldMapEntity>(gameObject);
		qWorldMapEntity.Init();
		if (entityId != 0)
		{
			QWorldThingEntityData mapEntityData = GetMapEntityData(entityId);
			if (mapEntityData != null)
			{
				qWorldMapEntity.InitEntityData(mapEntityData);
			}
		}
		gameObject.GetComponent<QWFurnitureAgent>().Initialize();
		AddElement(qWorldMapEntity);
		return qWorldMapEntity;
	}

	public QWorldMapEntity CreateZoneEntity(int entityId)
	{
		if (entityId == 0)
		{
			return null;
		}
		QWorldThingEntityData mapEntityData = GetMapEntityData(entityId);
		if (!(mapEntityData?.otherData is QWorldZoneDeviceEntityData qWorldZoneDeviceEntityData))
		{
			return null;
		}
		GameObject gameObject = new GameObject("Zone");
		QWorldMapEntity qWorldMapEntity = U3DUtil.Get<QWorldMapEntity>(gameObject);
		gameObject.AddComponent<QWAgent>();
		qWorldMapEntity.Init();
		qWorldMapEntity.InitEntityData(mapEntityData);
		if (qWorldZoneDeviceEntityData is QWorldVolumeDeviceEntityData qWorldVolumeDeviceEntityData)
		{
			QWVolumeDevice qWVolumeDevice = gameObject.AddComponent<QWVolumeDevice>();
			qWVolumeDevice.zoneId = mapEntityData.id;
			qWVolumeDevice.volumeSize = qWorldVolumeDeviceEntityData.volumeSize;
		}
		else if (qWorldZoneDeviceEntityData is QWorldCapsuleDeviceEntityData qWorldCapsuleDeviceEntityData)
		{
			QWCapsuleDevice qWCapsuleDevice = gameObject.AddComponent<QWCapsuleDevice>();
			qWCapsuleDevice.zoneId = mapEntityData.id;
			qWCapsuleDevice.height = qWorldCapsuleDeviceEntityData.height;
			qWCapsuleDevice.radius = qWorldCapsuleDeviceEntityData.radius;
		}
		AddElement(qWorldMapEntity);
		return qWorldMapEntity;
	}

	public QWorldThingEntityData GetMapEntityData(int entityId)
	{
		if (null != map_data)
		{
			foreach (QWorldThingEntityData thingEntityData in map_data.thingEntityDatas)
			{
				if (thingEntityData.id == entityId)
				{
					return thingEntityData;
				}
			}
		}
		return null;
	}

	public QWorldPatrolPathDeviceEntityData GetPatrolPath(int entityId)
	{
		if (map_data != null)
		{
			foreach (QWorldPatrolPathDeviceEntityData patrolPathEntityData in map_data.patrolPathEntityDatas)
			{
				if (patrolPathEntityData.id == entityId)
				{
					return patrolPathEntityData;
				}
			}
		}
		return null;
	}

	private void AddElement(QWorldMapEntity mapEnity)
	{
		if (elementIdPool.Count > 0)
		{
			mapEnity.uniqueId = elementIdPool.Dequeue();
		}
		else
		{
			mapEnity.uniqueId = NewElementId++;
		}
		elementList.Add(mapEnity);
		if (!elementDict.ContainsKey(mapEnity.entityId))
		{
			elementDict.Add(mapEnity.entityId, mapEnity);
		}
		QwLodMgr.AddLodObject(mapEnity);
	}

	public void RemoveMapElement(QWorldMapEntity mapEnity)
	{
		RemoveByUniqueId(mapEnity.uniqueId);
	}

	public bool RemoveByUniqueId(int uniqueId)
	{
		if (uniqueId == 0)
		{
			return false;
		}
		int count = elementList.Count;
		for (int i = 0; i < count; i++)
		{
			QWorldMapEntity qWorldMapEntity = elementList[i];
			if (uniqueId == qWorldMapEntity.uniqueId)
			{
				elementList.RemoveAt(i);
				ReleaseElement(qWorldMapEntity);
				return true;
			}
		}
		return false;
	}

	private void ReleaseElement(QWorldMapEntity mapEnity)
	{
		if (null == mapEnity)
		{
			Debug.LogWarning("Release Empty Element");
			return;
		}
		if (mapEnity.uniqueId > 0)
		{
			elementIdPool.Enqueue(mapEnity.uniqueId);
		}
		QwLodMgr.RemoveLodObject(mapEnity);
		mapEnity.Dispose();
		elementDict.Remove(mapEnity.entityId);
		Object.Destroy(mapEnity.gameObject);
	}
}
