#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MiniMapViewModel : OptionBase
{
	private MapMarkItemViewModel heroMark;

	private List<MapMarkItemViewModel> tpMarkViewModels = new List<MapMarkItemViewModel>();

	private List<MapMarkItemViewModel> taskMarkViewModels = new List<MapMarkItemViewModel>();

	private List<MapMarkItemViewModel> bossMonsterViewModels = new List<MapMarkItemViewModel>();

	private List<MapMarkItemViewModel> cavePointViewModels = new List<MapMarkItemViewModel>();

	private Dictionary<LevelSaveService.MapItemData, MapMarkItemViewModel> mapItemMarkViewModels = new Dictionary<LevelSaveService.MapItemData, MapMarkItemViewModel>();

	private List<MapMarkItemViewModel> trackMarkItemDatas = new List<MapMarkItemViewModel>();

	private InteractionRequest refreshMapDataRst = new InteractionRequest();

	private InteractionRequest refreshTpMarkDatas = new InteractionRequest();

	private InteractionRequest refreshTaskMarkDatas = new InteractionRequest();

	private InteractionRequest refreshBossMonsterMarkDatas = new InteractionRequest();

	private InteractionRequest refreshTrackMarkDatas = new InteractionRequest();

	private InteractionRequest<MapMarkItemViewModel> addMapItemRst = new InteractionRequest<MapMarkItemViewModel>();

	private InteractionRequest refreshAllMapItemRst = new InteractionRequest();

	private InteractionRequest refreshCavePointMarks = new InteractionRequest();

	private InteractionRequest updateMapMaskDataRst = new InteractionRequest();

	private ISubscription<TaskChangeNotifyMessager> _subscription;

	private ISubscription<LevelSaveMessage> _levelSaveSubscription;

	private ISubscription<MapMaskMsg> _levelMapMaskSubscription;

	private ISubscription<MapItemIconMessager> mapItemIconChange;

	private Quaternion captainRotation;

	private Vector3 captainScenePos;

	private Vector2 mapSizeDelta;

	private float sceneToUiRatio;

	private Vector2 mapOffset;

	private List<int> activeBonfires = new List<int>();

	private List<int> activeCavePoints = new List<int>();

	private MapConfigData oldMapData;

	private MapConfigData mapData;

	private SimpleCommand openMapCmd;

	private string clickToast;

	private bool clickEnable = true;

	private bool visible = true;

	private List<LevelSaveService.MapItemViewData> mapItemDatas = new List<LevelSaveService.MapItemViewData>(200);

	public Action UpdateContentPosAction { get; set; }

	public Action UpdateMarkFollowPosAction { get; set; }

	public InteractionRequest RefreshMapDataRst => refreshMapDataRst;

	public MapConfigData OldMapData => oldMapData;

	public Vector3 CaptainScenePos => captainScenePos;

	public Quaternion CaptainRotation
	{
		get
		{
			return captainRotation;
		}
		set
		{
			Set(ref captainRotation, value, "CaptainRotation");
		}
	}

	public MapMarkItemViewModel HeroMark => heroMark;

	public List<int> ActiveBonfires => activeBonfires;

	public Dictionary<LevelSaveService.MapItemData, MapMarkItemViewModel> MapItemMarkViewModels => mapItemMarkViewModels;

	public MapConfigData mapConfig => mapData;

	public ICommand OpenMapCmd => openMapCmd;

	public List<MapMarkItemViewModel> TpMarkViewModels => tpMarkViewModels;

	public List<MapMarkItemViewModel> CavePointViewModels => cavePointViewModels;

	public List<MapMarkItemViewModel> TaskMarkViewModels => taskMarkViewModels;

	public List<MapMarkItemViewModel> TrackMarkItemDatas => trackMarkItemDatas;

	public List<MapMarkItemViewModel> BossMonsterViewModels => bossMonsterViewModels;

	public InteractionRequest RefreshTpMarkDatas => refreshTpMarkDatas;

	public InteractionRequest RefreshTaskMarkDatas => refreshTaskMarkDatas;

	public InteractionRequest RefreshTrackMarkDatas => refreshTrackMarkDatas;

	public InteractionRequest RefreshBossMonsterMarkDatas => refreshBossMonsterMarkDatas;

	public InteractionRequest<MapMarkItemViewModel> AddMapItemRst => addMapItemRst;

	public InteractionRequest RefreshAllMapItemRst => refreshAllMapItemRst;

	public InteractionRequest RefreshCavePointMarks => refreshCavePointMarks;

	public InteractionRequest UpdateMapMaskDataRst => updateMapMaskDataRst;

	public MiniMapViewModel()
	{
	}

	public MiniMapViewModel(OptionBase parent)
	{
		base.parent = parent;
		openMapCmd = new SimpleCommand(OpenMapWindow);
		_subscription = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetTaskMessager().Subscribe<TaskChangeNotifyMessager>(OnTaskChangeNotify);
		_levelSaveSubscription = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>()?.GetMessager().Subscribe<LevelSaveMessage>(OnLevelSaveChanged);
		_levelMapMaskSubscription = Context.GetApplicationContext().GetService<IMessenger>()?.Subscribe<MapMaskMsg>(OnMapMaskMsgNotify);
		mapItemIconChange = Context.GetApplicationContext().GetService<IMessenger>()?.Subscribe<MapItemIconMessager>(OnMapItemIconChanged);
		heroMark = MapMarkItemViewModel.CreateHero(this, mapSizeDelta, sceneToUiRatio, mapOffset);
	}

	private void OnTaskChangeNotify(TaskChangeNotifyMessager notifyMessager)
	{
		if (notifyMessager != null)
		{
			RefreshBossMonsterMarkData();
			if (notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.TrackSet || notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.Received || notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.Finished || notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.UpdatePosition)
			{
				RefreshTaskMarkData();
				RefreshCavePointMarkData();
			}
		}
	}

	private void OnLevelSaveChanged(LevelSaveMessage message)
	{
		if (message == null || mapData == null)
		{
			return;
		}
		if (message.MessageType == LevelSaveMessageType.BonfireActiveStateChange)
		{
			if (message.LevelId == mapData.Id)
			{
				RefreshTpPointMarkState(message.ItemId);
			}
		}
		else if (message.MessageType == LevelSaveMessageType.CavePointActiveStateChange && message.LevelId == mapData.Id)
		{
			RefreshCavePointState(message.ItemId);
		}
	}

	private void OnMapMaskMsgNotify(MapMaskMsg msg)
	{
		updateMapMaskDataRst.Raise();
	}

	private void OnMapItemIconChanged(MapItemIconMessager messager)
	{
		RefreshMapItemData(messager.Data);
	}

	public async void RefreshMiniMapData(MapConfigData mapData)
	{
		if (mapData == null)
		{
			if (oldMapData == null)
			{
				return;
			}
			this.mapData = oldMapData;
		}
		else
		{
			if (this.mapData != null)
			{
				oldMapData = this.mapData;
			}
			this.mapData = mapData;
		}
		await RefreshBonfireData();
		await RefreshCavePointActiveData();
		refreshMapDataRst.Raise();
	}

	public async void UpdateMapMarks()
	{
		await RefreshBonfireData();
		await RefreshCavePointActiveData();
		heroMark.SetMapUIParam(mapSizeDelta, sceneToUiRatio, mapOffset);
		RefreshTpPointMarkData();
		RefreshTaskMarkData();
		RefreshBossMonsterMarkData();
		RefreshAllMapItemDatas();
		RefreshCavePointMarkData();
	}

	private async Task RefreshBonfireData()
	{
		activeBonfires.Clear();
		try
		{
			if (mapData.MapType == MapConfigData.MapTypeEnum.LevelMap)
			{
				activeBonfires = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>()?.GetBonfireActiveList(mapData.Id);
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private async Task RefreshCavePointActiveData()
	{
		activeCavePoints.Clear();
		try
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>()?.GetActiveCaves(mapData.LevelId, activeCavePoints);
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private void RefreshTpPointMarkData()
	{
		tpMarkViewModels.Clear();
		foreach (int item in mapData.TransferPoint)
		{
			DRTransferPoint dataRow = GameEntry.DataTable.GetDataRow<DRTransferPoint>(item);
			if (dataRow != null)
			{
				AddTpPointMark(MapMarkItemViewModel.CreateTpPoint(dataRow, mapSizeDelta, sceneToUiRatio, mapOffset, this));
			}
		}
		refreshTpMarkDatas.Raise();
	}

	private void RefreshTpPointMarkState(int bonfireId)
	{
		foreach (MapMarkItemViewModel tpMarkViewModel in tpMarkViewModels)
		{
			if (tpMarkViewModel.Id.Equals(bonfireId))
			{
				tpMarkViewModel.SetMarkState(1);
			}
		}
	}

	private void RefreshCavePointMarkData()
	{
		cavePointViewModels.Clear();
		trackMarkItemDatas.RemoveAll((MapMarkItemViewModel p) => p.MarkType == MapMarkItemViewModel.MarkTypeEnum.CavePoint);
		ITaskServices service = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
		if (service == null || mapConfig == null)
		{
			refreshCavePointMarks.Raise();
			refreshTrackMarkDatas.Raise();
			return;
		}
		List<TaskDataViewModel> list = service.FilterTrackingTask(service.GetDisplayLevelTask(mapConfig.LevelId));
		foreach (DRCavernPoint cavernPoint in mapData.CavernPoints)
		{
			bool flag = false;
			flag = cavernPoint.ActiveState == 1 || activeCavePoints.Contains(cavernPoint.Id);
			string icon = (flag ? "cave_point_normal" : "cave_point_lock");
			List<float> list2 = ((mapData.MapType == MapConfigData.MapTypeEnum.CaveMap) ? cavernPoint.CavernOut : cavernPoint.CavernIn);
			Vector2 configPos = new Vector2((list2.Count > 0) ? list2[0] : 0f, (list2.Count > 1) ? list2[1] : 0f);
			InteractivePoint.PointType pointType = InteractivePoint.PointType.None;
			if (mapData.MapType == MapConfigData.MapTypeEnum.LevelMap && list != null)
			{
				foreach (TaskDataViewModel item in list)
				{
					if (item.CaveId <= 0)
					{
						continue;
					}
					List<TaskPosition> taskPosition = item.GetTaskPosition();
					if (taskPosition != null && taskPosition.Count > 0 && item.CavePoints.Contains(cavernPoint.Id))
					{
						InteractivePoint.PointType taskPointType = InteractivePoint.GetTaskPointType(item.TaskType);
						if (pointType != taskPointType && InteractivePoint.GetPointIconPriority(taskPointType) > InteractivePoint.GetPointIconPriority(pointType))
						{
							pointType = taskPointType;
						}
					}
				}
			}
			if (pointType == InteractivePoint.PointType.None)
			{
				AddCavePointMark(MapMarkItemViewModel.CreateCavePoint(cavernPoint, icon, flag, configPos, mapSizeDelta, sceneToUiRatio, mapOffset));
				continue;
			}
			MapMarkItemViewModel mapMarkItemViewModel = MapMarkItemViewModel.CreateTrack(cavernPoint, icon, flag, InteractivePoint.GetPointIcon(pointType), configPos, mapSizeDelta, sceneToUiRatio, mapOffset);
			mapMarkItemViewModel.BubbleCount = 1;
			mapMarkItemViewModel.BubbleIcon1 = InteractivePoint.GetPointIcon(pointType);
			AddTrackMark(mapMarkItemViewModel);
		}
		refreshCavePointMarks.Raise();
		refreshTrackMarkDatas.Raise();
	}

	private void RefreshCavePointState(int cavePointId)
	{
		foreach (MapMarkItemViewModel cavePointViewModel in cavePointViewModels)
		{
			if (cavePointViewModel.Id.Equals(cavePointId))
			{
				cavePointViewModel.SetMarkState(1);
			}
		}
	}

	private void RefreshTaskMarkData()
	{
		if (mapData == null)
		{
			return;
		}
		taskMarkViewModels.Clear();
		trackMarkItemDatas.RemoveAll((MapMarkItemViewModel p) => p.MarkType == MapMarkItemViewModel.MarkTypeEnum.Task);
		foreach (TaskDataViewModel item in GetTask())
		{
			List<TaskPosition> taskPosition = item.GetTaskPosition();
			if (taskPosition == null || taskPosition.Count <= 0)
			{
				continue;
			}
			foreach (TaskPosition item2 in taskPosition)
			{
				if (item2.active)
				{
					Vector2 range = new Vector2(item2.rangeRadius * sceneToUiRatio * 2f, item2.rangeRadius * sceneToUiRatio * 2f);
					if (item.TrackState)
					{
						AddTrackMark(MapMarkItemViewModel.CreateTrack(item, item2.position, range, mapSizeDelta, sceneToUiRatio, mapOffset));
					}
					else
					{
						AddTaskMark(MapMarkItemViewModel.CreateTask(item, item2.position, range, mapSizeDelta, sceneToUiRatio, mapOffset));
					}
				}
			}
		}
		refreshTaskMarkDatas.Raise();
		refreshTrackMarkDatas.Raise();
	}

	private void RefreshBossMonsterMarkData()
	{
		if (mapData == null)
		{
			return;
		}
		foreach (MapMarkItemViewModel bossMonsterViewModel in bossMonsterViewModels)
		{
			bossMonsterViewModel?.Dispose();
		}
		bossMonsterViewModels.Clear();
		foreach (TaskDataViewModel item in GetTask())
		{
			List<TaskPosition> monsterPosition = item.MonsterPosition;
			if (monsterPosition == null)
			{
				continue;
			}
			foreach (TaskPosition item2 in monsterPosition)
			{
				if (item2.active)
				{
					AddBossMonsterMark(MapMarkItemViewModel.CreateBossMonster(item.MonsterId, item2.position, mapSizeDelta, sceneToUiRatio, mapOffset));
				}
			}
		}
		refreshBossMonsterMarkDatas.Raise();
	}

	private List<TaskDataViewModel> GetTask()
	{
		List<TaskDataViewModel> list = new List<TaskDataViewModel>();
		if (mapData.MapType == MapConfigData.MapTypeEnum.LevelMap)
		{
			list = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetDisplayLevelTask(mapData.Id, needShowInTaskUi: false);
			list.RemoveAll((TaskDataViewModel p) => p.CaveId > 0);
		}
		else if (mapData.MapType == MapConfigData.MapTypeEnum.CaveMap)
		{
			list = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetDisplayTaskInCave(mapData.Id);
		}
		return list;
	}

	private void RefreshAllMapItemDatas()
	{
		foreach (MapMarkItemViewModel value in mapItemMarkViewModels.Values)
		{
			value.Dispose();
		}
		mapItemMarkViewModels.Clear();
		try
		{
			if (mapConfig.MapType == MapConfigData.MapTypeEnum.LevelMap)
			{
				Singleton<ServiceSystem>.Instance?.GetService<ILevelSaveService>()?.GetMapItemDatas(mapData.Id, mapItemDatas);
			}
			else
			{
				_ = mapConfig.MapType;
				_ = 1;
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		if (mapItemDatas != null)
		{
			foreach (LevelSaveService.MapItemViewData mapItemData in mapItemDatas)
			{
				RefreshMapItemData(mapItemData, batchRefresh: true);
			}
		}
		refreshAllMapItemRst.Raise();
	}

	private void RefreshMapItemData(LevelSaveService.MapItemViewData mapItemViewData, bool batchRefresh = false)
	{
		string text = "";
		try
		{
			DRMapItem dataRow = GameEntry.DataTable.GetDataRow<DRMapItem>(mapItemViewData.Data.MapItemId);
			if (dataRow == null)
			{
				Log.Error($"交互物表不存在ID为[{mapItemViewData.Data.MapItemId}]的配置");
				return;
			}
			DRMapItemType dataRow2 = GameEntry.DataTable.GetDataRow<DRMapItemType>(dataRow.MapItemType);
			if (dataRow2 == null)
			{
				return;
			}
			if (mapItemViewData.Data.IconType == 1)
			{
				text = dataRow2.IconType1;
			}
			else if (mapItemViewData.Data.IconType == 2)
			{
				text = dataRow2.IconType2;
			}
			if (mapItemMarkViewModels.TryGetValue(mapItemViewData.Data, out var value))
			{
				value.UpdateIcon(text);
				value.UpdateWorldPos(mapItemViewData.Position);
				return;
			}
			MapMarkItemViewModel mapMarkItemViewModel = MapMarkItemViewModel.CreateMapItem(dataRow2, text, mapItemViewData.Position.ToVector2(), mapSizeDelta, sceneToUiRatio, mapOffset);
			mapItemMarkViewModels.Add(mapItemViewData.Data, mapMarkItemViewModel);
			if (!batchRefresh)
			{
				addMapItemRst.Raise(mapMarkItemViewModel);
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
	}

	public void UpdateHeroPos(Vector3 captainWorldPos, Quaternion captainRotation)
	{
		if (heroMark != null)
		{
			captainScenePos = captainWorldPos;
			heroMark.UpdateWorldPos(captainWorldPos);
			UpdateContentPosAction?.Invoke();
			CaptainRotation = new Quaternion(0f, 0f, 0f - captainRotation.y, captainRotation.w);
			if (trackMarkItemDatas.Count > 0)
			{
				UpdateMarkFollowPosAction?.Invoke();
			}
		}
	}

	public void UpdateMarkFollowPos(Vector2 scrollCenter, Vector2 scrollRectSizeRadis, Vector2 localScale)
	{
		foreach (MapMarkItemViewModel trackMarkItemData in trackMarkItemDatas)
		{
			trackMarkItemData.UpdateMarkFollowPos(scrollCenter, scrollRectSizeRadis, localScale);
		}
	}

	private void AddTpPointMark(MapMarkItemViewModel mapMark)
	{
		tpMarkViewModels.Add(mapMark);
		mapMark.SetParent(this);
	}

	private void AddTaskMark(MapMarkItemViewModel mapMark)
	{
		taskMarkViewModels.Add(mapMark);
		mapMark.SetParent(this);
	}

	private void AddTrackMark(MapMarkItemViewModel mapMark)
	{
		trackMarkItemDatas.Add(mapMark);
		mapMark.SetParent(this);
	}

	private void AddBossMonsterMark(MapMarkItemViewModel mapMark)
	{
		bossMonsterViewModels.Add(mapMark);
		mapMark.SetParent(this);
	}

	private void AddCavePointMark(MapMarkItemViewModel mapMark)
	{
		cavePointViewModels.Add(mapMark);
		mapMark.SetParent(this);
	}

	public void UpdateMapParam(Vector2 size, float sceneToUiRatio, Vector2 mapOffset)
	{
		mapSizeDelta = size;
		this.sceneToUiRatio = sceneToUiRatio;
		this.mapOffset = mapOffset;
	}

	public void EnableClick(bool enable, string toast = "")
	{
		clickEnable = enable;
		clickToast = toast;
	}

	private void OpenMapWindow()
	{
		if (!clickEnable)
		{
			if (!string.IsNullOrEmpty(clickToast))
			{
				Toast.ShowInfo(clickToast);
			}
		}
		else
		{
			OpenMapWindow(mapData.LevelId);
		}
	}

	public void OpenMapWindow(int levelId, Action cb = null, int trackTaskId = 0, Action<MapFunction> closeCb = null)
	{
		if (mapData != null)
		{
			openMapCmd.Enabled = false;
			int caveId = 0;
			if (mapData.MapType == MapConfigData.MapTypeEnum.CaveMap)
			{
				caveId = mapData.Id;
			}
			MapViewModel mapViewModel = new MapViewModel(parent, MapMode.Level, levelId);
			mapViewModel.SetPlayerMark(CaptainScenePos, CaptainRotation, mapData.LevelId, caveId);
			if (trackTaskId > 0)
			{
				mapViewModel.TrackTaskId = trackTaskId;
			}
			if (closeCb != null)
			{
				mapViewModel.AddMapCloseCallback(closeCb);
			}
			parent.ItemOnClick(new OpenViewArg(typeof(MapWindow), mapViewModel, "MiniMap", isOpenWindow: true, "DEFAULT", delegate
			{
				RefreshTaskMarkData();
				RefreshCavePointMarkData();
				parent.ItemOnClick(new OptionArg(this, "OnTrackChange"));
				openMapCmd.Enabled = true;
				cb?.Invoke();
			}));
		}
	}

	public override void Dispose()
	{
		_subscription?.Dispose();
		_subscription = null;
		_levelSaveSubscription?.Dispose();
		_levelSaveSubscription = null;
		mapItemIconChange?.Dispose();
		mapItemIconChange = null;
		base.Dispose();
	}
}
