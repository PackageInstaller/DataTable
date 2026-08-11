#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using DG.Tweening;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MapCaveView : UGuiView
{
	[SerializeField]
	private GameObject tabMain;

	[SerializeField]
	private MapAreaTabItem levelTab;

	[SerializeField]
	private MapAreaTabItem caveTab;

	[SerializeField]
	private GameObject mapMain;

	[SerializeField]
	private UIMapScaleScrollRect mapScrollRect;

	[SerializeField]
	private GameObject mapBg;

	[SerializeField]
	private RectTransform mapPrefabRoot;

	private GameObject mapPrefab;

	[SerializeField]
	private RectTransform overlayRoot;

	[SerializeField]
	private RectTransform taskRoot;

	[SerializeField]
	private RectTransform caveRoot;

	[SerializeField]
	private RectTransform collectionRoot;

	[SerializeField]
	private TaskPointItem taskPointItem;

	[SerializeField]
	private CavePointItem cavePointItem;

	[SerializeField]
	private InteractivePoint mapIconItem;

	[SerializeField]
	private MapGuidePointItem guidePointItem;

	[SerializeField]
	private AnimationUIView singleSelect;

	[SerializeField]
	private AnimationUIView multipleSelect;

	private MapWindow parentWindow;

	private GameObjectPool taskPointPool;

	private GameObjectPool mapIconPointPool;

	private GameObjectPool cavePointPool;

	private GameObjectPool guidePointPool;

	private float _clickRange;

	private RectTransform _multipleSelectRect;

	private InteractivePointData _selectedData;

	private RectTransform _singleSelectRect;

	private MapCaveViewModel _viewModel;

	private Vector3[] areaCorners;

	private float[] guideAngles;

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

	public void Initialize(MapWindow parent, MapCaveViewModel viewModel)
	{
		Init();
		parentWindow = parent;
		_viewModel = viewModel;
		BindingSet<MapCaveView, MapCaveViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(tabMain).For((GameObject v) => v.activeSelf).To((MapCaveViewModel vm) => vm.ShowTabs);
		bindingSet.Bind(mapMain).For((GameObject v) => v.activeSelf).To((MapCaveViewModel vm) => vm.ShowCaveMap);
		bindingSet.Bind().For((MapCaveView v) => v.OnCaveDataChanged).To((MapCaveViewModel vm) => vm.OnCaveDataChanged);
		bindingSet.Bind().For((MapCaveView v) => v.OnPointClick).To((MapCaveViewModel vm) => vm.OnPointClickRequest);
		bindingSet.Bind().For((MapCaveView v) => v.ResetSelectState).To((MapCaveViewModel vm) => vm.ResetSelectStateRst);
		bindingSet.Bind().For((MapCaveView v) => v.MapTweenMove).To((MapCaveViewModel vm) => vm.MapTweenMoveRst);
		bindingSet.Bind(heroMark.gameObject).For((GameObject v) => v.activeSelf).To((MapCaveViewModel vm) => vm.ShowPlayerMark);
		bindingSet.Bind(heroMark).For((RectTransform v) => v.anchoredPosition).To((MapCaveViewModel vm) => vm.HeroMarkPos);
		bindingSet.Bind(heroMark).For((RectTransform v) => v.rotation).To((MapCaveViewModel vm) => vm.HeroMarkRotation);
		bindingSet.Build();
		InitGuideAreaParams();
		OnInitUI();
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
		taskPointPool = new GameObjectPool(taskPointItem.gameObject, taskRoot);
		mapIconPointPool = new GameObjectPool(mapIconItem.gameObject, collectionRoot);
		cavePointPool = new GameObjectPool(cavePointItem.gameObject, caveRoot);
		guidePointPool = new GameObjectPool(guidePointItem.gameObject, overlayRoot);
		_singleSelectRect = singleSelect.GetComponent<RectTransform>();
		_multipleSelectRect = multipleSelect.GetComponent<RectTransform>();
		_clickRange = _multipleSelectRect.sizeDelta.x / 2f;
		_singleSelectRect.localScale = new Vector2(1f / mapScrollRect.CurScale, 1f / mapScrollRect.CurScale);
		_multipleSelectRect.localScale = new Vector2(1f / mapScrollRect.CurScale, 1f / mapScrollRect.CurScale);
		heroMark.localScale = Vector2.one * (1f / mapScrollRect.CurScale);
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
		levelTab.Init(_viewModel.LevelTabItemData);
		caveTab.Init(_viewModel.CaveTabItemData);
	}

	private async void OnCaveDataChanged(object sender, InteractionEventArgs e)
	{
		await RefreshMap();
	}

	private async Task RefreshMap()
	{
		mapBg.gameObject.SetActive(value: false);
		DRCavern mapConfigData = _viewModel.CaveData;
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
		mapScrollRect.SetMapSize(_viewModel.MapSizeDelta, mapConfigData.ContentScale);
		RefreshMapScaleLimit(mapConfigData.Scale);
		RefreshTaskPoints();
		RefreshCavePoints(mapConfigData);
		RefreshGuidePoints();
		if (_viewModel.MapMode == MapMode.Outer)
		{
			RefreshMapIconItemsOuter();
		}
		else if (_viewModel.MapMode == MapMode.Level)
		{
			RefreshMapIconItemsLevel();
		}
		CancelInvoke("OnMapDataChangeAfter");
		Invoke("OnMapDataChangeAfter", 0.1f);
	}

	private void OnPointClick(object sender, InteractionEventArgs e)
	{
		InteractivePointData interactivePointData = (InteractivePointData)e.Context;
		InteractivePoint.PointInfo clickPointInfo = interactivePointData.PointInfo;
		Vector2 clickWorldPos = default(Vector2);
		List<InteractivePointData> points = new List<InteractivePointData>();
		points.Add(interactivePointData);
		taskPointPool.GetAll().ForEach(SearchNearPoint);
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
					else if (Vector2.Distance(pointInfo.Pos, clickPointInfo.Pos) <= _clickRange)
					{
						points.Add(pointData);
					}
				}
			}
		}
	}

	private void OnPointClickResult(InteractivePointData clickPoint, List<InteractivePointData> nearPoints, Vector2 clickWorldPos)
	{
		if (nearPoints.Count <= 0)
		{
			return;
		}
		Vector2 pos = clickPoint.PointInfo.Pos;
		if (nearPoints.Count == 1)
		{
			if (clickPoint.PointInfo.PointType == InteractivePoint.PointType.MainTask)
			{
				TaskDataViewModel task = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(clickPoint.PointInfo.Id);
				if (task.SpaceChapter && task.Timelineid > 0)
				{
					parentWindow.OnSpaceChapterTaskClick(task);
					return;
				}
			}
			SetPointSelected(clickPoint);
			SetSelectState(show: true, ignoreAnimation: false, isMultiple: false, pos);
			if (clickPoint.PointInfo.PointType == InteractivePoint.PointType.BossMonster)
			{
				_viewModel.OpenMonsterInfoView(clickPoint);
			}
			else
			{
				parentWindow.OpenPointInfoView(clickPoint);
			}
		}
		else
		{
			SetPointSelected(clickPoint);
			SetSelectState(show: true, ignoreAnimation: false, isMultiple: true, pos);
			parentWindow.MultiPointView.RefreshPointsData(clickWorldPos, nearPoints);
			parentWindow.SetDropListVisible(visible: true);
		}
	}

	public void ControlMapSlider(bool enable)
	{
		mapScrollRect.ScaleSlider.interactable = enable;
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

	private void RefreshTaskPoints(object sender = null, InteractionEventArgs e = null)
	{
		taskPointPool.RecycleAll();
		DRCavern caveData = _viewModel.CaveData;
		foreach (TaskDataViewModel item in Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetDisplayTaskInCave(caveData.Id))
		{
			List<TaskPosition> taskPosition = item.GetTaskPosition();
			if (taskPosition == null || taskPosition.Count <= 0)
			{
				continue;
			}
			foreach (TaskPosition item2 in taskPosition)
			{
				TaskPointItem component = taskPointPool.Allocate(out var newCreate).GetComponent<TaskPointItem>();
				if (newCreate)
				{
					component.Init(new TaskPointItemData(_viewModel), areaCorners, guideAngles);
					component.ItemScale(1f / mapScrollRect.CurScale);
				}
				component.RefreshData(item, _viewModel.MapSizeDelta, item2.position, item2.rangeRadius, item2.active);
			}
		}
	}

	private void RefreshMapIconItemsOuter()
	{
	}

	private void RefreshMapIconItemsLevel()
	{
	}

	private void RefreshCavePoints(DRCavern drData)
	{
		cavePointPool.RecycleAll();
		foreach (int item in drData.CavernPoint)
		{
			DRCavernPoint dataRow = GameEntry.DataTable.GetDataRow<DRCavernPoint>(item);
			if (dataRow != null)
			{
				CavePointItem component = cavePointPool.Allocate(out var newCreate).GetComponent<CavePointItem>();
				if (newCreate)
				{
					component.Init(new CavePointItemData(_viewModel, dataRow, isInCave: true, _viewModel.MapSizeDelta), areaCorners, guideAngles);
					component.GetPointData().SetScale(1f / mapScrollRect.CurScale);
				}
				else
				{
					component.RefreshData(dataRow, _viewModel.MapSizeDelta);
				}
				component.ViewModel.RefreshState(active: true);
				component.ViewModel.SetCavernState(state: true);
			}
		}
	}

	public void RefreshGuidePoints()
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
		foreach (GameObject item in taskPointPool.GetAll())
		{
			MapGuidePointData mapGuidePointData2 = item.GetComponent<TaskPointItem>().UpdateVisualData();
			if (mapGuidePointData2 != null)
			{
				list.Add(mapGuidePointData2);
			}
		}
		list.Sort((MapGuidePointData a, MapGuidePointData b) => (a.TypePriority != b.TypePriority) ? (-a.TypePriority.CompareTo(b.TypePriority)) : a.Distance.CompareTo(b.Distance));
		Dictionary<float, List<MapGuidePointData>> dictionary = new Dictionary<float, List<MapGuidePointData>>();
		foreach (MapGuidePointData item2 in list)
		{
			bool flag = false;
			foreach (float key in dictionary.Keys)
			{
				if (Mathf.Abs(item2.Angle - key) <= GuideAttachAngle)
				{
					if (dictionary[key].Count <= 3)
					{
						dictionary[key].Add(item2);
					}
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				dictionary.Add(item2.Angle, new List<MapGuidePointData> { item2 });
			}
		}
		guidePointPool.RecycleAll();
		foreach (KeyValuePair<float, List<MapGuidePointData>> item3 in dictionary)
		{
			MapGuidePointItemData viewModel = new MapGuidePointItemData(_viewModel, item3.Key, item3.Value);
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

	private void OnMapDataChangeAfter()
	{
		bool flag = false;
		Vector2 anchoredPosition = Vector2.zero;
		if (_viewModel.LocationType == MapCaveViewModel.LocationTypeEnum.TrackTask)
		{
			foreach (GameObject item in taskPointPool.GetAll())
			{
				TaskPointItem component = item.GetComponent<TaskPointItem>();
				if (component.gameObject.activeSelf && !component.GetPointData().IsLock)
				{
					TaskPointItemData taskPointItemData = (TaskPointItemData)component.GetPointData();
					if (taskPointItemData.TaskViewModel.TaskId.Equals(_viewModel.LocationArg) || taskPointItemData.TaskViewModel.ParentTaskId.Equals(_viewModel.LocationArg))
					{
						anchoredPosition = -taskPointItemData.PointInfo.Pos * mapScrollRect.CurScale;
						flag = true;
						break;
					}
				}
			}
		}
		else if (_viewModel.LocationType == MapCaveViewModel.LocationTypeEnum.Player && _viewModel.ShowPlayerMark)
		{
			flag = true;
			anchoredPosition = (0f - mapScrollRect.CurScale) * new Vector2(heroMark.anchoredPosition.x, heroMark.anchoredPosition.y - heroMark.sizeDelta.y / 2f);
		}
		if (!flag)
		{
			List<float> initPos = _viewModel.CaveData.InitPos;
			float x = ((initPos.Count > 0) ? initPos[0] : 0f);
			float y = ((initPos.Count > 1) ? initPos[1] : 0f);
			anchoredPosition = new Vector2(x, y);
		}
		mapScrollRect.content.anchoredPosition = anchoredPosition;
		RefreshGuidePoints();
		UpdateMapPivot();
		mapBg.gameObject.SetActive(value: true);
	}

	private void ScalePoints(float scale)
	{
		Vector2 vector = new Vector2(1f / scale, 1f / scale);
		_singleSelectRect.localScale = vector;
		_multipleSelectRect.localScale = vector;
		foreach (GameObject item in taskPointPool.GetAll())
		{
			item.GetComponent<TaskPointItem>()?.GetPointData().SetScale(1f / scale);
		}
		foreach (GameObject item2 in mapIconPointPool.GetAll())
		{
			item2.GetComponent<InteractivePoint>()?.GetPointData().SetScale(1f / scale);
		}
		foreach (GameObject item3 in guidePointPool.GetAll())
		{
			item3.GetComponent<MapGuidePointItem>()?.ItemScale(1f / scale);
		}
		UpdateMapPivot();
	}

	private void RefreshMapScaleLimit(List<float> scales)
	{
		float min = ((scales.Count > 0) ? scales[0] : 0.9f);
		float raw = ((scales.Count > 1) ? scales[1] : 1f);
		float max = ((scales.Count > 2) ? scales[2] : 1.1f);
		mapScrollRect.ResetScaleLimit(min, max, raw, reset: true);
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
		taskPointPool?.Dispose();
		taskPointPool = null;
		mapIconPointPool?.Dispose();
		mapIconPointPool = null;
		cavePointPool?.Dispose();
		cavePointPool = null;
		guidePointPool?.Dispose();
		guidePointPool = null;
		base.OnDestroy();
	}
}
