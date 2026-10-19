using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.Localization.Settings;
using Utility;

namespace ACT.UI;

public static class MapUtility
{
	public static ConfigWorldMapGraphData ConfigWorldMapGraph;

	public const int gridLength = 512;

	public const float gridWordLength = 51.2f;

	private static Vector3[] worldCorner = new Vector3[4];

	private static int sideLength = RuntimeConfigs.data.game.MistPointUnitDensity * RuntimeConfigs.data.game.MistPointUnitRatio;

	private static int pointSpace = RuntimeConfigs.data.game.MistPointUnitDensity;

	private static Vector2Int compareDisatanceGridId = Vector2Int.zero;

	private static Vector2Int logGridId = Vector2Int.zero;

	public static Map map
	{
		get
		{
			MapField<int, Map> mapField = G.localPlayer?.Maps;
			if (mapField == null)
			{
				return null;
			}
			return mapField.GetValueOrDefault(Singleton<GameManager>.instance.worldManager.ActiveWorldId);
		}
	}

	public static MapConfig mapConfig => GameLoader.meta.mapConfig;

	public static MapLayer playerMapLayer => MapLayer.L0;

	public static int playerChunkId => Singleton<GameManager>.instance.worldManager.ActiveChunkId;

	public static ACT.World.MapArea playerMapArea => (ACT.World.MapArea)Singleton<GameManager>.instance.worldManager.ActiveMapId;

	public static ACT.World.MapArea LastQuitMapArea { get; set; }

	public static Vector3 playerPos
	{
		get
		{
			if (!MonoECS.instance.mainEntity.IsLogicAvailable())
			{
				return Vector3.zero;
			}
			return MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		}
	}

	public static Vector2Int playerVector2IntPos
	{
		get
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity.IsValid)
			{
				CompTransform compTransform = mainEntity.GetCompTransform();
				if (compTransform != null)
				{
					return new Vector2Int(Mathf.FloorToInt(compTransform.physicsPosition.x), Mathf.FloorToInt(compTransform.physicsPosition.y));
				}
			}
			return Vector2Int.zero;
		}
	}

	public static ACT.World.MapArea GetMapAreaBySGOID(int sgoid)
	{
		return Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(sgoid)?.mapArea ?? ACT.World.MapArea.None;
	}

	public static bool IsMissionMapIcon(MapIconType type)
	{
		if ((uint)(type - 2001) <= 2u)
		{
			return true;
		}
		return false;
	}

	public static List<BakeStaticMapIconData> GetMapIconDataByAreaAndType(ACT.World.MapArea mapArea, MapIconType type)
	{
		List<BakeStaticMapIconData> list = new List<BakeStaticMapIconData>();
		HashSet<BakeStaticMapIconData> mapIconDataBy = ConfigWorldMapGraph.GetMapIconDataBy(mapArea);
		if (mapIconDataBy != null)
		{
			foreach (BakeStaticMapIconData item in mapIconDataBy)
			{
				if (item.iconTypeId == (int)type)
				{
					list.Add(item);
				}
			}
		}
		return list;
	}

	public static bool InteractObjIsActive(int id)
	{
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(id);
		if (worldStateAssetDataBySGOID == null)
		{
			return false;
		}
		IconData data = CoreUtils.GetData(worldStateAssetDataBySGOID.iconDataId, RuntimeConfigs.data.iconDatas);
		if (data == null)
		{
			return false;
		}
		return InteractStateId.IconActive(data.mapIcon, worldStateAssetDataBySGOID.stateId);
	}

	public static MapIconType GetMapIconTypeByMissionType(int missionType)
	{
		switch (missionType)
		{
		case 1:
		case 2:
			return MapIconType.MainMission;
		case 3:
		case 4:
			return MapIconType.SideMission;
		case 5:
		case 6:
			return MapIconType.DailyMission;
		case 7:
			return MapIconType.LegendMission;
		default:
			return MapIconType.None;
		}
	}

	public static bool CheckMapIconValid(MapIconType type, int stateWorldAssetUid)
	{
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateWorldAssetUid);
		if (worldStateAssetDataBySGOID == null)
		{
			return false;
		}
		if (!worldStateAssetDataBySGOID.showOnMap)
		{
			return false;
		}
		int iconDataId = worldStateAssetDataBySGOID.iconDataId;
		if (!RuntimeConfigs.data.iconDatas.ContainsKey(iconDataId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{type} {stateWorldAssetUid} 配置的 iconDataId 非法 配成了 {iconDataId}，不在 iconData表中");
			}
			return false;
		}
		if (RuntimeConfigs.data.iconDatas[iconDataId].pointType != (int)type)
		{
			Debug.LogError($"{type} {stateWorldAssetUid} 配置的 iconDataId 类型不对，{iconDataId} 属于 {(MapIconType)RuntimeConfigs.data.iconDatas[iconDataId].pointType}，但配给了 {type}");
			return false;
		}
		return true;
	}

	public static int GetInteractObjSpriteId(int uid)
	{
		int result = 0;
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(uid);
		if (worldStateAssetDataBySGOID == null)
		{
			return result;
		}
		MapIconData data = CoreUtils.GetData(CoreUtils.GetData(worldStateAssetDataBySGOID.iconDataId, RuntimeConfigs.data.iconDatas).mapIcon, RuntimeConfigs.data.mapIconDatas);
		switch ((MapIconType)CoreUtils.GetData(worldStateAssetDataBySGOID.iconDataId, RuntimeConfigs.data.iconDatas).mapIcon)
		{
		case MapIconType.Transfer:
			result = ((worldStateAssetDataBySGOID.stateId == -2) ? data.lightState : data.greyState);
			break;
		case MapIconType.LightHouse:
			result = ((worldStateAssetDataBySGOID.stateId == -2) ? data.lightState : data.greyState);
			break;
		case MapIconType.TemporaryPortal:
		case MapIconType.BlockInteract:
		case MapIconType.OneWayDoor:
		case MapIconType.RewardBox:
		case MapIconType.OneWayDoorOpposite:
			result = data.lightState;
			break;
		case MapIconType.Npc:
			result = data.lightState;
			break;
		case MapIconType.SpotPoint:
			result = data.lightState;
			break;
		case MapIconType.Temple:
			result = ((worldStateAssetDataBySGOID.stateId == 1) ? data.lightState : data.greyState);
			if (worldStateAssetDataBySGOID is TempleEnterData templeEnterData)
			{
				TempleData templeData = Model<TempleModel>.Interface.GetTempleData(templeEnterData.id);
				if (templeData != null && templeData.isComplate && templeData.isPerfect)
				{
					result = ((data.specialState != 0) ? data.specialState : result);
				}
			}
			break;
		case MapIconType.Raid:
			result = ((worldStateAssetDataBySGOID.stateId == 1) ? data.lightState : data.greyState);
			break;
		default:
			result = 0;
			break;
		}
		return result;
	}

	public static int GetMapIconSpriteIdByBakeData(BakeStaticMapIconData data)
	{
		int num = 0;
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(data.uid);
		MapIconData data2 = CoreUtils.GetData(data.iconTypeId, RuntimeConfigs.data.mapIconDatas);
		if (worldStateAssetDataBySGOID == null || data2 == null)
		{
			return 0;
		}
		switch ((MapIconType)data.iconTypeId)
		{
		case MapIconType.Transfer:
			num = ((worldStateAssetDataBySGOID.stateId == -2) ? data2.lightState : data2.greyState);
			break;
		case MapIconType.LightHouse:
			num = ((worldStateAssetDataBySGOID.stateId == -2) ? data2.lightState : data2.greyState);
			break;
		case MapIconType.TemporaryPortal:
		case MapIconType.BlockInteract:
		case MapIconType.OneWayDoor:
		case MapIconType.RewardBox:
		case MapIconType.OneWayDoorOpposite:
			num = data2.lightState;
			break;
		case MapIconType.Npc:
			num = data2.lightState;
			break;
		case MapIconType.Temple:
			num = ((worldStateAssetDataBySGOID.stateId == 1) ? data2.lightState : data2.greyState);
			if (worldStateAssetDataBySGOID is TempleEnterData templeEnterData)
			{
				TempleData templeData = Model<TempleModel>.Interface.GetTempleData(templeEnterData.id);
				if (templeData != null && templeData.isComplate && templeData.isPerfect)
				{
					num = ((data2.specialState != 0) ? data2.specialState : num);
				}
			}
			break;
		case MapIconType.Raid:
			num = ((worldStateAssetDataBySGOID.stateId == 1) ? data2.lightState : data2.greyState);
			break;
		default:
			num = 0;
			break;
		}
		return num;
	}

	public static MapIconType GetMapIconTypeByUid(int uid)
	{
		return (MapIconType)CoreUtils.GetData(Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(uid).iconDataId, RuntimeConfigs.data.iconDatas).pointType;
	}

	public static MapIconType GetMapIconTypeByUid(StateWorldAssetData stateWorldAssetData)
	{
		return (MapIconType)CoreUtils.GetData(stateWorldAssetData.iconDataId, RuntimeConfigs.data.iconDatas).pointType;
	}

	public static int GetMissionSpriteId(int missionId)
	{
		MissionConfig missionConfig = Singleton<MissionManager>.instance.GetMissionConfig(missionId);
		if (!missionConfig.IsValid)
		{
			return -1;
		}
		return missionConfig.MissionType;
	}

	public static int GetMapEnvironmentElementAtlasId(EnvironmentElementData data)
	{
		if (data == null)
		{
			return 0;
		}
		EnvironmentElement data2 = CoreUtils.GetData(ElementHelper.Element2Id(data.element), RuntimeConfigs.data.EnvironmentElements);
		if (data2 == null)
		{
			return 0;
		}
		return data.intensity switch
		{
			EnvironmentElementIntensity.Intensity1 => data2.weekAtlasId, 
			EnvironmentElementIntensity.Intensity2 => data2.strongAtlasId, 
			_ => 0, 
		};
	}

	public static int GetMapEnvironmentElementAtlasId(ElementBitmask element)
	{
		int num = ElementHelper.Element2Id(element);
		if (num == 0)
		{
			return 0;
		}
		return CoreUtils.GetData(num, RuntimeConfigs.data.EnvironmentElements)?.worldMapAtlasId ?? 0;
	}

	public static bool AreaUnlock(int area)
	{
		return AreaUnlock((ACT.World.MapArea)area);
	}

	public static bool AreaUnlock(ACT.World.MapArea area)
	{
		if (area == ACT.World.MapArea.None)
		{
			return false;
		}
		int unlock = CoreUtils.GetData((int)area, RuntimeConfigs.data.mapAreas).Unlock;
		if (unlock == 0)
		{
			return true;
		}
		int[] missionId = CoreUtils.GetData(unlock, RuntimeConfigs.data.missionGroups).missionId;
		if (missionId.Length != 0)
		{
			ACT.Config.Mission data = CoreUtils.GetData(missionId[0], RuntimeConfigs.data.missions);
			if (data != null && data.param.Length != 0)
			{
				return Singleton<PreconditionInfoManager>.instance.IsComplete(data.preconditionId, data.param);
			}
		}
		return true;
	}

	public static void MapTransferByMonsterPoint(ACT.World.MapArea area, int monsterPoint)
	{
		int num = 0;
		foreach (KeyValuePair<int, MonsterPointData> item in Singleton<GameManager>.instance.worldManager.FetchActiveWorldStateAssetDatas<MonsterPointData>())
		{
			if (item.Value.monsterPointId == monsterPoint)
			{
				num = item.Value.stateWorldAssetUid;
				break;
			}
		}
		if (Model<MonsterHandModel>.Interface.WildBossUnLock(monsterPoint))
		{
			MonsterPointData monsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(num) as MonsterPointData;
			TPEvt evt = EventTrackSolver.Instance.GetEvt<TPEvt>();
			evt.currentPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
			evt.targetPosition = monsterPointData.GetTeleportPos();
			EventTrackSolver.Instance.Dispatch(evt);
			TeleportUtility.TeleportWithInteractObject(monsterPointData).Forget();
		}
		else if (num != 0)
		{
			MapTransferByUid(area, num);
		}
	}

	public static void MapTransferByUid(ACT.World.MapArea area, int uid)
	{
		if (Model<MapModel>.Interface.DisableTPButton)
		{
			return;
		}
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(uid);
		List<BakeStaticMapIconData> mapIconDataByAreaAndType = GetMapIconDataByAreaAndType(area, MapIconType.Transfer);
		if (mapIconDataByAreaAndType.Count > 0 && worldStateAssetDataBySGOID != null)
		{
			int targetId = 0;
			float num = float.MaxValue;
			WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
			foreach (BakeStaticMapIconData item in mapIconDataByAreaAndType)
			{
				float num2 = Vector3.Distance(item.initPos, worldStateAssetDataBySGOID.initPos);
				if (CoreUtils.TryGetServiceSaveStateId(worldManager.ActiveWorldId, item.uid, out var stateId) && stateId == -2 && num2 < num)
				{
					num = num2;
					targetId = item.uid;
				}
			}
			if (targetId != 0)
			{
				if (playerMapArea != area)
				{
					ACT.Config.MapArea data = CoreUtils.GetData((int)area, RuntimeConfigs.data.mapAreas);
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
					{
						commonId = 2391,
						texts = new string[1] { LocalizationSettings.StringDatabase.GetLocalizedString("shortcommon", data.name, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null) },
						OnConfirm = () =>
						{
							Transfer(targetId);
						}
					});
				}
				else
				{
					Transfer(targetId);
				}
			}
			else
			{
				Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
				{
					tableName = LocalizationUtility.localizeTableName_Common,
					localizeId = 2395
				});
			}
		}
		else
		{
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
			{
				tableName = LocalizationUtility.localizeTableName_Common,
				localizeId = 2395
			});
		}
	}

	public static void Transfer(int transferId)
	{
		if (MonoECS.instance.ruleManager.SharedGetState(transferId) != -2)
		{
			return;
		}
		StateWorldAssetData stateWorldAssetData = MonoECS.instance.ruleManager.GetStateWorldAssetData(transferId);
		if (stateWorldAssetData != null)
		{
			TPEvt evt = EventTrackSolver.Instance.GetEvt<TPEvt>();
			evt.currentPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
			evt.targetPosition = ((PortalData)stateWorldAssetData).SitPos;
			EventTrackSolver.Instance.Dispatch(evt);
			TeleportUtility.TeleportWithInteractObject(stateWorldAssetData).Forget();
			Singleton<BloodBottleHandler>.instance.RecoverItems();
			if (MPPlayer.local.CurrentActiveBattlePotionId != 0)
			{
				Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(MPPlayer.local.CurrentActiveBattlePotionId);
			}
			Singleton<AchievementSyncBattleTypeManager>.instance.DispatchAnchorTransfer();
		}
	}

	public static bool TempleAreaUnlock(ACT.World.MapArea area)
	{
		if (area == ACT.World.MapArea.None)
		{
			return false;
		}
		if (Model<TempleModel>.Interface.areaTempleDatas.TryGetValue((int)area, out var value))
		{
			if (value != null)
			{
				return value.Count > 0;
			}
			return false;
		}
		return false;
	}

	public static List<int> GetAllUnlockLightHouseId()
	{
		new List<int>();
		return map.ServiceSaveStateIds.Where((KeyValuePair<int, int> pair) => (Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(pair.Key) is LightHouseData { serviceSaveTag: ServiceSaveTag.LightHouse } && pair.Value == 0) ? true : false).ToList().ConvertAll((KeyValuePair<int, int> p) => p.Key);
	}

	public static List<int> GetAllUnlockTransferId()
	{
		WorldManager worldMgr = Singleton<GameManager>.instance.worldManager;
		return map.ServiceSaveStateIds.Where((KeyValuePair<int, int> p) => (worldMgr.GetWorldStateAssetDataBySGOID(p.Key) is PortalData { serviceSaveTag: ServiceSaveTag.Transfer } && p.Value == 0) ? true : false).ToList().ConvertAll((KeyValuePair<int, int> v) => v.Key);
	}

	public static float GetAreaExploreRatio(ACT.World.MapArea area)
	{
		if (!Model<MapModel>.HasInstance())
		{
			return 0f;
		}
		return Model<MapModel>.Interface.GetAreaGroupExploreRatio(area);
	}

	public static int GetAreaBySubArea(int subAreaId)
	{
		foreach (ACT.Config.MapArea value in RuntimeConfigs.data.mapAreas.Values)
		{
			if (value.subMapArea.Length != 0 && value.subMapArea.Find((int x) => x == subAreaId) != 0)
			{
				return value.id;
			}
		}
		return 0;
	}

	public static bool GetAreaCanExplore(ACT.World.MapArea area)
	{
		if (CoreUtils.GetData((int)area, RuntimeConfigs.data.areaStateObjects) == null)
		{
			return false;
		}
		return CoreUtils.GetData((int)area, RuntimeConfigs.data.areaStateObjects).group.Length != 0;
	}

	public static void AddUnlockIndex()
	{
		if (map == null)
		{
			return;
		}
		foreach (StateWorldAssetData item in Singleton<GameManager>.instance.worldManager.FetchActiveWorldStateAssetDatas())
		{
			int stateWorldAssetUid = item.stateWorldAssetUid;
			if (item == null)
			{
				continue;
			}
			int stateId = item.stateId;
			if (!(item is PortalData) && !(item is LightHouseData) && !(item is NPCPointData) && !(item is SwitchMotionPathData))
			{
				continue;
			}
			if (item is LightHouseData)
			{
				LightHouseData lightHouseData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateWorldAssetUid) as LightHouseData;
				Model<MapModel>.Interface.AddUnlockInteractObjId((MapLayer)item.mapLayer, stateWorldAssetUid);
				if (stateId != -2)
				{
					continue;
				}
				foreach (LightHouseInteracts interactIcon in lightHouseData.interactIcons)
				{
					Model<MapModel>.Interface.AddUnlockInteractObjId(MonoECS.instance.ruleManager.GetStateWorldAssetMapLayer(interactIcon.uid), interactIcon.uid);
				}
			}
			else if (item is PortalData && stateId == -2)
			{
				Model<MapModel>.Interface.AddUnlockInteractObjId(item.MapLayer, stateWorldAssetUid);
			}
			else if (item is SwitchMotionPathData && stateId == 0)
			{
				Model<MapModel>.Interface.AddUnlockInteractObjId(item.MapLayer, stateWorldAssetUid);
			}
		}
	}

	public static Vector2 GetAreaOffset(ACT.World.MapArea area, Vector2 worldPos)
	{
		return worldPos - mapConfig.GetAreaLeftBottomWorldPos(area);
	}

	public static Vector2Int GetAreaGridId(ACT.World.MapArea area, Vector2 worldPos)
	{
		Vector2 areaOffset = GetAreaOffset(area, worldPos);
		return new Vector2Int(Mathf.FloorToInt(areaOffset.x / 51.2f), Mathf.FloorToInt(areaOffset.y / 51.2f));
	}

	public static void SetMiniMapRoomMaterialTexture(Texture unlockFogRt)
	{
		mapConfig.miniMapRoomMaterial.SetTexture("_UnlockMistMask", unlockFogRt);
	}

	public static void SetLargeMapRoomMaterialTexture(Texture unlockFogRt)
	{
		mapConfig.largeMapRoomMaterial.SetTexture("_UnlockMistMask", unlockFogRt);
	}

	public static void SetMiniMapDetailMaterialTexture(Texture unlockFogRt, Texture exploreFogRt)
	{
		mapConfig.miniMapDetailMaterial.SetTexture("_UnlockMistMask", unlockFogRt);
		mapConfig.miniMapDetailMaterial.SetTexture("_ExploreMistMask", exploreFogRt);
	}

	public static void SetLargeMapDetailMaterialTexture(Texture unlockFogRt, Texture exploreFogRt)
	{
		mapConfig.largeMapDetailMaterial.SetTexture("_UnlockMistMask", unlockFogRt);
		mapConfig.largeMapDetailMaterial.SetTexture("_ExploreMistMask", exploreFogRt);
	}

	public static void SetMiniMapRoomMaterialCorner(RectTransform rectTransform, Vector2 offset = default(Vector2))
	{
		rectTransform.GetWorldCorners(worldCorner);
		mapConfig.miniMapRoomMaterial.SetVector("_LBCorner", new Vector4(worldCorner[0].x + offset.x, worldCorner[0].y + offset.y, worldCorner[0].z, 0f));
		mapConfig.miniMapRoomMaterial.SetVector("_RTCorner", new Vector4(worldCorner[2].x + offset.x, worldCorner[2].y + offset.y, worldCorner[2].z, 0f));
	}

	public static void SetLargeMapRoomMaterialCorner(RectTransform rectTransform, Vector2 offset = default(Vector2))
	{
		rectTransform.GetWorldCorners(worldCorner);
		mapConfig.largeMapRoomMaterial.SetVector("_LBCorner", new Vector4(worldCorner[0].x + offset.x, worldCorner[0].y + offset.y, worldCorner[0].z, 0f));
		mapConfig.largeMapRoomMaterial.SetVector("_RTCorner", new Vector4(worldCorner[2].x + offset.x, worldCorner[2].y + offset.y, worldCorner[2].z, 0f));
	}

	public static void SetMiniMapDetailMaterialCorner(RectTransform rectTransform, Vector2 offset = default(Vector2))
	{
		rectTransform.GetWorldCorners(worldCorner);
		mapConfig.miniMapDetailMaterial.SetVector("_LBCorner", new Vector4(worldCorner[0].x + offset.x, worldCorner[0].y + offset.y, worldCorner[0].z, 0f));
		mapConfig.miniMapDetailMaterial.SetVector("_RTCorner", new Vector4(worldCorner[2].x + offset.x, worldCorner[2].y + offset.y, worldCorner[2].z, 0f));
	}

	public static void SetLargeMapDetailMaterialCorner(RectTransform rectTransform, Vector2 offset = default(Vector2))
	{
		rectTransform.GetWorldCorners(worldCorner);
		mapConfig.largeMapDetailMaterial.SetVector("_LBCorner", new Vector4(worldCorner[0].x + offset.x, worldCorner[0].y + offset.y, worldCorner[0].z, 0f));
		mapConfig.largeMapDetailMaterial.SetVector("_RTCorner", new Vector4(worldCorner[2].x + offset.x, worldCorner[2].y + offset.y, worldCorner[2].z, 0f));
	}

	public static bool CanLogLocalExplorePos(ACT.World.MapArea area, int chunkId, Vector2 pos)
	{
		if (mapConfig.IsDefaultUnlockArea(area))
		{
			return false;
		}
		if (CanLogLocalExplorePos(area, chunkId))
		{
			return Model<MapModel>.Interface.CanLogLocalExplorePos(area, pos);
		}
		return false;
	}

	private static bool CanLogLocalExplorePos(ACT.World.MapArea area, int chunkId)
	{
		MapModel.LayerExploreInfo orCreateChunkExploreInfo = Model<MapModel>.Interface.GetOrCreateChunkExploreInfo(area, chunkId);
		if (Model<MapModel>.Interface.GetAreaExploreInfo(area).IsComplete)
		{
			return false;
		}
		if (orCreateChunkExploreInfo.IsComplete)
		{
			return false;
		}
		return true;
	}

	public static bool CanLogSyncExplorePos(ACT.World.MapArea area, int chunkId, Vector2Int pos)
	{
		if (mapConfig.IsDefaultUnlockArea(area))
		{
			return false;
		}
		MapModel.AreaExploreInfo areaExploreInfo = Model<MapModel>.Interface.GetAreaExploreInfo(area);
		if (areaExploreInfo == null)
		{
			return true;
		}
		if (areaExploreInfo.IsComplete)
		{
			return false;
		}
		if (areaExploreInfo.GetOrCreateChunkExploreInfo(chunkId).IsComplete)
		{
			return false;
		}
		(int, int) gridXY = GetGridXY(area, MapLayer.L0, pos);
		for (int i = gridXY.Item1 - 1; i <= gridXY.Item1 + 1; i++)
		{
			for (int j = gridXY.Item2 - 1; j <= gridXY.Item2 + 1; j++)
			{
				compareDisatanceGridId.x = i;
				compareDisatanceGridId.y = j;
				if (!areaExploreInfo.TryGetNearbyGridInfo(compareDisatanceGridId, 0f, out var gridInfo))
				{
					continue;
				}
				foreach (Vector2Int item in gridInfo)
				{
					if (Vector2Int.Distance(pos, item) < (float)pointSpace)
					{
						return false;
					}
				}
			}
		}
		return true;
	}

	public static void LogSyncExplorePos(ACT.World.MapArea area, int ChunkId, Vector2Int pos)
	{
		if (!mapConfig.IsDefaultUnlockArea(area))
		{
			Model<MapModel>.Interface.AddSyncMapViewLogInfo(area, ChunkId, pos);
			MapModel.LayerExploreInfo orCreateChunkExploreInfo = Model<MapModel>.Interface.GetOrCreateChunkExploreInfo(area, ChunkId);
			(logGridId.x, logGridId.y) = GetGridXY(area, MapLayer.L0, pos);
			if (!orCreateChunkExploreInfo.gridInfo.ContainsKey(logGridId))
			{
				orCreateChunkExploreInfo.gridInfo.Add(logGridId, new HashSet<Vector2Int>());
			}
			orCreateChunkExploreInfo.gridInfo[logGridId].Add(pos);
		}
	}

	public static (int gridX, int gridY) GetGridXY(ACT.World.MapArea area, MapLayer layer, Vector2Int logPos)
	{
		Bounds areaBoundBy = ConfigWorldMapGraph.GetAreaBoundBy(area);
		int item = (logPos.x - (int)areaBoundBy.min.x) / sideLength * sideLength + (int)areaBoundBy.min.x;
		int item2 = (logPos.y - (int)areaBoundBy.min.y) / sideLength * sideLength + (int)areaBoundBy.min.y;
		return (gridX: item, gridY: item2);
	}

	public static bool IsPosExplored(Vector3 pos, ACT.World.MapArea area)
	{
		if (Model<MapModel>.HasInstance())
		{
			return Model<MapModel>.Interface.IsPosExploredByFogMask(area, new Vector2(pos.x, pos.y));
		}
		return false;
	}

	public static Tweener DONormalizedPos(this AreaMapScrollRectBase target, Vector2 endValue, float duration, bool snapping = false)
	{
		return DOTween.To(() => new Vector2(target.horizontalNormalizedPosition, target.verticalNormalizedPosition), (Vector2 x) =>
		{
			target.horizontalNormalizedPosition = x.x;
			target.verticalNormalizedPosition = x.y;
		}, endValue, duration).SetOptions(snapping).SetTarget(target);
	}
}
