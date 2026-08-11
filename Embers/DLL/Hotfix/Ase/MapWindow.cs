#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MapWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private UIMapScaleScrollRect mapScrollRect;

	[SerializeField]
	private MapAreaListView mapAreaListView;

	[SerializeField]
	private RectTransform mapPrefabRoot;

	private GameObject mapPrefab;

	[SerializeField]
	private MapMaskTest mapMask;

	[SerializeField]
	private Image mapBg;

	[SerializeField]
	private RectTransform overlayRoot;

	[SerializeField]
	private RectTransform taskRoot;

	[SerializeField]
	private RectTransform taskUnderMaskRoot;

	[SerializeField]
	private RectTransform tpRoot;

	[SerializeField]
	private RectTransform tpActiveRoot;

	[SerializeField]
	private RectTransform bossMonsterRoot;

	[SerializeField]
	private RectTransform collectionRoot;

	[SerializeField]
	private RectTransform caveRoot;

	[SerializeField]
	private TpPointItem tpPointItem;

	[SerializeField]
	private TaskPointItem taskPointItem;

	[SerializeField]
	private InteractivePoint bossMonsterItem;

	[SerializeField]
	private InteractivePoint mapIconItem;

	[SerializeField]
	private CavePointItem cavePointItem;

	[SerializeField]
	private MapGuidePointItem guidePointItem;

	[SerializeField]
	private AnimationUIView singleSelect;

	[SerializeField]
	private AnimationUIView multipleSelect;

	[SerializeField]
	private DropItemListView multiPointView;

	[SerializeField]
	private MapPointInfoView mapPointInfoView;

	[SerializeField]
	private MapCaveView mapCaveView;

	[SerializeField]
	private float clickRange = 100f;

	private GameObjectPool tpPointPool;

	private GameObjectPool taskPointPool;

	private GameObjectPool taskPointUnderMaskPool;

	private GameObjectPool bossMonsterPointPool;

	private GameObjectPool mapIconPointPool;

	private GameObjectPool cavePointPool;

	private GameObjectPool guidePointPool;

	private RectTransform _multipleSelectRect;

	private InteractivePointData _selectedData;

	private RectTransform _singleSelectRect;

	private MapViewModel _viewModel;

	private string _lastMapMaskLoadPath;

	private string _lastMapAlphaLoadPath;

	private Vector3[] areaCorners;

	private float[] guideAngles;

	private bool _initAfterActive;

	[SerializeField]
	private TextMeshProUGUI exploreProgress;

	[SerializeField]
	private Image exploreBar;

	[SerializeField]
	private Toggle exploreToggle;

	[SerializeField]
	private GameObject exploreToggleOn;

	[SerializeField]
	private GameObject exploreToggleOff;

	[SerializeField]
	private GameObject explorePanel;

	[SerializeField]
	private Button btnCloseExplore;

	[SerializeField]
	private RectTransform exploreItemRoot;

	[SerializeField]
	private BaseItem exploreItemTpl;

	private GameObjectPool exploreItemPool;

	[SerializeField]
	private RectTransform guideRect;

	[SerializeField]
	private RectTransform mapCenter;

	public static float GuideAttachAngle = 5f;

	public float guideMoveTime = 0.5f;

	private int guideMoveId = 1;

	private Tweener guideMoveTween;

	[SerializeField]
	private RectTransform heroMark;

	[SerializeField]
	private Button btnLocate;

	private bool btnLocateEnable = true;

	private bool levelChangedWhenLocate = true;

	private bool animationReloading;

	public DropItemListView MultiPointView => multiPointView;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<MapViewModel>();
		BindingSet<MapWindow, MapViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((MapWindow v) => v.OnDismissRequest).To((MapViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((MapWindow v) => v.OpenUguiWindow).To((MapViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((MapWindow v) => v.SetChildViewVisibility).To((MapViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind().For((MapWindow v) => v.OnWindowReload).To((MapViewModel vm) => vm.WindowReloadRst);
		bindingSet.Bind().For((MapWindow v) => v.OnLevelDataChanged).To((MapViewModel vm) => vm.OnLevelDataChanged);
		bindingSet.Bind().For((MapWindow v) => v.RefreshPointsState).To((MapViewModel vm) => vm.RefreshInteractionPointRst);
		bindingSet.Bind().For((MapWindow v) => v.RefreshCaveActiveState).To((MapViewModel vm) => vm.RefreshCaveActiveRst);
		bindingSet.Bind().For((MapWindow v) => v.OnRefreshGuidePointsRst).To((MapViewModel vm) => vm.RefreshGuidePointsRst);
		bindingSet.Bind().For((MapWindow v) => v.OnTaskChangeNotify).To((MapViewModel vm) => vm.OnTaskChanged);
		bindingSet.Bind().For((MapWindow v) => v.OnTrackTaskChanged).To((MapViewModel vm) => vm.OnTrackTaskChanged);
		bindingSet.Bind().For((MapWindow v) => v.OnPointClick).To((MapViewModel vm) => vm.OnPointClickRequest);
		bindingSet.Bind().For((MapWindow v) => v.OnDropPointItemClick).To((MapViewModel vm) => vm.OnDropListClickRst);
		bindingSet.Bind().For((MapWindow v) => v.ResetSelectState).To((MapViewModel vm) => vm.ResetSelectStateRst);
		bindingSet.Bind().For((MapWindow v) => v.MapTweenMove).To((MapViewModel vm) => vm.MapTweenMoveRst);
		bindingSet.Bind().For((MapWindow v) => v.OnSetDropListVisible).To((MapViewModel vm) => vm.SetDropListVisibleRst);
		bindingSet.Bind(btnLocate.gameObject).For((GameObject v) => v.activeSelf).To((MapViewModel vm) => vm.ShowLocateBtn);
		bindingSet.Bind().For((MapWindow v) => v.OnOpenPointInfoView).To((MapViewModel vm) => vm.OpenMapInfoViewRst);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((MapViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind<TextMeshProUGUI>(exploreProgress).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MapViewModel vm) => $"{vm.ExploreProgress}%");
		bindingSet.Bind().For((MapWindow v) => v.RefreshExplore).To((MapViewModel vm) => vm.RefreshExploreDataRst);
		bindingSet.Bind(exploreBar).For((Image v) => v.fillAmount).To((MapViewModel vm) => vm.ExploreRate);
		bindingSet.Bind(heroMark.gameObject).For((GameObject v) => v.activeSelf).To((MapViewModel vm) => vm.ShowPlayerMark);
		bindingSet.Bind(heroMark).For((RectTransform v) => v.anchoredPosition).To((MapViewModel vm) => vm.HeroMarkPos);
		bindingSet.Bind(heroMark).For((RectTransform v) => v.rotation).To((MapViewModel vm) => vm.HeroMarkRotation);
		bindingSet.Build();
		mapCaveView.Initialize(this, _viewModel.MapCaveViewModel);
		InitGuideAreaParams();
		OnInitUI();
		mapAreaListView.Init(_viewModel.AreaListViewModel);
		if (_viewModel.SectionData != null)
		{
			mapAreaListView.RefreshSections(_viewModel.SectionData.Id);
		}
		if (_viewModel.LevelData != null)
		{
			mapAreaListView.RefreshLevels(_viewModel.LevelData.Id);
		}
		RefreshLevelMapData();
	}

	private void InitGuideAreaParams()
	{
		float num = UIUtilly.GetCanvasSize().y / (float)Screen.height;
		Vector2 vector = new Vector2(UIUtilly.GetCanvasSize().x / 2f, UIUtilly.GetCanvasSize().y / 2f);
		areaCorners = new Vector3[4];
		guideRect.GetWorldCorners(areaCorners);
		Vector2 vector2 = new Vector2(areaCorners[0].x, areaCorners[0].y) * num - vector;
		Vector2 vector3 = new Vector2(areaCorners[1].x, areaCorners[1].y) * num - vector;
		Vector2 vector4 = new Vector2(areaCorners[2].x, areaCorners[2].y) * num - vector;
		Vector2 vector5 = new Vector2(areaCorners[3].x, areaCorners[3].y) * num - vector;
		float num2 = Vector2.Angle(Vector2.up, vector2);
		float num3 = Vector2.Angle(Vector2.up, vector3);
		float num4 = Vector2.Angle(Vector2.up, vector4);
		float num5 = Vector2.Angle(Vector2.up, vector5);
		Vector3 vector6 = Vector3.Cross(Vector2.up, vector2);
		Vector3 vector7 = Vector3.Cross(Vector2.up, vector3);
		Vector3 vector8 = Vector3.Cross(Vector2.up, vector4);
		Vector3 vector9 = Vector3.Cross(Vector2.up, vector5);
		num2 = ((vector6.z < 0f) ? (360f - num2) : num2);
		num3 = ((vector7.z < 0f) ? (360f - num3) : num3);
		num4 = ((vector8.z < 0f) ? (360f - num4) : num4);
		num5 = ((vector9.z < 0f) ? (360f - num5) : num5);
		guideAngles = new float[4] { num2, num3, num4, num5 };
	}

	private void OnInitUI()
	{
		tpPointPool = new GameObjectPool(tpPointItem.gameObject, tpRoot);
		taskPointPool = new GameObjectPool(taskPointItem.gameObject, taskRoot);
		taskPointUnderMaskPool = new GameObjectPool(taskPointItem.gameObject, taskUnderMaskRoot);
		bossMonsterPointPool = new GameObjectPool(bossMonsterItem.gameObject, bossMonsterRoot);
		mapIconPointPool = new GameObjectPool(mapIconItem.gameObject, collectionRoot);
		cavePointPool = new GameObjectPool(cavePointItem.gameObject, caveRoot);
		guidePointPool = new GameObjectPool(guidePointItem.gameObject, overlayRoot);
		mapMask.Init();
		_singleSelectRect = singleSelect.GetComponent<RectTransform>();
		_multipleSelectRect = multipleSelect.GetComponent<RectTransform>();
		_singleSelectRect.localScale = new Vector2(1f / mapScrollRect.CurScale, 1f / mapScrollRect.CurScale);
		_multipleSelectRect.localScale = new Vector2(1f / mapScrollRect.CurScale, 1f / mapScrollRect.CurScale);
		multiPointView.Init(_viewModel.DropItemListVm);
		heroMark.localScale = Vector2.one * (1f / mapScrollRect.CurScale);
		mapPointInfoView.Init(_viewModel.PointInfoVm);
		UIMapScaleScrollRect uIMapScaleScrollRect = mapScrollRect;
		uIMapScaleScrollRect.ScaleAction = (Action<float>)Delegate.Combine(uIMapScaleScrollRect.ScaleAction, new Action<float>(ScalePoints));
		mapScrollRect.onValueChanged.AddListener(delegate
		{
			RefreshGuidePoints();
		});
		mapScrollRect.OnEndDragAction = delegate
		{
			UpdateMapPivot();
		};
		exploreItemPool = new GameObjectPool(exploreItemTpl.gameObject, exploreItemRoot);
		exploreToggle.onValueChanged.AddListener(delegate(bool isOn)
		{
			exploreToggleOn.SetActive(isOn);
			exploreToggleOff.SetActive(!isOn);
			explorePanel.SetActive(isOn);
			btnCloseExplore.gameObject.SetActive(isOn);
		});
		btnCloseExplore.onClick.AddListener(delegate
		{
			exploreToggle.isOn = false;
		});
		RefreshExplore();
		btnLocate.onClick.AddListener(LocatePlayer);
	}

	protected override void OnShow()
	{
		base.OnShow();
		if (_viewModel != null)
		{
			RefreshExplore();
			if (_viewModel.MapMode == MapMode.Level)
			{
				_viewModel.GamePause();
			}
		}
	}

	private async UniTaskVoid MarkViewModelVisibleAfterShown()
	{
		await UniTask.WaitUntil(() => Visibility);
		if (_viewModel.ManualLocate)
		{
			levelChangedWhenLocate = true;
			CancelInvoke("ManualLocate");
			Invoke("ManualLocate", 0.1f);
		}
		else
		{
			CancelInvoke("AutoLocate");
			Invoke("AutoLocate", 0.1f);
		}
	}

	private async void OnLevelDataChanged(object sender, InteractionEventArgs e)
	{
		await RefreshLevelMapData();
	}

	private async Task RefreshLevelMapData()
	{
		mapBg.gameObject.SetActive(value: false);
		DRMap mapConfigData = _viewModel.LevelData;
		if (mapConfigData == null)
		{
			return;
		}
		Vector2 mapSize = new Vector2((mapConfigData.MapSize.Count > 0) ? mapConfigData.MapSize[0] : 0f, (mapConfigData.MapSize.Count > 1) ? mapConfigData.MapSize[1] : 0f);
		try
		{
			DisposeMapPrefab();
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIFormAsset(mapConfigData.MapPrefabPath), mapPrefabRoot);
			if (gameObject != null)
			{
				mapPrefab = gameObject;
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		_viewModel.SetMapSize(mapSize);
		mapScrollRect.SetMapSize(mapSize, mapConfigData.ContentScale);
		RefreshMapScaleLimit(mapConfigData.Scale);
		await RefreshMapMask(mapConfigData);
		RefreshBossMonsterPoints();
		RefreshTpPoints(mapConfigData);
		RefreshCavePoints(mapConfigData.Id);
		RefreshTaskPoints();
		RefreshGuidePoints();
		if (_viewModel.MapMode == MapMode.Outer)
		{
			RefreshMapIconItemsByConfig();
		}
		else if (_viewModel.MapMode == MapMode.Level)
		{
			if (mapConfigData.Id == _viewModel.PlayerLevelId)
			{
				RefreshMapIconItemsByLevelSave();
			}
			else
			{
				RefreshMapIconItemsByConfig();
			}
		}
		MarkViewModelVisibleAfterShown().Forget();
	}

	private void TryUnloadMapTextureAsset()
	{
		mapMask.SetMaskTexture(null);
		if (!string.IsNullOrEmpty(_lastMapMaskLoadPath))
		{
			GameEntry.Resource.UnloadAsset(_lastMapMaskLoadPath);
			_lastMapMaskLoadPath = string.Empty;
		}
		if (!string.IsNullOrEmpty(_lastMapAlphaLoadPath))
		{
			GameEntry.Resource.UnloadAsset(_lastMapAlphaLoadPath);
			_lastMapAlphaLoadPath = string.Empty;
		}
	}

	private async Task RefreshMapMask(DRMap mapConfigData)
	{
		if (mapConfigData == null || (UnityEngine.Object)(object)mapMask == null || mapBg == null)
		{
			return;
		}
		Vector2 mapSize = new Vector2((mapConfigData.MapSize.Count > 0) ? mapConfigData.MapSize[0] : 0f, (mapConfigData.MapSize.Count > 1) ? mapConfigData.MapSize[1] : 0f);
		TryUnloadMapTextureAsset();
		Image maskImage = ((Component)(object)mapMask).GetComponent<Image>();
		if (maskImage != null)
		{
			_lastMapMaskLoadPath = AssetUtility.GetTextureAsset(mapConfigData.MapMaskPath);
			Sprite sprite = await LoadSpriteAsync(_lastMapMaskLoadPath);
			if (sprite == null)
			{
				((Component)(object)mapMask).gameObject.SetActive(value: false);
				return;
			}
			maskImage.sprite = sprite;
			mapBg.sprite = maskImage.sprite;
			maskImage.rectTransform.sizeDelta = mapSize;
		}
		_lastMapAlphaLoadPath = AssetUtility.GetTextureAsset(mapConfigData.MaskAlphaPath);
		Texture texture = await LoadAssetAsync<Texture>(_lastMapAlphaLoadPath);
		if (texture == null)
		{
			((Component)(object)mapMask).gameObject.SetActive(value: false);
			return;
		}
		mapMask.SetMaskTexture(texture);
		mapMask.SetMatTexelSize(new Vector4(mapSize.x / 2f, mapSize.y / 2f, 1f, 1f));
		UpdateMapMaskData(mapConfigData);
		((Component)(object)mapMask).gameObject.SetActive(value: true);
	}

	private void UpdateMapMaskData(DRMap mapConfigData)
	{
		if (!string.IsNullOrEmpty(mapConfigData.SceneName))
		{
			int[,] mapMaskData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMapMaskData(mapConfigData.Id);
			if (mapMaskData != null)
			{
				int[,] maskDataImmediate = new int[8, 8];
				mapMask.SetMaskDataImmediate(maskDataImmediate);
				mapMask.SetMaskData(mapMaskData);
			}
		}
	}

	private void OnTrackTaskChanged(object sender, InteractionEventArgs e)
	{
		RefreshCavePointsBubbles();
		OnRefreshGuidePointsRst();
	}

	private void RefreshTpPoints(DRMap mapConfigData)
	{
		tpPointPool.RecycleAll();
		foreach (int item in mapConfigData.TransferPoint)
		{
			DRTransferPoint dataRow = GameEntry.DataTable.GetDataRow<DRTransferPoint>(item);
			if (dataRow != null)
			{
				TpPointItem component = tpPointPool.Allocate(out var newCreate).GetComponent<TpPointItem>();
				if (newCreate)
				{
					component.Init(new TpPointItemData(_viewModel));
					component.GetPointData().SetScale(1f / mapScrollRect.CurScale);
				}
				component.RefreshData(dataRow, mapConfigData, _viewModel.MapSizeDelta);
				bool active = _viewModel.ActiveBonfires.Contains(item);
				RefreshTpPointState(component, active);
			}
		}
	}

	private void RefreshTpPointState(TpPointItem tp, bool active)
	{
		tp.RefreshState(active);
		tp.transform.SetParent(active ? tpActiveRoot : tpRoot);
	}

	private void RefreshTaskPoints(object sender = null, InteractionEventArgs e = null)
	{
		taskPointPool.RecycleAll();
		taskPointUnderMaskPool.RecycleAll();
		DRMap levelData = _viewModel.LevelData;
		List<TaskDataViewModel> displayLevelTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetDisplayLevelTask(levelData.Id, needShowInTaskUi: false);
		displayLevelTask.RemoveAll((TaskDataViewModel p) => p.CaveId > 0);
		foreach (TaskDataViewModel item in displayLevelTask)
		{
			List<TaskPosition> taskPosition = item.GetTaskPosition();
			if (taskPosition == null || taskPosition.Count <= 0)
			{
				continue;
			}
			foreach (TaskPosition item2 in taskPosition)
			{
				TaskPointItem component = ((!item.IsShowInTaskUI()) ? taskPointUnderMaskPool.Allocate(out var newCreate) : taskPointPool.Allocate(out newCreate)).GetComponent<TaskPointItem>();
				if (newCreate)
				{
					component.Init(new TaskPointItemData(_viewModel), areaCorners, guideAngles);
					component.ItemScale(1f / mapScrollRect.CurScale);
				}
				component.RefreshData(item, _viewModel.MapSizeDelta, item2.position, item2.rangeRadius, item2.active);
			}
		}
	}

	private void RefreshBossMonsterPoints()
	{
		bossMonsterPointPool.RecycleAll();
		DRMap levelData = _viewModel.LevelData;
		List<TaskDataViewModel> displayLevelTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetDisplayLevelTask(levelData.Id, needShowInTaskUi: false);
		Vector2 posOffset = new Vector2((levelData.WorldPosOffset.Count > 0) ? levelData.WorldPosOffset[0] : 0f, (levelData.WorldPosOffset.Count > 1) ? levelData.WorldPosOffset[1] : 0f);
		foreach (TaskDataViewModel item in displayLevelTask)
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
					InteractivePoint.PointInfo pointInfo = new InteractivePoint.PointInfo(InteractivePoint.PointType.BossMonster, item.MonsterId, item.TaskName, item2.position, posOffset, _viewModel.MapSizeDelta);
					InteractivePointData interactivePointData = new InteractivePointData(_viewModel, pointInfo);
					interactivePointData.SetScale(1f / mapScrollRect.CurScale);
					InteractivePoint component = bossMonsterPointPool.Allocate(out var newCreate).GetComponent<InteractivePoint>();
					if (newCreate)
					{
						component.Init(interactivePointData);
					}
					else
					{
						component.RefreshData(interactivePointData);
					}
				}
			}
		}
	}

	private void RefreshMapIconItemsByConfig()
	{
		mapIconPointPool.RecycleAll();
		DRMap levelData = _viewModel.LevelData;
		Vector2 posOffset = new Vector2((levelData.WorldPosOffset.Count > 0) ? levelData.WorldPosOffset[0] : 0f, (levelData.WorldPosOffset.Count > 1) ? levelData.WorldPosOffset[1] : 0f);
		List<KeyValuePair<int, Vector2>> list = new List<KeyValuePair<int, Vector2>>();
		for (int i = 0; i < levelData.ResourceType.Count && levelData.ResourcePosition.Count > i; i++)
		{
			Vector2 value = new Vector2((levelData.ResourcePosition[i].Count > 0) ? levelData.ResourcePosition[i][0] : 0f, (levelData.ResourcePosition[i].Count > 1) ? levelData.ResourcePosition[i][1] : 0f);
			list.Add(new KeyValuePair<int, Vector2>(levelData.ResourceType[i], value));
		}
		foreach (KeyValuePair<int, Vector2> item in list)
		{
			InteractivePoint.PointInfo pointInfo = new InteractivePoint.PointInfo(InteractivePoint.PointType.MapItem, $"map_collect_{item.Key}", item.Value, posOffset, _viewModel.MapSizeDelta);
			InteractivePointData interactivePointData = new InteractivePointData(_viewModel, pointInfo);
			interactivePointData.SetScale(1f / mapScrollRect.CurScale);
			InteractivePoint component = mapIconPointPool.Allocate(out var newCreate).GetComponent<InteractivePoint>();
			if (newCreate)
			{
				component.Init(interactivePointData);
			}
			else
			{
				component.RefreshData(interactivePointData);
			}
		}
	}

	private void RefreshMapIconItemsByLevelSave()
	{
		try
		{
			mapIconPointPool.RecycleAll();
			Vector2 posOffset = new Vector2((_viewModel.LevelData.WorldPosOffset.Count > 0) ? _viewModel.LevelData.WorldPosOffset[0] : 0f, (_viewModel.LevelData.WorldPosOffset.Count > 1) ? _viewModel.LevelData.WorldPosOffset[1] : 0f);
			foreach (LevelSaveService.MapItemViewData mapItemData in _viewModel.MapItemDatas)
			{
				DRMapItem dataRow = GameEntry.DataTable.GetDataRow<DRMapItem>(mapItemData.Data.MapItemId);
				if (dataRow == null)
				{
					Log.Error($"交互物表不存在ID为[{mapItemData.Data.MapItemId}]的配置");
					continue;
				}
				DRMapItemType dataRow2 = GameEntry.DataTable.GetDataRow<DRMapItemType>(dataRow.MapItemType);
				if (dataRow2 != null)
				{
					string icon = "";
					if (mapItemData.Data.IconType == 1)
					{
						icon = dataRow2.IconType1;
					}
					else if (mapItemData.Data.IconType == 2)
					{
						icon = dataRow2.IconType2;
					}
					InteractivePoint.PointInfo pointInfo = new InteractivePoint.PointInfo(InteractivePoint.PointType.MapItem, icon, mapItemData.Position.ToVector2(), posOffset, _viewModel.MapSizeDelta);
					InteractivePointData interactivePointData = new InteractivePointData(_viewModel, pointInfo);
					interactivePointData.SetScale(1f / mapScrollRect.CurScale);
					InteractivePoint component = mapIconPointPool.Allocate(out var newCreate).GetComponent<InteractivePoint>();
					if (newCreate)
					{
						component.Init(interactivePointData);
					}
					else
					{
						component.RefreshData(interactivePointData);
					}
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private void RefreshCavePoints(int levelId)
	{
		cavePointPool.RecycleAll();
		_viewModel.CavePointItemDatas.Clear();
		List<TaskDataViewModel> displayLevelTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetDisplayLevelTask(levelId);
		DRCavern[] dataRows = GameEntry.DataTable.GetDataRows((DRCavern p) => p.LevelId == levelId);
		if (dataRows == null)
		{
			return;
		}
		float num = -1f;
		CavePointItemData cavePointItemData = null;
		DRCavern[] array = dataRows;
		foreach (DRCavern dRCavern in array)
		{
			foreach (int item in dRCavern.CavernPoint)
			{
				DRCavernPoint dataRow = GameEntry.DataTable.GetDataRow<DRCavernPoint>(item);
				if (dataRow == null)
				{
					continue;
				}
				CavePointItem component = cavePointPool.Allocate(out var newCreate).GetComponent<CavePointItem>();
				if (newCreate)
				{
					component.Init(new CavePointItemData(_viewModel, dataRow, isInCave: false, _viewModel.MapSizeDelta), areaCorners, guideAngles, caveRoot, overlayRoot);
					component.GetPointData().SetScale(1f / mapScrollRect.CurScale);
				}
				else
				{
					component.RefreshData(dataRow, _viewModel.MapSizeDelta);
				}
				bool flag = false;
				flag = dataRow.ActiveState == 1 || _viewModel.ActiveCavePoints.Contains(dataRow.Id);
				component.ViewModel.RefreshState(flag);
				component.ViewModel.ResetAllBubbles();
				if (_viewModel.PlayerCaveId > 0 && _viewModel.PlayerCaveId == dRCavern.Id && !component.ViewModel.IsLock)
				{
					Vector2 a = new Vector2((dataRow.CavernOut.Count > 0) ? dataRow.CavernOut[0] : 0f, (dataRow.CavernOut.Count > 1) ? dataRow.CavernOut[1] : 0f);
					Vector2 b = new Vector2(_viewModel.HeroWorldPos.x, _viewModel.HeroWorldPos.z);
					if (num < 0f || Vector2.Distance(a, b) < num)
					{
						num = Vector2.Distance(a, b);
						cavePointItemData = component.ViewModel;
					}
				}
				if (displayLevelTask != null)
				{
					foreach (TaskDataViewModel item2 in displayLevelTask)
					{
						if (item2.CaveId > 0)
						{
							List<TaskPosition> taskPosition = item2.GetTaskPosition();
							if (taskPosition != null && taskPosition.Count > 0 && item2.CavePoints.Contains(dataRow.Id))
							{
								component.ViewModel.AddTask(item2);
							}
						}
					}
				}
				_viewModel.CavePointItemDatas.Add(component.ViewModel);
			}
		}
		cavePointItemData?.AddPlayer();
	}

	private void RefreshCavePointsBubbles()
	{
		if (cavePointPool == null || _viewModel.LevelData == null)
		{
			return;
		}
		List<TaskDataViewModel> displayLevelTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetDisplayLevelTask(_viewModel.LevelData.Id);
		foreach (GameObject item in cavePointPool.GetAll())
		{
			CavePointItem component = item.GetComponent<CavePointItem>();
			component.ViewModel.ResetTaskBubbles();
			if (displayLevelTask == null)
			{
				continue;
			}
			foreach (TaskDataViewModel item2 in displayLevelTask)
			{
				if (item2.CaveId > 0)
				{
					List<TaskPosition> taskPosition = item2.GetTaskPosition();
					if (taskPosition != null && taskPosition.Count > 0 && item2.CavePoints.Contains(component.ViewModel.DrCavernPoint.Id))
					{
						component.ViewModel.AddTask(item2);
					}
				}
			}
		}
	}

	private void RefreshGuidePoints()
	{
		List<MapGuidePointData> list = new List<MapGuidePointData>();
		if (_viewModel.ShowPlayerMark)
		{
			MapGuidePointData mapGuidePointData = UpdateHeroMarkVisualData();
			if (mapGuidePointData != null)
			{
				list.Add(mapGuidePointData);
			}
		}
		foreach (GameObject item in GetAllTaskItem())
		{
			MapGuidePointData mapGuidePointData2 = item.GetComponent<TaskPointItem>().UpdateVisualData();
			if (mapGuidePointData2 != null)
			{
				list.Add(mapGuidePointData2);
			}
		}
		foreach (GameObject item2 in cavePointPool.GetAll())
		{
			MapGuidePointData mapGuidePointData3 = item2.GetComponent<CavePointItem>().UpdateVisualData();
			if (mapGuidePointData3 != null)
			{
				list.Add(mapGuidePointData3);
			}
		}
		list.Sort((MapGuidePointData a, MapGuidePointData b) => (a.TypePriority != b.TypePriority) ? (-a.TypePriority.CompareTo(b.TypePriority)) : a.Distance.CompareTo(b.Distance));
		Dictionary<float, List<MapGuidePointData>> dictionary = new Dictionary<float, List<MapGuidePointData>>();
		foreach (MapGuidePointData item3 in list)
		{
			bool flag = false;
			foreach (float key in dictionary.Keys)
			{
				if (Mathf.Abs(item3.Angle - key) <= GuideAttachAngle)
				{
					if (dictionary[key].Count <= 3)
					{
						dictionary[key].Add(item3);
					}
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				dictionary.Add(item3.Angle, new List<MapGuidePointData> { item3 });
			}
		}
		guidePointPool.RecycleAll();
		foreach (KeyValuePair<float, List<MapGuidePointData>> item4 in dictionary)
		{
			MapGuidePointItemData viewModel = new MapGuidePointItemData(_viewModel, item4.Key, item4.Value);
			MapGuidePointItem component = guidePointPool.Allocate(out var newCreate).GetComponent<MapGuidePointItem>();
			if (newCreate)
			{
				component.Init(viewModel);
				component.ItemScale(1f / mapScrollRect.CurScale);
			}
			else
			{
				component.RefreshData(viewModel);
			}
		}
	}

	private void OnRefreshGuidePointsRst(object sender = null, InteractionEventArgs e = null)
	{
		RefreshGuidePoints();
		mapCaveView?.RefreshGuidePoints();
	}

	private void RefreshPointsState(object sender, InteractionEventArgs e)
	{
		foreach (GameObject item in tpPointPool.GetAll())
		{
			TpPointItem component = item.GetComponent<TpPointItem>();
			int id = component.GetPointData().PointInfo.Id;
			bool active = _viewModel.ActiveBonfires.Contains(id);
			RefreshTpPointState(component, active);
		}
	}

	private void RefreshCaveActiveState(object sender, InteractionEventArgs e)
	{
		foreach (GameObject item in cavePointPool.GetAll())
		{
			CavePointItem component = item.GetComponent<CavePointItem>();
			int id = component.ViewModel.DrCavernPoint.Id;
			bool flag = false;
			flag = component.ViewModel.DrCavernPoint.ActiveState == 1 || _viewModel.ActiveCavePoints.Contains(id);
			component.RefreshState(flag);
		}
	}

	private void OnTaskChangeNotify(object sender, InteractionEventArgs e)
	{
		if (e.Context is TaskChangeNotifyMessager { changeNotifyType: var changeNotifyType } && (changeNotifyType == TaskSystem.TaskChangeNotifyType.Delete || changeNotifyType == TaskSystem.TaskChangeNotifyType.Finished || changeNotifyType == TaskSystem.TaskChangeNotifyType.Received || changeNotifyType == TaskSystem.TaskChangeNotifyType.UpdatePosition))
		{
			RefreshTaskPoints();
		}
	}

	private void OnPointClick(object sender, InteractionEventArgs e)
	{
		InteractivePointData interactivePointData = (InteractivePointData)e.Context;
		InteractivePoint.PointInfo clickPointInfo = interactivePointData.PointInfo;
		Vector2 clickWorldPos = default(Vector2);
		List<InteractivePointData> points = new List<InteractivePointData>();
		points.Add(interactivePointData);
		tpPointPool.GetAll().ForEach(SearchNearPoint);
		GetAllTaskItem().ForEach(SearchNearPoint);
		cavePointPool.GetAll().ForEach(SearchNearPoint);
		OnPointClickResult(interactivePointData, points, clickWorldPos);
		void SearchNearPoint(GameObject pointGo)
		{
			InteractivePoint component = pointGo.GetComponent<InteractivePoint>();
			if (!(component == null) && component.gameObject.activeSelf)
			{
				InteractivePointData pointData = component.GetPointData();
				if (!pointData.IsLock)
				{
					InteractivePoint.PointInfo pointInfo = pointData.PointInfo;
					if (pointInfo.Equal(clickPointInfo))
					{
						clickWorldPos = component.transform.position;
					}
					else if (Vector2.Distance(pointInfo.Pos, clickPointInfo.Pos) <= clickRange)
					{
						points.Add(pointData);
					}
				}
			}
		}
	}

	private void OnPointClickResult(InteractivePointData clickPoint, List<InteractivePointData> nearPoints, Vector2 clickWorldPos)
	{
		if (nearPoints.Count > 0)
		{
			if (nearPoints.Count == 1)
			{
				OnFinalPointClick(clickPoint);
				return;
			}
			SetPointSelected(clickPoint);
			SetSelectState(show: true, ignoreAnimation: false, isMultiple: true, clickPoint.PointInfo.Pos);
			multiPointView.RefreshPointsData(clickWorldPos, nearPoints);
			SetDropListVisible(visible: true);
		}
	}

	private void OnDropPointItemClick(object sender, InteractionEventArgs e)
	{
		InteractivePointData data = (InteractivePointData)e.Context;
		SetDropListVisible(visible: false);
		OnFinalPointClick(data);
	}

	private void OnFinalPointClick(InteractivePointData data)
	{
		if (data.PointInfo.PointType == InteractivePoint.PointType.MainTask)
		{
			TaskDataViewModel task = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(data.PointInfo.Id);
			if (task.SpaceChapter && task.Timelineid > 0)
			{
				OnSpaceChapterTaskClick(task);
				return;
			}
		}
		if (data.PointInfo.PointType == InteractivePoint.PointType.BossMonster)
		{
			_viewModel.OpenMonsterInfoView(data);
			SetPointSelected(data);
			SetSelectState(show: true, ignoreAnimation: false, isMultiple: false, data.PointInfo.Pos);
		}
		else if (data.PointInfo.PointType == InteractivePoint.PointType.CavePoint)
		{
			if (data is CavePointItemData cavePointItemData)
			{
				_viewModel.ShowMapCaveView(cavePointItemData.DrCavernPoint.CavernlId);
				SetPointSelected();
				SetSelectState(show: false);
			}
		}
		else
		{
			OpenPointInfoView(data);
			SetPointSelected(data);
			SetSelectState(show: true, ignoreAnimation: false, isMultiple: false, data.PointInfo.Pos);
		}
	}

	private void OnSetDropListVisible(object sender, InteractionEventArgs e)
	{
		bool visible = (bool)e.Context;
		SetDropListVisible(visible);
	}

	public void SetDropListVisible(bool visible, bool ignoreAnimation = false)
	{
		if (!visible)
		{
			multiPointView.Hide(ignoreAnimation);
			ControlMapSlider(enable: true);
		}
		else
		{
			multiPointView.Show(ignoreAnimation);
			ControlMapSlider(enable: false);
		}
	}

	private void ControlMapSlider(bool enable)
	{
		mapScrollRect.ScaleSlider.interactable = enable;
		mapCaveView?.ControlMapSlider(enable);
	}

	private void ResetSelectState(object sender, InteractionEventArgs e)
	{
		SetPointSelected();
		SetSelectState(show: false);
	}

	private void SetPointSelected(InteractivePointData data = null)
	{
		_selectedData?.PlayAnimation(InteractivePoint.AnimationType.Out);
		_selectedData = data;
		_selectedData?.PlayAnimation(InteractivePoint.AnimationType.Enter);
	}

	private void SetSelectState(bool show, bool ignoreAnimation = false, bool isMultiple = false, Vector2 showPos = default(Vector2))
	{
		if (!show)
		{
			singleSelect.Hide(ignoreAnimation);
			multipleSelect.Hide(ignoreAnimation);
		}
		else if (isMultiple)
		{
			singleSelect.Hide(ignoreAnimation);
			_multipleSelectRect.anchoredPosition = showPos;
			multipleSelect.Show(ignoreAnimation);
		}
		else
		{
			multipleSelect.Hide(ignoreAnimation);
			_singleSelectRect.anchoredPosition = showPos;
			singleSelect.Show(ignoreAnimation);
		}
	}

	public void OpenPointInfoView(InteractivePointData pointItemData)
	{
		mapPointInfoView.Show(pointItemData);
	}

	private void OnOpenPointInfoView(object sender, InteractionEventArgs e)
	{
		if (e.Context is InteractivePointData pointItemData)
		{
			mapPointInfoView.Show(pointItemData);
		}
	}

	public void OnSpaceChapterTaskClick(TaskDataViewModel taskData)
	{
		IAsyncResult<int> result = AlertDialog.Show("提示", "是否开始剧情《" + taskData.TaskName + "》?\n(该任务文本量较大，请传火者耐心观看)", "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				PlaySpaceChapterTimeline(taskData);
			}
		});
	}

	private async void PlaySpaceChapterTimeline(TaskDataViewModel taskData)
	{
		if (await Singleton<Story>.Instance.PlayStory(0u, taskData.Timelineid) && await Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().FinishTask(taskData.TaskId))
		{
			_viewModel.SetLevelIdWaitReload(taskData.TaskId);
		}
	}

	private void RefreshExplore(object sender = null, InteractionEventArgs e = null)
	{
		exploreToggle.isOn = false;
		exploreItemPool.RecycleAll();
		foreach (KeyValuePair<int, KeyValuePair<int, int>> exploreTypeDatum in _viewModel.ExploreTypeData)
		{
			BaseItem component = exploreItemPool.Allocate(out var newCreate).GetComponent<BaseItem>();
			BaseItemData baseItemData = new BaseItemData(_viewModel)
			{
				Icon = $"Exploration_{exploreTypeDatum.Key}",
				Text = $"{exploreTypeDatum.Value.Key}/{exploreTypeDatum.Value.Value}"
			};
			if (newCreate)
			{
				component.Init(baseItemData);
			}
			else
			{
				component.RefreshData(baseItemData);
			}
			component.transform.SetAsLastSibling();
		}
	}

	private void MapTweenMove(object sender, InteractionEventArgs e)
	{
		Vector2 position = (Vector2)e.Context;
		MoveToPosition(position);
	}

	public void MoveToPosition(Vector2 position)
	{
		position = -position * mapScrollRect.CurScale;
		if (guideMoveTween == null)
		{
			guideMoveTween = DOTween.To(() => mapScrollRect.content.anchoredPosition, delegate(Vector2 x)
			{
				mapScrollRect.content.anchoredPosition = x;
			}, position, guideMoveTime).SetEase(Ease.Linear).OnKill(delegate
			{
				guideMoveTween = null;
			})
				.SetAutoKill()
				.SetId(guideMoveId);
		}
		else
		{
			guideMoveTween.ChangeEndValue(position, guideMoveTime, snapStartValue: true);
		}
	}

	private MapGuidePointData UpdateHeroMarkVisualData()
	{
		return InteractivePoint.UpdatePointVisualDataWithRectangle(areaCorners, guideAngles, heroMark, heroMark.transform.parent.GetComponent<RectTransform>(), new InteractivePoint.PointInfo(InteractivePoint.PointType.Player, 0, "", heroMark.anchoredPosition));
	}

	public void LocatePlayer()
	{
		if (btnLocateEnable && _viewModel.MapMode != MapMode.Outer && _viewModel.PlayerLevelId > 0)
		{
			btnLocateEnable = false;
			_viewModel.ManualLocate = true;
			if (_viewModel.LevelData?.Id == _viewModel.PlayerLevelId)
			{
				levelChangedWhenLocate = false;
				ManualLocate();
			}
			else
			{
				_viewModel.RefreshData(_viewModel.PlayerLevelId);
			}
		}
	}

	private void AutoLocate()
	{
		bool flag = false;
		Vector2 anchoredPosition = Vector2.zero;
		if (_viewModel.AutoLocateWhenOpen)
		{
			if (_viewModel.TrackTaskId > 0)
			{
				TaskDataViewModel task = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(_viewModel.TrackTaskId);
				if (task != null)
				{
					if (task.CaveId > 0)
					{
						int num = ((task.CavePoints.Count > 0) ? task.CavePoints[0] : 0);
						if (num > 0)
						{
							foreach (GameObject item in cavePointPool.GetAll())
							{
								CavePointItem component = item.GetComponent<CavePointItem>();
								if (component.gameObject.activeSelf)
								{
									CavePointItemData cavePointItemData = (CavePointItemData)component.GetPointData();
									if (cavePointItemData.DrCavernPoint.Id == num)
									{
										anchoredPosition = -cavePointItemData.PointInfo.Pos * mapScrollRect.CurScale;
										flag = true;
										break;
									}
								}
							}
						}
					}
					else
					{
						foreach (GameObject item2 in GetAllTaskItem())
						{
							TaskPointItem component2 = item2.GetComponent<TaskPointItem>();
							if (component2.gameObject.activeSelf && !component2.GetPointData().IsLock)
							{
								TaskPointItemData taskPointItemData = (TaskPointItemData)component2.GetPointData();
								if (taskPointItemData.TaskViewModel.TaskId.Equals(_viewModel.TrackTaskId) || taskPointItemData.TaskViewModel.ParentTaskId.Equals(_viewModel.TrackTaskId))
								{
									anchoredPosition = -taskPointItemData.PointInfo.Pos * mapScrollRect.CurScale;
									flag = true;
									break;
								}
							}
						}
					}
					_viewModel.TrackTaskId = 0;
				}
			}
			else if (_viewModel.ShowPlayerMark)
			{
				flag = true;
				anchoredPosition = (0f - mapScrollRect.CurScale) * new Vector2(heroMark.anchoredPosition.x, heroMark.anchoredPosition.y - heroMark.sizeDelta.y / 2f);
			}
			else if (_viewModel.PlayerCaveId > 0)
			{
				foreach (GameObject item3 in cavePointPool.GetAll())
				{
					CavePointItem component3 = item3.GetComponent<CavePointItem>();
					if (component3.gameObject.activeSelf)
					{
						CavePointItemData cavePointItemData2 = (CavePointItemData)component3.GetPointData();
						if (cavePointItemData2.PlayerIn)
						{
							anchoredPosition = -cavePointItemData2.PointInfo.Pos * mapScrollRect.CurScale;
							flag = true;
							break;
						}
					}
				}
				_viewModel.MapCaveViewModel.SetLocation(MapCaveViewModel.LocationTypeEnum.Player);
				_viewModel.ShowMapCaveView(_viewModel.PlayerCaveId);
			}
		}
		if (!flag)
		{
			List<float> initPos = _viewModel.LevelData.InitPos;
			float x = ((initPos.Count > 0) ? initPos[0] : 0f);
			float y = ((initPos.Count > 1) ? initPos[1] : 0f);
			anchoredPosition = new Vector2(x, y);
		}
		mapScrollRect.content.anchoredPosition = anchoredPosition;
		_viewModel.AutoLocateWhenOpen = false;
		RefreshGuidePoints();
		UpdateMapPivot();
		((Component)(object)mapMask).gameObject.SetActive(value: false);
		if (IsActive())
		{
			StopCoroutine(RefreshMapMaskVisible());
			StartCoroutine(RefreshMapMaskVisible());
		}
	}

	private void ManualLocate()
	{
		bool flag = false;
		Vector2 anchoredPosition = Vector2.zero;
		if (_viewModel.PlayerCaveId > 0)
		{
			if (GameEntry.DataTable.GetDataRow<DRCavern>(_viewModel.PlayerCaveId) != null)
			{
				foreach (GameObject item in cavePointPool.GetAll())
				{
					CavePointItem component = item.GetComponent<CavePointItem>();
					if (component.gameObject.activeSelf && !component.GetPointData().IsLock)
					{
						CavePointItemData cavePointItemData = (CavePointItemData)component.GetPointData();
						if (cavePointItemData.PlayerIn)
						{
							anchoredPosition = -cavePointItemData.PointInfo.Pos * mapScrollRect.CurScale;
							flag = true;
							_viewModel.MapCaveViewModel.SetLocation(MapCaveViewModel.LocationTypeEnum.Player);
							_viewModel.ShowMapCaveView(_viewModel.PlayerCaveId, forceRefresh: true);
							break;
						}
					}
				}
			}
		}
		else
		{
			_viewModel.HideMapCaveView();
			flag = true;
			anchoredPosition = (0f - mapScrollRect.CurScale) * new Vector2(heroMark.anchoredPosition.x, heroMark.anchoredPosition.y - heroMark.sizeDelta.y / 2f);
		}
		if (!flag)
		{
			List<float> initPos = _viewModel.LevelData.InitPos;
			float x = ((initPos.Count > 0) ? initPos[0] : 0f);
			float y = ((initPos.Count > 1) ? initPos[1] : 0f);
			anchoredPosition = new Vector2(x, y);
		}
		mapScrollRect.content.anchoredPosition = anchoredPosition;
		btnLocateEnable = true;
		_viewModel.ManualLocate = false;
		RefreshGuidePoints();
		UpdateMapPivot();
		if (levelChangedWhenLocate)
		{
			((Component)(object)mapMask).gameObject.SetActive(value: false);
			if (IsActive())
			{
				StopCoroutine(RefreshMapMaskVisible());
				StartCoroutine(RefreshMapMaskVisible());
			}
		}
	}

	private IEnumerator RefreshMapMaskVisible()
	{
		yield return new WaitForEndOfFrame();
		((Component)(object)mapMask).gameObject.SetActive(value: true);
		mapBg.gameObject.SetActive(value: true);
	}

	private void RefreshMapScaleLimit(List<float> scales)
	{
		float min = ((scales.Count > 0) ? scales[0] : 0.9f);
		float raw = ((scales.Count > 1) ? scales[1] : 1f);
		float num = ((scales.Count > 2) ? scales[2] : 1.1f);
		if (_viewModel.TrackTaskId > 0)
		{
			raw = num;
		}
		mapScrollRect.ResetScaleLimit(min, num, raw, reset: true);
	}

	private void UpdateMapPivot()
	{
		RectTransform component = mapBg.GetComponent<RectTransform>();
		component.pivot = new Vector2(0.5f, 0.5f);
		component.anchoredPosition = Vector2.zero;
		Vector2 sizeDelta = component.sizeDelta;
		mapCenter.SetParent(mapBg.transform);
		Vector2 vector = mapCenter.anchoredPosition + sizeDelta / 2f;
		Vector2 pivot = new Vector2(vector.x / sizeDelta.x, vector.y / sizeDelta.y);
		mapCenter.SetParent(mapScrollRect.viewport);
		component.SetPivotWithCurrentPosition(pivot);
	}

	private List<GameObject> GetAllTaskItem()
	{
		List<GameObject> list = new List<GameObject>();
		if (taskPointPool != null)
		{
			list.AddRange(taskPointPool.GetAll());
		}
		if (taskPointUnderMaskPool != null)
		{
			list.AddRange(taskPointUnderMaskPool.GetAll());
		}
		return list;
	}

	private void ScalePoints(float scale)
	{
		Vector2 vector = new Vector2(1f / scale, 1f / scale);
		_singleSelectRect.localScale = vector;
		_multipleSelectRect.localScale = vector;
		foreach (GameObject item in cavePointPool.GetAll())
		{
			item.GetComponent<CavePointItem>()?.GetPointData().SetScale(1f / scale);
		}
		foreach (GameObject item2 in tpPointPool.GetAll())
		{
			item2.GetComponent<TpPointItem>()?.GetPointData().SetScale(1f / scale);
		}
		foreach (GameObject item3 in GetAllTaskItem())
		{
			item3.GetComponent<TaskPointItem>()?.GetPointData().SetScale(1f / scale);
		}
		foreach (GameObject item4 in bossMonsterPointPool.GetAll())
		{
			item4.GetComponent<InteractivePoint>()?.GetPointData().SetScale(1f / scale);
		}
		foreach (GameObject item5 in mapIconPointPool.GetAll())
		{
			item5.GetComponent<InteractivePoint>()?.GetPointData().SetScale(1f / scale);
		}
		foreach (GameObject item6 in guidePointPool.GetAll())
		{
			item6.GetComponent<MapGuidePointItem>()?.ItemScale(1f / scale);
		}
		UpdateMapPivot();
	}

	private void OnWindowReload(object sender, InteractionEventArgs e)
	{
		if (!animationReloading)
		{
			EnterAnimation?.OnStart(delegate
			{
				animationReloading = true;
			}).OnEnd(delegate
			{
				animationReloading = false;
			}).Play();
		}
	}

	private void DisposeMapPrefab()
	{
		if (mapPrefab != null)
		{
			UnityEngine.Object.DestroyImmediate(mapPrefab);
			mapPrefab = null;
		}
	}

	protected override void OnDestroy()
	{
		DisposeMapPrefab();
		tpPointPool?.Dispose();
		tpPointPool = null;
		taskPointPool?.Dispose();
		taskPointPool = null;
		taskPointUnderMaskPool?.Dispose();
		taskPointUnderMaskPool = null;
		bossMonsterPointPool?.Dispose();
		bossMonsterPointPool = null;
		mapIconPointPool?.Dispose();
		mapIconPointPool = null;
		cavePointPool?.Dispose();
		cavePointPool = null;
		guidePointPool?.Dispose();
		guidePointPool = null;
		TryUnloadMapTextureAsset();
		base.OnDestroy();
	}
}
