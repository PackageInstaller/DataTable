using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Core;
using ACT.MissionSystem;
using ACT.UI.InputController;
using Bamboo.AssetField;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskListComponentV3 : MonoBehaviour
{
	[SerializeField]
	private YooAssetReference _categoryGroupReference;

	[SerializeField]
	private YooAssetReference _missionGroupReference;

	[SerializeField]
	private YooAssetReference _standaloneMissionReference;

	[SerializeField]
	private YooAssetReference _groupedMissionReference;

	[SerializeField]
	private List<TaskTabBindingV3> _tabs = new List<TaskTabBindingV3>();

	[SerializeField]
	private ActToggleGroup _tabToggleGroup;

	[SerializeField]
	private Transform _contentRoot;

	[SerializeField]
	private Transform _poolCacheRoot;

	[SerializeField]
	private ToggleGroup _missionToggleGroup;

	[SerializeField]
	private GameObject _noTask;

	private TaskComponentPoolV3<TaskCategoryGroupV3> _categoryGroupPool;

	private TaskComponentPoolV3<TaskMissionGroupCellV3> _missionGroupPool;

	private TaskComponentPoolV3<TaskStandaloneMissionCellV3> _standaloneMissionPool;

	private TaskComponentPoolV3<TaskGroupedMissionCellV3> _groupedMissionPool;

	private readonly List<TaskCategoryGroupV3> _activeCategoryGroups = new List<TaskCategoryGroupV3>();

	private readonly List<TaskMissionGroupCellV3> _activeMissionGroups = new List<TaskMissionGroupCellV3>();

	private readonly List<TaskMissionCellBaseV3> _activeMissionCells = new List<TaskMissionCellBaseV3>();

	private readonly Dictionary<int, TaskMissionCellBaseV3> _missionCellMap = new Dictionary<int, TaskMissionCellBaseV3>();

	private readonly TaskViewSnapshotV3 _snapshot = new TaskViewSnapshotV3();

	private readonly List<int> _acceptedMissionIds = new List<int>();

	private readonly Dictionary<TaskCategoryV3, TaskTabBindingV3> _tabMap = new Dictionary<TaskCategoryV3, TaskTabBindingV3>();

	private readonly List<RedDotItem> _tabRedDots = new List<RedDotItem>();

	private readonly HashSet<string> _preloadedAssetGuids = new HashSet<string>();

	private ImageAssetStation _station;

	private CancellationTokenSource _sessionCancellation;

	private Action<int> _onMissionSelected;

	private Action<int> _onMissionActivated;

	private Action<bool> _onMissionAvailabilityChanged;

	private int _sessionVersion;

	private int _requestedMissionId;

	private bool _initialized;

	private TaskCategoryV3 _currentCategory;

	public event Action LayoutChanged;

	internal event Action TabChangeStarting;

	public event Action TabChanged;

	public async UniTask<bool> InitializeAsync(ImageAssetStation station, int requestedMissionId, Action<int> onMissionSelected, Action<int> onMissionActivated, Action<bool> onMissionAvailabilityChanged, CancellationToken token)
	{
		ImageAssetStation station2 = _station;
		ResetRuntime();
		if (station2 != station)
		{
			ClearPools();
		}
		_station = station;
		_requestedMissionId = requestedMissionId;
		_onMissionSelected = onMissionSelected;
		_onMissionActivated = onMissionActivated;
		_onMissionAvailabilityChanged = onMissionAvailabilityChanged;
		_sessionCancellation = CancellationTokenSource.CreateLinkedTokenSource(token);
		int version = _sessionVersion;
		CancellationToken sessionToken = _sessionCancellation.Token;
		SetTabsInteractable(interactable: false);
		BindTabs();
		Singleton<MissionManager>.instance.RefreshRedDot();
		BuildSnapshot();
		bool flag = await PreloadRequiredPrefabsAsync(version, sessionToken);
		if (!IsSessionValid(version, sessionToken) || !flag)
		{
			return false;
		}
		EnsurePools();
		BuildTaskList();
		SetTabsInteractable(interactable: true);
		_initialized = true;
		_tabMap[TaskCategoryV3.All].Tab.SetIsOnWithoutNotify(val: true);
		ShowCategory(TaskCategoryV3.All);
		return true;
	}

	public void Uninitialize()
	{
		ResetRuntime();
		ClearPools();
		_station = null;
	}

	private void ResetRuntime()
	{
		_sessionVersion++;
		_initialized = false;
		if (_sessionCancellation != null)
		{
			_sessionCancellation.Cancel();
			_sessionCancellation.Dispose();
			_sessionCancellation = null;
		}
		UnbindTabs();
		ReleaseActiveComponents();
		ClearRuntimeData();
	}

	private bool IsSessionValid(int version, CancellationToken token)
	{
		if (version == _sessionVersion)
		{
			return !token.IsCancellationRequested;
		}
		return false;
	}

	private void ClearRuntimeData()
	{
		_snapshot.Clear();
		_acceptedMissionIds.Clear();
		_tabMap.Clear();
		_tabRedDots.Clear();
		_requestedMissionId = 0;
		_currentCategory = TaskCategoryV3.All;
		_onMissionSelected = null;
		_onMissionActivated = null;
		_onMissionAvailabilityChanged = null;
	}

	private void BuildSnapshot()
	{
		_acceptedMissionIds.Clear();
		Singleton<MissionManager>.instance.GetAllMissions(_acceptedMissionIds);
		for (int i = 0; i < _acceptedMissionIds.Count; i++)
		{
			int num = _acceptedMissionIds[i];
			if (!RuntimeConfigs.data.missionBases.TryGetValue(num, out var value))
			{
				Debug.LogError($"任务配置错误，找不到 missionBase: {num}");
			}
			else
			{
				if (!value.isValid || value.isHidden || Singleton<MissionManager>.instance.IsFinished(num))
				{
					continue;
				}
				MissionConfig missionConfig = Singleton<MissionManager>.instance.GetMissionConfig(num);
				if (!missionConfig.IsValid)
				{
					Debug.LogError($"任务配置错误，无法生成 MissionConfig: {num}");
					continue;
				}
				if (!TaskViewV3Utility.TryGetCategory(missionConfig.MissionType, out var category))
				{
					Debug.LogWarning($"TaskViewV3 忽略未知任务类型，missionId={num}, type={missionConfig.MissionType}");
					continue;
				}
				int num2 = missionConfig.ChapterId;
				int chapterTitleId = 0;
				int chapterSubtitleId = 0;
				if (num2 != -1)
				{
					if (RuntimeConfigs.data.mainmissionDatas.TryGetValue(num2, out var value2))
					{
						chapterTitleId = value2.title;
						chapterSubtitleId = value2.subTitle;
					}
					else
					{
						Debug.LogError($"任务配置错误，找不到 Chapter: missionId={num}, chapterId={num2}");
						num2 = -1;
					}
				}
				int zoneDescId = missionConfig.ZoneDescId;
				int placeDescId = missionConfig.PlaceDescId;
				TaskMissionViewDataV3 mission = new TaskMissionViewDataV3(num, category, num2, missionConfig.MissionNameId, missionConfig.MissionTitleDescId, missionConfig.MissionContentDescId, zoneDescId, placeDescId, missionConfig.RewardId);
				_snapshot.AddMission(mission, chapterTitleId, chapterSubtitleId);
			}
		}
	}

	public bool TryGetMission(int missionId, out TaskMissionViewDataV3 mission)
	{
		return _snapshot.TryGetMission(missionId, out mission);
	}

	public bool TrySelectMission(MoveDirection direction)
	{
		if (!_initialized || (direction != MoveDirection.Up && direction != MoveDirection.Down))
		{
			return false;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		int num = -1;
		int num2 = -1;
		int num3 = -1;
		for (int i = 0; i < _activeMissionCells.Count; i++)
		{
			TaskMissionCellBaseV3 taskMissionCellBaseV = _activeMissionCells[i];
			if (taskMissionCellBaseV.gameObject.activeInHierarchy)
			{
				num2 = ((num2 < 0) ? i : num2);
				num3 = i;
				if (taskMissionCellBaseV.SelectionTarget == currentSelected)
				{
					num = i;
				}
			}
		}
		if (num2 < 0)
		{
			return false;
		}
		if (num < 0)
		{
			int index = ((direction == MoveDirection.Down) ? num2 : num3);
			SelectMissionCell(_activeMissionCells[index]);
			return true;
		}
		int num4 = ((direction == MoveDirection.Down) ? 1 : (-1));
		int j;
		for (j = num + num4; j >= 0 && j < _activeMissionCells.Count && !_activeMissionCells[j].gameObject.activeInHierarchy; j += num4)
		{
		}
		if (j < 0 || j >= _activeMissionCells.Count)
		{
			return false;
		}
		SelectMissionCell(_activeMissionCells[j]);
		return true;
	}

	internal bool TryFocusMission(int missionId)
	{
		if (!_initialized || missionId <= 0 || !_missionCellMap.TryGetValue(missionId, out var value) || !value.gameObject.activeInHierarchy)
		{
			return false;
		}
		if (!EventSystemHelper.Available)
		{
			return false;
		}
		GameObject selectionTarget = value.SelectionTarget;
		if (EventSystemHelper.CurrentSelected != selectionTarget)
		{
			EventSystemHelper.SetSelectedGameObject(selectionTarget);
		}
		return EventSystemHelper.CurrentSelected == selectionTarget;
	}

	private static void SelectMissionCell(TaskMissionCellBaseV3 missionCell)
	{
		missionCell.Select();
		GameObject selectionTarget = missionCell.SelectionTarget;
		if (EventSystemHelper.Available && EventSystemHelper.CurrentSelected != selectionTarget)
		{
			EventSystemHelper.SetSelectedGameObject(selectionTarget);
		}
	}

	public void RefreshTracingState(int tracingMissionId)
	{
		for (int i = 0; i < _activeMissionCells.Count; i++)
		{
			TaskMissionCellBaseV3 taskMissionCellBaseV = _activeMissionCells[i];
			taskMissionCellBaseV.SetTracing(taskMissionCellBaseV.MissionId == tracingMissionId);
		}
	}

	public void RefreshBlockedState()
	{
		for (int i = 0; i < _activeMissionCells.Count; i++)
		{
			TaskMissionCellBaseV3 taskMissionCellBaseV = _activeMissionCells[i];
			bool blocked = Singleton<MissionManager>.instance.IsInBlockedMapArea(taskMissionCellBaseV.MissionId);
			taskMissionCellBaseV.SetBlocked(blocked);
		}
	}

	public void RefreshAllRedDots()
	{
		for (int i = 0; i < _activeMissionCells.Count; i++)
		{
			_activeMissionCells[i].RefreshRedDot();
		}
		for (int j = 0; j < _tabRedDots.Count; j++)
		{
			_tabRedDots[j].UpdateDisplay();
		}
	}

	private void BindTabs()
	{
		for (int i = 0; i < _tabs.Count; i++)
		{
			TaskTabBindingV3 binding = _tabs[i];
			_tabMap.Add(binding.Category, binding);
			binding.Tab.Group = _tabToggleGroup;
			binding.Tab.SetIsOnWithoutNotify(val: false);
			binding.Handler = (bool isOn) =>
			{
				OnTabChanged(binding.Category, isOn);
			};
			binding.Tab.onValueChanged.AddListener(binding.Handler);
			RedDotItem componentInChildren = binding.Tab.GetComponentInChildren<RedDotItem>(includeInactive: true);
			if ((bool)componentInChildren)
			{
				componentInChildren.BindTrieNode();
				componentInChildren.UpdateDisplay();
				_tabRedDots.Add(componentInChildren);
			}
		}
	}

	private void UnbindTabs()
	{
		for (int i = 0; i < _tabs.Count; i++)
		{
			TaskTabBindingV3 taskTabBindingV = _tabs[i];
			if (taskTabBindingV.Handler != null)
			{
				taskTabBindingV.Tab.onValueChanged.RemoveListener(taskTabBindingV.Handler);
				taskTabBindingV.Handler = null;
			}
			taskTabBindingV.Tab.SetIsOnWithoutNotify(val: false);
			taskTabBindingV.Tab.Group = null;
		}
	}

	private void SetTabsInteractable(bool interactable)
	{
		for (int i = 0; i < _tabs.Count; i++)
		{
			_tabs[i].Tab.interactable = interactable;
		}
	}

	private void OnTabChanged(TaskCategoryV3 category, bool isOn)
	{
		if (isOn && _initialized)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Mission/Left_Click");
			TabChangeStarting?.Invoke();
			ShowCategory(category);
			TabChanged?.Invoke();
		}
	}

	public void CycleTab(bool forward)
	{
		if (!_initialized || _tabs.Count == 0)
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < _tabs.Count; i++)
		{
			if (_tabs[i].Category == _currentCategory)
			{
				num = i;
				break;
			}
		}
		int index = (forward ? ((num + 1) % _tabs.Count) : ((num - 1 + _tabs.Count) % _tabs.Count));
		_tabs[index].Tab.SetIsOn(val: true);
	}

	private void EnsurePools()
	{
		if (_categoryGroupPool == null)
		{
			_categoryGroupPool = new TaskComponentPoolV3<TaskCategoryGroupV3>(_station, _categoryGroupReference, _poolCacheRoot);
		}
		if (_missionGroupPool == null)
		{
			_missionGroupPool = new TaskComponentPoolV3<TaskMissionGroupCellV3>(_station, _missionGroupReference, _poolCacheRoot);
		}
		if (_standaloneMissionPool == null)
		{
			_standaloneMissionPool = new TaskComponentPoolV3<TaskStandaloneMissionCellV3>(_station, _standaloneMissionReference, _poolCacheRoot);
		}
		if (_groupedMissionPool == null)
		{
			_groupedMissionPool = new TaskComponentPoolV3<TaskGroupedMissionCellV3>(_station, _groupedMissionReference, _poolCacheRoot);
		}
	}

	private void BuildTaskList()
	{
		for (int i = 0; i < _snapshot.Categories.Count; i++)
		{
			TaskCategoryViewDataV3 taskCategoryViewDataV = _snapshot.Categories[i];
			if (taskCategoryViewDataV.HasMission)
			{
				TaskCategoryGroupV3 taskCategoryGroupV = _categoryGroupPool.Get(_contentRoot);
				_activeCategoryGroups.Add(taskCategoryGroupV);
				taskCategoryGroupV.Bind(taskCategoryViewDataV.Category);
				BuildGroupedMissions(taskCategoryViewDataV, taskCategoryGroupV);
				BuildStandaloneMissions(taskCategoryViewDataV, taskCategoryGroupV);
			}
		}
		RefreshAllRedDots();
		RefreshTracingState(Singleton<MissionManager>.instance.GetTracingMission());
		RefreshBlockedState();
	}

	private void BuildGroupedMissions(TaskCategoryViewDataV3 categoryData, TaskCategoryGroupV3 categoryGroup)
	{
		for (int i = 0; i < categoryData.MissionGroups.Count; i++)
		{
			TaskMissionGroupViewDataV3 taskMissionGroupViewDataV = categoryData.MissionGroups[i];
			TaskMissionGroupCellV3 taskMissionGroupCellV = _missionGroupPool.Get(categoryGroup.GroupedMissionRoot);
			_activeMissionGroups.Add(taskMissionGroupCellV);
			taskMissionGroupCellV.Bind(taskMissionGroupViewDataV, _missionToggleGroup);
			for (int j = 0; j < taskMissionGroupViewDataV.Missions.Count; j++)
			{
				TaskMissionViewDataV3 taskMissionViewDataV = taskMissionGroupViewDataV.Missions[j];
				TaskGroupedMissionCellV3 taskGroupedMissionCellV = _groupedMissionPool.Get(taskMissionGroupCellV.MissionRoot);
				_activeMissionCells.Add(taskGroupedMissionCellV);
				_missionCellMap.Add(taskMissionViewDataV.MissionId, taskGroupedMissionCellV);
				taskGroupedMissionCellV.Bind(taskMissionViewDataV, _missionToggleGroup, taskMissionGroupCellV, _onMissionSelected, _onMissionActivated);
			}
		}
	}

	private void BuildStandaloneMissions(TaskCategoryViewDataV3 categoryData, TaskCategoryGroupV3 categoryGroup)
	{
		for (int i = 0; i < categoryData.StandaloneMissions.Count; i++)
		{
			TaskMissionViewDataV3 taskMissionViewDataV = categoryData.StandaloneMissions[i];
			TaskStandaloneMissionCellV3 taskStandaloneMissionCellV = _standaloneMissionPool.Get(categoryGroup.StandaloneMissionRoot);
			_activeMissionCells.Add(taskStandaloneMissionCellV);
			_missionCellMap.Add(taskMissionViewDataV.MissionId, taskStandaloneMissionCellV);
			taskStandaloneMissionCellV.Bind(taskMissionViewDataV, _missionToggleGroup, null, _onMissionSelected, _onMissionActivated);
		}
	}

	private void ShowCategory(TaskCategoryV3 category)
	{
		_currentCategory = category;
		for (int i = 0; i < _activeCategoryGroups.Count; i++)
		{
			TaskCategoryGroupV3 taskCategoryGroupV = _activeCategoryGroups[i];
			taskCategoryGroupV.gameObject.SetActive(category == TaskCategoryV3.All || taskCategoryGroupV.Category == category);
		}
		bool flag = ((category == TaskCategoryV3.All) ? _snapshot.HasMission : _snapshot.GetCategory(category).HasMission);
		_noTask.SetActive(!flag);
		_onMissionAvailabilityChanged?.Invoke(flag);
		if (!flag)
		{
			LayoutChanged?.Invoke();
			return;
		}
		int num = ResolveDefaultMissionId(category);
		if (num > 0 && _missionCellMap.TryGetValue(num, out var value))
		{
			value.Select();
			RebuildListLayout(value.SelectionTarget);
		}
		LayoutChanged?.Invoke();
	}

	private int ResolveDefaultMissionId(TaskCategoryV3 category)
	{
		if (_requestedMissionId > 0 && _snapshot.TryGetMission(_requestedMissionId, out var mission) && (category == TaskCategoryV3.All || mission.Category == category))
		{
			int requestedMissionId = _requestedMissionId;
			_requestedMissionId = 0;
			return requestedMissionId;
		}
		_requestedMissionId = 0;
		int tracingMission = Singleton<MissionManager>.instance.GetTracingMission();
		if (tracingMission > 0 && _snapshot.TryGetMission(tracingMission, out var mission2) && (category == TaskCategoryV3.All || mission2.Category == category))
		{
			return tracingMission;
		}
		if (category != TaskCategoryV3.All)
		{
			List<TaskMissionViewDataV3> missions = _snapshot.GetCategory(category).Missions;
			if (missions.Count <= 0)
			{
				return 0;
			}
			return missions[0].MissionId;
		}
		for (int i = 0; i < _snapshot.Categories.Count; i++)
		{
			List<TaskMissionViewDataV3> missions2 = _snapshot.Categories[i].Missions;
			if (missions2.Count > 0)
			{
				return missions2[0].MissionId;
			}
		}
		return 0;
	}

	private void RebuildListLayout(GameObject selectionTarget)
	{
		Canvas.ForceUpdateCanvases();
		LayoutRebuilder.ForceRebuildLayoutImmediate((RectTransform)_contentRoot);
		if (EventSystemHelper.Available)
		{
			EventSystemHelper.SetSelectedGameObject(selectionTarget);
		}
	}

	private void ReleaseActiveComponents()
	{
		if (_standaloneMissionPool != null && _groupedMissionPool != null)
		{
			for (int i = 0; i < _activeMissionCells.Count; i++)
			{
				TaskMissionCellBaseV3 taskMissionCellBaseV = _activeMissionCells[i];
				if (taskMissionCellBaseV is TaskStandaloneMissionCellV3 item)
				{
					_standaloneMissionPool.Release(item);
				}
				else
				{
					_groupedMissionPool.Release((TaskGroupedMissionCellV3)taskMissionCellBaseV);
				}
			}
		}
		if (_missionGroupPool != null)
		{
			for (int j = 0; j < _activeMissionGroups.Count; j++)
			{
				_missionGroupPool.Release(_activeMissionGroups[j]);
			}
		}
		if (_categoryGroupPool != null)
		{
			for (int k = 0; k < _activeCategoryGroups.Count; k++)
			{
				_categoryGroupPool.Release(_activeCategoryGroups[k]);
			}
		}
		_activeMissionCells.Clear();
		_activeMissionGroups.Clear();
		_activeCategoryGroups.Clear();
		_missionCellMap.Clear();
	}

	private void ClearPools()
	{
		_categoryGroupPool?.ClearReferences();
		_missionGroupPool?.ClearReferences();
		_standaloneMissionPool?.ClearReferences();
		_groupedMissionPool?.ClearReferences();
		_categoryGroupPool = null;
		_missionGroupPool = null;
		_standaloneMissionPool = null;
		_groupedMissionPool = null;
		_preloadedAssetGuids.Clear();
	}

	private async UniTask<bool> PreloadRequiredPrefabsAsync(int version, CancellationToken token)
	{
		bool hasMission = _snapshot.HasMission;
		bool flag = false;
		bool flag2 = false;
		for (int i = 0; i < _snapshot.Categories.Count; i++)
		{
			TaskCategoryViewDataV3 taskCategoryViewDataV = _snapshot.Categories[i];
			flag |= taskCategoryViewDataV.MissionGroups.Count > 0;
			flag2 |= taskCategoryViewDataV.StandaloneMissions.Count > 0;
		}
		List<UniTask<bool>> list = new List<UniTask<bool>>(4);
		HashSet<string> scheduledAssetGuids = new HashSet<string>();
		if (hasMission)
		{
			QueuePrefabPreload(_categoryGroupReference, scheduledAssetGuids, list, version, token);
		}
		if (flag)
		{
			QueuePrefabPreload(_missionGroupReference, scheduledAssetGuids, list, version, token);
			QueuePrefabPreload(_groupedMissionReference, scheduledAssetGuids, list, version, token);
		}
		if (flag2)
		{
			QueuePrefabPreload(_standaloneMissionReference, scheduledAssetGuids, list, version, token);
		}
		bool[] array = await UniTask.WhenAll(list);
		if (!IsSessionValid(version, token))
		{
			return false;
		}
		for (int j = 0; j < array.Length; j++)
		{
			if (!array[j])
			{
				return false;
			}
		}
		return true;
	}

	private void QueuePrefabPreload(YooAssetReference assetReference, HashSet<string> scheduledAssetGuids, List<UniTask<bool>> preloadTasks, int version, CancellationToken token)
	{
		string gUID = assetReference.GUID;
		if (!_preloadedAssetGuids.Contains(gUID) && scheduledAssetGuids.Add(gUID))
		{
			preloadTasks.Add(PreloadPrefabAsync(assetReference, version, token));
		}
	}

	private async UniTask<bool> PreloadPrefabAsync(YooAssetReference assetReference, int version, CancellationToken token)
	{
		if (_preloadedAssetGuids.Contains(assetReference.GUID))
		{
			return true;
		}
		AssetLoadHandle handle = _station.LoadAsync<GameObject>(assetReference);
		await handle;
		if (!IsSessionValid(version, token))
		{
			return false;
		}
		if (!handle.IsValid || handle.State != LoadState.Success || !handle.AsGameObject())
		{
			Debug.LogError("TaskViewV3 预加载 Prefab 失败: " + assetReference.GUID, this);
			return false;
		}
		_preloadedAssetGuids.Add(assetReference.GUID);
		return true;
	}
}
