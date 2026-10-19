using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.MissionSystem;
using ACT.Model;
using ACT.NPC;
using ACT.UI.InputController;
using ACT.UI.VirtualCursor;
using ACT.Utility;
using ACT.ViewControl;
using ACT.World;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Collections;
using Bamboo.ImageCenter;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using Utility;

namespace ACT.UI;

public class LargeMapView : BaseUIView<LargeMapViewInputController>
{
	private LargeMapViewData m_data;

	private List<int> _unlockFogAnimationIds;

	private bool _isUnlockFogMaterialReady;

	private bool _isUnlockFogAnimationRequested;

	private bool interactIconLoaded;

	[Space(50f)]
	public GameObject worldMapRoot;

	public BImage curWorldIcon;

	public WorldMapScrollRect worldMapScrollRect;

	public WorldAreaSideInfo worldAreaSide;

	public BetterAnimation worldMapAnimation;

	public LargeMapMask worldMapMask;

	public BackToWorldMapBtn backToWorldMapBtn;

	public OpenTempleMapBtn goToTempleMapBtn;

	public GameObject templeMapRoot;

	public TempleMapScrollRect templeMapScrollRect;

	[OdinSerialize]
	public Dictionary<ACT.World.MapArea, EnterAreaMapBtn> enterAreaBtnDic;

	[OdinSerialize]
	public Dictionary<ACT.World.MapArea, List<GameObject>> enterAreaImageDic;

	public GameObject areaMapRoot;

	public AreaMapScrollRect areaMapScrollRect;

	public RectTransform areaGridRoot;

	public GameObject areaInfoRoot;

	public AreaInfo areaInfo;

	public AreaExploreInfo areaExploreInfo;

	public RectTransform iconRoot;

	public RectTransform missionIconRoot;

	public RectTransform selfNodeIconRoot;

	public RectTransform areaBlockRoot;

	public RectTransform rewardBoxRoot;

	public MapPlayerIcon mapPlayerIcon;

	public LargeMapScaleSlider areaMapScaleSlider;

	public GameObject navBtnRoot;

	public NavButton playerNavBtn;

	public ComputeShader cs;

	[SerializeField]
	private float keyboardMoveSpeed = 1600f;

	[SerializeField]
	private float keyboardMoveSmooth = 50f;

	[SerializeField]
	private bool enableKeyboardControl = true;

	[SerializeField]
	private bool enableMouseWheelZoom = true;

	[SerializeField]
	private float mouseWheelZoomSpeed = 0.1f;

	[SerializeField]
	private float mouseWheelZoomSmooth = 10f;

	[SerializeField]
	private bool enableMouseCenterZoom;

	public LargeMapIconSidebar iconSidebar;

	public AnimateToggle animateToggle;

	public AreaMapVagueSelectList vagueSelectList;

	public ExploreRatioSidebar exploreRatioSidebar;

	public GameObject buttonGroup;

	public GamepadVirtualCursor virtualCursor;

	[OdinSerialize]
	public Dictionary<SubControllerType, List<GameObject>> ViewControlPrompt;

	[OdinSerialize]
	public Dictionary<SubControllerType, ViewControlLayer> ViewControlLayers;

	public GamePadTipsComp gamePadTips;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	private const int LocalizeSelect = 774;

	private const int LocalizePlace = 2628;

	[HideInInspector]
	public MapConfig mapConfig;

	private MapLayer curShowLayer;

	private ACT.World.MapArea playerArea;

	private ACT.World.MapArea curShowArea;

	private AreaGrid areaGrid;

	private AssetLoadHandle areaGridLoadHandle;

	private Matrix4x4 transformMatrix;

	private bool isNav;

	private Tween navTween;

	private Vector2 keyboardMoveInput;

	private Vector2 currentKeyboardVelocity;

	private bool isKeyboardControlling;

	private float targetScale;

	private float currentScale;

	private bool isMouseWheelZooming;

	private Vector2 lastMouseWheelZoomCenter;

	private LargeMapIcon accurateSelectIcon;

	private LargeMapIcon vagueSelectIcon;

	private HashSet<InstanceHandle> instantiateMapIcon;

	private HashSet<LargeMapInteractObjIcon> _templeIconDatas;

	private BSet<LargeMapBossRoomIcon> _instantiateBossRoomIconSet;

	private Dictionary<LargeMapMissionIcon, NavButton> missionIconNavBtnDic;

	private InstanceHandle _generalPointInstantiateGO;

	private NavButton _generalPointNavBtn;

	private InstanceHandle _trackSpecialPointInstantiateGO;

	private NavButton _specialPointNavBtn;

	private bool guideOpen;

	private MonsterTrackPointData _wantTrackMaterialTrackMonsterPointData;

	private MonsterPointData _wantTrackMonsterPointData;

	private int _trackMonsterId;

	private ACT.World.MapArea _wantTrackMonsterPointMapArea;

	private MapLayer _wantTrackMonsterPointMapLayer;

	private Dictionary<MapSubArea, List<MonsterTrackPointData>> _canTrackMonsterPointData;

	private CollectionTrackPointData _wantTrackCollectionPointData;

	private CollectionPointData _wantCollectionPointData;

	private int _trackCollectionConfigId;

	private ACT.World.MapArea _wantTrackCollectionPointMapArea;

	private Dictionary<MapSubArea, List<CollectionTrackPointData>> _canTrackCollectionPointData;

	private bool _hasSelectedOpenIcon;

	private Vector2 leftStickV2 = Vector2.zero;

	private List<LargeMapIcon> nearIcon = new List<LargeMapIcon>();

	private Dictionary<int, InstanceHandle> _selfNodeIconHandles = new Dictionary<int, InstanceHandle>();

	private bool _isPlacingMarker;

	private SelfNodeData _tempSelfNodeData;

	private InstanceHandle _tempGo;

	private int _selectedMarkerIconTypeId = 1;

	private ImageAssetStation _selfNodeImageStation;

	public bool InteractIconLoaded => interactIconLoaded;

	private float curScale => areaMapScrollRect.content.localScale.x;

	public MapLayer CurShowLayer => curShowLayer;

	public ACT.World.MapArea CurShowArea => curShowArea;

	public bool SameArea => curShowArea == playerArea;

	public AreaGrid AreaGrid => areaGrid;

	private bool IsOperating
	{
		get
		{
			if (!iconSidebar.IsOperating && !vagueSelectList.IsOperating)
			{
				return exploreRatioSidebar.IsOperating;
			}
			return true;
		}
	}

	public bool IsNav
	{
		get
		{
			return isNav;
		}
		set
		{
			if (isNav != value)
			{
				isNav = value;
				areaMapScrollRect.vertical = !isNav;
				areaMapScrollRect.horizontal = !isNav;
				if (isNav)
				{
					keyboardMoveInput = Vector2.zero;
					currentKeyboardVelocity = Vector2.zero;
					LeftStick = Vector2.zero;
					isKeyboardControlling = false;
				}
			}
		}
	}

	public HashSet<LargeMapInteractObjIcon> templeIconDatas => _templeIconDatas;

	public bool GuideOpen
	{
		get
		{
			return guideOpen;
		}
		set
		{
			guideOpen = value;
		}
	}

	private bool UnlockOpen
	{
		get
		{
			if (m_data != null)
			{
				return mapConfig.IsValidUnlockFogAll(m_data.unlockFogIds);
			}
			return false;
		}
	}

	public bool templeOpen { get; set; }

	public bool templeDungeonOpen
	{
		get
		{
			if (m_data != null)
			{
				return m_data.templeDungeonId > 0;
			}
			return false;
		}
	}

	public bool MapIconOpen
	{
		get
		{
			if (m_data != null)
			{
				return m_data.selectPointId > 0;
			}
			return false;
		}
	}

	public bool NpcOpen
	{
		get
		{
			if (m_data != null)
			{
				return m_data.jumpNpcId > 0;
			}
			return false;
		}
	}

	private bool SpecifiedPosOpen => m_data?.missionOpen ?? false;

	private bool SpecifiedAreaOpen => m_data?.AreaOpen ?? false;

	private bool HasWantTrackMonsterId
	{
		get
		{
			if (m_data != null)
			{
				return m_data.wantTrackMonsterPointId != 0;
			}
			return false;
		}
	}

	private bool HasWantTrackCollectionId
	{
		get
		{
			if (m_data != null)
			{
				return m_data.collectionPointId != 0;
			}
			return false;
		}
	}

	private bool BossOpen
	{
		get
		{
			if (m_data != null)
			{
				return m_data.selectBossId != 0;
			}
			return false;
		}
	}

	public Vector2 LeftStick
	{
		get
		{
			LargeMapViewInputController controller = GetController();
			if (controller != null)
			{
				if (controller.ControllerType != SubControllerType.main)
				{
					return Vector2.zero;
				}
				return leftStickV2;
			}
			return Vector2.zero;
		}
		set
		{
			leftStickV2 = value;
		}
	}

	public int SelectedMarkerIconTypeId
	{
		get
		{
			return _selectedMarkerIconTypeId;
		}
		set
		{
			_selectedMarkerIconTypeId = value;
		}
	}

	public bool IsPlacingMarker => _isPlacingMarker;

	private void Update()
	{
		if (gameObject.activeInHierarchy && !Model<GuideModel>.Interface.IsInStrongGuide() && UIController.State == UIState.Opened)
		{
			GetController()?.RefreshMapMoveInput();
			UpdateKeyboardMapMove();
			UpdateLeftStickMapMove();
			UpdateMouseWheelZoom();
		}
	}

	private void OnToggleChanged(bool isOn)
	{
		Model<MapModel>.Interface.ShowRewardBoxIcon = isOn;
		rewardBoxRoot?.gameObject.SetActive(isOn);
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		InitGameTipsDic();
	}

	private void InitGameTipsDic()
	{
		actionDic.Add("LargeMapView/Select", new GamePadTipsAction
		{
			inputAction = "UI/Confirm",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/MoveMap", new GamePadTipsAction
		{
			inputAction = "UI/MoveMap",
			localizeKey = 2629,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/MoveCursor", new GamePadTipsAction
		{
			inputAction = "UI/MoveMap",
			localizeKey = 2630,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/BackToPlayer", new GamePadTipsAction
		{
			inputAction = "UI/RightStickPress",
			localizeKey = 2632,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/BackToTarget", new GamePadTipsAction
		{
			inputAction = "UI/SwitchPageDown",
			localizeKey = 2631,
			localizeTable = "Common"
		});
		actionDic.Add("UI/RSUpDownSelect", new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		});
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		mapConfig = GameLoader.meta.mapConfig;
		enableMouseWheelZoom = false;
		areaMapScrollRect.horizontal = false;
		areaMapScrollRect.vertical = false;
		m_data = uiViewData as LargeMapViewData;
		CacheUnlockFogAnimationIds();
		_isUnlockFogMaterialReady = false;
		_isUnlockFogAnimationRequested = false;
		G.service.MapAreaExploreQuery(InitAllMapData);
	}

	private void CacheUnlockFogAnimationIds()
	{
		if (m_data == null)
		{
			return;
		}
		_unlockFogAnimationIds = new List<int>();
		if (m_data.unlockFogIds == null)
		{
			return;
		}
		foreach (int unlockFogId in m_data.unlockFogIds)
		{
			if (mapConfig.IsValidUnlockFog(unlockFogId) && !_unlockFogAnimationIds.Contains(unlockFogId))
			{
				_unlockFogAnimationIds.Add(unlockFogId);
			}
		}
	}

	protected override void Init()
	{
		base.Init();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_MapPointTraceEvt, HandleMapPointTrace);
		Model<TrackModel>.Interface.OnTrackCollectionPointChanged += OnCollectionPointTraceChanged;
		Model<TrackModel>.Interface.OnTrackMonsterPointChanged += OnMonsterPointTraceChanged;
		virtualCursor.OnSnapToIcon += OnSnapToIcon;
		virtualCursor.OnLeaveIcon += OnLeaveIcon;
	}

	private void InitTrackSystem()
	{
		_wantTrackMaterialTrackMonsterPointData = null;
		_wantTrackMonsterPointData = null;
		_trackMonsterId = 0;
		_wantTrackMonsterPointMapArea = ACT.World.MapArea.None;
		_wantTrackCollectionPointData = null;
		_wantCollectionPointData = null;
		_trackCollectionConfigId = 0;
		_wantTrackCollectionPointMapArea = ACT.World.MapArea.None;
	}

	private void InitAllMapData()
	{
		if (!Model<MapModel>.HasInstance())
		{
			return;
		}
		m_data = uiViewData as LargeMapViewData;
		playerArea = MapUtility.playerMapArea;
		instantiateMapIcon = new HashSet<InstanceHandle>();
		_templeIconDatas = new HashSet<LargeMapInteractObjIcon>();
		_instantiateBossRoomIconSet = BSetPool<LargeMapBossRoomIcon>.Default.Get();
		missionIconNavBtnDic = new Dictionary<LargeMapMissionIcon, NavButton>();
		InitTrackSystem();
		InitSelfNodeSystem();
		if (HasWantTrackMonsterId)
		{
			_trackMonsterId = m_data.wantTrackMonsterPointId;
			if (_trackMonsterId != 0)
			{
				EnemyTrackPointInit();
			}
		}
		else if (HasWantTrackCollectionId)
		{
			_trackCollectionConfigId = m_data.collectionPointId;
			if (_trackCollectionConfigId != 0)
			{
				CollectionTrackPointInit();
			}
		}
		else if (BossOpen)
		{
			int nativePlace = CoreUtils.GetData(m_data.selectBossId, RuntimeConfigs.data.entityEnemyDatas).nativePlace;
			if (nativePlace == 0)
			{
				List<MonsterTrackPointData> allMonsterTrackPointDataByEnemyId = Model<MaterialTrackModel>.Interface.GetAllMonsterTrackPointDataByEnemyId(m_data.selectBossId);
				if (allMonsterTrackPointDataByEnemyId != null)
				{
					EnterAreaMapOnInit(allMonsterTrackPointDataByEnemyId[0].mapArea, MapLayer.L0);
				}
				else
				{
					EnterAreaMapOnInit(playerArea, MapUtility.playerMapLayer);
				}
			}
			else
			{
				EnterAreaMapOnInit((ACT.World.MapArea)nativePlace, MapLayer.L0);
			}
		}
		else if (MapIconOpen)
		{
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(m_data.selectPointId);
			if (worldStateAssetDataBySGOID == null)
			{
				EnterAreaMapOnInit(playerArea, MapUtility.playerMapLayer);
			}
			else
			{
				EnterAreaMapOnInit(worldStateAssetDataBySGOID.mapArea, worldStateAssetDataBySGOID.MapLayer);
			}
		}
		else if (NpcOpen)
		{
			if (Singleton<RuntimeNpcManager>.instance.AllNpcDataDic.TryGetValue(m_data.jumpNpcId, out var value))
			{
				ACT.World.MapArea currentWorldMapAreaByChunkId = Singleton<GameManager>.instance.worldManager.GetCurrentWorldMapAreaByChunkId(value.ChunkID);
				EnterAreaMapOnInit(currentWorldMapAreaByChunkId, MapLayer.L0);
			}
			else
			{
				EnterAreaMapOnInit(playerArea, MapLayer.L0);
			}
		}
		else if (UnlockOpen)
		{
			EnterAreaMapOnInit(playerArea, MapUtility.playerMapLayer);
		}
		else if (SpecifiedPosOpen || SpecifiedAreaOpen)
		{
			EnterAreaMapOnInit(m_data.initMapArea, MapLayer.L0);
		}
		else if (templeDungeonOpen)
		{
			EnterAreaMapOnInit(m_data.initMapArea, MapLayer.L0);
		}
		else
		{
			LargeMapViewData data = m_data;
			if (data != null && data.templeAreaOpen)
			{
				EnterTempleAreaMap(m_data.initMapArea);
			}
			else
			{
				EnterAreaMapOnInit(playerArea, MapUtility.playerMapLayer);
			}
		}
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		TrackOpenMap evt = EventTrackSolver.Instance.GetEvt<TrackOpenMap>();
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	private void EnemyTrackPointInit()
	{
		_wantTrackMaterialTrackMonsterPointData = Model<MaterialTrackModel>.Interface.GetFirstMonsterPointDataByEnemyId(_trackMonsterId);
		if (_wantTrackMaterialTrackMonsterPointData == null)
		{
			_wantTrackMaterialTrackMonsterPointData = Model<MaterialTrackModel>.Interface.GetFirstCanGetRewardMaterialTrackMonsterPointData(_trackMonsterId);
			if (_wantTrackMaterialTrackMonsterPointData == null)
			{
				EnterAreaMapOnInit(playerArea, MapUtility.playerMapLayer);
				return;
			}
			_wantTrackMonsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(_wantTrackMaterialTrackMonsterPointData.monsterPointUid) as MonsterPointData;
			if (_wantTrackMonsterPointData != null)
			{
				_wantTrackMonsterPointMapArea = MapUtility.GetMapAreaBySGOID(_wantTrackMaterialTrackMonsterPointData.monsterPointUid);
				_wantTrackMonsterPointMapLayer = (MapLayer)_wantTrackMonsterPointData.mapLayer;
				EnterAreaMapOnInit(_wantTrackMonsterPointMapArea, _wantTrackMonsterPointMapLayer);
			}
		}
		else
		{
			int monsterPointUid = _wantTrackMaterialTrackMonsterPointData.monsterPointUid;
			_wantTrackMonsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(monsterPointUid) as MonsterPointData;
			if (_wantTrackMonsterPointData != null)
			{
				_wantTrackMonsterPointMapArea = MapUtility.GetMapAreaBySGOID(monsterPointUid);
				_wantTrackMonsterPointMapLayer = (MapLayer)_wantTrackMonsterPointData.mapLayer;
				EnterAreaMapOnInit(_wantTrackMonsterPointMapArea, _wantTrackMonsterPointMapLayer);
			}
		}
	}

	private void CollectionTrackPointInit()
	{
		List<CollectionTrackPointData> collectionPointsByConfigId = MapUtility.ConfigWorldMapGraph.GetCollectionPointsByConfigId(_trackCollectionConfigId);
		_wantTrackCollectionPointData = Model<MaterialTrackModel>.Interface.GetFirstCollectionPoint(collectionPointsByConfigId, MapUtility.playerPos);
		_wantCollectionPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(_wantTrackCollectionPointData.collectionPointId) as CollectionPointData;
		if (_wantCollectionPointData != null)
		{
			_wantTrackCollectionPointMapArea = _wantCollectionPointData.mapArea;
			EnterAreaMapOnInit(_wantTrackCollectionPointMapArea, MapLayer.L0);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (!UnlockOpen)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		else
		{
			betterAnimation.GetSequence("Unlock").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).OnEvent("UpdateUnlockFog", UpdateUnlockFog)
				.Play();
		}
	}

	public void UpdateUnlockFog()
	{
		_isUnlockFogAnimationRequested = true;
		TryStartUnlockFogAnimation();
	}

	private void TryStartUnlockFogAnimation()
	{
		if (!_isUnlockFogMaterialReady || !_isUnlockFogAnimationRequested)
		{
			return;
		}
		_isUnlockFogAnimationRequested = false;
		List<int> unlockFogAnimationIds = _unlockFogAnimationIds;
		if (unlockFogAnimationIds == null || unlockFogAnimationIds.Count <= 0)
		{
			return;
		}
		Vector2 vector = MapUtility.GetAreaOffset(curShowArea, MapUtility.playerPos) * mapConfig.largeMapRatio;
		Vector2Int vector2Int = mapConfig.GetAreaWidthHeightCellNum(curShowArea) * 512;
		Vector2 characterUVPos = new Vector2(vector.x / (float)vector2Int.x, vector.y / (float)vector2Int.y);
		foreach (int unlockFogAnimationId in _unlockFogAnimationIds)
		{
			Model<MapModel>.Interface.UpdateUnlockFogOnUnlockAnimationStart(unlockFogAnimationId, characterUVPos);
		}
		m_data.unlockFogIds = null;
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		areaMapScrollRect.horizontal = true;
		areaMapScrollRect.vertical = true;
		enableMouseWheelZoom = true;
	}

	private void UnInitWorldMapComp()
	{
		if (IsDestroyed)
		{
			return;
		}
		worldMapRoot.SetActive(value: false);
		worldMapScrollRect.UnInit();
		worldAreaSide.Hide();
		foreach (var (_, enterAreaMapBtn2) in enterAreaBtnDic)
		{
			worldMapScrollRect.OnScaleChanged -= enterAreaMapBtn2.SetScale;
		}
		ChangeToGamePadInputState(SubControllerType.main);
	}

	protected override void UnInit()
	{
		base.UnInit();
		MapUtility.LastQuitMapArea = curShowArea;
		areaMapScrollRect.UnInit(parentUnInit: true);
		worldMapScrollRect.UnInit();
		animateToggle.onValueChanged.RemoveListener(OnToggleChanged);
		RecycleAllMapIcon();
		if (missionIconNavBtnDic != null)
		{
			foreach (KeyValuePair<LargeMapMissionIcon, NavButton> item in missionIconNavBtnDic)
			{
				if (item.Value != null)
				{
					UnityEngine.Object.Destroy(item.Value.gameObject);
				}
			}
			missionIconNavBtnDic.Clear();
		}
		HideIconSideBarImmediately();
		HideVagueSelectListImmediately();
		HideExploreRatioSideBarImmediately();
		accurateSelectIcon = null;
		vagueSelectIcon = null;
		if (navTween != null)
		{
			navTween.Kill();
			navTween = null;
		}
		IsNav = false;
		LeftStick = Vector2.zero;
		_hasSelectedOpenIcon = false;
		templeOpen = false;
		keyboardMoveInput = Vector2.zero;
		currentKeyboardVelocity = Vector2.zero;
		isKeyboardControlling = false;
		isMouseWheelZooming = false;
		targetScale = 0f;
		currentScale = 0f;
		BSetPool<LargeMapBossRoomIcon>.Default.Recycle(_instantiateBossRoomIconSet);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_MapPointTraceEvt, HandleMapPointTrace);
		Model<TrackModel>.Interface.OnTrackCollectionPointChanged -= OnCollectionPointTraceChanged;
		Model<TrackModel>.Interface.OnTrackMonsterPointChanged -= OnMonsterPointTraceChanged;
		virtualCursor.OnSnapToIcon -= OnSnapToIcon;
		virtualCursor.OnLeaveIcon -= OnLeaveIcon;
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		UnInitSelfNodeSystem();
		ReleaseAreaGrid();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		if (!exploreRatioSidebar.IsOperating)
		{
			if (worldMapRoot.activeSelf)
			{
				EnterAreaMap(playerArea);
			}
			else
			{
				base.Close();
			}
		}
	}

	public void WorldMaskTips()
	{
		Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
		{
			tableName = LocalizationUtility.localizeTableName_Common,
			localizeId = 2379
		});
	}

	public void BackToWorldMap()
	{
		if (areaGrid == null)
		{
			return;
		}
		keyboardMoveInput = Vector2.zero;
		currentKeyboardVelocity = Vector2.zero;
		isKeyboardControlling = false;
		ReleaseAreaGrid();
		worldMapRoot.SetActive(value: true);
		worldMapScrollRect.Init();
		worldMapAnimation.GetSequence("WorldMapShow").OnEvent("EnterAreaBtnShow", PlayEnterAreaBtnShowAnim).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Map/World_Open_Animation");
		int num = 0;
		ViewControlLayers[SubControllerType.worldMap].SetDefaultSelect(null);
		foreach (KeyValuePair<ACT.World.MapArea, EnterAreaMapBtn> item in enterAreaBtnDic)
		{
			var (area, enterAreaMapBtn2) = item;
			num++;
			if (num == 1)
			{
				worldMapMask?.MaskInit();
			}
			worldMapMask?.SetMaskTexture(area, MapUtility.AreaUnlock(area));
			bool flag = false;
			foreach (MissionPointData point in Model<BattleMainMarkModelV2>.Interface.Points)
			{
				if (point.MapArea == area)
				{
					flag = true;
					break;
				}
			}
			if (enterAreaImageDic.TryGetValue(area, out var value))
			{
				enterAreaMapBtn2.BindTarget((value.Count > 0) ? value[0] : null);
			}
			bool unlock = MapUtility.AreaUnlock(area);
			bool missionHere = flag;
			bool playerHere = playerArea == area;
			MapPointTraceInfo currentTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
			enterAreaMapBtn2.Init(unlock, missionHere, playerHere, currentTraceMapPoint != null && currentTraceMapPoint.mapArea == area, Model<TrackModel>.Interface.TrackingPointArea() == area, () =>
			{
				EnterAreaMap(area);
			});
			enterAreaMapBtn2.SetScale(worldMapScrollRect.defaultScale);
			worldMapScrollRect.OnScaleChanged += enterAreaMapBtn2.SetScale;
			if (playerArea == area && !Model<GuideModel>.Interface.IsInStrongGuide())
			{
				ViewControlLayers[SubControllerType.worldMap].SetDefaultSelect(enterAreaMapBtn2.GetComponent<ACT.ViewControl.SelectableEx>());
			}
			else if (Model<GuideModel>.Interface.IsInStrongGuide() && area == ACT.World.MapArea.Aurum)
			{
				ViewControlLayers[SubControllerType.worldMap].SetDefaultSelect(enterAreaMapBtn2.GetComponent<ACT.ViewControl.SelectableEx>());
			}
		}
		foreach (KeyValuePair<ACT.World.MapArea, List<GameObject>> item2 in enterAreaImageDic)
		{
			foreach (GameObject item3 in item2.Value)
			{
				item3.SetActive(MapUtility.AreaUnlock(item2.Key));
			}
		}
		ChangeToGamePadInputState(SubControllerType.worldMap);
		ClearAreaMap();
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.OpenWorldMap);
	}

	public void ClearAreaMap()
	{
		InitTrackSystem();
		areaMapScaleSlider.UnInit();
		areaMapScrollRect.UnInit();
		commonClose();
	}

	private void PlayEnterAreaBtnShowAnim()
	{
		foreach (KeyValuePair<ACT.World.MapArea, EnterAreaMapBtn> item in enterAreaBtnDic)
		{
			item.Deconstruct(out var _, out var value);
			value.PlayShowAnimation();
		}
	}

	private void commonClose()
	{
		areaInfoRoot.SetActive(value: false);
		areaInfo.UnInit();
		areaExploreInfo.UnInit();
		playerNavBtn.gameObject.SetActive(value: false);
		backToWorldMapBtn.UnInit();
		RecycleAllMapIcon();
		iconSidebar.HideImmediately();
		vagueSelectList.HideImmediately();
		exploreRatioSidebar.HideImmediately();
		accurateSelectIcon = null;
		vagueSelectIcon = null;
	}

	private async void EnterAreaMapOnInit(ACT.World.MapArea area, MapLayer layer)
	{
		await CreateAreaGrid(area);
		UpdateAreaScrollRectSize(area);
		InitMatrix(area);
		curShowArea = area;
		curShowLayer = layer;
		UnInitWorldMapComp();
		UpdateAreaScrollRectScaleOnInit();
		UpdateMapPlayerIcon();
		UpdateAreaScrollRectNormalizedPosOnInit();
		UpdateFogMaterial();
		EnableAreaMapComp();
		UpdateLayerOnEnterAreaMap(curShowLayer);
		await UniTask.NextFrame();
		_isUnlockFogMaterialReady = true;
		TryStartUnlockFogAnimation();
	}

	private void UpdateAreaScrollRectScaleOnInit()
	{
		if (UnlockOpen)
		{
			RectTransform rectTransform = null;
			if (m_data.unlockFogIds.Count > 0)
			{
				rectTransform = areaGrid.GetUnlockFogRectTransform(m_data.unlockFogIds[0]);
			}
			if (rectTransform != null)
			{
				float a = (float)(Screen.width - 800) / (rectTransform.sizeDelta.x * rectTransform.localScale.x);
				float b = (float)(Screen.height - 300) / (rectTransform.sizeDelta.y * rectTransform.localScale.y);
				(float, float) areaScrollRectMinMaxScale = mapConfig.GetAreaScrollRectMinMaxScale(curShowArea);
				areaMapScrollRect.content.localScale = Vector3.one * Mathf.Clamp(Mathf.Min(a, b), areaScrollRectMinMaxScale.Item1, areaScrollRectMinMaxScale.Item2);
			}
		}
		else if (guideOpen)
		{
			areaMapScrollRect.content.localScale = Vector3.one * mapConfig.GetAreaScrollRectMinMaxScale(curShowArea).minScale;
		}
		else
		{
			areaMapScrollRect.content.localScale = Vector3.one * mapConfig.GetAreaScrollRectDefaultScale(curShowArea);
		}
	}

	private void UpdateAreaScrollRectNormalizedPosOnInit()
	{
		if (UnlockOpen)
		{
			RectTransform rectTransform = null;
			if (m_data.unlockFogIds.Count > 0)
			{
				rectTransform = areaGrid.GetUnlockFogRectTransform(m_data.unlockFogIds[0]);
			}
			areaMapScrollRect.normalizedPosition = ((rectTransform != null) ? GetCenterNormalizedPos(rectTransform, areaMapScrollRect) : GetCenterNormalizedPos(mapPlayerIcon.transform as RectTransform, areaMapScrollRect));
		}
		else if (HasWantTrackMonsterId)
		{
			areaMapScrollRect.normalizedPosition = GetCenterNormalizedPos(GetIconPos(curShowArea, _wantTrackMonsterPointData.initPos), areaMapScrollRect);
		}
		else if (guideOpen)
		{
			areaMapScrollRect.normalizedPosition = Vector2.zero;
			guideOpen = false;
		}
		else if (SpecifiedPosOpen)
		{
			areaMapScrollRect.normalizedPosition = GetCenterNormalizedPos(GetIconPos(curShowArea, m_data.initPosition), areaMapScrollRect);
		}
		else
		{
			areaMapScrollRect.normalizedPosition = ((curShowArea == playerArea) ? GetCenterNormalizedPos(mapPlayerIcon.transform as RectTransform, areaMapScrollRect) : (Vector2.one * 0.5f));
		}
	}

	public async void EnterAreaMap(ACT.World.MapArea area)
	{
		PlayOpenAnimation();
		if (areaGrid == null)
		{
			await CreateAreaGrid(area);
		}
		if (GetCurSubControllerType() != SubControllerType.main)
		{
			ChangeToGamePadInputState(SubControllerType.main);
			UpdateAreaScrollRectSize(area);
			InitMatrix(area);
			curShowArea = area;
			curShowLayer = ((area == playerArea) ? MapUtility.playerMapLayer : mapConfig.GetAreaDefaultLayer(area));
			UpdateAreaScrollRectScale();
			UpdateMapPlayerIcon();
			UpdateAreaScrollRectNormalizedPos();
			UpdateFogMaterial();
			EnableAreaMapComp();
			worldMapAnimation.GetSequence("WorldMapHide").OnComplete((AnimationBuilder _) =>
			{
				UnInitWorldMapComp();
			}).Play();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Map/Area_Open_Animation");
			UpdateLayerOnEnterAreaMap(curShowLayer);
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.OpenWorldMap);
		}
	}

	private void UpdateAreaScrollRectScale()
	{
		areaMapScrollRect.content.localScale = Vector3.one * mapConfig.GetAreaScrollRectDefaultScale(curShowArea);
	}

	private void UpdateAreaScrollRectNormalizedPos()
	{
		areaMapScrollRect.normalizedPosition = ((curShowArea == playerArea) ? GetCenterNormalizedPos(mapPlayerIcon.transform as RectTransform, areaMapScrollRect) : (Vector2.one * 0.5f));
	}

	public async void EnterTempleAreaMap(ACT.World.MapArea area, bool fromAreaMap = false)
	{
		if (areaGrid == null)
		{
			await CreateAreaGrid(area);
		}
		if (GetCurSubControllerType() != SubControllerType.templeMap)
		{
			UpdateTempleScrollRectSize(area);
			templeOpen = true;
			curShowArea = area;
			curShowLayer = ((area == playerArea) ? MapUtility.playerMapLayer : mapConfig.GetAreaDefaultLayer(area));
			if (areaMapScaleSlider.gameObject.activeSelf)
			{
				areaMapScaleSlider.UnInit();
			}
			if (areaMapScrollRect.gameObject.activeSelf)
			{
				areaMapScrollRect.UnInit();
			}
			UpdateTempleAreaScrollRectScale();
			mapPlayerIcon.SetActive(!templeOpen);
			UpdateTempleAreaScrollRectNormalizedPos();
			InitTempleComp(area, fromAreaMap);
			ChangeToGamePadInputState(SubControllerType.templeMap);
			buttonGroup.SetActive(value: false);
		}
	}

	private void UpdateTempleAreaScrollRectScale()
	{
		(float, float) areaScrollRectMinMaxScale = mapConfig.GetAreaScrollRectMinMaxScale(curShowArea);
		templeMapScrollRect.content.localScale = Vector3.one * areaScrollRectMinMaxScale.Item2;
	}

	private void UpdateTempleAreaScrollRectNormalizedPos()
	{
		templeMapScrollRect.normalizedPosition = Vector2.one * 0.5f;
	}

	private void UpdateTempleScrollRectSize(ACT.World.MapArea area)
	{
		if (!(areaGrid == null))
		{
			(float, float) areaScrollRectMargin = mapConfig.GetAreaScrollRectMargin(area);
			templeMapScrollRect.content.sizeDelta = areaGrid.GetSize() + new Vector2(areaScrollRectMargin.Item1, areaScrollRectMargin.Item2);
		}
	}

	private void InitTempleComp(ACT.World.MapArea area, bool fromAreaMap = false)
	{
		if (fromAreaMap)
		{
			ClearAreaMap();
		}
		templeMapScrollRect.Init(() =>
		{
			RecycleAllMapIcon();
			EnterAreaMap(area);
			ChangeToGamePadInputState(SubControllerType.main);
		});
	}

	private async UniTask CreateAreaGrid(ACT.World.MapArea area)
	{
		YooAssetReference areaGridPrefab = mapConfig.GetAreaGridPrefab(area);
		if (!(areaGridPrefab == null))
		{
			if (areaGrid != null)
			{
				UnityEngine.Object.Destroy(areaGrid.gameObject);
				areaGrid = null;
			}
			areaGridLoadHandle = Station.LoadAsync<GameObject>(areaGridPrefab);
			await areaGridLoadHandle;
			if (areaGridLoadHandle.IsValid)
			{
				areaGrid = UnityEngine.Object.Instantiate(areaGridLoadHandle.As<GameObject>(), areaGridRoot).GetComponent<AreaGrid>();
				RefreshUnlockMaskVisibility();
			}
		}
	}

	private void RefreshUnlockMaskVisibility()
	{
		if (areaGrid?.unlockMaskRectTransform == null)
		{
			return;
		}
		foreach (KeyValuePair<int, RectTransform> item in areaGrid.unlockMaskRectTransform)
		{
			RectTransform value = item.Value;
			if (value == null)
			{
				continue;
			}
			UnlockMaskData component = value.GetComponent<UnlockMaskData>();
			if (!(component == null))
			{
				StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(component.stateObjectId);
				if (worldStateAssetDataBySGOID != null)
				{
					value.gameObject.SetActive(worldStateAssetDataBySGOID.stateId == worldStateAssetDataBySGOID.initialStateId);
				}
			}
		}
	}

	private void ReleaseAreaGrid()
	{
		if (areaGrid != null)
		{
			UnityEngine.Object.Destroy(areaGrid.gameObject);
			areaGrid = null;
		}
		if (AssetLoadHandleExtensions.IsValid(areaGridLoadHandle))
		{
			Station.ReleaseInstance(areaGridLoadHandle);
		}
		areaGridLoadHandle = default;
	}

	private void UpdateAreaScrollRectSize(ACT.World.MapArea area)
	{
		if (!(areaGrid == null))
		{
			(float, float) areaScrollRectMargin = mapConfig.GetAreaScrollRectMargin(area);
			areaMapScrollRect.content.sizeDelta = areaGrid.GetSize() + new Vector2(areaScrollRectMargin.Item1, areaScrollRectMargin.Item2);
		}
	}

	private void UpdateFogMaterial()
	{
		MapUtility.SetLargeMapRoomMaterialCorner(areaGrid.transform as RectTransform);
		MapUtility.SetLargeMapDetailMaterialCorner(areaGrid.transform as RectTransform);
		if (Model<MapModel>.HasInstance())
		{
			MapUtility.SetLargeMapRoomMaterialTexture(Model<MapModel>.Interface.GetAreaLayerUnlockFogRt(curShowArea, curShowLayer));
			MapUtility.SetLargeMapDetailMaterialTexture(Model<MapModel>.Interface.GetAreaLayerUnlockFogRt(curShowArea, curShowLayer), Model<MapModel>.Interface.GetAreaLayerExploreFogRt(curShowArea, curShowLayer));
		}
	}

	private void UpdateMapPlayerIcon()
	{
		mapPlayerIcon.SetFixedScale(mapConfig.iconFixedScale, areaGrid?.transform.GetComponent<RectTransform>());
		mapPlayerIcon.UpdateScale(curScale);
		mapPlayerIcon.SetPos(GetIconPos(curShowArea, MapUtility.playerPos));
	}

	private void EnableAreaMapComp(bool fromTemple = false)
	{
		(float, float) areaScrollRectMinMaxScale = mapConfig.GetAreaScrollRectMinMaxScale(curShowArea);
		areaMapScaleSlider.Init(areaScrollRectMinMaxScale.Item1, areaScrollRectMinMaxScale.Item2, areaMapScrollRect.content.localScale.x, mapConfig.GetAreaScrollRectSliderBtnScaleDelta(curShowArea));
		areaMapScrollRect.Init();
		areaInfoRoot.SetActive(value: true);
		areaInfo.Init(curShowArea);
		Station.LoadImage(183, (int)curShowArea, curWorldIcon);
		areaExploreInfo.Init(curShowArea);
		if (animateToggle != null)
		{
			animateToggle.onValueChanged.RemoveListener(OnToggleChanged);
			animateToggle.onValueChanged.AddListener(OnToggleChanged);
			animateToggle.isOn = Model<MapModel>.Interface.ShowRewardBoxIcon;
		}
		CreateAllMapIcon(curShowArea, curShowLayer);
		backToWorldMapBtn.Init(curShowArea, Model<MapModel>.Interface.IsOtherAreaHasMissionPoint(curShowArea));
	}

	private Vector2 GetCenterNormalizedPos(RectTransform item, ScrollRect scrollRect)
	{
		Vector2 vector = UIUtility.ConvertLocalPosToTargetPos(item, scrollRect.viewport);
		Vector2 vector2 = Vector2.zero - vector;
		Vector2 vector3 = scrollRect.content.sizeDelta * scrollRect.content.localScale - scrollRect.viewport.rect.size;
		Vector2 vector4 = new Vector2(vector2.x / vector3.x, vector2.y / vector3.y);
		Vector2 result = scrollRect.normalizedPosition - vector4;
		result.x = Mathf.Clamp01(result.x);
		result.y = Mathf.Clamp01(result.y);
		return result;
	}

	private Vector2 GetCenterNormalizedPos(Vector2 iconPos, ScrollRect scrollRect)
	{
		Vector2 vector = scrollRect.viewport.InverseTransformPoint(iconRoot.TransformPoint(iconPos));
		Vector2 vector2 = Vector2.zero - vector;
		Vector2 vector3 = scrollRect.content.sizeDelta * scrollRect.content.localScale - scrollRect.viewport.rect.size;
		Vector2 vector4 = new Vector2(vector2.x / vector3.x, vector2.y / vector3.y);
		Vector2 result = scrollRect.normalizedPosition - vector4;
		result.x = Mathf.Clamp01(result.x);
		result.y = Mathf.Clamp01(result.y);
		return result;
	}

	public void SetRectTransformToCenter(RectTransform rectTransform, float navTime = 0f)
	{
		if (rectTransform == null)
		{
			return;
		}
		if (navTween != null && !navTween.IsComplete())
		{
			navTween.Kill();
		}
		IsNav = true;
		if (templeOpen)
		{
			navTween = templeMapScrollRect.DONormalizedPos(GetCenterNormalizedPos(rectTransform, templeMapScrollRect), mapConfig.navTime).SetEase(mapConfig.navCurve).ChangeStartValue(templeMapScrollRect.normalizedPosition)
				.OnKill(() =>
				{
					IsNav = false;
				})
				.OnComplete(() =>
				{
					IsNav = false;
					if (virtualCursor.isActive)
					{
						Vector3 vector = Singleton<NewUIManager>.instance.UICamera.WorldToScreenPoint(rectTransform.position);
						Vector2 localPoint = Vector2.zero;
						RectTransform rectTransform2 = areaMapRoot.transform as RectTransform;
						RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform2, vector, Singleton<NewUIManager>.instance.UICamera, out localPoint);
						virtualCursor.SetCursorPosition(localPoint + new Vector2(rectTransform2.rect.width / 2f, rectTransform2.rect.height / 2f));
					}
				});
			return;
		}
		navTween = areaMapScrollRect.DONormalizedPos(GetCenterNormalizedPos(rectTransform, areaMapScrollRect), (navTime == 0f) ? mapConfig.navTime : navTime).SetEase(mapConfig.navCurve).ChangeStartValue(areaMapScrollRect.normalizedPosition)
			.OnKill(() =>
			{
				IsNav = false;
			})
			.OnComplete(() =>
			{
				IsNav = false;
				if (virtualCursor.isActive)
				{
					Vector3 vector = Singleton<NewUIManager>.instance.UICamera.WorldToScreenPoint(rectTransform.position);
					Vector2 localPoint = Vector2.zero;
					RectTransform rectTransform2 = areaMapRoot.transform as RectTransform;
					RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform2, vector, Singleton<NewUIManager>.instance.UICamera, out localPoint);
					virtualCursor.SetCursorPosition(localPoint + new Vector2(rectTransform2.rect.width / 2f, rectTransform2.rect.height / 2f));
				}
			});
	}

	public void OnScaleUpdate(float beforeVal, float afterVal)
	{
		foreach (InstanceHandle item in instantiateMapIcon)
		{
			item.Result.GetComponent<MapIconBase>().UpdateScale(curScale);
		}
		mapPlayerIcon.UpdateScale(curScale);
	}

	private void CreateAllMapIcon(ACT.World.MapArea area, MapLayer layer)
	{
		CreateInteractObjMapIcon(area, layer);
		CreateRewardBoxIcon(area);
		CreateNpcMapIcon(area);
		CreateReceiveSideMissionMapIcon(area);
		CreateAreaBlockIcon(area);
		CreateMissionMapIcon(area, layer);
		CreateMonsterPointMapIcon(area);
		CreateCollectionPointMapIcon(area);
		CreateSelfNodeMapIcons(area);
		CreateGeneralNavButtonIcons(area);
		CheckSpecialTrackStatus();
	}

	private void CheckSpecialTrackStatus()
	{
		if (accurateSelectIcon is LargeMapCollectionPointIcon largeMapCollectionPointIcon && _wantCollectionPointData != null && MapUtility.playerMapArea == _wantCollectionPointData.mapArea)
		{
			Model<MaterialTrackModel>.Interface.TrackCollectionPoint(largeMapCollectionPointIcon);
			if (Model<TrackModel>.Interface.IsTrackingCollectionPoint && Model<TrackModel>.Interface.GetTrackCollectionPointId() == largeMapCollectionPointIcon.GetId())
			{
				iconSidebar.unTrackBtn.gameObject.SetActive(value: true);
			}
			else
			{
				iconSidebar.trackBtn.gameObject.SetActive(value: true);
			}
		}
		else if (accurateSelectIcon is LargeMapMonsterPointIcon largeMapMonsterPointIcon && _wantTrackMonsterPointData != null && MapUtility.playerMapArea == _wantTrackMonsterPointData.mapArea)
		{
			Model<MaterialTrackModel>.Interface.TrackEnemyPoint(largeMapMonsterPointIcon);
			if (Model<TrackModel>.Interface.IsTrackingMonsterPoint && Model<TrackModel>.Interface.GetTrackMonsterPointId() == largeMapMonsterPointIcon.GetUid())
			{
				iconSidebar.unTrackBtn.gameObject.SetActive(value: true);
			}
			else
			{
				iconSidebar.trackBtn.gameObject.SetActive(value: true);
			}
		}
	}

	private void CreateInteractObjMapIcon(ACT.World.MapArea area, MapLayer layer)
	{
		HashSet<BakeStaticMapIconData> mapIconDataBy = MapUtility.ConfigWorldMapGraph.GetMapIconDataBy(area);
		if (mapIconDataBy == null || mapIconDataBy.Count == 0)
		{
			return;
		}
		foreach (BakeStaticMapIconData staticMapIconData in mapIconDataBy)
		{
			bool flag = true;
			if (staticMapIconData.iconTypeId == 1017)
			{
				flag = IsPosExplored(staticMapIconData.initPos, (MapSubArea)staticMapIconData.subAreaId);
			}
			else if (staticMapIconData.iconTypeId != 1002)
			{
				if (staticMapIconData.linkedUnlockFogId == 0)
				{
					_ = 1;
				}
				else
					Model<MapModel>.Interface.UnlockFogHasUnlock(staticMapIconData.linkedUnlockFogId);
				if (staticMapIconData.iconTypeId == 1001)
				{
					flag = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(staticMapIconData.uid).stateId == -2 || IsPosExplored(staticMapIconData.initPos, (MapSubArea)staticMapIconData.subAreaId);
				}
				else if (staticMapIconData.iconTypeId == 1021 || staticMapIconData.iconTypeId == 10201 || staticMapIconData.iconTypeId == 1022)
				{
					flag = MapUtility.InteractObjIsActive(staticMapIconData.uid) && IsPosExplored(staticMapIconData.initPos, (MapSubArea)staticMapIconData.subAreaId);
				}
				else if (!staticMapIconData.IsWorldBossIcon())
				{
					flag = MapUtility.InteractObjIsActive(staticMapIconData.uid);
				}
			}
			if (!flag)
			{
				continue;
			}
			if (staticMapIconData.IsWorldBossIcon())
			{
				InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapWorldBossPrefabAssetD.GUID);
				instanceHandle.Completed += (InstanceHandle go) =>
				{
					instantiateMapIcon.Add(go);
					LargeMapWorldBossIcon component = go.Result.GetComponent<LargeMapWorldBossIcon>();
					go.Result.transform.SetParent(iconRoot);
					component.SetPos(GetIconPos(area, staticMapIconData.initPos));
					component.Init(staticMapIconData, curShowArea);
					component.SetFixedScale(mapConfig.iconFixedScale);
					component.UpdateScale(curScale);
					component.SetIsExplored(Model<MonsterHandModel>.Interface.WildBossUnLock(staticMapIconData.worldBossId));
					component.RefreshState();
					component.BindClickAction(TrySelectIcon);
					if (BossOpen && component.GetWorldBossId() == m_data.selectBossId && !_hasSelectedOpenIcon)
					{
						areaMapScrollRect.normalizedPosition = GetCenterNormalizedPos(GetIconPos(curShowArea, staticMapIconData.initPos), areaMapScrollRect);
						AccurateSelectIcon(component);
						_hasSelectedOpenIcon = true;
					}
				};
				instanceHandle.CompleteSync();
				continue;
			}
			InstanceHandle instanceHandle2 = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapInteractObjIconPrefabAssetD.GUID);
			instanceHandle2.Completed += (InstanceHandle go) =>
			{
				instantiateMapIcon.Add(go);
				LargeMapInteractObjIcon component = go.Result.GetComponent<LargeMapInteractObjIcon>();
				go.Result.transform.SetParent(iconRoot);
				component.SetPos(GetIconPos(area, staticMapIconData.initPos));
				component.SetFixedScale(mapConfig.iconFixedScale);
				component.Init(staticMapIconData, area);
				component.BindClickAction(TrySelectIcon);
				component.UpdateScale(curScale);
				interactIconLoaded = true;
				if (component.type == MapIconType.Temple)
				{
					if (Model<MapModel>.Interface.FindTempleEnterDataByInstanceId(component.GetDataId()) != null && templeDungeonOpen && m_data.templeDungeonId == component.GetDataId())
					{
						areaMapScrollRect.normalizedPosition = GetCenterNormalizedPos(GetIconPos(curShowArea, staticMapIconData.initPos), areaMapScrollRect);
						AccurateSelectIcon(component);
					}
				}
				else if (component.type == MapIconType.Transfer && m_data != null && m_data.selectPointId > 0 && m_data.selectPointId == component.GetSwId() && Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(component.GetSwId()) != null)
				{
					areaMapScrollRect.normalizedPosition = GetCenterNormalizedPos(GetIconPos(curShowArea, staticMapIconData.initPos), areaMapScrollRect);
					AccurateSelectIcon(component);
				}
			};
			instanceHandle2.CompleteSync();
		}
	}

	private void CreateRewardBoxIcon(ACT.World.MapArea area)
	{
		rewardBoxRoot.gameObject.SetActive(Model<MapModel>.Interface.ShowRewardBoxIcon);
		HashSet<BakeStaticMapIconData> rewardBoxDataBy = MapUtility.ConfigWorldMapGraph.GetRewardBoxDataBy(area);
		if (rewardBoxDataBy == null || rewardBoxDataBy.Count == 0)
		{
			return;
		}
		foreach (BakeStaticMapIconData staticMapIconData in rewardBoxDataBy)
		{
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(staticMapIconData.uid);
			if (worldStateAssetDataBySGOID != null && worldStateAssetDataBySGOID.stateId == 1)
			{
				InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapRewardBoxPrefabAssetD.GUID);
				instanceHandle.Completed += (InstanceHandle go) =>
				{
					instantiateMapIcon.Add(go);
					LargeMapRewardBoxIcon component = go.Result.GetComponent<LargeMapRewardBoxIcon>();
					go.Result.transform.SetParent(rewardBoxRoot);
					component.SetPos(GetIconPos(area, staticMapIconData.initPos));
					component.SetFixedScale(mapConfig.iconFixedScale);
					component.Init(staticMapIconData, area);
					component.UpdateScale(curScale);
				};
				instanceHandle.CompleteSync();
			}
		}
	}

	private bool IsPosExplored(Vector3 pos, MapSubArea subAreaId)
	{
		if (mapConfig.IsDefaultUnlockSubArea(subAreaId))
		{
			return true;
		}
		return MapUtility.IsPosExplored(pos, curShowArea);
	}

	private void CreateMonsterPointMapIcon(ACT.World.MapArea area)
	{
		if (_wantTrackMonsterPointData != null && _wantTrackMonsterPointMapArea == area)
		{
			_canTrackMonsterPointData = Model<MaterialTrackModel>.Interface.GetShowMonsterTrackPointDataGroupBySubArea(_trackMonsterId, area);
			{
				foreach (List<MonsterTrackPointData> value in _canTrackMonsterPointData.Values)
				{
					foreach (MonsterTrackPointData pointData in value)
					{
						InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapMonsterPointPrefabAssetID.GUID);
						instanceHandle.Completed += (InstanceHandle go) =>
						{
							instantiateMapIcon.Add(go);
							LargeMapMonsterPointIcon component = go.Result.GetComponent<LargeMapMonsterPointIcon>();
							StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(pointData.monsterPointUid);
							go.Result.transform.SetParent(iconRoot);
							component.worldPos = worldStateAssetDataBySGOID.initPos;
							component.SetPos(GetIconPos(area, worldStateAssetDataBySGOID.initPos));
							component.SetFixedScale(mapConfig.iconFixedScale);
							component.UpdateScale(curScale);
							component.Init(area, worldStateAssetDataBySGOID.mapSubArea, worldStateAssetDataBySGOID.stateWorldAssetUid, _trackMonsterId);
							component.BindClickAction(TrySelectIcon);
							component.SetIsFade(_wantTrackMonsterPointData.mapSubArea != worldStateAssetDataBySGOID.mapSubArea);
							if (!_hasSelectedOpenIcon && _wantTrackMonsterPointData.stateWorldAssetUid == pointData.monsterPointUid)
							{
								SetRectTransformToCenter(component.transform as RectTransform, 0.25f);
								AccurateSelectIcon(component);
								_hasSelectedOpenIcon = true;
							}
						};
						instanceHandle.CompleteSync();
					}
				}
				return;
			}
		}
		if (!Model<TrackModel>.Interface.IsTrackingMonsterPoint || !Model<MaterialTrackModel>.Interface.IsTrackingEnemyId || Model<TrackModel>.Interface.GetTrackMonsterPointMapArea() != area)
		{
			return;
		}
		_trackMonsterId = Model<MaterialTrackModel>.Interface.GetTrackEnemyId();
		_canTrackMonsterPointData = Model<MaterialTrackModel>.Interface.GetShowMonsterTrackPointDataGroupBySubArea(_trackMonsterId, area);
		int trackMonsterPointUid = Model<TrackModel>.Interface.GetTrackMonsterPointId();
		_wantTrackMonsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(trackMonsterPointUid) as MonsterPointData;
		foreach (List<MonsterTrackPointData> value2 in _canTrackMonsterPointData.Values)
		{
			foreach (MonsterTrackPointData pointData2 in value2)
			{
				PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapMonsterPointPrefabAssetID.GUID).Completed += (InstanceHandle go) =>
				{
					instantiateMapIcon.Add(go);
					LargeMapMonsterPointIcon component = go.Result.GetComponent<LargeMapMonsterPointIcon>();
					StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(pointData2.monsterPointUid);
					go.Result.transform.SetParent(iconRoot);
					component.worldPos = worldStateAssetDataBySGOID.initPos;
					component.SetPos(GetIconPos(area, worldStateAssetDataBySGOID.initPos));
					component.SetFixedScale(mapConfig.iconFixedScale);
					component.UpdateScale(curScale);
					component.Init(area, worldStateAssetDataBySGOID.mapSubArea, worldStateAssetDataBySGOID.stateWorldAssetUid, _trackMonsterId);
					component.BindClickAction(TrySelectIcon);
					component.SetIsTrack(worldStateAssetDataBySGOID.stateWorldAssetUid == trackMonsterPointUid);
					component.SetIsFade(_wantTrackMonsterPointData.mapSubArea != worldStateAssetDataBySGOID.mapSubArea);
					if (worldStateAssetDataBySGOID.stateWorldAssetUid == trackMonsterPointUid)
					{
						_trackSpecialPointInstantiateGO = go;
						CreateSpecialPointNavButton(component);
					}
				};
			}
		}
	}

	private void CreateCollectionPointMapIcon(ACT.World.MapArea area)
	{
		if (_wantCollectionPointData != null && _wantTrackCollectionPointMapArea == area)
		{
			_canTrackCollectionPointData = Model<MaterialTrackModel>.Interface.GetCollectionPointDataByConfigIdAndArea(_trackCollectionConfigId, area);
			{
				foreach (List<CollectionTrackPointData> value in _canTrackCollectionPointData.Values)
				{
					foreach (CollectionTrackPointData pointData in value)
					{
						InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapCollectPointPrefabAssetID.GUID);
						instanceHandle.Completed += (InstanceHandle go) =>
						{
							instantiateMapIcon.Add(go);
							LargeMapCollectionPointIcon component = go.Result.GetComponent<LargeMapCollectionPointIcon>();
							StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(pointData.collectionPointId);
							go.Result.transform.SetParent(iconRoot);
							component.worldPos = worldStateAssetDataBySGOID.initPos;
							component.SetPos(GetIconPos(area, worldStateAssetDataBySGOID.initPos));
							component.SetFixedScale(mapConfig.iconFixedScale);
							component.UpdateScale(curScale);
							component.Init(area, worldStateAssetDataBySGOID.mapSubArea, worldStateAssetDataBySGOID.stateWorldAssetUid, _trackCollectionConfigId);
							component.BindClickAction(TrySelectIcon);
							component.SetIsFade(_wantTrackCollectionPointData.subAreaId != worldStateAssetDataBySGOID.mapSubArea);
							if (!_hasSelectedOpenIcon && _wantTrackCollectionPointData.collectionPointId == pointData.collectionPointId)
							{
								SetRectTransformToCenter(component.transform as RectTransform, 0.25f);
								AccurateSelectIcon(component);
								_hasSelectedOpenIcon = true;
							}
						};
						instanceHandle.CompleteSync();
					}
				}
				return;
			}
		}
		if (!Model<TrackModel>.Interface.IsTrackingCollectionPoint || Model<TrackModel>.Interface.GetTrackCollectionMapArea() != area)
		{
			return;
		}
		_trackCollectionConfigId = Model<TrackModel>.Interface.GetTrackCollectionPointConfigId();
		_canTrackCollectionPointData = Model<MaterialTrackModel>.Interface.GetCollectionPointDataByConfigIdAndArea(_trackCollectionConfigId, area);
		int trackCollectPointUid = Model<TrackModel>.Interface.GetTrackCollectionPointId();
		_wantCollectionPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(trackCollectPointUid) as CollectionPointData;
		foreach (List<CollectionTrackPointData> value2 in _canTrackCollectionPointData.Values)
		{
			foreach (CollectionTrackPointData pointData2 in value2)
			{
				PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapCollectPointPrefabAssetID.GUID).Completed += (InstanceHandle go) =>
				{
					instantiateMapIcon.Add(go);
					LargeMapCollectionPointIcon component = go.Result.GetComponent<LargeMapCollectionPointIcon>();
					CollectionPointData collectionPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(pointData2.collectionPointId) as CollectionPointData;
					go.Result.transform.SetParent(iconRoot);
					component.worldPos = collectionPointData.initPos;
					component.SetPos(GetIconPos(area, collectionPointData.initPos));
					component.SetFixedScale(mapConfig.iconFixedScale);
					component.UpdateScale(curScale);
					component.SetIsTrack(collectionPointData.stateWorldAssetUid == trackCollectPointUid);
					component.Init(area, collectionPointData.mapSubArea, collectionPointData.stateWorldAssetUid, collectionPointData.collectionPointId);
					component.BindClickAction(TrySelectIcon);
					component.SetIsFade(_wantCollectionPointData.mapSubArea != collectionPointData.mapSubArea);
					if (collectionPointData.stateWorldAssetUid == trackCollectPointUid)
					{
						_trackSpecialPointInstantiateGO = go;
						CreateSpecialPointNavButton(component);
					}
				};
			}
		}
	}

	public void ShowSubAreaMonsterPoints(MapSubArea mapSubArea)
	{
		if (!_canTrackMonsterPointData.TryGetValue(mapSubArea, out var value) || value.Count <= 0)
		{
			return;
		}
		MonsterTrackPointData monsterTrackPointData = value[0];
		foreach (InstanceHandle item in instantiateMapIcon)
		{
			if (!(item.Result.GetComponent<MapIconBase>() is LargeMapMonsterPointIcon largeMapMonsterPointIcon))
			{
				continue;
			}
			if (mapSubArea != largeMapMonsterPointIcon.GetSubArea())
			{
				largeMapMonsterPointIcon.SetIsFade(fade: true);
				continue;
			}
			largeMapMonsterPointIcon.SetIsFade(fade: false);
			if (largeMapMonsterPointIcon.GetUid() == monsterTrackPointData.monsterPointUid)
			{
				UnSelectCurAccurateSelectIcon();
				AccurateSelectIcon(largeMapMonsterPointIcon);
				SetRectTransformToCenter(largeMapMonsterPointIcon.transform as RectTransform, 0.25f);
			}
		}
	}

	public void ShowSubAreaCollectionPoints(MapSubArea mapSubArea)
	{
		if (!_canTrackCollectionPointData.TryGetValue(mapSubArea, out var value) || value.Count <= 0)
		{
			return;
		}
		CollectionTrackPointData collectionTrackPointData = value[0];
		foreach (InstanceHandle item in instantiateMapIcon)
		{
			if (!(item.Result.GetComponent<MapIconBase>() is LargeMapCollectionPointIcon largeMapCollectionPointIcon))
			{
				continue;
			}
			if (mapSubArea != largeMapCollectionPointIcon.GetSubArea())
			{
				largeMapCollectionPointIcon.SetIsFade(fade: true);
				continue;
			}
			largeMapCollectionPointIcon.SetIsFade(fade: false);
			if (largeMapCollectionPointIcon.GetId() == collectionTrackPointData.collectionPointId)
			{
				UnSelectCurAccurateSelectIcon();
				AccurateSelectIcon(largeMapCollectionPointIcon);
				SetRectTransformToCenter(largeMapCollectionPointIcon.transform as RectTransform, 0.25f);
			}
		}
	}

	private void CreateNpcMapIcon(ACT.World.MapArea area)
	{
		foreach (NpcShowEntranceCollection item in Singleton<RuntimeNpcManager>.instance.GetNpcCollectionByMapArea(area))
		{
			int uid = item.NpcConfigUid;
			Vector3 npcPos = item.WorldPosition;
			NPCHeadIconConfig.IconConfig spriteId = GameLoader.meta.npcOrInteractObjectIconConfig.FindConfigById(item.TipIconID);
			if (spriteId.id <= 0)
			{
				continue;
			}
			InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapNpcIconPrefabAssetD.GUID);
			instanceHandle.Completed += (InstanceHandle go) =>
			{
				instantiateMapIcon.Add(go);
				LargeMapNpcIcon component = go.Result.GetComponent<LargeMapNpcIcon>();
				go.Result.transform.SetParent(iconRoot);
				component.SetPos(GetIconPos(area, npcPos));
				component.worldPos = npcPos;
				component.SetFixedScale(mapConfig.iconFixedScale);
				component.UpdateScale(curScale);
				component.Init(uid, spriteId.icon, area);
				component.BindClickAction(TrySelectIcon);
				if (m_data != null && m_data.jumpNpcId > 0 && m_data.jumpNpcId == uid)
				{
					areaMapScrollRect.normalizedPosition = GetCenterNormalizedPos(GetIconPos(curShowArea, npcPos), areaMapScrollRect);
					AccurateSelectIcon(component);
				}
			};
			instanceHandle.CompleteSync();
		}
	}

	private void CreateReceiveSideMissionMapIcon(ACT.World.MapArea area)
	{
		foreach (ReceiveMissionData receiveMissionData in Singleton<RuntimeNpcManager>.instance.GetReceiveMissionDatas((int)area))
		{
			Vector3 npcPosition = Singleton<RuntimeNpcManager>.instance.GetNpcPosition(receiveMissionData.npcUid);
			InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapReceiveSideMissionIconPrefabAssetID.GUID);
			instanceHandle.Completed += (InstanceHandle go) =>
			{
				instantiateMapIcon.Add(go);
				LargeMapReceiveSideMissionIcon component = go.Result.GetComponent<LargeMapReceiveSideMissionIcon>();
				go.Result.transform.SetParent(missionIconRoot);
				component.Init(receiveMissionData.missionId, receiveMissionData.npcUid, area, npcPosition);
				component.SetPos(GetIconPos(area, npcPosition));
				component.SetFixedScale(mapConfig.iconFixedScale);
				component.UpdateScale(curScale);
				component.BindClickAction(TrySelectIcon);
			};
			instanceHandle.CompleteSync();
		}
	}

	private void CreateMissionMapIcon(ACT.World.MapArea area, MapLayer layer)
	{
		IReadOnlyList<MissionPointData> points = Model<BattleMainMarkModelV2>.Interface.Points;
		if (points == null || points.Count == 0)
		{
			return;
		}
		foreach (MissionPointData pointData in points)
		{
			if (pointData.MapArea == area && pointData.GetGuidePointMapLayer() == layer)
			{
				PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapMissionIconPrefabAssetD.GUID).Completed += (InstanceHandle go) =>
				{
					instantiateMapIcon.Add(go);
					LargeMapMissionIcon component = go.Result.GetComponent<LargeMapMissionIcon>();
					go.Result.transform.SetParent(missionIconRoot);
					component.Init(pointData);
					component.BindClickAction(TrySelectIcon);
					component.SetPos(GetIconPos(area, pointData.GetActualPos()));
					component.SetFixedScale(mapConfig.iconFixedScale);
					component.UpdateScale(curScale);
					CreateMissionNavButton(component, pointData.GetSpriteId());
				};
			}
		}
	}

	private void CreateAreaBlockIcon(ACT.World.MapArea area)
	{
		Dictionary<int, Vector2> mapAreaBlockPos = mapConfig.GetMapAreaBlockPos(area);
		if (mapAreaBlockPos == null || mapAreaBlockPos.Count == 0)
		{
			return;
		}
		(float, float) areaScrollRectMinMaxScale = mapConfig.GetAreaScrollRectMinMaxScale(curShowArea);
		float standScale = (areaScrollRectMinMaxScale.Item2 + areaScrollRectMinMaxScale.Item1) / 2f;
		foreach (KeyValuePair<int, Vector2> areaBlock in mapAreaBlockPos)
		{
			PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapAreaBlockIconPrefabAssetD.GUID).Completed += (InstanceHandle go) =>
			{
				instantiateMapIcon.Add(go);
				LargeMapAreaExploreNode component = go.Result.GetComponent<LargeMapAreaExploreNode>();
				go.Result.transform.SetParent(areaBlockRoot);
				(float, float) areaScrollRectMargin = mapConfig.GetAreaScrollRectMargin(area);
				component.SetPos(areaBlock.Value + new Vector2(areaScrollRectMargin.Item1, areaScrollRectMargin.Item2) * 0.5f);
				component.Init(area, areaBlock.Key, standScale);
				component.UpdateScale(curScale);
			};
		}
		Dictionary<int, RectTransform> unlockFogRectTransform = areaGrid.unlockFogRectTransform;
		if (unlockFogRectTransform == null || unlockFogRectTransform.Count == 0)
		{
			return;
		}
		Dictionary<int, MapConfig.NodeBoundsData> chunkBoundData = mapConfig.GetChunkBoundData(area);
		foreach (KeyValuePair<int, RectTransform> chunkData in unlockFogRectTransform)
		{
			if (chunkBoundData.ContainsKey(chunkData.Key))
			{
				PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapChunkExplorePrefabAssetD.GUID).Completed += (InstanceHandle go) =>
				{
					instantiateMapIcon.Add(go);
					LargeMapChunkExploreNode component = go.Result.GetComponent<LargeMapChunkExploreNode>();
					RectTransform value = chunkData.Value;
					go.Result.transform.SetParent(areaBlockRoot);
					(float, float) areaScrollRectMargin = mapConfig.GetAreaScrollRectMargin(area);
					component.SetPos(value.anchoredPosition + new Vector2(areaScrollRectMargin.Item1, areaScrollRectMargin.Item2) * 0.5f);
					component.Init(area, chunkData.Key, standScale);
					component.UpdateScale(curScale);
				};
			}
		}
	}

	private Vector2 GetIconPos(ACT.World.MapArea area, Vector2 worldPos)
	{
		(float, float) areaScrollRectMargin = mapConfig.GetAreaScrollRectMargin(area);
		Vector3 vector = transformMatrix.MultiplyPoint3x4(worldPos);
		return new Vector2(vector.x, vector.y) + mapConfig.largeMapIconOffset + new Vector2(areaScrollRectMargin.Item1, areaScrollRectMargin.Item2) * 0.5f;
	}

	private void InitMatrix(ACT.World.MapArea area)
	{
		float largeMapRatio = mapConfig.largeMapRatio;
		Vector2 areaLeftBottomWorldPos = mapConfig.GetAreaLeftBottomWorldPos(area);
		Vector3 vector = new Vector3(areaLeftBottomWorldPos.x, areaLeftBottomWorldPos.y, MapUtility.ConfigWorldMapGraph.GetMapAreaZOffset(area));
		transformMatrix = Matrix4x4.TRS(-vector * largeMapRatio, Quaternion.identity, new Vector3(largeMapRatio, largeMapRatio, largeMapRatio));
	}

	public Vector3 GetIconWorldPos(ACT.World.MapArea area, Vector2 localPos)
	{
		(float, float) areaScrollRectMargin = mapConfig.GetAreaScrollRectMargin(area);
		Vector2 vector = localPos - new Vector2(areaScrollRectMargin.Item1, areaScrollRectMargin.Item2) * 0.5f;
		return transformMatrix.inverse.MultiplyPoint3x4(vector);
	}

	private void CleanNavButton()
	{
		if (_specialPointNavBtn != null)
		{
			UnityEngine.Object.Destroy(_specialPointNavBtn.gameObject);
			_specialPointNavBtn = null;
		}
	}

	private void RecycleAllMapIcon()
	{
		if (missionIconNavBtnDic != null)
		{
			foreach (KeyValuePair<LargeMapMissionIcon, NavButton> item in missionIconNavBtnDic)
			{
				if (item.Value != null)
				{
					UnityEngine.Object.Destroy(item.Value.gameObject);
				}
			}
			missionIconNavBtnDic.Clear();
		}
		CleanGeneralNavButtons();
		CleanNavButton();
		if (instantiateMapIcon != null)
		{
			foreach (InstanceHandle item2 in instantiateMapIcon)
			{
				(item2.Result?.GetComponent<MapIconBase>())?.UnInit();
				PrecacheManager.Instance.ReleaseInstanceHandle(item2);
			}
			instantiateMapIcon.Clear();
			interactIconLoaded = false;
		}
		RecycleSelfNodeIcons();
		if (_instantiateBossRoomIconSet != null)
		{
			foreach (LargeMapBossRoomIcon item3 in _instantiateBossRoomIconSet)
			{
				UnityEngine.Object.Destroy(item3.gameObject);
			}
			_instantiateBossRoomIconSet.Clear();
		}
		_trackSpecialPointInstantiateGO = null;
	}

	private void SetTempleMapIconActive()
	{
		if (missionIconNavBtnDic != null)
		{
			foreach (KeyValuePair<LargeMapMissionIcon, NavButton> item in missionIconNavBtnDic)
			{
				if (item.Value != null)
				{
					UnityEngine.Object.Destroy(item.Value.gameObject);
				}
			}
			missionIconNavBtnDic.Clear();
		}
		CleanGeneralNavButtons();
		CleanNavButton();
		if (instantiateMapIcon != null)
		{
			foreach (InstanceHandle item2 in instantiateMapIcon)
			{
				(item2.Result?.GetComponent<MapIconBase>())?.UnInit();
				PrecacheManager.Instance.ReleaseInstanceHandle(item2);
			}
			instantiateMapIcon.Clear();
		}
		if (_instantiateBossRoomIconSet != null)
		{
			foreach (LargeMapBossRoomIcon item3 in _instantiateBossRoomIconSet)
			{
				UnityEngine.Object.Destroy(item3.gameObject);
			}
			_instantiateBossRoomIconSet.Clear();
		}
		_trackSpecialPointInstantiateGO = null;
	}

	public void RecycleWantTrackMonsterPointIcon()
	{
		if (_trackSpecialPointInstantiateGO == null)
		{
			return;
		}
		_trackSpecialPointInstantiateGO.Result.GetComponent<LargeMapMonsterPointIcon>()?.UnInit();
		PrecacheManager.Instance.ReleaseInstanceHandle(_trackSpecialPointInstantiateGO);
		instantiateMapIcon.Remove(_trackSpecialPointInstantiateGO);
		_trackSpecialPointInstantiateGO = null;
		foreach (InstanceHandle item in instantiateMapIcon)
		{
			MapIconBase mapIconBase = item.Result?.GetComponent<MapIconBase>();
			if (mapIconBase is LargeMapMonsterPointIcon)
			{
				mapIconBase.UnInit();
				PrecacheManager.Instance.ReleaseInstanceHandle(item);
			}
		}
		_canTrackMonsterPointData.Clear();
		CleanNavButton();
		CheckSpecialPointNavBtn();
		Model<TrackModel>.Interface.SendMonsterPointChanged();
	}

	public void RecycleWantTrackCollectionPointIcon()
	{
		if (_trackSpecialPointInstantiateGO == null)
		{
			return;
		}
		_trackSpecialPointInstantiateGO.Result.GetComponent<LargeMapCollectionPointIcon>()?.UnInit();
		PrecacheManager.Instance.ReleaseInstanceHandle(_trackSpecialPointInstantiateGO);
		instantiateMapIcon.Remove(_trackSpecialPointInstantiateGO);
		_trackSpecialPointInstantiateGO = null;
		foreach (InstanceHandle item in instantiateMapIcon)
		{
			MapIconBase mapIconBase = item.Result?.GetComponent<MapIconBase>();
			if (mapIconBase is LargeMapCollectionPointIcon)
			{
				mapIconBase.UnInit();
				PrecacheManager.Instance.ReleaseInstanceHandle(item);
			}
		}
		_canTrackCollectionPointData.Clear();
		CleanNavButton();
		CheckSpecialPointNavBtn();
		Model<TrackModel>.Interface.SendCollectionPointChanged();
	}

	public void SelectIcon(LargeMapIcon icon)
	{
		TrySelectIcon(icon);
	}

	private void TrySelectIcon(LargeMapIcon icon)
	{
		if (IsOperating || ((accurateSelectIcon == icon || vagueSelectIcon == icon) && !FindNearIcon(icon)))
		{
			return;
		}
		MapPointTraceInfo curGuideIcon = Model<MapModel>.Interface.CurrentGuideMapPoint;
		if (curGuideIcon != null && curGuideIcon.pointId != 0)
		{
			InstanceHandle instanceHandle = instantiateMapIcon.Find((InstanceHandle instantiateGO) =>
			{
				LargeMapIcon component = instantiateGO.Result.GetComponent<LargeMapIcon>();
				return instantiateGO.Result.activeSelf && component != null && component.type == curGuideIcon.iconType && component.GetId() == curGuideIcon.pointId;
			});
			if (instanceHandle != null)
			{
				SetRectTransformToCenter(icon.transform as RectTransform, 0.25f);
				if (accurateSelectIcon != null)
				{
					UnAccurateSelectIconImmediately(accurateSelectIcon);
				}
				AccurateSelectIcon(instanceHandle.Result?.GetComponent<LargeMapIcon>());
				Model<MapModel>.Interface.SetMapPointGuideInfo(0, 0);
			}
			return;
		}
		if (accurateSelectIcon != null)
		{
			UnAccurateSelectIconImmediately(accurateSelectIcon);
		}
		else if (vagueSelectIcon != null)
		{
			UnVagueSelectIconImmediately(vagueSelectIcon);
		}
		SetRectTransformToCenter(icon.transform as RectTransform, 0.25f);
		if (FindNearIcon(icon))
		{
			VagueSelectIcon(icon);
			return;
		}
		if (accurateSelectIcon != null)
		{
			UnAccurateSelectIconImmediately(accurateSelectIcon);
		}
		AccurateSelectIcon(icon);
	}

	private bool FindNearIcon(LargeMapIcon icon)
	{
		nearIcon = instantiateMapIcon.Where((InstanceHandle instantiateGO) => GetIconDistance((RectTransform)instantiateGO.Result.transform, (RectTransform)icon.transform) < mapConfig.vagueSelectRadius && instantiateGO.Result.GetComponent<LargeMapIcon>() != null && instantiateGO.Result.GetComponent<LargeMapIcon>() != icon && instantiateGO.Result.GetComponent<LargeMapIcon>().type != MapIconType.RewardBox && instantiateGO.Result.activeSelf).ToList().ConvertAll((InstanceHandle instantiateGO) => instantiateGO.Result.GetComponent<LargeMapIcon>());
		nearIcon.Insert(0, icon);
		return nearIcon.Count > 1;
	}

	private float GetIconDistance(RectTransform icon, RectTransform target)
	{
		Camera uICamera = Singleton<NewUIManager>.instance.UICamera;
		Vector3 vector = uICamera.WorldToScreenPoint(icon.position);
		Vector3 vector2 = uICamera.WorldToScreenPoint(target.position);
		return Vector2.Distance(vector, vector2);
	}

	private void AccurateSelectIcon(LargeMapIcon icon)
	{
		accurateSelectIcon = icon;
		icon.AccurateSelectEffect();
		ShowIconSideBar();
		if (!templeMapScrollRect.iconSelectFromScrollMap)
		{
			return;
		}
		if (icon is LargeMapInteractObjIcon largeMapInteractObjIcon)
		{
			if (largeMapInteractObjIcon.type == MapIconType.Temple)
			{
				List<TempleData> infos = templeMapScrollRect.infos;
				if (infos != null && infos.Count > 0)
				{
					for (int i = 0; i < templeMapScrollRect.infos.Count; i++)
					{
						TempleData templeData = templeMapScrollRect.infos[i];
						if (templeData.templeId == largeMapInteractObjIcon.GetDataId())
						{
							templeMapScrollRect.nowSelectData = templeData;
							templeMapScrollRect.templeList.ScrollToCell(i, 0f);
						}
					}
				}
			}
			templeMapScrollRect.iconSelectFromScrollMap = true;
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.LargeMapIconClick);
	}

	public void AccurateSelectIconFormVagueSelectList(LargeMapIcon accurateSelectIcon)
	{
		UnVagueSelectIcon(vagueSelectIcon);
		AccurateSelectIcon(accurateSelectIcon);
	}

	private void UnAccurateSelectIcon(LargeMapIcon icon)
	{
		accurateSelectIcon = null;
		icon.DeAccurateSelectEffect();
		HideIconSideBar();
	}

	private void UnAccurateSelectIconImmediately(LargeMapIcon icon)
	{
		accurateSelectIcon = null;
		icon.DeAccurateSelectEffect();
		HideIconSideBarImmediately();
	}

	public void UnSelectCurAccurateSelectIcon()
	{
		if (!(accurateSelectIcon == null))
		{
			UnAccurateSelectIcon(accurateSelectIcon);
		}
	}

	public bool UnTrackWantTrackPoint(MapIconType iconType)
	{
		UnSelectCurAccurateSelectIcon();
		return true;
	}

	private void OnMonsterPointTraceChanged()
	{
		if (!Model<TrackModel>.HasInstance())
		{
			return;
		}
		if (Model<TrackModel>.Interface.IsTrackingMonsterPoint)
		{
			foreach (InstanceHandle item in instantiateMapIcon)
			{
				MapIconBase mapIconBase = item.Result?.GetComponent<MapIconBase>();
				if (mapIconBase is LargeMapMonsterPointIcon largeMapMonsterPointIcon)
				{
					if (mapIconBase.GetId() == Model<TrackModel>.Interface.GetTrackMonsterPointId())
					{
						_trackSpecialPointInstantiateGO = item;
						CreateSpecialPointNavButton(largeMapMonsterPointIcon);
						largeMapMonsterPointIcon.SetIsTrack(isTrack: true);
					}
					else
					{
						largeMapMonsterPointIcon.SetIsTrack(isTrack: false);
					}
				}
			}
			return;
		}
		RecycleWantTrackMonsterPointIcon();
	}

	private void OnCollectionPointTraceChanged()
	{
		if (!Model<TrackModel>.HasInstance())
		{
			return;
		}
		if (Model<TrackModel>.Interface.IsTrackingCollectionPoint)
		{
			foreach (InstanceHandle item in instantiateMapIcon)
			{
				MapIconBase mapIconBase = item.Result?.GetComponent<MapIconBase>();
				if (mapIconBase is LargeMapCollectionPointIcon largeMapCollectionPointIcon)
				{
					if (mapIconBase.GetId() == Model<TrackModel>.Interface.GetTrackCollectionPointId())
					{
						_trackSpecialPointInstantiateGO = item;
						CreateSpecialPointNavButton(largeMapCollectionPointIcon);
						largeMapCollectionPointIcon.SetIsTrack(isTrack: true);
					}
					else
					{
						largeMapCollectionPointIcon.SetIsTrack(isTrack: false);
					}
				}
			}
			return;
		}
		RecycleWantTrackCollectionPointIcon();
	}

	public bool HasAccurateSelectIcon()
	{
		return accurateSelectIcon != null;
	}

	private void VagueSelectIcon(LargeMapIcon icon)
	{
		vagueSelectIcon = icon;
		icon.VagueSelectEffect();
		ShowVagueSelectList();
	}

	private void UnVagueSelectIcon(LargeMapIcon icon)
	{
		vagueSelectIcon = null;
		icon.DeVagueSelectEffect();
		HideVagueSelectList();
	}

	private void UnVagueSelectIconImmediately(LargeMapIcon icon)
	{
		vagueSelectIcon = null;
		icon.DeVagueSelectEffect();
		HideVagueSelectListImmediately();
	}

	public void UnSelectCurVagueSelectIcon()
	{
		if (vagueSelectList.IsNormal && !(vagueSelectIcon == null))
		{
			UnVagueSelectIcon(vagueSelectIcon);
		}
	}

	public void ForceUnSelectCurVagueSelectIcon()
	{
		if (!(vagueSelectIcon == null))
		{
			UnVagueSelectIconImmediately(vagueSelectIcon);
			ChangeToGamePadInputState(SubControllerType.main);
		}
	}

	public bool HasVagueSelectIcon()
	{
		return vagueSelectIcon != null;
	}

	public bool HasSelectIcon()
	{
		if (!HasAccurateSelectIcon())
		{
			return HasVagueSelectIcon();
		}
		return true;
	}

	public void ShowVagueSelectList()
	{
		vagueSelectList.SetNearIcon(nearIcon);
		vagueSelectList.Show();
		ChangeToGamePadInputState(SubControllerType.selectedPoint);
	}

	public void HideVagueSelectList()
	{
		vagueSelectList.Hide();
		ChangeToGamePadInputState(SubControllerType.main);
	}

	public void HideVagueSelectListImmediately()
	{
		vagueSelectList.HideImmediately();
	}

	public void ShowIconSideBar()
	{
		HideExploreRatioSideBarImmediately();
		if (!iconSidebar.IsHidden)
		{
			iconSidebar.SetHide();
		}
		iconSidebar.SetIcon(accurateSelectIcon);
		iconSidebar.Show();
		ChangeToGamePadInputState(SubControllerType.sideBar);
	}

	public void HideIconSideBar()
	{
		iconSidebar.Hide();
		ChangeToGamePadInputState(SubControllerType.main);
	}

	private void HideIconSideBarImmediately()
	{
		iconSidebar.HideImmediately();
	}

	public void ShowExploreRatioSideBar()
	{
		if (!IsOperating)
		{
			HideIconSideBarImmediately();
			exploreRatioSidebar.Show(AreaTabType.Area);
			ChangeToGamePadInputState(SubControllerType.mapCollection);
		}
	}

	public void ShowSubAreaExploreRatioSideBar()
	{
		if (!IsOperating)
		{
			HideIconSideBarImmediately();
			exploreRatioSidebar.Show(AreaTabType.SubArea);
			ChangeToGamePadInputState(SubControllerType.mapCollection);
		}
	}

	public void HideExploreRatioSideBar()
	{
		if (!IsOperating && exploreRatioSidebar.IsNormal)
		{
			exploreRatioSidebar.Hide();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Close");
			ChangeToGamePadInputState(SubControllerType.main);
		}
	}

	private void HideExploreRatioSideBarImmediately()
	{
		exploreRatioSidebar.HideImmediately();
		ChangeToGamePadInputState(SubControllerType.main);
	}

	public void SetPlayerNavButton()
	{
		if (InMapSoftMask(mapPlayerIcon.transform.position) || !mapPlayerIcon.gameObject.activeSelf)
		{
			playerNavBtn.gameObject.SetActive(value: false);
			return;
		}
		playerNavBtn.gameObject.SetActive(value: true);
		Vector2 zero = Vector2.zero;
		Vector2 vector = UIUtility.ConvertLocalPosToTargetPos(mapPlayerIcon.transform as RectTransform, areaMapScrollRect.viewport);
		Vector2 forward = vector - zero;
		SetNavButtonRotAndPos(playerNavBtn, forward, zero, vector);
		playerNavBtn.navBtn.onClick.RemoveAllListeners();
		playerNavBtn.AddClickAction(() =>
		{
			SetRectTransformToCenter(mapPlayerIcon.transform as RectTransform);
		});
	}

	private void CreateMissionNavButton(LargeMapMissionIcon largeMapMissionIcon, int missionSpriteId)
	{
		NavButton component = UnityEngine.Object.Instantiate(mapConfig.navBtnPrefab, navBtnRoot.transform).GetComponent<NavButton>();
		component.TrackMissionInit(missionSpriteId);
		component.AddClickAction(() =>
		{
			SetRectTransformToCenter(largeMapMissionIcon.transform as RectTransform);
		});
		missionIconNavBtnDic.Add(largeMapMissionIcon, component);
		CheckMissionNavBtn();
	}

	private void SetSingleMissionNavBtn(LargeMapMissionIcon missionIcon)
	{
		if (missionIconNavBtnDic.TryGetValue(missionIcon, out var value))
		{
			if (InMapSoftMask(missionIcon.transform.position))
			{
				value.gameObject.SetActive(value: false);
				return;
			}
			value.gameObject.SetActive(value: true);
			Vector2 zero = Vector2.zero;
			Vector2 vector = UIUtility.ConvertLocalPosToTargetPos(missionIcon.transform as RectTransform, areaMapScrollRect.viewport);
			Vector2 forward = vector - zero;
			SetNavButtonRotAndPos(value, forward, zero, vector);
		}
	}

	public void SetMissionNavButton()
	{
		if (missionIconNavBtnDic.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<LargeMapMissionIcon, NavButton> item in missionIconNavBtnDic)
		{
			SetSingleMissionNavBtn(item.Key);
		}
	}

	private void HandleMapPointTrace(BaseEventContent e)
	{
		if (e is MapPointTraceRefresh mapPointTraceRefresh)
		{
			if (mapPointTraceRefresh.id != 0)
			{
				CreateGeneralNavButtonIcons(curShowArea);
			}
			else
			{
				CleanGeneralNavButtons();
			}
			CheckGeneralPointNavBtn();
		}
	}

	private void CreateGeneralNavButtonIcons(ACT.World.MapArea area)
	{
		MapPointTraceInfo currentTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
		if (currentTraceMapPoint == null || currentTraceMapPoint.pointId == 0 || currentTraceMapPoint.mapArea != area)
		{
			return;
		}
		CleanGeneralNavButtons();
		foreach (InstanceHandle item in instantiateMapIcon)
		{
			LargeMapIcon icon = item.Result.GetComponent<LargeMapIcon>();
			if (!(icon == null) && currentTraceMapPoint.mapArea == icon.mapArea && currentTraceMapPoint.pointId == icon.GetId() && currentTraceMapPoint.iconType == icon.type)
			{
				_generalPointInstantiateGO = item;
				item.Result?.GetComponent<LargeMapIcon>().SetIsTrack(isTrack: true);
				GameObject gameObject = UnityEngine.Object.Instantiate(mapConfig.navBtnPrefab, navBtnRoot.transform);
				_generalPointNavBtn = gameObject.GetComponent<NavButton>();
				if (icon is LargeMapSelfNodeIcon largeMapSelfNodeIcon)
				{
					_generalPointNavBtn.TrackGeneralPointInit(largeMapSelfNodeIcon.GetSelfNodeIconTypeId());
				}
				else if (icon is LargeMapReceiveSideMissionIcon)
				{
					_generalPointNavBtn.TrackGeneralPointInit(10909);
				}
				else if (icon is LargeMapNpcIcon largeMapNpcIcon)
				{
					_generalPointNavBtn.TrackNpcPointInit(largeMapNpcIcon.GetSpriteId());
				}
				else if (icon is LargeMapWorldBossIcon largeMapWorldBossIcon)
				{
					int enemyId = CoreUtils.DetermineActualMonster(largeMapWorldBossIcon.GetWorldBossId());
					_generalPointNavBtn.TrackMonsterPointInit(enemyId, largeMapWorldBossIcon.IsDisabled.activeSelf);
				}
				else
				{
					_generalPointNavBtn.TrackGeneralPointInit(MapUtility.GetInteractObjSpriteId(icon.GetId()));
				}
				_generalPointNavBtn.AddClickAction(() =>
				{
					SetRectTransformToCenter(icon.transform as RectTransform);
				});
				CheckGeneralPointNavBtn();
				break;
			}
		}
	}

	public void SetGeneralPointNavButton()
	{
		if (!(_generalPointNavBtn == null) && _generalPointInstantiateGO != null && !(_generalPointInstantiateGO.Result == null))
		{
			if (InMapSoftMask(_generalPointInstantiateGO.Result.transform.position))
			{
				_generalPointNavBtn.gameObject.SetActive(value: false);
				return;
			}
			_generalPointNavBtn.gameObject.SetActive(value: true);
			Vector2 zero = Vector2.zero;
			Vector2 vector = UIUtility.ConvertLocalPosToTargetPos(_generalPointInstantiateGO.Result.transform as RectTransform, areaMapScrollRect.viewport);
			Vector2 forward = vector - zero;
			SetNavButtonRotAndPos(_generalPointNavBtn, forward, zero, vector);
		}
	}

	private void CreateSpecialPointNavButton(LargeMapIcon largeMapPointIcon)
	{
		if (_specialPointNavBtn != null)
		{
			UnityEngine.Object.Destroy(_specialPointNavBtn.gameObject);
			_specialPointNavBtn = null;
			CheckSpecialPointNavBtn();
		}
		GameObject gameObject = UnityEngine.Object.Instantiate(mapConfig.navBtnPrefab, navBtnRoot.transform);
		_specialPointNavBtn = gameObject.GetComponent<NavButton>();
		if (largeMapPointIcon is LargeMapMonsterPointIcon largeMapMonsterPointIcon)
		{
			_specialPointNavBtn.TrackMonsterPointInit(largeMapMonsterPointIcon.GetEnemyId());
		}
		else if (largeMapPointIcon is LargeMapCollectionPointIcon)
		{
			_specialPointNavBtn.TrackCollectionPointInit();
		}
		_specialPointNavBtn.AddClickAction(() =>
		{
			SetRectTransformToCenter(largeMapPointIcon.transform as RectTransform);
		});
		CheckSpecialPointNavBtn();
	}

	public void SetSpecialPointNavButton()
	{
		if (!(_specialPointNavBtn == null) && _trackSpecialPointInstantiateGO != null && !(_trackSpecialPointInstantiateGO.Result == null))
		{
			if (InMapSoftMask(_trackSpecialPointInstantiateGO.Result.transform.position))
			{
				_specialPointNavBtn.gameObject.SetActive(value: false);
				return;
			}
			_specialPointNavBtn.gameObject.SetActive(value: true);
			Vector2 zero = Vector2.zero;
			Vector2 vector = UIUtility.ConvertLocalPosToTargetPos(_trackSpecialPointInstantiateGO.Result.transform as RectTransform, areaMapScrollRect.viewport);
			Vector2 forward = vector - zero;
			SetNavButtonRotAndPos(_specialPointNavBtn, forward, zero, vector);
		}
	}

	private void SetNavButtonRotAndPos(NavButton navBtn, Vector2 forward, Vector2 scrollViewportPos, Vector2 mapIconPos)
	{
		SetNavButtonRot(navBtn, forward);
		SetNavButtonPos(navBtn, forward, scrollViewportPos, mapIconPos);
	}

	private void SetNavButtonRot(NavButton navBtn, Vector2 forward)
	{
		float z = Mathf.Atan2(forward.y, forward.x) * 57.29578f;
		navBtn.outer.localRotation = Quaternion.Euler(0f, 0f, z);
	}

	private void SetNavButtonPos(NavButton navBtn, Vector2 forward, Vector2 scrollViewportPos, Vector2 mapIconPos)
	{
		Rect rect = areaMapScrollRect.viewport.rect;
		float num = (0f - rect.width) / 2f + mapConfig.navBtnHorizontalMargin;
		float num2 = rect.width / 2f - mapConfig.navBtnHorizontalMargin;
		float num3 = (0f - rect.height) / 2f + mapConfig.navBtnVerticalMargin;
		float num4 = rect.height / 2f - mapConfig.navBtnVerticalMargin;
		float num5 = forward.y / forward.x;
		float num6 = num4 / num2;
		float num7 = num4 / num;
		Vector2 zero = Vector2.zero;
		if (num5 >= num6 || num5 <= num7)
		{
			zero.x = Mathf.Lerp(scrollViewportPos.x, mapIconPos.x, ((forward.y > 0f) ? num4 : num3) / mapIconPos.y);
			zero.y = ((forward.y > 0f) ? num4 : num3);
		}
		else if (num5 < num6 && num5 > num7)
		{
			zero.x = ((forward.x > 0f) ? num2 : num);
			zero.y = Mathf.Lerp(scrollViewportPos.y, mapIconPos.y, ((forward.x > 0f) ? num2 : num) / mapIconPos.x);
		}
		navBtn.self.anchoredPosition = zero;
	}

	private bool InMapSoftMask(Vector3 worldPosition)
	{
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(GameUtility.uiCamera, worldPosition);
		return RectTransformUtility.RectangleContainsScreenPoint(areaMapScrollRect.viewport, screenPoint, GameUtility.uiCamera);
	}

	private void UpdateLayerOnEnterAreaMap(MapLayer layer)
	{
		if (!templeOpen)
		{
			areaGrid.ShowSingleLayer(layer);
			CheckPlayerIcon();
			CheckPlayerNavBtn();
			CheckSpecialPointNavBtn();
			CheckGeneralPointNavBtn();
		}
	}

	public void ToggleDescriptionMode()
	{
		if (animateToggle != null)
		{
			animateToggle.isOn = !animateToggle.isOn;
		}
	}

	public void SwitchToLayer(MapLayer layer)
	{
		if (accurateSelectIcon != null)
		{
			UnAccurateSelectIconImmediately(accurateSelectIcon);
		}
		if (vagueSelectIcon != null)
		{
			UnVagueSelectIconImmediately(vagueSelectIcon);
		}
		curShowLayer = layer;
		if (templeOpen)
		{
			SetTempleMapIconActive();
		}
		else
		{
			RecycleAllMapIcon();
		}
		CreateAllMapIcon(areaGrid.area, layer);
		if (!templeOpen)
		{
			areaGrid.ShowSingleLayer(layer);
			CheckPlayerIcon();
			CheckPlayerNavBtn();
			CheckMissionNavBtn();
			CheckSpecialPointNavBtn();
			CheckGeneralPointNavBtn();
		}
	}

	private void CheckPlayerIcon()
	{
		if (curShowArea == playerArea)
		{
			mapPlayerIcon.SetActive(active: true);
			SetPlayerNavButton();
		}
		else
		{
			mapPlayerIcon.SetActive(active: false);
		}
	}

	private void CheckPlayerNavBtn()
	{
		if (curShowArea != playerArea)
		{
			areaMapScrollRect.RemoveSetPlayerNavBtnOnValueChanged();
		}
		else
		{
			areaMapScrollRect.AddSetPlayerNavBtnOnValueChanged();
		}
	}

	private void CheckMissionNavBtn()
	{
		Dictionary<LargeMapMissionIcon, NavButton> dictionary = missionIconNavBtnDic;
		if (dictionary != null && dictionary.Count > 0)
		{
			areaMapScrollRect.AddSetMissionNavBtnOnValueChanged();
		}
		else
		{
			areaMapScrollRect.RemoveSetMissionNavBtnOnValueChanged();
		}
	}

	private void CheckSpecialPointNavBtn()
	{
		if (_trackSpecialPointInstantiateGO != null)
		{
			areaMapScrollRect.AddSetMonsterPointNavBtnOnValueChanged();
		}
		else
		{
			areaMapScrollRect.RemoveSetMonsterPointNavBtnOnValueChanged();
		}
	}

	private void CheckGeneralPointNavBtn()
	{
		if (_generalPointInstantiateGO != null)
		{
			areaMapScrollRect.AddSetGeneralPointNavBtnOnValueChanged();
		}
		else
		{
			areaMapScrollRect.RemoveSetGeneralPointNavBtnOnValueChanged();
		}
	}

	public void HandleKeyboardMapMove(Vector2 inputDir, bool isControl)
	{
		if (!enableKeyboardControl)
		{
			return;
		}
		keyboardMoveInput = inputDir;
		isKeyboardControlling = (inputDir != Vector2.zero) & isControl;
		if (isKeyboardControlling)
		{
			if (templeOpen)
			{
				templeMapScrollRect.velocity = Vector2.zero;
			}
			else
			{
				areaMapScrollRect.velocity = Vector2.zero;
			}
		}
	}

	private void UpdateKeyboardMapMove()
	{
		if (!enableKeyboardControl || !isKeyboardControlling || IsOperating || IsNav || isMouseWheelZooming)
		{
			if (currentKeyboardVelocity.magnitude > 0.1f)
			{
				currentKeyboardVelocity = Vector2.Lerp(currentKeyboardVelocity, Vector2.zero, keyboardMoveSmooth * Time.deltaTime);
			}
			else
			{
				currentKeyboardVelocity = Vector2.zero;
			}
		}
		else
		{
			Vector2 b = keyboardMoveInput * keyboardMoveSpeed;
			currentKeyboardVelocity = Vector2.Lerp(currentKeyboardVelocity, b, keyboardMoveSmooth * Time.deltaTime);
			ApplyKeyboardMove(currentKeyboardVelocity * Time.deltaTime);
		}
	}

	private void UpdateLeftStickMapMove()
	{
		Vector2 leftStick = LeftStick;
		if (IsOperating || IsNav || isMouseWheelZooming || leftStick == Vector2.zero || isKeyboardControlling)
		{
			virtualCursor?.ClearCursorMovementBounds();
			virtualCursor?.HandleGamepadInput(Vector2.zero);
			return;
		}
		Vector2 b = leftStick * keyboardMoveSpeed * 1.5f;
		currentKeyboardVelocity = Vector2.Lerp(currentKeyboardVelocity, b, keyboardMoveSmooth * Time.deltaTime);
		Vector2 vector = ((virtualCursor != null) ? virtualCursor.GetCursorPosition() : Vector2.zero);
		Vector2 vector2 = ((virtualCursor != null) ? virtualCursor.GetScreenCenter() : Vector2.zero);
		bool flag = NeedsCursorRecenter(vector.x, vector2.x, leftStick.x);
		bool flag2 = NeedsCursorRecenter(vector.y, vector2.y, leftStick.y);
		Vector2 deltaMove = currentKeyboardVelocity * Time.deltaTime;
		if (flag)
		{
			deltaMove.x = 0f;
		}
		if (flag2)
		{
			deltaMove.y = 0f;
		}
		Vector2 vector3 = ApplyLeftStickMapMove(deltaMove);
		Vector2 vector4 = new Vector2((flag || Mathf.Abs(vector3.x) <= 0.01f) ? leftStick.x : 0f, (flag2 || Mathf.Abs(vector3.y) <= 0.01f) ? leftStick.y : 0f);
		if (!(virtualCursor != null))
		{
			return;
		}
		if (flag | flag2)
		{
			Rect defaultCursorMovementBounds = virtualCursor.GetDefaultCursorMovementBounds();
			Vector2 min = defaultCursorMovementBounds.min;
			Vector2 max = defaultCursorMovementBounds.max;
			if (flag)
			{
				if (vector.x > vector2.x)
				{
					min.x = vector2.x;
				}
				else
				{
					max.x = vector2.x;
				}
			}
			if (flag2)
			{
				if (vector.y > vector2.y)
				{
					min.y = vector2.y;
				}
				else
				{
					max.y = vector2.y;
				}
			}
			virtualCursor.SetCursorMovementBounds(min, max);
		}
		else
		{
			virtualCursor.ClearCursorMovementBounds();
		}
		if (vector4 != Vector2.zero)
		{
			virtualCursor.CancelAutoSnap();
		}
		virtualCursor.HandleGamepadInput(vector4);
	}

	private void ApplyKeyboardMove(Vector2 deltaMove)
	{
		if (templeOpen)
		{
			TempleMapScrollRect templeMapScrollRect = this.templeMapScrollRect;
			if (!(templeMapScrollRect == null))
			{
				Vector2 normalizedPosition = templeMapScrollRect.normalizedPosition;
				Vector2 size = templeMapScrollRect.viewport.rect.size;
				Vector2 vector = templeMapScrollRect.content.sizeDelta * templeMapScrollRect.content.localScale;
				float num = vector.x - size.x;
				float num2 = vector.y - size.y;
				if (!(Mathf.Abs(num) < 0.01f) && !(Mathf.Abs(num2) < 0.01f))
				{
					Vector2 vector2 = new Vector2(deltaMove.x / num, deltaMove.y / num2);
					Vector2 normalizedPosition2 = normalizedPosition + vector2;
					normalizedPosition2.x = Mathf.Clamp01(normalizedPosition2.x);
					normalizedPosition2.y = Mathf.Clamp01(normalizedPosition2.y);
					templeMapScrollRect.normalizedPosition = normalizedPosition2;
				}
			}
			return;
		}
		AreaMapScrollRect areaMapScrollRect = this.areaMapScrollRect;
		if (!(areaMapScrollRect == null))
		{
			Vector2 normalizedPosition3 = areaMapScrollRect.normalizedPosition;
			Vector2 size2 = areaMapScrollRect.viewport.rect.size;
			Vector2 vector3 = areaMapScrollRect.content.sizeDelta * areaMapScrollRect.content.localScale;
			float num3 = vector3.x - size2.x;
			float num4 = vector3.y - size2.y;
			if (!(Mathf.Abs(num3) < 0.01f) && !(Mathf.Abs(num4) < 0.01f))
			{
				Vector2 vector4 = new Vector2(deltaMove.x / num3, deltaMove.y / num4);
				Vector2 normalizedPosition4 = normalizedPosition3 + vector4;
				normalizedPosition4.x = Mathf.Clamp01(normalizedPosition4.x);
				normalizedPosition4.y = Mathf.Clamp01(normalizedPosition4.y);
				areaMapScrollRect.normalizedPosition = normalizedPosition4;
			}
		}
	}

	public void SetKeyboardControlEnable(bool enable)
	{
		enableKeyboardControl = enable;
		if (!enable)
		{
			keyboardMoveInput = Vector2.zero;
			currentKeyboardVelocity = Vector2.zero;
			isKeyboardControlling = false;
		}
	}

	public bool IsKeyboardControlEnabled()
	{
		return enableKeyboardControl;
	}

	public void SetKeyboardMoveSpeed(float speed)
	{
		keyboardMoveSpeed = Mathf.Max(0f, speed);
	}

	public void SetKeyboardMoveSmooth(float smooth)
	{
		keyboardMoveSmooth = Mathf.Max(0.1f, smooth);
	}

	private Vector2 ApplyLeftStickMapMove(Vector2 deltaMove)
	{
		ScrollRect scrollRect = (templeOpen ? ((ScrollRect)templeMapScrollRect) : ((ScrollRect)areaMapScrollRect));
		if (scrollRect == null || scrollRect.viewport == null || scrollRect.content == null)
		{
			return Vector2.zero;
		}
		Vector2 normalizedPosition = scrollRect.normalizedPosition;
		Vector2 size = scrollRect.viewport.rect.size;
		Vector2 vector = scrollRect.content.sizeDelta * scrollRect.content.localScale - size;
		Vector2 vector2 = new Vector2((vector.x > 0f) ? (deltaMove.x / vector.x) : 0f, (vector.y > 0f) ? (deltaMove.y / vector.y) : 0f);
		Vector2 normalizedPosition2 = new Vector2(Mathf.Clamp01(normalizedPosition.x + vector2.x), Mathf.Clamp01(normalizedPosition.y + vector2.y));
		Vector2 anchoredPosition = scrollRect.content.anchoredPosition;
		scrollRect.normalizedPosition = normalizedPosition2;
		return scrollRect.content.anchoredPosition - anchoredPosition;
	}

	private static bool NeedsCursorRecenter(float cursorPosition, float cursorCenter, float input)
	{
		if (!(cursorPosition > cursorCenter + 0.01f) || !(input < 0f))
		{
			if (cursorPosition < cursorCenter - 0.01f)
			{
				return input > 0f;
			}
			return false;
		}
		return true;
	}

	public void HandleMouseWheelZoom(float scrollDelta)
	{
		if (!enableMouseWheelZoom || IsOperating || IsNav)
		{
			return;
		}
		ScrollRect scrollRect = (templeOpen ? ((ScrollRect)templeMapScrollRect) : ((ScrollRect)areaMapScrollRect));
		if (scrollRect == null)
		{
			return;
		}
		(float, float) areaScrollRectMinMaxScale = mapConfig.GetAreaScrollRectMinMaxScale(curShowArea);
		float x = scrollRect.content.localScale.x;
		float num = scrollDelta * mouseWheelZoomSpeed;
		targetScale = Mathf.Clamp(x + num, areaScrollRectMinMaxScale.Item1, areaScrollRectMinMaxScale.Item2);
		if (!Mathf.Approximately(targetScale, x))
		{
			if (enableMouseCenterZoom && RectTransformUtility.ScreenPointToLocalPointInRectangle(scrollRect.viewport, Input.mousePosition, GameUtility.uiCamera, out var localPoint))
			{
				lastMouseWheelZoomCenter = localPoint;
			}
			isMouseWheelZooming = true;
			currentScale = x;
		}
	}

	private void UpdateMouseWheelZoom()
	{
		if (!enableMouseWheelZoom || GetCurSubControllerType() != SubControllerType.main)
		{
			return;
		}
		float axis = Input.GetAxis("Mouse ScrollWheel");
		if (Mathf.Abs(axis) > 0.01f && IsMouseInMapViewport())
		{
			HandleMouseWheelZoom(axis);
		}
		if (!isMouseWheelZooming)
		{
			return;
		}
		ScrollRect scrollRect = (templeOpen ? ((ScrollRect)templeMapScrollRect) : ((ScrollRect)areaMapScrollRect));
		if (scrollRect == null)
		{
			isMouseWheelZooming = false;
			return;
		}
		currentScale = Mathf.Lerp(currentScale, targetScale, mouseWheelZoomSmooth * Time.deltaTime);
		ApplyMouseWheelZoom(scrollRect, currentScale);
		if (Mathf.Abs(currentScale - targetScale) < 0.001f)
		{
			currentScale = targetScale;
			ApplyMouseWheelZoom(scrollRect, currentScale);
			isMouseWheelZooming = false;
		}
	}

	private bool IsMouseInMapViewport()
	{
		ScrollRect scrollRect = (templeOpen ? ((ScrollRect)templeMapScrollRect) : ((ScrollRect)areaMapScrollRect));
		if (scrollRect == null || scrollRect.viewport == null)
		{
			return false;
		}
		Vector2 screenPoint = Input.mousePosition;
		return RectTransformUtility.RectangleContainsScreenPoint(scrollRect.viewport, screenPoint, GameUtility.uiCamera);
	}

	private void ApplyMouseWheelZoom(ScrollRect scrollRect, float newScale)
	{
		if (!(scrollRect == null))
		{
			Vector2 normalizedPosition = scrollRect.normalizedPosition;
			Vector3 localScale = scrollRect.content.localScale;
			if (scrollRect is AreaMapScrollRect areaMapScrollRect)
			{
				areaMapScrollRect.UpdateTargetScale(UIUtility.screenCenter, newScale * 1f);
			}
			else
			{
				scrollRect.content.localScale = Vector3.one * newScale;
			}
			if (enableMouseCenterZoom && !Mathf.Approximately(localScale.x, newScale))
			{
				AdjustScrollPositionForMouseCenterZoom(scrollRect, normalizedPosition, localScale.x, newScale);
			}
			UpdateScaleRelatedComponents(newScale);
		}
	}

	private void AdjustScrollPositionForMouseCenterZoom(ScrollRect scrollRect, Vector2 oldNormalizedPos, float oldScale, float newScale)
	{
		Vector2 vector = lastMouseWheelZoomCenter;
		Vector2 size = scrollRect.viewport.rect.size;
		Vector2 vector2 = new Vector2((vector.x + size.x * 0.5f) / size.x, (vector.y + size.y * 0.5f) / size.y);
		float num = newScale / oldScale;
		Vector2 normalizedPosition = new Vector2(oldNormalizedPos.x + (vector2.x - 0.5f) * (1f - 1f / num) / num, oldNormalizedPos.y + (vector2.y - 0.5f) * (1f - 1f / num) / num);
		normalizedPosition.x = Mathf.Clamp01(normalizedPosition.x);
		normalizedPosition.y = Mathf.Clamp01(normalizedPosition.y);
		scrollRect.normalizedPosition = normalizedPosition;
	}

	private void UpdateScaleRelatedComponents(float newScale)
	{
		if (!templeOpen && areaMapScaleSlider != null && areaMapScaleSlider.gameObject.activeSelf)
		{
			areaMapScaleSlider.SetValueWithoutNotify(newScale);
		}
		OnScaleUpdate(currentScale, newScale);
	}

	public void SetMouseWheelZoomEnable(bool enable)
	{
		enableMouseWheelZoom = enable;
		if (!enable)
		{
			isMouseWheelZooming = false;
		}
	}

	public bool IsMouseWheelZoomEnabled()
	{
		return enableMouseWheelZoom;
	}

	public void SetMouseWheelZoomSpeed(float speed)
	{
		mouseWheelZoomSpeed = Mathf.Max(0f, speed);
	}

	public void SetMouseWheelZoomSmooth(float smooth)
	{
		mouseWheelZoomSmooth = Mathf.Max(0.1f, smooth);
	}

	public void SetGamePadTipsActive(bool active)
	{
		LargeMapViewInputController controller = GetController();
		if (controller == null)
		{
			return;
		}
		if (active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			GamePadTipsStatusChange(controller.ControllerType);
			if (ViewControlLayers.TryGetValue(controller.ControllerType, out var value))
			{
				value.ReFocus();
			}
		}
		if ((controller.ControllerType == SubControllerType.main) & active)
		{
			virtualCursor.ResetToScreenCenter();
			virtualCursor.EnableVirtualCursor();
		}
		else
		{
			virtualCursor.DisableVirtualCursor();
		}
	}

	private void OnSnapToIcon()
	{
		LargeMapViewInputController controller = GetController();
		if (controller != null && controller.ControllerType == SubControllerType.main)
		{
			gamePadTips?.GetPrompt("LargeMapView/Select")?.SetLocalizeString(774);
		}
	}

	private void OnLeaveIcon()
	{
		LargeMapViewInputController controller = GetController();
		if (controller != null && controller.ControllerType == SubControllerType.main)
		{
			gamePadTips?.GetPrompt("LargeMapView/Select")?.SetLocalizeString(2628);
		}
	}

	public void GamePadTipsStatusChange(SubControllerType subController)
	{
		foreach (KeyValuePair<SubControllerType, List<GameObject>> item in ViewControlPrompt)
		{
			if (subController == item.Key)
			{
				foreach (GameObject item2 in item.Value)
				{
					item2.SetActive(value: true);
				}
				continue;
			}
			foreach (GameObject item3 in item.Value)
			{
				item3.SetActive(value: false);
			}
		}
		gamePadTips.ClearAllPrompts();
		_tipsActions.Clear();
		GamePadTipsAction gamePadTipsAction = actionDic["LargeMapView/Select"];
		gamePadTipsAction.localizeKey = 774;
		switch (subController)
		{
		case SubControllerType.main:
			if (virtualCursor?.GetSnapTarget() == null)
			{
				gamePadTipsAction.localizeKey = 2628;
			}
			_tipsActions.Add(gamePadTipsAction);
			_tipsActions.Add(actionDic["UI/Back"]);
			_tipsActions.Add(actionDic["LargeMapView/MoveMap"]);
			_tipsActions.Add(actionDic["LargeMapView/MoveCursor"]);
			if (MapUtility.playerMapArea == curShowArea)
			{
				_tipsActions.Add(actionDic["LargeMapView/BackToPlayer"]);
			}
			if (Singleton<MissionManager>.instance.GetTracingMission() != 0)
			{
				_tipsActions.Add(actionDic["LargeMapView/BackToTarget"]);
			}
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case SubControllerType.sideBar:
			_tipsActions.Add(actionDic["UI/Back"]);
			if (iconSidebar.GetActiveScrollView() != null)
			{
				ScrollRect activeScrollView = iconSidebar.GetActiveScrollView();
				if (activeScrollView.content.rect.height > activeScrollView.viewport.rect.height)
				{
					_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
				}
			}
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case SubControllerType.worldMap:
		case SubControllerType.mapCollection:
		case SubControllerType.mapRewardPreview:
			_tipsActions.Add(gamePadTipsAction);
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case SubControllerType.selectedPoint:
		case SubControllerType.templeMap:
		case SubControllerType.sideBarSelectItem:
		case SubControllerType.templeMapSideBar:
		case SubControllerType.templeMapSideBarReward:
		case SubControllerType.worldAreaSideBar:
		case SubControllerType.rewardPreviewItem:
		case SubControllerType.rewardWindow:
			_tipsActions.Add(actionDic["UI/Back"]);
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		}
		actionDic["LargeMapView/Select"] = gamePadTipsAction;
	}

	public void ChangeToSideBarSelectType()
	{
		LargeMapViewInputController controller = GetController();
		if (controller != null)
		{
			if (controller.ControllerType == SubControllerType.sideBar)
			{
				ChangeToGamePadInputState(SubControllerType.sideBarSelectItem);
			}
			else if (controller.ControllerType == SubControllerType.rewardWindow)
			{
				ChangeToGamePadInputState(SubControllerType.rewardPreviewItem);
			}
			else if (controller.ControllerType == SubControllerType.templeMapSideBar)
			{
				ChangeToGamePadInputState(SubControllerType.templeMapSideBarReward);
			}
		}
	}

	public SubControllerType GetCurSubControllerType()
	{
		return GetController()?.ControllerType ?? SubControllerType.main;
	}

	public void ChangeToGamePadInputState(SubControllerType type, bool needReFocusLayer = false)
	{
		LargeMapViewInputController controller = GetController();
		if (controller == null)
		{
			return;
		}
		controller.ControllerType = type;
		if (ViewControlLayers.TryGetValue(type, out var value))
		{
			if (needReFocusLayer)
			{
				value.ReFocus();
			}
			else
			{
				value.Focus();
			}
		}
		if (type != SubControllerType.main)
		{
			HandleKeyboardMapMove(Vector2.zero, isControl: false);
			LeftStick = Vector2.zero;
			virtualCursor?.HandleGamepadInput(Vector2.zero);
			virtualCursor?.DisableVirtualCursor();
		}
		else if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			virtualCursor?.EnableVirtualCursor();
		}
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			GamePadTipsStatusChange(controller.ControllerType);
		}
		buttonGroup.gameObject.SetActive(type == SubControllerType.main);
		animateToggle.gameObject.SetActive(type == SubControllerType.main);
		if (type == SubControllerType.templeMap || type == SubControllerType.templeMapSideBar || type == SubControllerType.templeMapSideBarReward)
		{
			templeMapScrollRect.Focus(type);
		}
		else
		{
			templeMapScrollRect.UnFocus(type);
		}
	}

	public void HandleGamePadSelectButtonInput(SubControllerType type)
	{
		switch (type)
		{
		case SubControllerType.main:
			virtualCursor?.HandleClickInput();
			break;
		case SubControllerType.sideBar:
			iconSidebar.GetCurActiveButton()?.OnClick?.Invoke();
			break;
		case SubControllerType.templeMapSideBar:
			templeMapScrollRect.btnTeleport.OnClick?.Invoke();
			break;
		case SubControllerType.selectedPoint:
		case SubControllerType.worldMap:
		case SubControllerType.mapCollection:
		case SubControllerType.templeMap:
		case SubControllerType.sideBarSelectItem:
		case SubControllerType.templeMapSideBarReward:
		case SubControllerType.worldAreaSideBar:
		case SubControllerType.mapRewardPreview:
		case SubControllerType.rewardPreviewItem:
		case SubControllerType.rewardWindow:
			GetController()?.CommonSelect();
			break;
		}
	}

	public void HandleGuideSelectButtonInput(SubControllerType type)
	{
		switch (type)
		{
		case SubControllerType.main:
		{
			MapPointTraceInfo curGuideIcon = Model<MapModel>.Interface.CurrentGuideMapPoint;
			if (curGuideIcon == null || curGuideIcon.pointId == 0)
			{
				break;
			}
			InstanceHandle instanceHandle = instantiateMapIcon.Find((InstanceHandle instantiateGO) =>
			{
				LargeMapIcon component = instantiateGO.Result.GetComponent<LargeMapIcon>();
				return instantiateGO.Result.activeSelf && component != null && component.type == curGuideIcon.iconType && component.GetId() == curGuideIcon.pointId;
			});
			if (instanceHandle != null)
			{
				if (accurateSelectIcon != null)
				{
					UnAccurateSelectIconImmediately(accurateSelectIcon);
				}
				AccurateSelectIcon(instanceHandle.Result?.GetComponent<LargeMapIcon>());
				Model<MapModel>.Interface.SetMapPointGuideInfo(0, 0);
			}
			break;
		}
		case SubControllerType.worldMap:
			HandleCurrentSelectGameObjByGamePad(1);
			break;
		case SubControllerType.sideBar:
			iconSidebar.GetCurActiveButton()?.OnClick?.Invoke();
			break;
		case SubControllerType.selectedPoint:
			break;
		}
	}

	public void CloseRewardPreviewWindow()
	{
		(exploreRatioSidebar.IsAreaType ? exploreRatioSidebar.areaExploreGroup.rewardGroup : exploreRatioSidebar.subAreaExploreGroup.rewardGroup).CloseRewardPreview();
	}

	public void HandleGamePadReturnButtonInput(SubControllerType type)
	{
		switch (type)
		{
		case SubControllerType.main:
			Close();
			break;
		case SubControllerType.worldMap:
			EnterAreaMap(playerArea);
			break;
		case SubControllerType.templeMap:
			templeMapScrollRect.backToAreaMap.OnClick?.Invoke();
			break;
		case SubControllerType.mapCollection:
			HideExploreRatioSideBar();
			break;
		case SubControllerType.sideBar:
			UnSelectCurAccurateSelectIcon();
			break;
		case SubControllerType.sideBarSelectItem:
			ChangeToGamePadInputState(SubControllerType.sideBar);
			break;
		case SubControllerType.selectedPoint:
			UnSelectCurVagueSelectIcon();
			break;
		case SubControllerType.templeMapSideBar:
			templeMapScrollRect.CloseRightPanel();
			break;
		case SubControllerType.templeMapSideBarReward:
			ChangeToGamePadInputState(SubControllerType.templeMapSideBar);
			break;
		case SubControllerType.worldAreaSideBar:
			worldAreaSide.Hide();
			break;
		case SubControllerType.mapRewardPreview:
			ChangeToGamePadInputState(SubControllerType.mapCollection, needReFocusLayer: true);
			break;
		case SubControllerType.rewardPreviewItem:
			ChangeToGamePadInputState(SubControllerType.rewardWindow, needReFocusLayer: true);
			break;
		case SubControllerType.rewardWindow:
			CloseRewardPreviewWindow();
			break;
		}
	}

	public void HandleGamePadMapItemInput(SubControllerType type)
	{
		switch (type)
		{
		case SubControllerType.main:
			ToggleDescriptionMode();
			break;
		case SubControllerType.sideBar:
			if (iconSidebar.worldBossRoot.activeSelf)
			{
				iconSidebar.buyRewardCountButton.OnClick?.Invoke();
			}
			break;
		}
	}

	private void HandleCurrentSelectGameObjByGamePad(int indexType, int direction = -1)
	{
		if (!EventSystemHelper.CurrentSelected)
		{
			return;
		}
		if ((uint)(indexType - 1) > 2u)
		{
			_ = 4;
			return;
		}
		ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
		{
			handler.OnSubmit(data);
		});
	}

	private void InitSelfNodeSystem()
	{
		if (_selfNodeImageStation == null)
		{
			_selfNodeImageStation = Station;
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
		_tempSelfNodeData = null;
		_isPlacingMarker = false;
	}

	private void CreateSelfNodeMapIcons(ACT.World.MapArea area)
	{
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
		InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapSelfNodeIconPrefabAssetD.GUID);
		instanceHandle.CompleteSync();
		instanceHandle.Completed += (InstanceHandle go) =>
		{
			instantiateMapIcon.Add(go);
			LargeMapSelfNodeIcon component = go.Result.GetComponent<LargeMapSelfNodeIcon>();
			go.Result.transform.SetParent(selfNodeIconRoot);
			InitSelfNodeIcon(component, nodeData);
		};
		_selfNodeIconHandles.Add(nodeData.id, instanceHandle);
	}

	private void CreateTempSelfNodeIcon(SelfNodeData nodeData)
	{
		if (nodeData != null)
		{
			_tempGo = PrecacheManager.Instance.GetInstanceHandle(mapConfig.largeMapSelfNodeIconPrefabAssetD.GUID);
			_tempGo.Completed += (InstanceHandle go) =>
			{
				LargeMapSelfNodeIcon component = go.Result.GetComponent<LargeMapSelfNodeIcon>();
				go.Result.transform.SetParent(iconRoot);
				InitTempSelfNodeIcon(component, nodeData);
			};
		}
	}

	private void InitSelfNodeIcon(LargeMapSelfNodeIcon icon, SelfNodeData nodeData)
	{
		icon.SetPos(GetIconPos(nodeData.mapArea, nodeData.worldPos));
		icon.SetFixedScale(mapConfig.iconFixedScale);
		icon.UpdateScale(curScale);
		icon.Init(nodeData, _selfNodeImageStation);
		icon.BindClickAction(TrySelectIcon);
	}

	private void InitTempSelfNodeIcon(LargeMapSelfNodeIcon icon, SelfNodeData nodeData)
	{
		icon.SetPos(GetIconPos(nodeData.mapArea, nodeData.worldPos));
		icon.SetFixedScale(mapConfig.iconFixedScale);
		icon.UpdateScale(curScale);
		icon.Init(nodeData, _selfNodeImageStation);
		if (accurateSelectIcon != null)
		{
			UnAccurateSelectIconImmediately(accurateSelectIcon);
		}
		AccurateSelectIcon(icon);
		ChangeToGamePadInputState(SubControllerType.sideBar);
	}

	public void UpdateTempSelfNodeIcon(int iconType)
	{
		if (_tempGo != null)
		{
			LargeMapSelfNodeIcon component = _tempGo.Result.GetComponent<LargeMapSelfNodeIcon>();
			if (iconType != component.GetSelfNodeIconTypeId())
			{
				component.ChangeIconType(iconType);
			}
		}
	}

	private void CleanGeneralNavButtons()
	{
		if (_generalPointNavBtn != null)
		{
			UnityEngine.Object.Destroy(_generalPointNavBtn.gameObject);
			_generalPointNavBtn = null;
		}
		ResetTraceStatus();
	}

	private void ResetTraceStatus()
	{
		if (_generalPointInstantiateGO != null)
		{
			LargeMapIcon largeMapIcon = _generalPointInstantiateGO.Result?.GetComponent<LargeMapIcon>();
			if ((bool)largeMapIcon)
			{
				largeMapIcon.SetIsTrack(isTrack: false);
			}
			_generalPointInstantiateGO = null;
		}
	}

	private void RecycleSelfNodeIcons()
	{
		foreach (KeyValuePair<int, InstanceHandle> selfNodeIconHandle in _selfNodeIconHandles)
		{
			if (selfNodeIconHandle.Value != null)
			{
				if ((bool)selfNodeIconHandle.Value.Result)
				{
					selfNodeIconHandle.Value.Result?.GetComponent<LargeMapSelfNodeIcon>()?.UnInit();
				}
				PrecacheManager.Instance.ReleaseInstanceHandle(selfNodeIconHandle.Value);
			}
		}
		_selfNodeIconHandles.Clear();
	}

	private void RecycleSelfNodeIcon(int nodeId)
	{
		if (_selfNodeIconHandles.TryGetValue(nodeId, out var value))
		{
			if ((bool)value.Result)
			{
				value.Result.GetComponent<LargeMapSelfNodeIcon>().UnInit();
				instantiateMapIcon.Remove(value);
				PrecacheManager.Instance.ReleaseInstanceHandle(value);
			}
			_selfNodeIconHandles.Remove(nodeId);
		}
	}

	public void EnterPlaceMarkerMode(Vector2 screenPos)
	{
		if (!_isPlacingMarker)
		{
			_isPlacingMarker = true;
			_selectedMarkerIconTypeId = RuntimeConfigs.data.subIconDatas[10901].iconAddress;
			HandleMapClickForPlaceMarker(screenPos);
			Debug.Log("[LargeMapView] 进入标点放置模式");
		}
	}

	public void ExitPlaceMarkerMode()
	{
		_isPlacingMarker = false;
		ClearTempData();
		Debug.Log("[LargeMapView] 退出标点放置模式");
	}

	private void ClearTempData()
	{
		if (_tempGo != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(_tempGo);
			_tempGo = null;
		}
		_tempSelfNodeData = null;
	}

	public void HandleMapClickForPlaceMarker(Vector2 screenPosition)
	{
		if (_isPlacingMarker && RectTransformUtility.ScreenPointToLocalPointInRectangle(selfNodeIconRoot, screenPosition, Singleton<NewUIManager>.instance.UICamera, out var localPoint))
		{
			Vector3 iconWorldPos = GetIconWorldPos(curShowArea, localPoint);
			_tempSelfNodeData = new SelfNodeData
			{
				id = 0,
				iconTypeId = _selectedMarkerIconTypeId,
				worldPos = iconWorldPos,
				mapArea = curShowArea
			};
			CreateTempSelfNodeIcon(_tempSelfNodeData);
			Debug.Log($"[LargeMapView] 成功放置临时标点: ID={_tempSelfNodeData.id}, Pos={iconWorldPos}");
		}
	}

	public void PlaceMarkerAtWorldPos()
	{
		if (_tempSelfNodeData != null)
		{
			if (!Model<MapSelfNodeModel>.Interface.CanAddSelfNode(_tempSelfNodeData.mapArea))
			{
				GameUtility.OpenToolTip(2387);
			}
			else
			{
				SendAddSelfNodeRequest((int)_tempSelfNodeData.mapArea, _tempSelfNodeData.iconTypeId, _tempSelfNodeData.worldPos, AddSelfNode);
			}
		}
	}

	private void AddSelfNode(int curMapArea, int id, int iconTypeId, Vector3 worldPos)
	{
		SelfNodeData selfNodeData = new SelfNodeData
		{
			id = id,
			iconTypeId = iconTypeId,
			worldPos = worldPos,
			mapArea = (ACT.World.MapArea)curMapArea
		};
		UnSelectCurAccurateSelectIcon();
		iconSidebar.HideImmediately();
		Model<MapSelfNodeModel>.Interface.AddSelfNode(selfNodeData);
		ExitPlaceMarkerMode();
		Debug.Log($"[LargeMapView] 成功放置标点: ID={id}, Pos={worldPos}");
		ReportEvent(selfNodeData, 1);
	}

	public void DeleteSelfNode(int nodeId, Action callBack = null)
	{
		if (Model<MapModel>.Interface.CurrentTraceMapPoint != null)
		{
			MapPointTraceInfo currentTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
			SelfNodeData selfNode = Model<MapSelfNodeModel>.Interface.GetSelfNode(nodeId);
			ReportEvent(selfNode, 2);
			if (currentTraceMapPoint.iconType == MapIconType.SelfPoint && currentTraceMapPoint.pointId == nodeId)
			{
				Model<MapModel>.Interface.MapSetupTracePoint((int)currentTraceMapPoint.mapArea, currentTraceMapPoint.pointId, (int)currentTraceMapPoint.iconType, isCancel: true, () =>
				{
					SendDeleteSelfNodeRequest(nodeId, callBack);
				});
				return;
			}
		}
		SendDeleteSelfNodeRequest(nodeId, callBack);
	}

	public void DeleteSelectedSelfNode()
	{
		if (accurateSelectIcon is LargeMapSelfNodeIcon largeMapSelfNodeIcon)
		{
			int id = largeMapSelfNodeIcon.GetId();
			UnSelectCurAccurateSelectIcon();
			DeleteSelfNode(id);
		}
	}

	public void ClearAreaSelfNodes()
	{
		foreach (SelfNodeData item in Model<MapSelfNodeModel>.Interface.GetSelfNodesByArea(curShowArea))
		{
			DeleteSelfNode(item.id);
		}
	}

	public void ModifySelfNodeIconType(int nodeId, int newIconTypeId, Action callBack = null)
	{
		SelfNodeData selfNode = Model<MapSelfNodeModel>.Interface.GetSelfNode(nodeId);
		if (selfNode != null && selfNode.iconTypeId != newIconTypeId)
		{
			SendModifySelfNodeRequest(nodeId, newIconTypeId, () =>
			{
				Model<MapSelfNodeModel>.Interface.CallModifySelfNodeIconTypeAction(nodeId);
				callBack?.Invoke();
			});
			ReportEvent(selfNode, 3);
		}
	}

	private void OnSelfNodeAdded(SelfNodeData nodeData)
	{
		if (nodeData.mapArea == curShowArea)
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
			_ = (bool)value.Result;
			value.Result.GetComponent<LargeMapSelfNodeIcon>().ChangeIconType(nodeData.iconTypeId);
		}
	}

	private void SendAddSelfNodeRequest(int areaId, int iconTypeId, Vector3 worldPos, Action<int, int, int, Vector3> action = null)
	{
		G.service.PlayerAddCustomMapIcon(areaId, iconTypeId, worldPos, action);
	}

	private void SendDeleteSelfNodeRequest(int nodeId, Action callback = null)
	{
		G.service.DeleteCustomMapIcon(nodeId, callback);
	}

	private void SendModifySelfNodeRequest(int nodeId, int newIconTypeId, Action callback = null)
	{
		G.service.ModifyCustomMapFlagType((int)curShowArea, nodeId, newIconTypeId, callback);
	}

	public int GetCurrentAreaSelfNodeCount()
	{
		return Model<MapSelfNodeModel>.Interface.GetSelfNodesByArea(curShowArea).Count;
	}

	public int GetTotalSelfNodeCount()
	{
		return Model<MapSelfNodeModel>.Interface.GetSelfNodeCount();
	}

	public int GetMaxSelfNodeCount()
	{
		return Model<MapSelfNodeModel>.Interface.GetMaxSelfNodeCount();
	}

	public void NavigateToSelfNode(int nodeId)
	{
		SelfNodeData selfNode = Model<MapSelfNodeModel>.Interface.GetSelfNode(nodeId);
		if (selfNode != null)
		{
			if (selfNode.mapArea != curShowArea)
			{
				EnterAreaMap(selfNode.mapArea);
			}
			if (_selfNodeIconHandles.TryGetValue(nodeId, out var value) && (bool)value.Result)
			{
				SetRectTransformToCenter(value.Result.GetComponent<RectTransform>(), 0.25f);
			}
		}
	}

	private void ReportEvent(SelfNodeData node, int status)
	{
		if (node != null)
		{
			MapLabelEvent evt = EventTrackSolver.Instance.GetEvt<MapLabelEvent>();
			evt.areaId = (int)node.mapArea;
			evt.labelId = node.iconTypeId;
			evt.pos = node.worldPos;
			evt.status = status;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}
}
