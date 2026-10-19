using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle.Configs;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.NPC;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Collections;
using Bamboo.ImageCenter;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MiniMap : LuminSerializedMonoBehaviour
{
	private sealed class UnlockMaskRuntimeData
	{
		public int stateObjectId;

		public InstanceHandle instantiateHandle;

		public AssetLoadHandle spriteHandle;
	}

	private readonly struct PendingExploreIcon(Vector2Int cellId, BakeStaticMapIconData data)
	{
		public readonly Vector2Int cellId = cellId;

		public readonly BakeStaticMapIconData data = data;
	}

	private class MissionWrapper
	{
		private MiniMapMissionIcon _icon;

		public int PointId { get; private set; }

		public InstanceHandle Go { get; private set; }

		public MissionPointData MissionPointData { get; private set; }

		public MiniMapMissionIcon Icon
		{
			get
			{
				if (_icon == null)
				{
					_icon = Go.Result?.GetComponent<MiniMapMissionIcon>();
				}
				return _icon;
			}
		}

		public MissionWrapper(MissionPointData data, InstanceHandle go)
		{
			PointId = data.PointId;
			MissionPointData = data;
			Go = go;
		}
	}

	private class MapCellImageHandlePool
	{
		private struct MapCellImageAddressKey : IEquatable<MapCellImageAddressKey>
		{
			public ACT.World.MapArea area;

			public MapLayer layer;

			public int imageType;

			public int row;

			public int col;

			public bool Equals(MapCellImageAddressKey other)
			{
				if (area == other.area && layer == other.layer && imageType == other.imageType && row == other.row)
				{
					return col == other.col;
				}
				return false;
			}
		}

		private const int _capacity = 54;

		private Dictionary<MapCellImageAddressKey, AssetLoadHandle> _spriteHandlePoolAssetID = new Dictionary<MapCellImageAddressKey, AssetLoadHandle>(54);

		private Queue<MapCellImageAddressKey> _addressQueue = new Queue<MapCellImageAddressKey>(54);

		private MapCellImageAddressKey _key;

		public MapCellImageHandlePool()
		{
			Init();
		}

		private void Init()
		{
			_spriteHandlePoolAssetID.Clear();
			_addressQueue.Clear();
		}

		public void Release()
		{
			_spriteHandlePoolAssetID.Clear();
			_addressQueue.Clear();
		}

		public void GetMapCellImage(ACT.World.MapArea area, MapLayer layer, string imageType, int row, int col, Action<Sprite> callback)
		{
			_key.area = area;
			_key.layer = layer;
			_key.imageType = MapGridNameRule.GridTypeString2Id(imageType);
			_key.row = row;
			_key.col = col;
			if (_spriteHandlePoolAssetID.TryGetValue(_key, out var value))
			{
				if (value.As<Sprite>() != null)
				{
					callback?.Invoke(value.As<Sprite>());
					return;
				}
				value.Completed += (AssetLoadHandle result) =>
				{
					Sprite obj = result.As<Sprite>();
					callback?.Invoke(obj);
				};
				return;
			}
			if (_spriteHandlePoolAssetID.Count >= 54)
			{
				MapCellImageAddressKey key = _addressQueue.Dequeue();
				AssetStationManager.BattleStation.Release(_spriteHandlePoolAssetID[key]);
				_spriteHandlePoolAssetID.Remove(key);
			}
			_addressQueue.Enqueue(_key);
			string assetID = "Sprite/" + MapGridNameRule.GetFormatName(area, layer, _key.imageType, row, col);
			try
			{
				AssetLoadHandle value2 = AssetStationManager.BattleStation.LoadAsync<Sprite>(assetID);
				value2.Completed += (AssetLoadHandle result) =>
				{
					Sprite obj = result.As<Sprite>();
					callback?.Invoke(obj);
					if (!_spriteHandlePoolAssetID.ContainsKey(_key))
					{
						_spriteHandlePoolAssetID.Add(_key, result);
					}
				};
				if (!_spriteHandlePoolAssetID.ContainsKey(_key))
				{
					_spriteHandlePoolAssetID.Add(_key, value2);
				}
			}
			catch (Exception message)
			{
				Debug.LogError(message);
				throw;
			}
		}
	}

	public RectTransform playerIcon;

	public RectTransform content;

	public RectTransform unlockMaskRoot;

	public RectTransform interactObjIconRoot;

	public RectTransform missionIconRoot;

	public RectTransform specialPointIconRoot;

	public Dictionary<string, RectTransform> typeRoot;

	private Vector2 offset;

	private Vector2Int prePlayerCellId = new Vector2Int(-100, -100);

	private Vector2Int curPlayerCellId;

	private const int _aroundCellMaxCount = 9;

	private HashSet<Vector2Int> preNineCell = new HashSet<Vector2Int>(9);

	private HashSet<Vector2Int> curNineCell = new HashSet<Vector2Int>(9);

	private Dictionary<Vector2Int, HashSet<InstanceHandle>> cellImageInstantiateGO = new Dictionary<Vector2Int, HashSet<InstanceHandle>>(9);

	private Dictionary<Vector2Int, HashSet<InstanceHandle>> cellInteractObjIconInstantiateGO = new Dictionary<Vector2Int, HashSet<InstanceHandle>>(9);

	private Dictionary<Vector2Int, HashSet<InstanceHandle>> cellWorldBossIconInstantiateGO = new Dictionary<Vector2Int, HashSet<InstanceHandle>>(9);

	private int _lastExploreFogVersion = -1;

	private bool _needRefreshExploreIconStatus = true;

	private InstanceHandle _monsterPointNavIconInstantiateGo;

	private MiniMapMonsterPointIcon _monsterPointNavIcon;

	private InstanceHandle _collectPointNavIconInstantiateGo;

	private MiniMapCollectPointIcon _collectPointNavIcon;

	private InstanceHandle _generalPointInstantiateGO;

	private MiniMapIcon _generalPointNavIcon;

	private readonly List<string> _imageTypeList = new List<string> { "Bg", "Room", "Detail" };

	private MapCellImageHandlePool _cellImageHandlePool;

	private ImageAssetStation _station;

	private readonly List<UnlockMaskRuntimeData> _unlockMaskRuntimeData = new List<UnlockMaskRuntimeData>();

	private int _unlockMaskGeneration;

	private int _exploreIconQueryGeneration;

	private int _exploreIconCreateGeneration;

	private MapAreaLayerInfo curAreaLayerInfo = MapAreaLayerInfo.None;

	private MapAreaLayerInfo preAreaLayerInfo = MapAreaLayerInfo.None;

	private bool hasInit;

	private bool _show;

	private Vector2 _playerUiPos;

	private float _halfMinimapWidth;

	private float _halfMinimapHeight;

	private Vector3[] miniMapCorners = new Vector3[4];

	private Vector3 bottomLeft;

	private Vector3 topLeft;

	private Vector3 topRight;

	private Vector3 bottomRight;

	private float xMin;

	private float xMax;

	private float yMin;

	private float yMax;

	private float halfWidth;

	private float halfHeight;

	private Vector3 playerUIPos;

	private float k13;

	private float k24;

	private int timer;

	private Dictionary<int, MissionWrapper> _pointId2Icon = new Dictionary<int, MissionWrapper>();

	private Vector3[] _corners = new Vector3[4];

	private Vector2 inCanSeeRectReturnVal;

	private Dictionary<int, InstanceHandle> _selfNodeIconHandles = new Dictionary<int, InstanceHandle>();

	private Dictionary<int, InstanceHandle> _npcIcons = new Dictionary<int, InstanceHandle>();

	private Dictionary<int, int> _receiveMissionIconNpcUids = new Dictionary<int, int>();

	private ImageAssetStation _selfNodeImageStation;

	private MapConfig mapConfig => GameLoader.meta.mapConfig;

	private float cellSize => 512f / (mapConfig.largeMapRatio / mapConfig.miniMapRatio);

	public void Init(ImageAssetStation station)
	{
		OnTMiniMapModeDisabledChangeEventHandler();
		_station = station;
		Model<BattleMainModel>.Interface.OnMiniMapModeDisabledChangeEventHandler -= OnTMiniMapModeDisabledChangeEventHandler;
		Model<BattleMainModel>.Interface.OnMiniMapModeDisabledChangeEventHandler += OnTMiniMapModeDisabledChangeEventHandler;
		if (!Singleton<GameManager>.instance.worldManager.HasActiveWorld || Singleton<GameManager>.instance.worldManager.ActiveWorldId != 3 || gameObject.scene.name != "GameStart")
		{
			return;
		}
		if (!hasInit && Model<MapModel>.HasInstance() && Model<MapModel>.Interface.MainWorldDataInitFinish)
		{
			RuntimeNpcManager instance = Singleton<RuntimeNpcManager>.instance;
			instance.OnNpcHide = (Action<int>)Delegate.Combine(instance.OnNpcHide, new Action<int>(OnMapModelDynamicNpcHide));
			RuntimeNpcManager instance2 = Singleton<RuntimeNpcManager>.instance;
			instance2.OnNpcShow = (Action<int>)Delegate.Combine(instance2.OnNpcShow, new Action<int>(OnMapModelDynamicNpcShow));
			Model<MapModel>.Interface.OnMapModelMissionPointUpdate += OnMapModelMissionPointUpdate;
			Model<TrackModel>.Interface.OnTrackMonsterPointChanged += OnTrackModelTrackMonsterPointChanged;
			Model<TrackModel>.Interface.OnTrackCollectionPointChanged += OnTrackModelTrackCollectionPointChanged;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, OnServiceSaveRefresh);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_AcceptEnd, OnMissionAccepted);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingArrowAdded, OnMissionArrowAdded);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingArrowRemoved, OnMissionArrowRemoved);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_MapPointTraceEvt, HandleMapPointTrace);
			_halfMinimapWidth = (transform as RectTransform).rect.width / 2f;
			_halfMinimapHeight = (transform as RectTransform).rect.height / 2f;
			(transform as RectTransform).GetWorldCorners(miniMapCorners);
			bottomLeft = miniMapCorners[0];
			topLeft = miniMapCorners[1];
			topRight = miniMapCorners[2];
			bottomRight = miniMapCorners[3];
			xMin = bottomLeft.x;
			xMax = bottomRight.x;
			yMin = bottomLeft.y;
			yMax = topLeft.y;
			halfWidth = 0.5f * (xMax - xMin);
			halfHeight = 0.5f * (yMax - yMin);
			playerUIPos = playerIcon.position;
			k13 = GetK(bottomLeft, topRight);
			k24 = GetK(topLeft, bottomRight);
			_cellImageHandlePool = new MapCellImageHandlePool();
			InitSelfNodeSystem();
			preAreaLayerInfo.SetMapAreaLayerInfo((ACT.World.MapArea)Singleton<GameManager>.instance.worldManager.ActiveMapId);
			curAreaLayerInfo.SetMapAreaLayerInfo((ACT.World.MapArea)Singleton<GameManager>.instance.worldManager.ActiveMapId);
			EnterNewAreaLayer();
			hasInit = true;
			bool flag = Model<BattleMainModel>.Interface.MiniMapModeDisabled || !Singleton<SystemUnlockManager>.instance.IsUnlock(1028);
			if ((bool)gameObject)
			{
				gameObject.SetActive(!flag);
			}
		}
		if (Model<MapModel>.HasInstance())
		{
			MapUtility.SetMiniMapRoomMaterialTexture(Model<MapModel>.Interface.GetAreaLayerUnlockFogRt(curAreaLayerInfo.mapArea, MapLayer.L0));
			MapUtility.SetMiniMapDetailMaterialTexture(Model<MapModel>.Interface.GetAreaLayerUnlockFogRt(curAreaLayerInfo.mapArea, MapLayer.L0), Model<MapModel>.Interface.GetAreaLayerExploreFogRt(curAreaLayerInfo.mapArea, MapLayer.L0));
		}
	}

	public void OnRelease()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingArrowAdded, OnMissionArrowAdded);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingArrowRemoved, OnMissionArrowRemoved);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_MapPointTraceEvt, HandleMapPointTrace);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_AcceptEnd, OnMissionAccepted);
		Model<BattleMainModel>.Interface.OnMiniMapModeDisabledChangeEventHandler -= OnTMiniMapModeDisabledChangeEventHandler;
		if (hasInit)
		{
			if (Model<MapModel>.HasInstance())
			{
				RuntimeNpcManager instance = Singleton<RuntimeNpcManager>.instance;
				instance.OnNpcHide = (Action<int>)Delegate.Remove(instance.OnNpcHide, new Action<int>(OnMapModelDynamicNpcHide));
				RuntimeNpcManager instance2 = Singleton<RuntimeNpcManager>.instance;
				instance2.OnNpcShow = (Action<int>)Delegate.Remove(instance2.OnNpcShow, new Action<int>(OnMapModelDynamicNpcShow));
				Model<MapModel>.Interface.OnMapModelMissionPointUpdate -= OnMapModelMissionPointUpdate;
				Model<TrackModel>.Interface.OnTrackMonsterPointChanged -= OnTrackModelTrackMonsterPointChanged;
				Model<TrackModel>.Interface.OnTrackCollectionPointChanged -= OnTrackModelTrackCollectionPointChanged;
				Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, OnServiceSaveRefresh);
			}
			_cellImageHandlePool.Release();
			UnInitSelfNodeSystem();
			UnInitNpcMapIcons();
			hasInit = false;
			Reset();
		}
	}

	private void OnTMiniMapModeDisabledChangeEventHandler()
	{
		bool flag = Model<BattleMainModel>.Interface.MiniMapModeDisabled || !Model<MapModel>.HasInstance() || !Singleton<SystemUnlockManager>.instance.IsUnlock(1028);
		if ((bool)gameObject)
		{
			gameObject.SetActive(!flag);
		}
	}

	private void Update()
	{
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_BATTLEMAIN);
		if ((firstUIState == UIState.Opening || firstUIState == UIState.Opened || firstUIState == UIState.Closing) && hasInit && !Model<BattleMainModel>.Interface.MiniMapModeDisabled)
		{
			timer++;
			if (timer == 2)
			{
				timer = 0;
				UpdateContent();
			}
		}
	}

	public void UpdateContent()
	{
		curAreaLayerInfo.SetMapAreaLayerInfo((ACT.World.MapArea)Singleton<GameManager>.instance.worldManager.ActiveMapId);
		if (curAreaLayerInfo == MapAreaLayerInfo.None)
		{
			return;
		}
		if (curAreaLayerInfo != preAreaLayerInfo)
		{
			Reset();
		}
		offset = GetPlayerWorldOffset(curAreaLayerInfo.mapArea);
		_playerUiPos = offset * mapConfig.miniMapRatio + mapConfig.miniMapIconOffset;
		content.anchoredPosition = -_playerUiPos;
		curPlayerCellId = GetPlayerCellId(offset);
		if (curAreaLayerInfo != preAreaLayerInfo)
		{
			EnterNewAreaLayer();
		}
		else
		{
			UpdateInAreaLayer();
		}
		UpdateMissionNavIcon();
		UpdateSpecialPointNavIcon();
		UpdateGeneralPointNavIcon();
		UpdateXYCellIconStatus(NeedRefreshExploreIconStatus());
		MapUtility.SetMiniMapRoomMaterialCorner(content);
		MapUtility.SetMiniMapDetailMaterialCorner(content);
		preAreaLayerInfo = curAreaLayerInfo;
		if (!(curPlayerCellId != prePlayerCellId))
		{
			return;
		}
		preNineCell.Clear();
		foreach (Vector2Int item in curNineCell)
		{
			preNineCell.Add(item);
		}
		prePlayerCellId = curPlayerCellId;
	}

	private void EnterNewAreaLayer()
	{
		content.sizeDelta = (Vector2)mapConfig.GetAreaWidthHeightCellNum(curAreaLayerInfo.mapArea) * cellSize;
		CreateUnlockMasks(curAreaLayerInfo.mapArea);
		MapUtility.SetMiniMapRoomMaterialTexture(Model<MapModel>.Interface.GetAreaLayerUnlockFogRt(curAreaLayerInfo.mapArea, MapLayer.L0));
		MapUtility.SetMiniMapDetailMaterialTexture(Model<MapModel>.Interface.GetAreaLayerUnlockFogRt(curAreaLayerInfo.mapArea, MapLayer.L0), Model<MapModel>.Interface.GetAreaLayerExploreFogRt(curAreaLayerInfo.mapArea, MapLayer.L0));
		GetCurNineCell(curAreaLayerInfo.mapArea, curPlayerCellId, ref curNineCell);
		CreateCellImage(curAreaLayerInfo, curNineCell);
		CreateCellIcon(curAreaLayerInfo, curNineCell);
		CreateMissionPointIcon();
		CreateDynamicNpcIcon(curAreaLayerInfo.mapArea);
		CreateSelfNodeMapIcons(curAreaLayerInfo.mapArea);
		CreateGeneralNavButtonIcons(curAreaLayerInfo.mapArea);
		CreateMonsterPointNavIcon();
	}

	private void CreateUnlockMasks(ACT.World.MapArea area)
	{
		RecycleUnlockMasks();
		if (unlockMaskRoot == null || mapConfig.miniMapUnlockMaskAssetID == null)
		{
			return;
		}
		List<UnlockMaskOutPutData> mapAreaUnlockMask = mapConfig.GetMapAreaUnlockMask(area);
		if (mapAreaUnlockMask == null || mapAreaUnlockMask.Count == 0)
		{
			return;
		}
		int generation = _unlockMaskGeneration;
		float mapRatio = ((mapConfig.largeMapRatio == 0f) ? 1f : (mapConfig.miniMapRatio / mapConfig.largeMapRatio));
		foreach (UnlockMaskOutPutData unlockMaskData in mapAreaUnlockMask)
		{
			if (unlockMaskData == null)
			{
				continue;
			}
			UnlockMaskRuntimeData runtimeData = new UnlockMaskRuntimeData
			{
				stateObjectId = unlockMaskData.stateObjectId
			};
			_unlockMaskRuntimeData.Add(runtimeData);
			runtimeData.instantiateHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapUnlockMaskAssetID.GUID);
			if (runtimeData.instantiateHandle == null)
			{
				continue;
			}
			int maskId = unlockMaskData.unlockMaskId;
			runtimeData.instantiateHandle.Completed += (InstanceHandle handle) =>
			{
				if (generation == _unlockMaskGeneration && !(handle.Result == null))
				{
					GameObject result = handle.Result;
					result.name = $"MiniMapUnlockMask_{maskId}";
					result.transform.SetParent(unlockMaskRoot, worldPositionStays: false);
					if (result.transform is RectTransform rectTransform)
					{
						rectTransform.anchoredPosition = unlockMaskData.anchoredPosition * mapRatio;
						rectTransform.sizeDelta = unlockMaskData.size * mapRatio;
					}
					Image image = result.GetComponent<Image>();
					if (image != null)
					{
						runtimeData.spriteHandle = AssetStationManager.BattleStation.LoadAsync<Sprite>(NameUtility.GetUnlockMaskAddress(maskId));
						runtimeData.spriteHandle.Completed += (AssetLoadHandle spriteHandle) =>
						{
							if (generation == _unlockMaskGeneration && image != null)
							{
								image.sprite = spriteHandle.As<Sprite>();
							}
						};
					}
					RefreshUnlockMaskVisibility(runtimeData);
				}
			};
		}
	}

	private void RecycleUnlockMasks()
	{
		_unlockMaskGeneration++;
		foreach (UnlockMaskRuntimeData unlockMaskRuntimeDatum in _unlockMaskRuntimeData)
		{
			if (unlockMaskRuntimeDatum.instantiateHandle != null)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(unlockMaskRuntimeDatum.instantiateHandle);
			}
			if (AssetLoadHandleExtensions.IsValid(unlockMaskRuntimeDatum.spriteHandle))
			{
				AssetStationManager.BattleStation.Release(unlockMaskRuntimeDatum.spriteHandle, showError: false);
			}
		}
		_unlockMaskRuntimeData.Clear();
	}

	private void RefreshUnlockMaskVisibility(int uid)
	{
		foreach (UnlockMaskRuntimeData unlockMaskRuntimeDatum in _unlockMaskRuntimeData)
		{
			if (unlockMaskRuntimeDatum.stateObjectId == uid)
			{
				RefreshUnlockMaskVisibility(unlockMaskRuntimeDatum);
				break;
			}
		}
	}

	private void RefreshUnlockMaskVisibility(UnlockMaskRuntimeData runtimeData)
	{
		if (runtimeData == null || runtimeData.instantiateHandle == null)
		{
			return;
		}
		GameObject result = runtimeData.instantiateHandle.Result;
		if ((object)result != null)
		{
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(runtimeData.stateObjectId);
			if (worldStateAssetDataBySGOID != null)
			{
				result.SetActive(worldStateAssetDataBySGOID.stateId == worldStateAssetDataBySGOID.initialStateId);
			}
		}
	}

	private bool NeedRefreshExploreIconStatus()
	{
		if (!Model<MapModel>.HasInstance())
		{
			return false;
		}
		int areaExploreFogVersion = Model<MapModel>.Interface.GetAreaExploreFogVersion(curAreaLayerInfo.mapArea);
		if (!_needRefreshExploreIconStatus && areaExploreFogVersion == _lastExploreFogVersion)
		{
			return false;
		}
		_needRefreshExploreIconStatus = false;
		_lastExploreFogVersion = areaExploreFogVersion;
		return true;
	}

	private void UpdateXYCellIconStatus(bool refreshExploreStatus)
	{
		List<MiniMapInteractObjIcon> queryIcons = null;
		List<Vector2> queryPositions = null;
		foreach (Vector2Int item in curNineCell)
		{
			if (cellInteractObjIconInstantiateGO.TryGetValue(item, out var value))
			{
				foreach (InstanceHandle item2 in value)
				{
					if (item2.Result == null)
					{
						continue;
					}
					MiniMapInteractObjIcon component = item2.Result.GetComponent<MiniMapInteractObjIcon>();
					if (component == null)
					{
						continue;
					}
					if (component.type == MapIconType.Transfer || component.type == MapIconType.Temple)
					{
						if (refreshExploreStatus && !component.gameObject.activeSelf)
						{
							QueueExploreIconQuery(component, ref queryIcons, ref queryPositions);
						}
						if (!component.isFinish && component.type == MapIconType.Temple)
						{
							component.RefreshState();
						}
					}
					else if (component.type == MapIconType.OneWayDoorOpposite || component.type == MapIconType.BlockInteract || component.type == MapIconType.OneWayDoor)
					{
						StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(component.GetUid());
						bool flag = worldStateAssetDataBySGOID != null && InteractStateId.IconActive((int)component.type, worldStateAssetDataBySGOID.stateId);
						if (refreshExploreStatus & flag)
						{
							QueueExploreIconQuery(component, ref queryIcons, ref queryPositions);
						}
					}
				}
			}
			if (!cellWorldBossIconInstantiateGO.TryGetValue(item, out var value2))
			{
				continue;
			}
			foreach (InstanceHandle item3 in value2)
			{
				if (item3.Result == null)
				{
					continue;
				}
				MiniMapWorldBossIcon component2 = item3.Result.GetComponent<MiniMapWorldBossIcon>();
				if (!(component2 == null))
				{
					bool flag2 = Model<MonsterHandModel>.Interface.WildBossUnLock(component2.GetWorldBossId());
					if ((component2.IsDisabled.activeSelf & flag2) && Model<MapModel>.Interface.CurrentTraceMapPoint.pointId == component2.GetUid())
					{
						Model<MapModel>.Interface.MapSetupTracePoint((int)component2.mapArea, component2.GetUid(), (int)component2.type, isCancel: true);
					}
					component2.SetIsExplored(flag2);
				}
			}
		}
		if (queryIcons != null)
		{
			if (Model<MapModel>.HasInstance())
			{
				RequestExploreIconStatus(queryIcons, queryPositions);
			}
			else
			{
				ReleaseExploreQueryLists(queryIcons, queryPositions);
			}
		}
	}

	private void QueueExploreIconQuery(MiniMapInteractObjIcon icon, ref List<MiniMapInteractObjIcon> queryIcons, ref List<Vector2> queryPositions)
	{
		if (icon == null)
		{
			return;
		}
		if (mapConfig.IsDefaultUnlockSubArea(icon.GetSubArea()))
		{
			icon.SetActive(isActive: true);
			return;
		}
		if (queryIcons == null)
		{
			queryIcons = ListPool<MiniMapInteractObjIcon>.Get();
		}
		if (queryPositions == null)
		{
			queryPositions = ListPool<Vector2>.Get();
		}
		queryIcons.Add(icon);
		queryPositions.Add(icon.worldPos);
	}

	private static void ReleaseExploreQueryLists<T>(List<T> queryItems, List<Vector2> queryPositions)
	{
		ListPool<T>.Release(queryItems);
		ListPool<Vector2>.Release(queryPositions);
	}

	private void RequestExploreIconStatus(List<MiniMapInteractObjIcon> queryIcons, List<Vector2> queryPositions)
	{
		if (queryIcons == null || queryIcons.Count == 0)
		{
			ReleaseExploreQueryLists(queryIcons, queryPositions);
			return;
		}
		int generation = ++_exploreIconQueryGeneration;
		ACT.World.MapArea area = curAreaLayerInfo.mapArea;
		int version = Model<MapModel>.Interface.GetAreaExploreFogVersion(area);
		bool callbackInvoked = false;
		try
		{
			Model<MapModel>.Interface.RequestIsPosExploredByFogMaskBatch(area, queryPositions, (bool[] explored) =>
			{
				callbackInvoked = true;
				try
				{
					if (Model<MapModel>.HasInstance() && generation == _exploreIconQueryGeneration && area == curAreaLayerInfo.mapArea)
					{
						if (version != Model<MapModel>.Interface.GetAreaExploreFogVersion(area))
						{
							_needRefreshExploreIconStatus = true;
						}
						else if (explored == null || explored.Length < queryIcons.Count)
						{
							_needRefreshExploreIconStatus = true;
						}
						else
						{
							for (int i = 0; i < queryIcons.Count; i++)
							{
								MiniMapInteractObjIcon miniMapInteractObjIcon = queryIcons[i];
								if (miniMapInteractObjIcon != null && !miniMapInteractObjIcon.gameObject.activeSelf)
								{
									miniMapInteractObjIcon.SetActive(explored[i]);
								}
							}
						}
					}
				}
				finally
				{
					ReleaseExploreQueryLists(queryIcons, queryPositions);
				}
			});
		}
		catch
		{
			if (!callbackInvoked)
			{
				ReleaseExploreQueryLists(queryIcons, queryPositions);
			}
			throw;
		}
	}

	private void UpdateInAreaLayer()
	{
		if (curPlayerCellId != prePlayerCellId)
		{
			GetCurNineCell(curAreaLayerInfo.mapArea, curPlayerCellId, ref curNineCell);
			IEnumerable<Vector2Int> enumerable = preNineCell.Except(curNineCell);
			IEnumerable<Vector2Int> enumerable2 = curNineCell.Except(preNineCell);
			if (enumerable.Any())
			{
				RecycleCellImage(enumerable);
				RecycleCellIcon(enumerable);
			}
			if (enumerable2.Any())
			{
				CreateCellImage(curAreaLayerInfo, enumerable2);
				CreateCellIcon(curAreaLayerInfo, enumerable2);
			}
		}
	}

	private void CreateCellImage(MapAreaLayerInfo areaLayerInfo, IEnumerable<Vector2Int> needGetCellId)
	{
		if (!gameObject.activeSelf)
		{
			gameObject.SetActive(value: true);
		}
		foreach (Vector2Int cellId in needGetCellId)
		{
			(int, int) cellRowCol = GetCellRowCol(curAreaLayerInfo.mapArea, cellId);
			foreach (string imageType in _imageTypeList)
			{
				if (!mapConfig.IsValidGridId(curAreaLayerInfo.mapArea, MapLayer.L0, imageType, cellRowCol.Item1, cellRowCol.Item2))
				{
					continue;
				}
				_cellImageHandlePool.GetMapCellImage(areaLayerInfo.mapArea, areaLayerInfo.mapLayer, imageType, cellRowCol.Item1, cellRowCol.Item2, (Sprite result) =>
				{
					Vector2Int _cellId = cellId;
					string _imageType = imageType;
					InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapSingleGridAssetID.GUID);
					instanceHandle.Completed += (InstanceHandle handle) =>
					{
						handle.Result.transform.SetParent(typeRoot[_imageType]);
					};
					if (cellImageInstantiateGO.TryGetValue(_cellId, out var value))
					{
						value.Add(instanceHandle);
					}
					else
					{
						cellImageInstantiateGO.Add(_cellId, new HashSet<InstanceHandle> { instanceHandle });
					}
					instanceHandle.Completed += (InstanceHandle go) =>
					{
						string text = _imageType;
						Material material = ((text == "Room") ? mapConfig.miniMapRoomMaterial : ((!(text == "Detail")) ? null : mapConfig.miniMapDetailMaterial));
						Material mat = material;
						MiniMapSingleGrid component = go.Result.GetComponent<MiniMapSingleGrid>();
						content.GetComponent<SoftMask>().UpdateMaskablesInChildrenImmediate(component.transform);
						component.Init(typeRoot[_imageType], cellSize, (Vector2)_cellId * cellSize, result, mat);
					};
				});
			}
		}
	}

	private void RecycleCellImage(IEnumerable<Vector2Int> recycleCellId)
	{
		foreach (Vector2Int item in recycleCellId)
		{
			if (!cellImageInstantiateGO.TryGetValue(item, out var value))
			{
				continue;
			}
			foreach (InstanceHandle item2 in value)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(item2);
			}
			cellImageInstantiateGO.Remove(item);
		}
	}

	private void HandleMapPointTrace(BaseEventContent e)
	{
		if (e is MapPointTraceRefresh mapPointTraceRefresh)
		{
			if (mapPointTraceRefresh.id != 0)
			{
				CreateGeneralNavButtonIcons(curAreaLayerInfo.mapArea);
			}
			else
			{
				RecycleGeneralPointNavIcon();
			}
		}
	}

	private void CreateCellIcon(MapAreaLayerInfo areaLayerInfo, IEnumerable<Vector2Int> needGetCellId)
	{
		List<PendingExploreIcon> pendingExploreIcons = null;
		List<Vector2> queryPositions = null;
		foreach (Vector2Int item in needGetCellId)
		{
			if (!Model<MapModel>.Interface.TryGetGridDataByGridId(areaLayerInfo.mapArea, areaLayerInfo.mapLayer, item, out var gridData))
			{
				continue;
			}
			foreach (BakeStaticMapIconData staticMapIconDatum in gridData.staticMapIconData)
			{
				bool flag = true;
				bool flag2 = false;
				if (staticMapIconDatum.iconTypeId == 1017)
				{
					StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(staticMapIconDatum.uid);
					if (worldStateAssetDataBySGOID == null)
					{
						flag = false;
					}
					else if (worldStateAssetDataBySGOID.stateId != 1)
					{
						flag2 = !mapConfig.IsDefaultUnlockSubArea(worldStateAssetDataBySGOID.mapSubArea);
						flag = !flag2;
					}
				}
				else if (!staticMapIconDatum.IsWorldBossIcon() && staticMapIconDatum.iconTypeId != 1002)
				{
					if (staticMapIconDatum.iconTypeId == 1001)
					{
						StateWorldAssetData worldStateAssetDataBySGOID2 = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(staticMapIconDatum.uid);
						if (worldStateAssetDataBySGOID2 == null || worldStateAssetDataBySGOID2.stateId != -2)
						{
							flag2 = !mapConfig.IsDefaultUnlockSubArea((MapSubArea)staticMapIconDatum.subAreaId);
							flag = !flag2;
						}
					}
					else if (staticMapIconDatum.iconTypeId == 1021 || staticMapIconDatum.iconTypeId == 1022 || staticMapIconDatum.iconTypeId == 10201)
					{
						flag = MapUtility.InteractObjIsActive(staticMapIconDatum.uid);
						if (flag)
						{
							flag2 = !mapConfig.IsDefaultUnlockSubArea((MapSubArea)staticMapIconDatum.subAreaId);
							flag = !flag2;
						}
					}
					else
					{
						flag = MapUtility.InteractObjIsActive(staticMapIconDatum.uid);
					}
				}
				if (flag2)
				{
					if (pendingExploreIcons == null)
					{
						pendingExploreIcons = ListPool<PendingExploreIcon>.Get();
					}
					if (queryPositions == null)
					{
						queryPositions = ListPool<Vector2>.Get();
					}
					pendingExploreIcons.Add(new PendingExploreIcon(item, staticMapIconDatum));
					queryPositions.Add(staticMapIconDatum.initPos);
				}
				else
				{
					CreateMiniMapIcon(areaLayerInfo, item, staticMapIconDatum, flag);
				}
			}
		}
		if (pendingExploreIcons == null)
		{
			return;
		}
		if (!Model<MapModel>.HasInstance())
		{
			ReleaseExploreQueryLists(pendingExploreIcons, queryPositions);
			return;
		}
		int generation = _exploreIconCreateGeneration;
		ACT.World.MapArea area = areaLayerInfo.mapArea;
		bool callbackInvoked = false;
		try
		{
			Model<MapModel>.Interface.RequestIsPosExploredByFogMaskBatch(area, queryPositions, (bool[] explored) =>
			{
				callbackInvoked = true;
				try
				{
					if (generation == _exploreIconCreateGeneration && area == curAreaLayerInfo.mapArea)
					{
						if (explored == null || explored.Length < pendingExploreIcons.Count)
						{
							_needRefreshExploreIconStatus = true;
						}
						for (int i = 0; i < pendingExploreIcons.Count; i++)
						{
							PendingExploreIcon pendingExploreIcon = pendingExploreIcons[i];
							if (curNineCell.Contains(pendingExploreIcon.cellId))
							{
								bool show = explored != null && i < explored.Length && explored[i];
								CreateMiniMapIcon(areaLayerInfo, pendingExploreIcon.cellId, pendingExploreIcon.data, show);
							}
						}
					}
				}
				finally
				{
					ReleaseExploreQueryLists(pendingExploreIcons, queryPositions);
				}
			});
		}
		catch
		{
			if (!callbackInvoked)
			{
				ReleaseExploreQueryLists(pendingExploreIcons, queryPositions);
			}
			throw;
		}
	}

	private void CreateMiniMapIcon(MapAreaLayerInfo areaLayerInfo, Vector2Int cellId, BakeStaticMapIconData data, bool show)
	{
		if (data.IsWorldBossIcon())
		{
			InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapWorldBossIconPrefabAssetID.GUID);
			instanceHandle.Completed += (InstanceHandle go) =>
			{
				MiniMapWorldBossIcon component = go.Result.GetComponent<MiniMapWorldBossIcon>();
				go.Result.transform.SetParent(interactObjIconRoot);
				component.SetPos(MapUtility.GetAreaOffset(areaLayerInfo.mapArea, data.initPos) * mapConfig.miniMapRatio + mapConfig.miniMapIconOffset);
				component.Init(data, areaLayerInfo.mapArea);
				component.SetIsExplored(Model<MonsterHandModel>.Interface.WildBossUnLock(data.worldBossId));
				component.RefreshState();
				component.gameObject.SetActive(show);
			};
			if (cellWorldBossIconInstantiateGO.TryGetValue(cellId, out var value))
			{
				value.Add(instanceHandle);
				return;
			}
			cellWorldBossIconInstantiateGO.Add(cellId, new HashSet<InstanceHandle> { instanceHandle });
		}
		else
		{
			InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapInteractObjIconPrefabAssetID.GUID);
			instanceHandle.Completed += (InstanceHandle go) =>
			{
				MiniMapInteractObjIcon component = go.Result.GetComponent<MiniMapInteractObjIcon>();
				go.Result.transform.SetParent(interactObjIconRoot);
				component.SetPos(MapUtility.GetAreaOffset(areaLayerInfo.mapArea, data.initPos) * mapConfig.miniMapRatio + mapConfig.miniMapIconOffset);
				component.Init(data, areaLayerInfo.mapArea);
				component.RefreshState();
				component.gameObject.SetActive(show);
			};
			if (cellInteractObjIconInstantiateGO.TryGetValue(cellId, out var value2))
			{
				value2.Add(instanceHandle);
				return;
			}
			cellInteractObjIconInstantiateGO.Add(cellId, new HashSet<InstanceHandle> { instanceHandle });
		}
	}

	private void CreateDynamicNpcIcon(ACT.World.MapArea area)
	{
		UnInitNpcMapIcons();
		foreach (NpcShowEntranceCollection item in Singleton<RuntimeNpcManager>.instance.GetNpcCollectionByMapArea(area))
		{
			int uid = item.NpcConfigUid;
			if (_npcIcons.ContainsKey(uid))
			{
				continue;
			}
			NPCHeadIconConfig.IconConfig spriteId = GameLoader.meta.npcOrInteractObjectIconConfig.FindConfigById(item.TipIconID);
			if (spriteId.id > 0)
			{
				Vector3 npcPos = item.WorldPosition;
				InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapNpcIconPrefabAssetID.GUID);
				instanceHandle.CompleteSync();
				_npcIcons.Add(uid, instanceHandle);
				instanceHandle.Completed += (InstanceHandle go) =>
				{
					MiniMapNpcIcon component = go.Result.GetComponent<MiniMapNpcIcon>();
					go.Result.transform.SetParent(interactObjIconRoot);
					component.SetPos(MapUtility.GetAreaOffset(area, npcPos) * mapConfig.miniMapRatio + mapConfig.miniMapIconOffset);
					component.Init(uid, spriteId.icon, area);
				};
			}
		}
		foreach (ReceiveMissionData receiveMissionData in Singleton<RuntimeNpcManager>.instance.GetReceiveMissionDatas((int)area))
		{
			CreateReceiveMissionIcon(receiveMissionData, area);
		}
	}

	private void CreateReceiveMissionIcon(ReceiveMissionData sideMissionData, ACT.World.MapArea area)
	{
		if (sideMissionData.npcUid <= 0)
		{
			return;
		}
		int uid = sideMissionData.missionId;
		if (!_npcIcons.ContainsKey(uid))
		{
			Vector3 npcPos = Singleton<RuntimeNpcManager>.instance.GetNpcPosition(sideMissionData.npcUid);
			InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapReceiveSideMissionIconPrefabAssetID.GUID);
			instanceHandle.CompleteSync();
			_npcIcons.Add(uid, instanceHandle);
			_receiveMissionIconNpcUids[uid] = sideMissionData.npcUid;
			instanceHandle.Completed += (InstanceHandle go) =>
			{
				MiniMapReceiveSideMissionIcon component = go.Result.GetComponent<MiniMapReceiveSideMissionIcon>();
				go.Result.transform.SetParent(interactObjIconRoot);
				component.SetPos(MapUtility.GetAreaOffset(area, npcPos) * mapConfig.miniMapRatio + mapConfig.miniMapIconOffset);
				component.Init(uid, sideMissionData.npcUid, area, npcPos);
			};
		}
	}

	private void RefreshReceiveMissionIcon(int npcUid, ACT.World.MapArea area)
	{
		if (!Singleton<RuntimeNpcManager>.instance.TryGetReceiveMissionData(npcUid, out var _))
		{
			return;
		}
		foreach (ReceiveMissionData receiveMissionData2 in Singleton<RuntimeNpcManager>.instance.GetReceiveMissionDatas((int)area))
		{
			if (receiveMissionData2.npcUid == npcUid)
			{
				CreateReceiveMissionIcon(receiveMissionData2, area);
			}
		}
	}

	private void RecycleReceiveMissionIconByNpc(int npcUid)
	{
		if (_receiveMissionIconNpcUids.Count == 0)
		{
			return;
		}
		List<int> list = ListPool<int>.Get();
		try
		{
			foreach (KeyValuePair<int, int> receiveMissionIconNpcUid in _receiveMissionIconNpcUids)
			{
				if (receiveMissionIconNpcUid.Value == npcUid)
				{
					list.Add(receiveMissionIconNpcUid.Key);
				}
			}
			foreach (int item in list)
			{
				_receiveMissionIconNpcUids.Remove(item);
				if (_npcIcons.TryGetValue(item, out var value))
				{
					if (value != null)
					{
						PrecacheManager.Instance.ReleaseInstanceHandle(value);
					}
					_npcIcons.Remove(item);
				}
			}
		}
		finally
		{
			ListPool<int>.Release(list);
		}
	}

	private void OnMissionAccepted(BaseEventContent eventContent)
	{
		if (eventContent is MissionNAcceptEvt missionNAcceptEvt && _npcIcons.TryGetValue(missionNAcceptEvt.missionId, out var value) && !(value?.Result == null) && value.Result.TryGetComponent<MiniMapReceiveSideMissionIcon>(out var component))
		{
			component.RefreshState();
		}
	}

	private void RecycleCellIcon(IEnumerable<Vector2Int> recycleCellId)
	{
		foreach (Vector2Int item in recycleCellId)
		{
			if (cellInteractObjIconInstantiateGO.TryGetValue(item, out var value))
			{
				foreach (InstanceHandle item2 in value)
				{
					if (item2.Result != null)
					{
						item2.Result.GetComponent<MiniMapInteractObjIcon>().UnInit();
					}
					PrecacheManager.Instance.ReleaseInstanceHandle(item2);
				}
				cellInteractObjIconInstantiateGO.Remove(item);
			}
			if (!cellWorldBossIconInstantiateGO.TryGetValue(item, out var value2))
			{
				continue;
			}
			foreach (InstanceHandle item3 in value2)
			{
				if (item3.Result != null)
				{
					item3.Result.GetComponent<MiniMapWorldBossIcon>().UnInit();
				}
				PrecacheManager.Instance.ReleaseInstanceHandle(item3);
			}
			cellWorldBossIconInstantiateGO.Remove(item);
		}
	}

	public void OnServiceSaveRefresh(BaseEventContent obj)
	{
		ServiceStateRefresh serviceStateRefresh = (ServiceStateRefresh)obj;
		int swid = serviceStateRefresh.swid;
		Vector2Int key;
		HashSet<InstanceHandle> value;
		if (MapUtility.ConfigWorldMapGraph.IsStaticMapIcon(swid))
		{
			_needRefreshExploreIconStatus = true;
			foreach (KeyValuePair<Vector2Int, HashSet<InstanceHandle>> item in cellInteractObjIconInstantiateGO)
			{
				item.Deconstruct(out key, out value);
				foreach (InstanceHandle item2 in value)
				{
					if (!(item2.Result == null) && item2.Result.TryGetComponent<MiniMapInteractObjIcon>(out var component) && component.GetUid() == swid)
					{
						component.RefreshState();
					}
				}
			}
		}
		foreach (KeyValuePair<Vector2Int, HashSet<InstanceHandle>> item3 in cellWorldBossIconInstantiateGO)
		{
			item3.Deconstruct(out key, out value);
			foreach (InstanceHandle item4 in value)
			{
				if (!(item4.Result == null) && item4.Result.TryGetComponent<MiniMapWorldBossIcon>(out var component2) && component2.GetCollectionUid() == swid)
				{
					component2.RefreshState();
				}
			}
		}
		if (Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(swid) is LightHouseData lightHouseData && serviceStateRefresh.stateId == -2)
		{
			foreach (KeyValuePair<Vector2Int, HashSet<InstanceHandle>> item5 in cellInteractObjIconInstantiateGO)
			{
				item5.Deconstruct(out key, out value);
				foreach (InstanceHandle item6 in value)
				{
					MiniMapInteractObjIcon component3 = item6.Result.GetComponent<MiniMapInteractObjIcon>();
					int interactObjIconUid = component3.GetUid();
					if (lightHouseData.interactIcons.Any((LightHouseInteracts _) => (int)_.uid == interactObjIconUid))
					{
						component3.RefreshState();
					}
				}
			}
		}
		RefreshUnlockMaskVisibility(swid);
	}

	private void OnMapModelDynamicNpcHide(int npcUid)
	{
		if (_npcIcons.TryGetValue(npcUid, out var value) && value != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(value);
			_npcIcons.Remove(npcUid);
		}
		RecycleReceiveMissionIconByNpc(npcUid);
	}

	private void OnMapModelDynamicNpcShow(int npcUid)
	{
		RefreshReceiveMissionIcon(npcUid, curAreaLayerInfo.mapArea);
		if (_npcIcons.ContainsKey(npcUid))
		{
			return;
		}
		foreach (NpcShowEntranceCollection item in Singleton<RuntimeNpcManager>.instance.GetNpcCollectionByMapArea(curAreaLayerInfo.mapArea))
		{
			int uid = item.NpcConfigUid;
			if (uid != npcUid)
			{
				continue;
			}
			NPCHeadIconConfig.IconConfig spriteId = GameLoader.meta.npcOrInteractObjectIconConfig.FindConfigById(item.TipIconID);
			if (spriteId.id > 0)
			{
				Vector3 npcPos = item.WorldPosition;
				InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapNpcIconPrefabAssetID.GUID);
				_npcIcons.Add(uid, instanceHandle);
				instanceHandle.Completed += (InstanceHandle go) =>
				{
					MiniMapNpcIcon component = go.Result.GetComponent<MiniMapNpcIcon>();
					go.Result.transform.SetParent(interactObjIconRoot);
					component.SetPos(MapUtility.GetAreaOffset(curAreaLayerInfo.mapArea, npcPos) * mapConfig.miniMapRatio + mapConfig.miniMapIconOffset);
					component.Init(uid, spriteId.icon, curAreaLayerInfo.mapArea);
				};
			}
			break;
		}
	}

	private void CreateGeneralNavButtonIcons(ACT.World.MapArea area)
	{
		if (Model<MapModel>.Interface.CurrentTraceMapPoint == null)
		{
			return;
		}
		MapPointTraceInfo curTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
		if (_generalPointInstantiateGO != null || _generalPointNavIcon != null || curTraceMapPoint.mapArea != area)
		{
			RecycleGeneralPointNavIcon();
		}
		if (_generalPointInstantiateGO != null || !(_generalPointNavIcon == null) || curTraceMapPoint.mapArea != area)
		{
			return;
		}
		if (curTraceMapPoint.iconType == MapIconType.SelfPoint)
		{
			_generalPointInstantiateGO = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapSelfNodeIconPrefabAssetD.GUID);
		}
		else if (curTraceMapPoint.iconType == MapIconType.Npc)
		{
			_generalPointInstantiateGO = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapNpcIconPrefabAssetID.GUID);
		}
		else if (curTraceMapPoint.iconType == MapIconType.SideMission)
		{
			_generalPointInstantiateGO = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapReceiveSideMissionIconPrefabAssetID.GUID);
		}
		else if (curTraceMapPoint.iconType == MapIconType.WorldBoss)
		{
			_generalPointInstantiateGO = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapWorldBossIconPrefabAssetID.GUID);
		}
		else
		{
			_generalPointInstantiateGO = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapInteractObjIconPrefabAssetID.GUID);
		}
		_generalPointInstantiateGO.Completed += (InstanceHandle go) =>
		{
			switch (curTraceMapPoint.iconType)
			{
			case MapIconType.SelfPoint:
				_generalPointNavIcon = go.Result.GetComponent<MiniMapSelfNodeIcon>();
				break;
			case MapIconType.Npc:
				_generalPointNavIcon = go.Result.GetComponent<MiniMapNpcIcon>();
				break;
			case MapIconType.SideMission:
				_generalPointNavIcon = go.Result.GetComponent<MiniMapReceiveSideMissionIcon>();
				break;
			case MapIconType.WorldBoss:
				_generalPointNavIcon = go.Result.GetComponent<MiniMapWorldBossIcon>();
				break;
			default:
				_generalPointNavIcon = go.Result.GetComponent<MiniMapInteractObjIcon>();
				break;
			}
			go.Result.transform.SetParent(missionIconRoot);
			if (_generalPointNavIcon is MiniMapSelfNodeIcon miniMapSelfNodeIcon && _selfNodeIconHandles.TryGetValue(curTraceMapPoint.pointId, out var value) && value.IsDone)
			{
				MiniMapSelfNodeIcon component = value.Result.GetComponent<MiniMapSelfNodeIcon>();
				miniMapSelfNodeIcon.Init(component.GetNodeData(), _station);
				miniMapSelfNodeIcon.gameObject.SetActive(value: true);
				miniMapSelfNodeIcon.SetIsTrack(isTrack: true);
			}
			if (_generalPointNavIcon is MiniMapNpcIcon miniMapNpcIcon)
			{
				foreach (NpcShowEntranceCollection item in Singleton<RuntimeNpcManager>.instance.GetNpcCollectionByMapArea(area))
				{
					int npcConfigUid = item.NpcConfigUid;
					if (npcConfigUid == curTraceMapPoint.pointId)
					{
						Vector3 worldPosition = item.WorldPosition;
						NPCHeadIconConfig.IconConfig iconConfig = GameLoader.meta.npcOrInteractObjectIconConfig.FindConfigById(item.TipIconID);
						miniMapNpcIcon.Init(npcConfigUid, iconConfig.icon, area);
						miniMapNpcIcon.gameObject.SetActive(value: true);
						miniMapNpcIcon.worldPos = worldPosition;
						miniMapNpcIcon.SetIsTrack(isTrack: true);
						break;
					}
				}
			}
			else if (_generalPointNavIcon is MiniMapReceiveSideMissionIcon miniMapReceiveSideMissionIcon)
			{
				foreach (ReceiveMissionData receiveMissionData in Singleton<RuntimeNpcManager>.instance.GetReceiveMissionDatas((int)area))
				{
					int missionId = receiveMissionData.missionId;
					if (missionId == curTraceMapPoint.pointId)
					{
						Vector3 npcPosition = Singleton<RuntimeNpcManager>.instance.GetNpcPosition(receiveMissionData.npcUid);
						miniMapReceiveSideMissionIcon.Init(missionId, receiveMissionData.npcUid, area, npcPosition);
						miniMapReceiveSideMissionIcon.gameObject.SetActive(value: true);
						miniMapReceiveSideMissionIcon.SetIsTrack(isTrack: true);
						break;
					}
				}
			}
			else if (_generalPointNavIcon is MiniMapInteractObjIcon miniMapInteractObjIcon)
			{
				List<BakeStaticMapIconData> mapIconDataByAreaAndType = MapUtility.GetMapIconDataByAreaAndType(curAreaLayerInfo.mapArea, curTraceMapPoint.iconType);
				if (mapIconDataByAreaAndType.Count > 0)
				{
					foreach (BakeStaticMapIconData item2 in mapIconDataByAreaAndType)
					{
						if (item2.uid == curTraceMapPoint.pointId)
						{
							miniMapInteractObjIcon.Init(item2, curAreaLayerInfo.mapArea);
							miniMapInteractObjIcon.gameObject.SetActive(value: true);
							miniMapInteractObjIcon.SetIsTrack(isTrack: true);
							break;
						}
					}
				}
			}
			else if (_generalPointNavIcon is MiniMapWorldBossIcon miniMapWorldBossIcon)
			{
				List<BakeStaticMapIconData> mapIconDataByAreaAndType2 = MapUtility.GetMapIconDataByAreaAndType(curAreaLayerInfo.mapArea, curTraceMapPoint.iconType);
				if (mapIconDataByAreaAndType2.Count > 0)
				{
					foreach (BakeStaticMapIconData item3 in mapIconDataByAreaAndType2)
					{
						if (item3.uid == curTraceMapPoint.pointId)
						{
							miniMapWorldBossIcon.Init(item3, curAreaLayerInfo.mapArea);
							miniMapWorldBossIcon.SetIsExplored(Model<MonsterHandModel>.Interface.WildBossUnLock(item3.worldBossId));
							miniMapWorldBossIcon.gameObject.SetActive(value: true);
							miniMapWorldBossIcon.SetIsTrack(isTrack: true);
							break;
						}
					}
				}
			}
			_generalPointNavIcon.SetPos(GetPosInMiniMapCanSeeRect(_generalPointNavIcon.worldPos));
		};
	}

	private void CreateMonsterPointNavIcon()
	{
		if (Model<TrackModel>.Interface.IsTrackingMonsterPoint && Model<TrackModel>.Interface.GetTrackMonsterPointMapArea() == curAreaLayerInfo.mapArea)
		{
			int monsterPointId = Model<TrackModel>.Interface.GetTrackMonsterPointId();
			_monsterPointNavIconInstantiateGo = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapMonsterPointIconPrefabAssetID.GUID);
			_monsterPointNavIconInstantiateGo.Completed += (InstanceHandle go) =>
			{
				_monsterPointNavIcon = go.Result.GetComponent<MiniMapMonsterPointIcon>();
				go.Result.transform.SetParent(specialPointIconRoot);
				_monsterPointNavIcon.Init(curAreaLayerInfo.mapArea, monsterPointId, Model<MaterialTrackModel>.Interface.GetTrackEnemyId());
				_monsterPointNavIcon.SetIsTrack(isTrack: true);
				_monsterPointNavIcon.worldPos = Model<TrackModel>.Interface.GetTrackMonsterPointWorldPos();
				UpdateMonsterPointNavIcon();
			};
		}
	}

	private void RecycleMonsterPointNavIcon()
	{
		if (_monsterPointNavIconInstantiateGo != null && _monsterPointNavIcon != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(_monsterPointNavIconInstantiateGo);
			_monsterPointNavIconInstantiateGo = null;
			_monsterPointNavIcon = null;
		}
	}

	private void UpdateMonsterPointNavIcon()
	{
		if (!(_monsterPointNavIcon == null))
		{
			_monsterPointNavIcon.SetPos(GetPosInMiniMapCanSeeRect(_monsterPointNavIcon.worldPos));
		}
	}

	private void CreateCollectionPointNavIcon()
	{
		if (Model<TrackModel>.Interface.IsTrackingCollectionPoint && Model<TrackModel>.Interface.GetTrackCollectionMapArea() == curAreaLayerInfo.mapArea)
		{
			int collectPointId = Model<TrackModel>.Interface.GetTrackCollectionPointId();
			_collectPointNavIconInstantiateGo = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapCollectPointIconPrefabAssetID.GUID);
			_collectPointNavIconInstantiateGo.Completed += (InstanceHandle go) =>
			{
				_collectPointNavIcon = go.Result.GetComponent<MiniMapCollectPointIcon>();
				go.Result.transform.SetParent(specialPointIconRoot);
				_collectPointNavIcon.Init(curAreaLayerInfo.mapArea, collectPointId, Model<TrackModel>.Interface.GetTrackCollectionPointConfigId());
				_collectPointNavIcon.SetIsTrack(isTrack: true);
				_collectPointNavIcon.worldPos = Model<TrackModel>.Interface.GetTrackCollectionPointWorldPos();
				UpdateCollectionPointNavIcon();
			};
		}
	}

	private void RecycleCollectPointNavIcon()
	{
		if (_collectPointNavIconInstantiateGo != null && _collectPointNavIcon != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(_collectPointNavIconInstantiateGo);
			_collectPointNavIconInstantiateGo = null;
			_collectPointNavIcon = null;
		}
	}

	private void UpdateCollectionPointNavIcon()
	{
		if (!(_collectPointNavIcon == null))
		{
			_collectPointNavIcon.SetPos(GetPosInMiniMapCanSeeRect(_collectPointNavIcon.worldPos));
		}
	}

	private void UpdateSpecialPointNavIcon()
	{
		UpdateMonsterPointNavIcon();
		UpdateCollectionPointNavIcon();
	}

	private void RecycleSpecialPointNavIcon()
	{
		RecycleMonsterPointNavIcon();
		RecycleCollectPointNavIcon();
	}

	private void OnTrackModelTrackMonsterPointChanged()
	{
		RecycleMonsterPointNavIcon();
		CreateMonsterPointNavIcon();
	}

	private void OnTrackModelTrackCollectionPointChanged()
	{
		RecycleCollectPointNavIcon();
		CreateCollectionPointNavIcon();
	}

	private void UpdateGeneralPointNavIcon()
	{
		if (Model<MapModel>.Interface.CurrentTraceMapPoint != null && !(_generalPointNavIcon == null))
		{
			_generalPointNavIcon.SetPos(GetPosInMiniMapCanSeeRect(_generalPointNavIcon.worldPos));
		}
	}

	private void OnMissionArrowRemoved(BaseEventContent obj)
	{
		OnMapModelMissionPointUpdate();
	}

	private void OnMissionArrowAdded(BaseEventContent obj)
	{
		OnMapModelMissionPointUpdate();
	}

	private void CreateMissionPointIcon()
	{
		OnMapModelMissionPointUpdate();
	}

	private void CreateSingleMissionPointIcon(MissionPointData missionPointData)
	{
		if (_pointId2Icon.ContainsKey(missionPointData.PointId) || missionPointData.MapArea != curAreaLayerInfo.mapArea)
		{
			return;
		}
		InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapMissionIconPrefabAssetID.GUID);
		_pointId2Icon[missionPointData.PointId] = new MissionWrapper(missionPointData, instanceHandle);
		instanceHandle.Completed += (InstanceHandle go) =>
		{
			MiniMapMissionIcon component = go.Result.GetComponent<MiniMapMissionIcon>();
			go.Result.transform.SetParent(missionIconRoot);
			component.Init(missionPointData);
			if (missionPointData.ShowRadius)
			{
				go.Result.transform.SetParent(interactObjIconRoot);
			}
			component.UpdateScale(1f);
		};
	}

	private void RecycleMissionPointIcon(int pointId)
	{
		if (_pointId2Icon.TryGetValue(pointId, out var value))
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(value.Go);
			_pointId2Icon.Remove(pointId);
		}
	}

	private void RefreshMissionPoint(BaseEventContent baseEventContent)
	{
		OnMapModelMissionPointUpdate();
	}

	private void OnMapModelMissionPointUpdate()
	{
		IReadOnlyList<MissionPointData> points = Model<BattleMainMarkModelV2>.Interface.Points;
		BSet<int> bSet = BSetPool<int>.Default.Get();
		foreach (KeyValuePair<int, MissionWrapper> item in _pointId2Icon)
		{
			var (pointId, _) = item;
			if (points.All((MissionPointData x) => x.PointId != pointId))
			{
				bSet.Add(pointId);
			}
		}
		foreach (int item2 in bSet)
		{
			RecycleMissionPointIcon(item2);
		}
		BSetPool<int>.Default.Recycle(bSet);
		foreach (MissionPointData item3 in points)
		{
			CreateSingleMissionPointIcon(item3);
		}
	}

	private void UpdateMissionNavIcon()
	{
		foreach (var (missionPointId, missionWrapper2) in _pointId2Icon)
		{
			if (missionWrapper2.Icon == null)
			{
				continue;
			}
			MissionPointData missionPointData = Model<BattleMainMarkModelV2>.Interface.GetMissionPointData(missionPointId);
			if (missionPointData != null)
			{
				if (missionPointData.ShowRadius)
				{
					missionWrapper2.Icon.SetPos(MapUtility.GetAreaOffset(curAreaLayerInfo.mapArea, missionPointData.GetGuidePointPosition()) * mapConfig.miniMapRatio + mapConfig.miniMapIconOffset);
				}
				else
				{
					missionWrapper2.Icon.SetPos(GetPosInMiniMapCanSeeRect(missionPointData.GetGuidePointPosition()));
				}
			}
		}
	}

	private void Reset()
	{
		_exploreIconQueryGeneration++;
		_exploreIconCreateGeneration++;
		RecycleAll();
		_lastExploreFogVersion = -1;
		_needRefreshExploreIconStatus = true;
		prePlayerCellId = Vector2Int.one * -1;
		curPlayerCellId = Vector2Int.zero;
		preNineCell.Clear();
		curNineCell.Clear();
	}

	private void RecycleAll()
	{
		RecycleUnlockMasks();
		foreach (KeyValuePair<Vector2Int, HashSet<InstanceHandle>> item2 in cellImageInstantiateGO)
		{
			foreach (InstanceHandle item3 in item2.Value)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(item3);
			}
		}
		cellImageInstantiateGO.Clear();
		foreach (KeyValuePair<Vector2Int, HashSet<InstanceHandle>> item4 in cellInteractObjIconInstantiateGO)
		{
			foreach (InstanceHandle item5 in item4.Value)
			{
				if (item5.Result != null)
				{
					item5.Result.GetComponent<MiniMapInteractObjIcon>()?.UnInit();
				}
				PrecacheManager.Instance.ReleaseInstanceHandle(item5);
			}
		}
		cellInteractObjIconInstantiateGO.Clear();
		foreach (KeyValuePair<Vector2Int, HashSet<InstanceHandle>> item6 in cellWorldBossIconInstantiateGO)
		{
			foreach (InstanceHandle item7 in item6.Value)
			{
				if (item7.Result != null)
				{
					item7.Result.GetComponent<MiniMapWorldBossIcon>()?.UnInit();
				}
				PrecacheManager.Instance.ReleaseInstanceHandle(item7);
			}
		}
		cellWorldBossIconInstantiateGO.Clear();
		RecycleSpecialPointNavIcon();
		BSet<int> bSet = BSetPool<int>.Default.Get();
		foreach (var (item, _) in _pointId2Icon)
		{
			bSet.Add(item);
		}
		foreach (int item8 in bSet)
		{
			RecycleMissionPointIcon(item8);
		}
		BSetPool<int>.Default.Recycle(bSet);
	}

	private Vector2 GetPlayerWorldOffset(ACT.World.MapArea area)
	{
		return (Vector2)MapUtility.playerPos - GameLoader.meta.mapConfig.GetAreaLeftBottomWorldPos(area);
	}

	private Vector2Int GetPlayerCellId(Vector2 worldOffset)
	{
		return new Vector2Int(Mathf.FloorToInt(worldOffset.x / 51.2f), Mathf.FloorToInt(worldOffset.y / 51.2f));
	}

	private (int cellRow, int cellCol) GetCellRowCol(ACT.World.MapArea area, Vector2Int cellId)
	{
		return (cellRow: mapConfig.GetAreaWidthHeightCellNum(area).y - cellId.y - 1, cellCol: cellId.x);
	}

	private void GetCurNineCell(ACT.World.MapArea area, Vector2Int playerCellId, ref HashSet<Vector2Int> nineCell)
	{
		Vector2Int areaWidthHeightCellNum = mapConfig.GetAreaWidthHeightCellNum(area);
		nineCell.Clear();
		for (int i = playerCellId.x - 1; i <= playerCellId.x + 1; i++)
		{
			for (int j = playerCellId.y - 1; j <= playerCellId.y + 1; j++)
			{
				if (i >= 0 && i < areaWidthHeightCellNum.x && j >= 0 && j < areaWidthHeightCellNum.y)
				{
					nineCell.Add(new Vector2Int(i, j));
				}
			}
		}
	}

	private bool RectInMiniMapCanSeeRect(RectTransform rectTransform)
	{
		rectTransform.GetWorldCorners(_corners);
		if (!PosInMiniMapCanSeeRect(_corners[0]) && !PosInMiniMapCanSeeRect(_corners[1]) && !PosInMiniMapCanSeeRect(_corners[2]))
		{
			return PosInMiniMapCanSeeRect(_corners[3]);
		}
		return true;
	}

	private bool PosInMiniMapCanSeeRect(Vector3 worldPos)
	{
		if (worldPos.x >= xMin && worldPos.x <= xMax && worldPos.y >= yMin)
		{
			return worldPos.y <= yMax;
		}
		return false;
	}

	private float GetK(Vector2 pos1, Vector2 pos2)
	{
		return (pos2.y - pos1.y) / (pos2.x - pos1.x);
	}

	private Vector2 GetPosInMiniMapCanSeeRect(Vector3 worldPos)
	{
		Vector2 vector = (Vector2)(worldPos - MapUtility.playerPos) * mapConfig.miniMapRatio;
		inCanSeeRectReturnVal.x = Mathf.Clamp(vector.x, 0f - _halfMinimapWidth + 15f, _halfMinimapWidth - 15f);
		inCanSeeRectReturnVal.y = Mathf.Clamp(vector.y, 0f - _halfMinimapHeight + 15f, _halfMinimapHeight - 15f);
		return inCanSeeRectReturnVal;
	}

	private void OnDestroy()
	{
		OnRelease();
	}

	private void InitSelfNodeSystem()
	{
		if (_selfNodeImageStation == null)
		{
			_selfNodeImageStation = _station;
		}
		MapSelfNodeModel mapSelfNodeModel = Model<MapSelfNodeModel>.Interface;
		if (mapSelfNodeModel != null)
		{
			mapSelfNodeModel.OnSelfNodeAdded += OnSelfNodeAdded;
			mapSelfNodeModel.OnSelfNodeRemoved += OnSelfNodeRemoved;
			mapSelfNodeModel.OnSelfNodeModified += OnSelfNodeModified;
		}
	}

	private void UnInitSelfNodeSystem()
	{
		MapSelfNodeModel mapSelfNodeModel = Model<MapSelfNodeModel>.Interface;
		if (mapSelfNodeModel != null)
		{
			mapSelfNodeModel.OnSelfNodeAdded -= OnSelfNodeAdded;
			mapSelfNodeModel.OnSelfNodeRemoved -= OnSelfNodeRemoved;
			mapSelfNodeModel.OnSelfNodeModified -= OnSelfNodeModified;
		}
		RecycleSelfNodeIcons();
	}

	private void CreateSelfNodeMapIcons(ACT.World.MapArea area)
	{
		RecycleSelfNodeIcons();
		List<SelfNodeData> selfNodesByArea = Model<MapSelfNodeModel>.Interface.GetSelfNodesByArea(area);
		if (selfNodesByArea == null || selfNodesByArea.Count == 0)
		{
			return;
		}
		foreach (SelfNodeData item in selfNodesByArea)
		{
			CreateSelfNodeIcon(item);
		}
	}

	private void CreateSelfNodeIcon(SelfNodeData nodeData)
	{
		if (nodeData == null)
		{
			return;
		}
		if (_selfNodeIconHandles.ContainsKey(nodeData.id))
		{
			Debug.LogWarning($"[LargeMapView] 自定义标点 {nodeData.id} 已存在");
			return;
		}
		InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.miniMapSelfNodeIconPrefabAssetD.GUID);
		instanceHandle.Completed += (InstanceHandle go) =>
		{
			MiniMapSelfNodeIcon component = go.Result.GetComponent<MiniMapSelfNodeIcon>();
			go.Result.transform.SetParent(interactObjIconRoot);
			InitSelfNodeIcon(component, nodeData);
		};
		_selfNodeIconHandles.Add(nodeData.id, instanceHandle);
	}

	private void InitSelfNodeIcon(MiniMapSelfNodeIcon icon, SelfNodeData nodeData)
	{
		icon.SetPos(MapUtility.GetAreaOffset(nodeData.mapArea, nodeData.worldPos) * mapConfig.miniMapRatio + mapConfig.miniMapIconOffset);
		icon.Init(nodeData, _selfNodeImageStation);
	}

	private void RecycleGeneralPointNavIcon()
	{
		if (_generalPointInstantiateGO != null && _generalPointNavIcon != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(_generalPointInstantiateGO);
			_generalPointInstantiateGO = null;
			_generalPointNavIcon = null;
		}
	}

	private void RecycleSelfNodeIcons()
	{
		foreach (KeyValuePair<int, InstanceHandle> selfNodeIconHandle in _selfNodeIconHandles)
		{
			if ((bool)selfNodeIconHandle.Value.Result)
			{
				selfNodeIconHandle.Value.Result.GetComponent<MiniMapSelfNodeIcon>().UnInit();
			}
			PrecacheManager.Instance.ReleaseInstanceHandle(selfNodeIconHandle.Value);
		}
		_selfNodeIconHandles.Clear();
	}

	private void RecycleSelfNodeIcon(int nodeId)
	{
		if (_selfNodeIconHandles.TryGetValue(nodeId, out var value))
		{
			if ((bool)value.Result)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(value);
			}
			_selfNodeIconHandles.Remove(nodeId);
		}
	}

	private void UnInitNpcMapIcons()
	{
		if (_npcIcons == null)
		{
			return;
		}
		foreach (KeyValuePair<int, InstanceHandle> npcIcon in _npcIcons)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(npcIcon.Value);
		}
		_npcIcons.Clear();
		_receiveMissionIconNpcUids.Clear();
	}

	private void OnSelfNodeAdded(SelfNodeData nodeData)
	{
		if (nodeData.mapArea == curAreaLayerInfo.mapArea)
		{
			CreateSelfNodeIcon(nodeData);
		}
	}

	private void OnSelfNodeRemoved(int nodeId)
	{
		RecycleSelfNodeIcon(nodeId);
	}

	private void OnSelfNodeModified(SelfNodeData nodeData)
	{
		if (_selfNodeIconHandles.TryGetValue(nodeData.id, out var value))
		{
			value.Result.GetComponent<MiniMapSelfNodeIcon>().ChangeIconType(nodeData.iconTypeId);
		}
	}
}
