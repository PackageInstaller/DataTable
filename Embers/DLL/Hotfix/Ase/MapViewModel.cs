#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MapViewModel : OptionBase
{
	private MapMode mapMode;

	private MapFunction _mapFunction;

	private DRWorldMap worldData;

	private DRSectionMap sectionData;

	private DRMap levelData;

	private MapAreaListViewModel areaListViewModel;

	private MapPointInfoViewModel pointInfoVm;

	private DropItemListViewModel dropItemListVm;

	private MapCaveViewModel _mapCaveViewModel;

	private List<CavePointItemData> _cavePointItemDatas = new List<CavePointItemData>();

	private List<int> activeBonfires = new List<int>();

	private List<int> activeCavePoints = new List<int>();

	private Vector2 mapSizeDelta;

	private bool autoLocateWhenOpen = true;

	private bool manualLocate;

	private bool showLocateBtn;

	private int trackTaskId;

	private TaskDataViewModel taskData;

	private int levelIdWaitReload;

	private bool openPopupViewEnable = true;

	private InteractionRequest _onLevelDataChanged = new InteractionRequest();

	private InteractionRequest<InteractivePointData> _onPointClickRequest = new InteractionRequest<InteractivePointData>();

	private InteractionRequest<InteractivePointData> _onDropListClickRst = new InteractionRequest<InteractivePointData>();

	private InteractionRequest _resetSelectStateRst = new InteractionRequest();

	private InteractionRequest<bool> setDropListVisibleRst = new InteractionRequest<bool>();

	private InteractionRequest _refreshInteractionPointRst = new InteractionRequest();

	private InteractionRequest _refreshCaveActiveRst = new InteractionRequest();

	private InteractionRequest _refreshGuidePointsRst = new InteractionRequest();

	private InteractionRequest<Vector2> _mapTweenMoveRst = new InteractionRequest<Vector2>();

	private InteractionRequest<TaskChangeNotifyMessager> _onTaskChanged = new InteractionRequest<TaskChangeNotifyMessager>();

	private InteractionRequest onTrackTaskChanged = new InteractionRequest();

	private InteractionRequest<InteractivePointData> openMapInfoViewRst = new InteractionRequest<InteractivePointData>();

	private InteractionRequest windowReloadRst = new InteractionRequest();

	private ISubscription<TaskChangeNotifyMessager> _subscription;

	private bool openWindowEnabled = true;

	private int playerLevelId;

	private int playerCaveId;

	private bool showPlayerMark;

	private Vector2 _heroMarkPos;

	private Quaternion _heroMarkRotation;

	private Vector3 _heroWorldPos;

	private List<LevelSaveService.MapItemViewData> _mapItemDatas = new List<LevelSaveService.MapItemViewData>();

	private int teleportId;

	private Action<MapFunction> mapCloseCallback;

	private Dictionary<int, KeyValuePair<int, int>> exploreTypeData = new Dictionary<int, KeyValuePair<int, int>>();

	private int exploreProgress;

	private float exploreRate;

	private InteractionRequest refreshExploreDataRst = new InteractionRequest();

	public List<CavePointItemData> CavePointItemDatas
	{
		get
		{
			return _cavePointItemDatas;
		}
		set
		{
			_cavePointItemDatas = value;
		}
	}

	public bool AutoLocateWhenOpen
	{
		get
		{
			return autoLocateWhenOpen;
		}
		set
		{
			Set(ref autoLocateWhenOpen, value, "AutoLocateWhenOpen");
		}
	}

	public bool ManualLocate
	{
		get
		{
			return manualLocate;
		}
		set
		{
			Set(ref manualLocate, value, "ManualLocate");
		}
	}

	public InteractionRequest<InteractivePointData> OpenMapInfoViewRst => openMapInfoViewRst;

	public InteractionRequest OnTrackTaskChanged => onTrackTaskChanged;

	public bool ShowPlayerMark
	{
		get
		{
			return showPlayerMark;
		}
		private set
		{
			Set(ref showPlayerMark, value, "ShowPlayerMark");
		}
	}

	public int PlayerLevelId => playerLevelId;

	public int PlayerCaveId => playerCaveId;

	public Vector2 HeroMarkPos
	{
		get
		{
			return _heroMarkPos;
		}
		set
		{
			Set(ref _heroMarkPos, value, "HeroMarkPos");
		}
	}

	public Quaternion HeroMarkRotation
	{
		get
		{
			return _heroMarkRotation;
		}
		set
		{
			Set(ref _heroMarkRotation, value, "HeroMarkRotation");
		}
	}

	public Vector3 HeroWorldPos => _heroWorldPos;

	public List<LevelSaveService.MapItemViewData> MapItemDatas => _mapItemDatas;

	public int TeleportId => teleportId;

	public Dictionary<int, KeyValuePair<int, int>> ExploreTypeData => exploreTypeData;

	public int ExploreProgress
	{
		get
		{
			return exploreProgress;
		}
		set
		{
			Set(ref exploreProgress, value, "ExploreProgress");
		}
	}

	public float ExploreRate
	{
		get
		{
			return exploreRate;
		}
		set
		{
			Set(ref exploreRate, value, "ExploreRate");
		}
	}

	public InteractionRequest RefreshExploreDataRst => refreshExploreDataRst;

	public MapMode MapMode
	{
		get
		{
			return mapMode;
		}
		private set
		{
			mapMode = value;
			ShowLocateBtn = MapMode == MapMode.Level;
		}
	}

	public DRWorldMap WorldData
	{
		get
		{
			return worldData;
		}
		private set
		{
			worldData = value;
		}
	}

	public DRSectionMap SectionData
	{
		get
		{
			return sectionData;
		}
		private set
		{
			sectionData = value;
		}
	}

	public DRMap LevelData
	{
		get
		{
			return levelData;
		}
		private set
		{
			levelData = value;
			int num = LevelData?.Id ?? 0;
			ShowPlayerMark = PlayerLevelId > 0 && PlayerLevelId == num && PlayerCaveId <= 0;
		}
	}

	public TaskDataViewModel TaskData => taskData;

	public int TrackTaskId
	{
		get
		{
			return trackTaskId;
		}
		set
		{
			trackTaskId = value;
		}
	}

	public Vector2 MapSizeDelta
	{
		get
		{
			return mapSizeDelta;
		}
		private set
		{
			mapSizeDelta = value;
		}
	}

	public bool ShowLocateBtn
	{
		get
		{
			return showLocateBtn;
		}
		set
		{
			Set(ref showLocateBtn, value, "ShowLocateBtn");
		}
	}

	public List<int> ActiveBonfires => activeBonfires;

	public List<int> ActiveCavePoints => activeCavePoints;

	public MapAreaListViewModel AreaListViewModel => areaListViewModel;

	public MapPointInfoViewModel PointInfoVm => pointInfoVm;

	public DropItemListViewModel DropItemListVm => dropItemListVm;

	public MapCaveViewModel MapCaveViewModel => _mapCaveViewModel;

	public InteractionRequest OnLevelDataChanged => _onLevelDataChanged;

	public InteractionRequest<InteractivePointData> OnPointClickRequest => _onPointClickRequest;

	public InteractionRequest<InteractivePointData> OnDropListClickRst => _onDropListClickRst;

	public InteractionRequest ResetSelectStateRst => _resetSelectStateRst;

	public InteractionRequest<bool> SetDropListVisibleRst => setDropListVisibleRst;

	public InteractionRequest RefreshInteractionPointRst => _refreshInteractionPointRst;

	public InteractionRequest RefreshCaveActiveRst => _refreshCaveActiveRst;

	public InteractionRequest RefreshGuidePointsRst => _refreshGuidePointsRst;

	public InteractionRequest<Vector2> MapTweenMoveRst => _mapTweenMoveRst;

	public InteractionRequest<TaskChangeNotifyMessager> OnTaskChanged => _onTaskChanged;

	public InteractionRequest WindowReloadRst => windowReloadRst;

	public MapViewModel()
	{
	}

	public MapViewModel(OptionBase parent, MapMode mapMode, int levelMapId)
	{
		base.parent = parent;
		MapMode = mapMode;
		_subscription = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTaskMessager().Subscribe<TaskChangeNotifyMessager>(OnTaskChangeNotify);
		areaListViewModel = new MapAreaListViewModel(this);
		dropItemListVm = new DropItemListViewModel(this);
		pointInfoVm = new MapPointInfoViewModel(this);
		_mapCaveViewModel = new MapCaveViewModel(this, mapMode);
		RefreshData(levelMapId);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is MapAreaTabItemData mapAreaTabItemData)
		{
			if (mapAreaTabItemData.DrSectionMap != null)
			{
				if (OnSectionTabClick(mapAreaTabItemData.DrSectionMap))
				{
					areaListViewModel.SetSectionTabSelected(mapAreaTabItemData);
				}
			}
			else if (mapAreaTabItemData.DrMap != null && OnLevelTabClick(mapAreaTabItemData.DrMap))
			{
				areaListViewModel.SetLevelTabSelected(mapAreaTabItemData);
			}
		}
		else if (obj is DropPointItemData dropPointItemData)
		{
			setDropListVisibleRst.Raise(context: false);
			_onDropListClickRst.Raise(dropPointItemData.PointData);
		}
		else if (obj is DropItemListViewModel)
		{
			setDropListVisibleRst.Raise(context: false);
			_resetSelectStateRst.Raise();
			_mapCaveViewModel?.ResetSelectStateRst.Raise();
		}
		else if (obj is InteractivePointData context)
		{
			_onPointClickRequest.Raise(context);
		}
		else if (obj is MonsterInfoViewModel)
		{
			openPopupViewEnable = true;
			_resetSelectStateRst.Raise();
			_mapCaveViewModel?.ResetSelectStateRst.Raise();
		}
		else if (obj is MapGuidePointData mapGuidePointData)
		{
			_mapTweenMoveRst.Raise(mapGuidePointData.PointInfo.Pos);
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			bool allowSkipWindow = MapMode == MapMode.Outer;
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: false, allowSkipWindow);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is BattleReadyData battleReadyData)
		{
			if (MapMode == MapMode.Outer)
			{
				OpenBattleReadyWindow(battleReadyData);
			}
			else if (MapMode == MapMode.Level)
			{
				Teleport(battleReadyData.TargetId);
			}
		}
		else if (obj is BattleReadyViewModel battleReadyViewModel)
		{
			if (battleReadyViewModel.ReadyType == BattleReadyType.Ready)
			{
				DRLevel dataRow = GameEntry.DataTable.GetDataRow<DRLevel>(LevelData.Id);
				List<TeamMember> list = battleReadyViewModel.TeamData();
				List<PeripheryHeroData> list2 = new List<PeripheryHeroData>();
				for (int i = 0; i < list.Count; i++)
				{
					list2.Add(list[i].GetPeripheryHeroData());
				}
				OnBattleReadyEnd(SelectType.MapLevel, dataRow, $"{battleReadyViewModel.ReadyData.TargetId}", list2);
			}
		}
		else if (obj is LoadingToOtherLevelViewModel loadingToOtherLevelViewModel)
		{
			if (playerLevelId <= 0 || !int.TryParse(loadingToOtherLevelViewModel.GetBornfireKey(), out var result))
			{
				return;
			}
			DRTransferPoint dataRow2 = GameEntry.DataTable.GetDataRow<DRTransferPoint>(result);
			if (dataRow2 != null)
			{
				if (dataRow2.LevelId == playerLevelId)
				{
					Teleport(result);
				}
				else
				{
					LoadingToOtherLevel(loadingToOtherLevelViewModel);
				}
			}
		}
		else if (obj is string text)
		{
			if (text.Equals("ClosePointInfoView"))
			{
				_resetSelectStateRst.Raise();
				_mapCaveViewModel?.ResetSelectStateRst.Raise();
			}
		}
		else
		{
			if (!(obj is OptionArg optionArg))
			{
				return;
			}
			if (optionArg.OptionName == "MapAreaToggleClick")
			{
				object obj2 = optionArg.Obj;
				if (obj2 is bool)
				{
					_ = (bool)obj2;
					HideMapCaveView();
					return;
				}
			}
			if (optionArg.OptionName == "TaskTrackChanged" && optionArg.Obj is MapPointInfoViewModel)
			{
				areaListViewModel.UpdateTabItemTags();
				_mapCaveViewModel?.UpdateTabItemTags();
				_refreshGuidePointsRst.Raise();
				onTrackTaskChanged.Raise();
			}
			else if (optionArg.OptionName == "OpenMapInfoView" && optionArg.Obj is InteractivePointData context2)
			{
				openMapInfoViewRst.Raise(context2);
			}
		}
	}

	public override bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		if (jumpParams.WindowName.Equals("LevelMapWindow"))
		{
			if (jumpParams.Args != null && jumpParams.Args.Count > 0)
			{
				int.TryParse(jumpParams.Args[0].ToString(), out var result);
				if (result > 0)
				{
					optionBase.Close();
					windowReloadRst.Raise();
					RefreshData(result);
				}
			}
			return false;
		}
		return true;
	}

	public override void Close()
	{
		mapCloseCallback?.Invoke(_mapFunction);
		if (MapMode == MapMode.Level)
		{
			GameResume();
		}
		base.Close();
	}

	protected virtual void OnTaskChangeNotify(TaskChangeNotifyMessager notifyMessager)
	{
		_onTaskChanged.Raise(notifyMessager);
		RefreshMainProgress();
		if (levelIdWaitReload > 0 && notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.Received)
		{
			if (taskData != null && taskData.LevelMapId != levelIdWaitReload)
			{
				RefreshData(taskData.LevelMapId, forceReload: true);
				levelIdWaitReload = 0;
				return;
			}
			levelIdWaitReload = 0;
		}
		areaListViewModel?.UpdateTabItemTags();
	}

	public void RefreshData(int levelId = 0, bool forceReload = false)
	{
		RefreshMainProgress();
		int num = GameEntry.DataTable.GetDataRow<DRMap>(levelId)?.MapId ?? 0;
		int num2 = GameEntry.DataTable.GetDataRow<DRSectionMap>(num)?.WorldId ?? 0;
		if (num2 > 0 && num > 0 && levelId > 0)
		{
			RefreshWorldData(num2, num, forceReload);
			RefreshSectionData(num, levelId, forceReload);
			RefreshLevelData(levelId, forceReload);
		}
	}

	private bool RefreshWorldData(int worldId, int sectionId, bool forceRefresh = false)
	{
		if (!forceRefresh && WorldData != null && WorldData.Id.Equals(worldId) && SectionData != null && SectionData.Id.Equals(sectionId))
		{
			return false;
		}
		areaListViewModel.SectionDatas.Clear();
		WorldData = GameEntry.DataTable.GetDataRow<DRWorldMap>(worldId);
		if (WorldData == null)
		{
			return false;
		}
		areaListViewModel.SectionDatas = Singleton<ServiceSystem>.Instance.GetService<IMapService>().GetAllSectionInWorld(WorldData.Id);
		areaListViewModel.OnWorldDataChanged.Raise(sectionId);
		return true;
	}

	private bool RefreshSectionData(int sectionId, int levelId, bool forceRefresh = false)
	{
		if (!forceRefresh && SectionData != null && SectionData.Id.Equals(sectionId) && LevelData != null && LevelData.Id.Equals(levelId))
		{
			return false;
		}
		areaListViewModel.LevelDatas.Clear();
		SectionData = GameEntry.DataTable.GetDataRow<DRSectionMap>(sectionId);
		if (SectionData == null)
		{
			return false;
		}
		areaListViewModel.LevelDatas = Singleton<ServiceSystem>.Instance.GetService<IMapService>().GetAllLevelInSection(SectionData.Id);
		areaListViewModel.OnSectionDataChanged.Raise(levelId);
		return true;
	}

	private async void RefreshLevelData(int levelId, bool forceRefresh = false)
	{
		if (forceRefresh || LevelData == null || !LevelData.Id.Equals(levelId))
		{
			DRMap dRMap = areaListViewModel.LevelDatas.Find((DRMap p) => p.Id.Equals(levelId));
			if (dRMap == null)
			{
				LevelData = ((areaListViewModel.LevelDatas.Count > 0) ? areaListViewModel.LevelDatas[0] : null);
			}
			else
			{
				LevelData = dRMap;
			}
			RefreshMapItemData();
			if (LevelData != null)
			{
				_onLevelDataChanged.Raise();
			}
			await RefreshBonfireData();
			await RefreshCaveActiveData();
			await RefreshExploreData();
		}
	}

	private void RefreshMapItemData()
	{
		try
		{
			if (MapMode == MapMode.Level)
			{
				_mapItemDatas.Clear();
				if (LevelData != null && !string.IsNullOrEmpty(LevelData.SceneName))
				{
					Singleton<ServiceSystem>.Instance?.GetService<ILevelSaveService>().GetMapItemDatas(LevelData.Id, _mapItemDatas);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	public async Task RefreshBonfireData()
	{
		if (LevelData != null && !string.IsNullOrEmpty(LevelData.SceneName))
		{
			activeBonfires.Clear();
			activeBonfires = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetBonfireActiveList(LevelData.Id);
			_refreshInteractionPointRst.Raise();
		}
	}

	public async Task RefreshCaveActiveData()
	{
		if (LevelData != null && !string.IsNullOrEmpty(LevelData.SceneName))
		{
			activeCavePoints.Clear();
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetActiveCaves(LevelData.Id, activeCavePoints);
			_refreshCaveActiveRst.Raise();
		}
	}

	private async Task RefreshExploreData()
	{
		exploreTypeData.Clear();
		if (LevelData == null)
		{
			ExploreProgress = 0;
			ExploreRate = 0f;
			refreshExploreDataRst.Raise();
			return;
		}
		List<DRMapExplore> configs = GameEntry.DataTable.GetDataRows((DRMapExplore p) => p.MapId == LevelData.Id)?.ToList() ?? new List<DRMapExplore>();
		int curExploreValue = 0;
		int totalExploreValue = 0;
		List<PbIdValue> collectionsData = new List<PbIdValue>();
		int collection = 0;
		try
		{
			(collectionsData, collection) = await Singleton<ServiceSystem>.Instance.GetService<IMapService>().GetCollectionsForStory(LevelData.Id);
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		List<int> exploreTypes = new List<int>();
		configs.ForEach(delegate(DRMapExplore p)
		{
			if (!exploreTypes.Contains(p.ExplorationType))
			{
				exploreTypes.Add(p.ExplorationType);
			}
		});
		exploreTypeData.Clear();
		foreach (int exploreType in exploreTypes)
		{
			int num = 0;
			int num2 = 0;
			foreach (DRMapExplore item in configs.FindAll((DRMapExplore p) => p.ExplorationType == exploreType))
			{
				foreach (int itemId in item.ItemTypeId)
				{
					if (MapDefinition.GetExploreItemConfigData(item, itemId, out var num3, out var weight))
					{
						int num4 = 0;
						PbIdValue pbIdValue = collectionsData.Find((PbIdValue p) => p.Id == itemId);
						switch (item.ExplorationType)
						{
						case 1:
							num4 = pbIdValue?.Value ?? 0;
							break;
						case 2:
							num4 = (activeBonfires.Contains(itemId) ? 1 : 0);
							break;
						case 3:
							num4 = pbIdValue?.Value ?? 0;
							break;
						}
						num += num4;
						num2 += num3;
						curExploreValue += num4 * weight;
						totalExploreValue += num3 * weight;
					}
				}
			}
			if (!exploreTypeData.ContainsKey(exploreType))
			{
				exploreTypeData.Add(exploreType, new KeyValuePair<int, int>(num, num2));
			}
		}
		if (totalExploreValue == 0)
		{
			ExploreProgress = 100;
			ExploreRate = 1f;
		}
		else
		{
			ExploreProgress = collection;
			ExploreRate = (float)collection / 100f;
		}
		refreshExploreDataRst.Raise();
	}

	private void UpdateCavePointState(bool visible, int caveId)
	{
		if (CavePointItemDatas == null)
		{
			return;
		}
		foreach (CavePointItemData cavePointItemData in CavePointItemDatas)
		{
			if (cavePointItemData.DrCavernPoint == null || cavePointItemData.DrCavernPoint.CavernlId != caveId)
			{
				cavePointItemData.SetCavernState(state: false);
			}
			else
			{
				cavePointItemData.SetCavernState(visible);
			}
		}
	}

	private void RefreshMainProgress()
	{
		taskData = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetCurrentMainTask();
	}

	private bool OnSectionTabClick(DRSectionMap drSectionMap)
	{
		if (SectionData != null && SectionData.Id.Equals(drSectionMap.Id))
		{
			return false;
		}
		int latestLevelInSection = Singleton<ServiceSystem>.Instance.GetService<IMapService>().GetLatestLevelInSection(drSectionMap.Id);
		if (RefreshSectionData(drSectionMap.Id, latestLevelInSection))
		{
			if (latestLevelInSection > 0)
			{
				RefreshLevelData(latestLevelInSection);
			}
			return true;
		}
		return false;
	}

	private bool OnLevelTabClick(DRMap drMap)
	{
		if (LevelData != null && LevelData.Id.Equals(drMap.Id))
		{
			return false;
		}
		RefreshLevelData(drMap.Id);
		return true;
	}

	public void OpenBattleReadyWindow(BattleReadyData battleReadyData)
	{
		int targetId = battleReadyData.TargetId;
		DRTransferPoint dataRow = GameEntry.DataTable.GetDataRow<DRTransferPoint>(targetId);
		if (dataRow != null && !LevelEntryLimitHelper.TryBlockEntry(dataRow.LevelId) && openWindowEnabled)
		{
			openWindowEnabled = false;
			BattleReadyViewModel userData = new BattleReadyViewModel(this, battleReadyData);
			openWindowRequest.Raise(new OpenViewArg(typeof(BattleReadyWindow), userData), delegate
			{
				openWindowEnabled = true;
			});
		}
	}

	private async void OnBattleReadyEnd(SelectType selectType, DRLevel drLevel, string bonfireKey, List<PeripheryHeroData> heroList)
	{
		if (selectType == SelectType.MapLevel)
		{
			WorldData worldData = LevelWorldData.CreateLevelWorldData(0u, drLevel.SceneName, drLevel.Id, drLevel.MapData, bonfireKey, drLevel.NavMeshId, heroList);
			parent?.ItemOnClick("CloseMapWorldScene");
			LoadingLevelViewModel loadViewModel = new LoadingLevelViewModel("Outer/Outer", autoUnload: true, worldData);
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Story);
			loadViewModel.SetRandomLoadingTap(randomLoadingTap);
			await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadViewModel);
			await UniTask.WaitUntil(() => loadViewModel.IsLoadingFinish);
			bool loadingSuccess = loadViewModel.LoadingSuccess;
			if (loadViewModel.LoadingSuccess)
			{
				UIWindowHelper.WindowRelease();
				await loadViewModel.CloseLoading();
			}
			Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
		}
	}

	private void LoadingToOtherLevel(LoadingToOtherLevelViewModel loadingToOtherLevelViewModel)
	{
		DRLevel dataRow = GameEntry.DataTable.GetDataRow<DRLevel>(LevelData.Id);
		loadingToOtherLevelViewModel.SetLevelData(dataRow);
		loadingToOtherLevelViewModel.AddCloseView(this);
		parent?.ItemOnClick(loadingToOtherLevelViewModel);
	}

	public void OpenMonsterInfoView(InteractivePointData pointItemData)
	{
		if (openPopupViewEnable)
		{
			openPopupViewEnable = false;
			MonsterInfoViewModel monsterInfoViewModel = new MonsterInfoViewModel(this);
			monsterInfoViewModel.RefreshData(pointItemData.PointInfo.Id, showAllLevels: false);
			openWindowRequest.Raise(new OpenViewArg(typeof(MonsterInfoView), monsterInfoViewModel, "LevelMap", isOpenWindow: false));
		}
	}

	public void ShowMapCaveView(int caveId, bool forceRefresh = false)
	{
		DRCavern dataRow = GameEntry.DataTable.GetDataRow<DRCavern>(caveId);
		if (dataRow != null)
		{
			if (areaListViewModel.TabToggleItemData.IsSelected)
			{
				areaListViewModel.TabToggleItemData.TabOnClick();
			}
			_mapCaveViewModel.Show(dataRow, forceRefresh);
			UpdateCavePointState(visible: true, dataRow.Id);
		}
	}

	public void HideMapCaveView()
	{
		if (_mapCaveViewModel != null)
		{
			_mapCaveViewModel.Hide();
			UpdateCavePointState(visible: false, _mapCaveViewModel.CaveData?.Id ?? 0);
		}
	}

	public void SetPlayerMark(Vector3 worldPos, Quaternion rotation, int levelId, int caveId = 0)
	{
		playerLevelId = levelId;
		playerCaveId = caveId;
		_heroWorldPos = worldPos;
		HeroMarkRotation = rotation;
		int num = LevelData?.Id ?? 0;
		ShowPlayerMark = PlayerLevelId > 0 && PlayerLevelId == num && PlayerCaveId <= 0;
		UpdateHeroMarkPos();
	}

	private void UpdateHeroMarkPos()
	{
		if (LevelData != null)
		{
			Vector3 vector = new Vector3((LevelData.WorldPosOffset.Count > 0) ? LevelData.WorldPosOffset[0] : 0f, 0f, (LevelData.WorldPosOffset.Count > 1) ? LevelData.WorldPosOffset[1] : 0f);
			Vector3 vector2 = (_heroWorldPos - vector) * GameEntry.Base.GameConfig.minimap_UISceneRatio;
			HeroMarkPos = new Vector2(vector2.x, vector2.z - MapSizeDelta.y / 2f);
		}
	}

	public void Teleport(int targetId)
	{
		_mapFunction = MapFunction.Teleport;
		teleportId = targetId;
		parent?.ItemOnClick(new OptionArg(this, "Teleport"));
	}

	public void AddMapCloseCallback(Action<MapFunction> callback)
	{
		mapCloseCallback = (Action<MapFunction>)Delegate.Combine(mapCloseCallback, callback);
	}

	public void GamePause()
	{
		parent?.ItemOnClick(ProcessOperationEnum.GamePause);
	}

	public void GameResume()
	{
		parent?.ItemOnClick(ProcessOperationEnum.GameResume);
	}

	public void SetMapSize(Vector2 size)
	{
		MapSizeDelta = size;
		if (MapMode == MapMode.Level)
		{
			UpdateHeroMarkPos();
		}
	}

	public void SetLevelIdWaitReload(int levelId)
	{
		levelIdWaitReload = levelId;
	}
}
