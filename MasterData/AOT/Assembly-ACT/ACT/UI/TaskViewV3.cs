using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskViewV3 : BaseUIView<TaskViewV3InputController>
{
	[SerializeField]
	private TaskListComponentV3 _taskList;

	[SerializeField]
	private GameObject _rightPanel;

	[SerializeField]
	private LocalizeStringEvent _taskName;

	[SerializeField]
	private LocalizeStringEvent _taskLocation;

	[SerializeField]
	private LocalizeStringEvent _taskLocationDetail;

	[SerializeField]
	private LocalizeStringEvent _taskDetail;

	[SerializeField]
	private GameObject _locationRoot;

	[SerializeField]
	private TaskMissionConditionListV3 _conditionList;

	[SerializeField]
	private LoopHorizontalScrollRect _rewardScrollRect;

	[SerializeField]
	private GameObject _rewardTitleRoot;

	[SerializeField]
	private GameObject _rewardRoot;

	[SerializeField]
	private ActButton _closeButton;

	[SerializeField]
	private GameObject _blockedRoot;

	[SerializeField]
	private ActButton _traceButton;

	[SerializeField]
	private ActButton _untraceButton;

	[SerializeField]
	private TaskViewV3InputBinding _inputBinding = new TaskViewV3InputBinding();

	private CancellationTokenSource _sessionCancellation;

	private int _sessionVersion;

	private int _selectedMissionId;

	private bool _traceRequestPending;

	private bool _initialized;

	private bool _rewardListenerBound;

	private bool _conditionLayoutChangedBound;

	private bool _tabTransitionActive;

	private bool _tabContentPending;

	private bool _tabContentReady;

	private bool _tabOutPlaying;

	private bool _pendingHasMission;

	private int _pendingMissionId;

	private int _tabTransitionVersion;

	private readonly List<Item> _rewardItems = new List<Item>();

	private int _selectedRewardIndex = -1;

	private const float REWARD_CELL_SIZE = 108f;

	internal TaskListComponentV3 TaskList => _taskList;

	internal int SelectedMissionId => _selectedMissionId;

	internal bool IsTabTransitioning => _tabTransitionActive;

	internal TaskViewV3InputBinding InputBinding => _inputBinding;

	protected override void Init()
	{
		base.Init();
		_taskList.TabChangeStarting += BeginTabTransition;
		_taskList.TabChanged += FinishTabChange;
		BeginInitialize();
	}

	protected override void ReInit()
	{
		base.ReInit();
		BeginInitialize();
	}

	protected override void UnInit()
	{
		CancelSession();
		UnbindButtons();
		UnbindRewards();
		UnbindConditionLayoutChanged();
		_taskList.TabChangeStarting -= BeginTabTransition;
		_taskList.TabChanged -= FinishTabChange;
		_conditionList.Unbind();
		_taskList.Uninitialize();
		ClearRuntimeData();
		base.UnInit();
	}

	public override void Close()
	{
		CancelSession();
		base.Close();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		AnimationBuilder sequence = betterAnimation.GetSequence("Show");
		if (sequence == null)
		{
			OpenEffectFinishNew();
			return;
		}
		sequence.OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		AnimationBuilder sequence = betterAnimation.GetSequence("Hide");
		if (sequence == null)
		{
			CloseEffectFinishNew();
			return;
		}
		sequence.OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private void BeginInitialize()
	{
		CancelSession();
		UnbindButtons();
		UnbindRewards();
		UnbindConditionLayoutChanged();
		ClearRuntimeData();
		BindConditionLayoutChanged();
		_sessionCancellation = CancellationTokenSource.CreateLinkedTokenSource(destroyCancellationToken);
		int sessionVersion = _sessionVersion;
		InitializeAsync(sessionVersion, _sessionCancellation.Token).Forget();
	}

	private async UniTask InitializeAsync(int version, CancellationToken token)
	{
		try
		{
			_rightPanel.SetActive(value: false);
			BindButtons();
			BindRewards();
			int requestedMissionId = (uiViewData as TaskViewV3Data)?.missionId ?? 0;
			bool flag = await _taskList.InitializeAsync(Station, requestedMissionId, OnMissionSelected, OnMissionActivated, OnMissionAvailabilityChanged, token);
			if (IsSessionValid(version, token))
			{
				if (!flag)
				{
					Debug.LogError("TaskViewV3 任务列表初始化失败，终止本次界面初始化。", this);
					Close();
				}
				else
				{
					_initialized = true;
				}
			}
		}
		catch (Exception exception)
		{
			if (IsSessionValid(version, token))
			{
				Debug.LogException(exception, this);
				Close();
			}
		}
	}

	private void CancelSession()
	{
		_sessionVersion++;
		_initialized = false;
		_traceRequestPending = false;
		_tabTransitionVersion++;
		if (_sessionCancellation != null)
		{
			_sessionCancellation.Cancel();
			_sessionCancellation.Dispose();
			_sessionCancellation = null;
		}
		if (_tabTransitionActive && (bool)betterAnimation)
		{
			betterAnimation.StopAnimation();
			AnimationBuilder sequence = betterAnimation.GetSequence("TabEnter");
			if (sequence != null)
			{
				sequence.Complete();
			}
			else
			{
				betterAnimation.GetSequence("TabOut")?.Goto(0f);
			}
			betterAnimation.StopAnimation();
		}
		_tabTransitionActive = false;
		_tabContentPending = false;
		_tabContentReady = false;
		_tabOutPlaying = false;
		_pendingHasMission = false;
		_pendingMissionId = 0;
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
		_selectedMissionId = 0;
		_conditionList.Clear();
		ClearRewards();
	}

	private void BindConditionLayoutChanged()
	{
		if (!_conditionLayoutChangedBound)
		{
			_conditionList.LayoutChanged += RefreshDetailLayout;
			_conditionLayoutChangedBound = true;
		}
	}

	private void UnbindConditionLayoutChanged()
	{
		if (_conditionLayoutChangedBound)
		{
			_conditionList.LayoutChanged -= RefreshDetailLayout;
			_conditionLayoutChangedBound = false;
		}
	}

	private void BeginTabTransition()
	{
		if (!_initialized || _sessionCancellation == null)
		{
			return;
		}
		GetController()?.ExitDetailForTabChange();
		if (!useAnimation)
		{
			return;
		}
		if (!betterAnimation)
		{
			Debug.LogError("TaskViewV3 缺少页签动画组件。", this);
			return;
		}
		if (_tabOutPlaying)
		{
			_tabContentReady = false;
			_pendingHasMission = false;
			_pendingMissionId = 0;
			return;
		}
		int transitionVersion = ++_tabTransitionVersion;
		if (_tabTransitionActive && !_tabContentPending)
		{
			betterAnimation.GetSequence("TabEnter")?.Complete();
		}
		_tabTransitionActive = true;
		_tabContentPending = true;
		_tabContentReady = false;
		_pendingHasMission = false;
		_pendingMissionId = 0;
		if (_rightPanel.activeSelf)
		{
			AnimationBuilder sequence = betterAnimation.GetSequence("TabOut");
			if (sequence == null)
			{
				Debug.LogError("TaskViewV3 缺少 TabOut 动画。", this);
				return;
			}
			_tabOutPlaying = true;
			PlayTabOutAsync(sequence, _sessionVersion, transitionVersion, _sessionCancellation.Token).Forget();
		}
	}

	private void FinishTabChange()
	{
		if (_tabContentPending)
		{
			_tabContentReady = true;
			if (!_tabOutPlaying)
			{
				CommitTabContent(_tabTransitionVersion);
			}
		}
	}

	private async UniTask PlayTabOutAsync(AnimationBuilder tabOut, int sessionVersion, int transitionVersion, CancellationToken token)
	{
		try
		{
			float num = tabOut.Duration();
			bool completed = false;
			tabOut.SetDelay(0f).OnComplete((AnimationBuilder _) =>
			{
				completed = true;
			}).Play();
			await UniTask.WhenAll(UniTask.Delay(TimeSpan.FromSeconds(num), ignoreTimeScale: false, PlayerLoopTiming.Update, token), tabOut.AwaitComplete());
			if (IsSessionValid(sessionVersion, token) && transitionVersion == _tabTransitionVersion)
			{
				if (!completed)
				{
					Debug.LogWarning("TaskViewV3 TabOut 动画被提前中断，直接提交最新页签内容。", this);
				}
				_tabOutPlaying = false;
				if (_tabContentReady)
				{
					CommitTabContent(transitionVersion);
				}
			}
		}
		catch (OperationCanceledException)
		{
			if (IsSessionValid(sessionVersion, token) && transitionVersion == _tabTransitionVersion)
			{
				_tabOutPlaying = false;
				if (_tabContentReady)
				{
					CommitTabContent(transitionVersion);
				}
			}
		}
		catch (Exception exception)
		{
			if (IsSessionValid(sessionVersion, token) && transitionVersion == _tabTransitionVersion)
			{
				Debug.LogException(exception, this);
				_tabOutPlaying = false;
				if (_tabContentReady)
				{
					CommitTabContent(transitionVersion);
				}
			}
		}
	}

	private void CommitTabContent(int transitionVersion)
	{
		if (!_tabContentPending || !_tabContentReady || _sessionCancellation == null || transitionVersion != _tabTransitionVersion)
		{
			return;
		}
		bool pendingHasMission = _pendingHasMission;
		int pendingMissionId = _pendingMissionId;
		_tabContentPending = false;
		_tabContentReady = false;
		_pendingHasMission = false;
		_pendingMissionId = 0;
		if (pendingHasMission && pendingMissionId > 0)
		{
			OnMissionSelected(pendingMissionId);
		}
		else
		{
			OnMissionAvailabilityChanged(hasMission: false);
		}
		if (!_rightPanel.activeSelf)
		{
			_tabTransitionActive = false;
			return;
		}
		AnimationBuilder sequence = betterAnimation.GetSequence("TabEnter");
		if (sequence == null)
		{
			Debug.LogError("TaskViewV3 缺少 TabEnter 动画。", this);
			betterAnimation.GetSequence("TabOut")?.Goto(0f);
			betterAnimation.StopAnimation();
			_tabTransitionActive = false;
		}
		else
		{
			PlayTabEnterAsync(sequence, _sessionVersion, transitionVersion, _sessionCancellation.Token).Forget();
		}
	}

	private async UniTask PlayTabEnterAsync(AnimationBuilder tabEnter, int sessionVersion, int transitionVersion, CancellationToken token)
	{
		try
		{
			tabEnter.SetDelay(0f).Play();
			await tabEnter.AwaitComplete();
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception exception)
		{
			if (IsSessionValid(sessionVersion, token) && transitionVersion == _tabTransitionVersion)
			{
				Debug.LogException(exception, this);
			}
		}
		if (IsSessionValid(sessionVersion, token) && transitionVersion == _tabTransitionVersion)
		{
			_tabTransitionActive = false;
		}
	}

	private void OnMissionSelected(int missionId)
	{
		if (_sessionCancellation != null && _taskList.TryGetMission(missionId, out var mission))
		{
			if (_tabContentPending)
			{
				_pendingHasMission = true;
				_pendingMissionId = missionId;
				return;
			}
			_selectedMissionId = missionId;
			_rightPanel.SetActive(value: true);
			SetLocalizedString(_taskName, LocalizationUtility.localizeTableName_shortcommon, mission.NameId);
			SetLocalizedString(_taskDetail, LocalizationUtility.localizeTableName_longcommon, mission.ContentDescriptionId);
			_conditionList.BindMission(missionId);
			bool flag = mission.ZoneDescriptionId > 0 || mission.PlaceDescriptionId > 0;
			_locationRoot.SetActive(flag);
			SetLocalizedString(_taskLocation, LocalizationUtility.localizeTableName_longcommon, flag ? mission.ZoneDescriptionId : 0);
			SetLocalizedString(_taskLocationDetail, LocalizationUtility.localizeTableName_longcommon, flag ? mission.PlaceDescriptionId : 0);
			RefreshRewards(mission.RewardId);
			RefreshBlockedState();
			RefreshTraceButtons();
			RefreshDetailLayout();
		}
	}

	private void OnMissionAvailabilityChanged(bool hasMission)
	{
		if (_sessionCancellation == null)
		{
			return;
		}
		if (_tabContentPending)
		{
			_pendingHasMission = hasMission;
			if (!hasMission)
			{
				_pendingMissionId = 0;
			}
			return;
		}
		_rightPanel.SetActive(hasMission);
		if (!hasMission)
		{
			_selectedMissionId = 0;
			_conditionList.Clear();
			ClearRewards();
			ClearLocalizedString(_taskName);
			ClearLocalizedString(_taskLocation);
			ClearLocalizedString(_taskLocationDetail);
			ClearLocalizedString(_taskDetail);
		}
	}

	private void RefreshRewards(int rewardId)
	{
		ClearRewards();
		if (rewardId == 0 || !RuntimeConfigs.data.collections.TryGetValue(rewardId, out var value) || value.certain.Count == 0)
		{
			if (rewardId != 0 && !RuntimeConfigs.data.collections.ContainsKey(rewardId))
			{
				Debug.LogError($"任务奖励配置错误，collections 找不到: {rewardId}");
			}
			return;
		}
		for (int i = 0; i < value.certain.Count; i++)
		{
			ItemKv itemKv = value.certain[i];
			if (itemKv.id > 0)
			{
				_rewardItems.Add(new Item
				{
					Id = itemKv.id,
					Count = itemKv.count
				});
			}
		}
		if (_rewardItems.Count != 0)
		{
			_selectedRewardIndex = 0;
			_rewardTitleRoot.SetActive(value: true);
			_rewardRoot.SetActive(value: true);
			_rewardScrollRect.ClearCellsPool();
			_rewardScrollRect.totalCount = _rewardItems.Count;
			_rewardScrollRect.RefillCells();
			_rewardScrollRect.RefreshCells();
		}
	}

	internal bool TrySelectFirstReward()
	{
		if (_rewardItems.Count == 0)
		{
			return false;
		}
		if (!EventSystemHelper.Available)
		{
			return false;
		}
		ItemUIComponentBase itemUIComponentBase = _rewardScrollRect.GetItem(0) as ItemUIComponentBase;
		if (!itemUIComponentBase)
		{
			_rewardScrollRect.RefillCells();
			itemUIComponentBase = _rewardScrollRect.GetItem(0) as ItemUIComponentBase;
		}
		if (!itemUIComponentBase || !itemUIComponentBase.gameObject.activeInHierarchy)
		{
			ItemUIComponentBase[] componentsInChildren = _rewardScrollRect.content.GetComponentsInChildren<ItemUIComponentBase>(includeInactive: true);
			foreach (ItemUIComponentBase itemUIComponentBase2 in componentsInChildren)
			{
				if (itemUIComponentBase2.Index == 0)
				{
					itemUIComponentBase = itemUIComponentBase2;
					break;
				}
			}
		}
		if (!itemUIComponentBase || !itemUIComponentBase.gameObject.activeInHierarchy)
		{
			return false;
		}
		ACT.ViewControl.SelectableEx component = itemUIComponentBase.GetComponent<ACT.ViewControl.SelectableEx>();
		if (!component || !component.IsValid())
		{
			return false;
		}
		EventSystemHelper.SetSelectedGameObject(itemUIComponentBase.gameObject);
		bool flag = EventSystemHelper.CurrentSelected == itemUIComponentBase.gameObject;
		if (flag)
		{
			_selectedRewardIndex = 0;
		}
		return flag;
	}

	internal bool TryNavigateReward(MoveDirection direction)
	{
		if (_rewardItems.Count == 0)
		{
			return false;
		}
		int num = direction switch
		{
			MoveDirection.Left => -1, 
			MoveDirection.Right => 1, 
			_ => 0, 
		};
		if (num == 0)
		{
			return false;
		}
		if (!EventSystemHelper.Available)
		{
			return false;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		ItemUIComponentBase itemUIComponentBase = null;
		if ((bool)currentSelected)
		{
			itemUIComponentBase = currentSelected.GetComponent<ItemUIComponentBase>();
			if (!itemUIComponentBase)
			{
				itemUIComponentBase = currentSelected.GetComponentInParent<ItemUIComponentBase>();
			}
		}
		if ((bool)itemUIComponentBase && itemUIComponentBase.Index >= 0 && itemUIComponentBase.Index < _rewardItems.Count)
		{
			_selectedRewardIndex = itemUIComponentBase.Index;
		}
		if (_selectedRewardIndex < 0 || _selectedRewardIndex >= _rewardItems.Count)
		{
			_selectedRewardIndex = 0;
		}
		int num2 = Mathf.Clamp(_selectedRewardIndex + num, 0, _rewardItems.Count - 1);
		if (num2 == _selectedRewardIndex)
		{
			return false;
		}
		ItemUIComponentBase itemUIComponentBase2 = _rewardScrollRect.GetItem(num2) as ItemUIComponentBase;
		if (!itemUIComponentBase2 || !itemUIComponentBase2.gameObject.activeInHierarchy)
		{
			_rewardScrollRect.StopMovement();
			_rewardScrollRect.RefillCells(num2);
			itemUIComponentBase2 = _rewardScrollRect.GetItem(num2) as ItemUIComponentBase;
		}
		if (!itemUIComponentBase2 || !itemUIComponentBase2.gameObject.activeInHierarchy)
		{
			return false;
		}
		ACT.ViewControl.SelectableEx component = itemUIComponentBase2.GetComponent<ACT.ViewControl.SelectableEx>();
		if (!component || !component.IsValid())
		{
			return false;
		}
		EventSystemHelper.SetSelectedGameObject(itemUIComponentBase2.gameObject);
		if (EventSystemHelper.CurrentSelected != itemUIComponentBase2.gameObject)
		{
			return false;
		}
		_selectedRewardIndex = num2;
		return true;
	}

	private void ClearRewards()
	{
		_rewardItems.Clear();
		_selectedRewardIndex = -1;
		_rewardScrollRect.ClearCellsPool();
		_rewardScrollRect.totalCount = 0;
		_rewardTitleRoot.SetActive(value: false);
		_rewardRoot.SetActive(value: false);
	}

	private void BindRewards()
	{
		if (!_rewardListenerBound)
		{
			_rewardScrollRect.OnItemShow.AddListener(OnRewardShow);
			_rewardListenerBound = true;
		}
	}

	private void UnbindRewards()
	{
		if (_rewardListenerBound)
		{
			_rewardScrollRect.OnItemShow.RemoveListener(OnRewardShow);
			_rewardListenerBound = false;
		}
	}

	private void OnRewardShow(ILoopScrollDataSource dataSource)
	{
		if (dataSource is ItemUIComponentBase { Index: >=0 } itemUIComponentBase && itemUIComponentBase.Index < _rewardItems.Count)
		{
			itemUIComponentBase.SetData(_rewardItems[itemUIComponentBase.Index], 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			ApplyRewardCellSize(itemUIComponentBase);
			itemUIComponentBase.UpdatePerformance();
			itemUIComponentBase.gameObject.SetActive(value: true);
		}
	}

	private static void ApplyRewardCellSize(ItemUIComponentBase itemCell)
	{
		if (itemCell.transform is RectTransform rectTransform)
		{
			rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, 108f);
			rectTransform.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 108f);
		}
		LayoutElement component = itemCell.GetComponent<LayoutElement>();
		if ((bool)component)
		{
			component.minWidth = 108f;
			component.minHeight = 108f;
			component.preferredWidth = 108f;
			component.preferredHeight = 108f;
		}
	}

	private void RefreshDetailLayout()
	{
		GetController()?.RefreshViewState();
	}

	private void BindButtons()
	{
		_closeButton.SetButtonSound("event:/UI/Common/Return_Click");
		_closeButton.SetBtnClick(Close);
		_traceButton.SetBtnClick(TrackSelectedMission);
		_untraceButton.SetBtnClick(TrackSelectedMission);
	}

	private void UnbindButtons()
	{
		_closeButton.SetBtnClick(null);
		_traceButton.SetBtnClick(null);
		_untraceButton.SetBtnClick(null);
	}

	public void TrackSelectedMission()
	{
		if (!_initialized || _tabTransitionActive || _traceRequestPending || _selectedMissionId <= 0 || !_taskList.TryGetMission(_selectedMissionId, out var mission))
		{
			return;
		}
		int sessionVersion = _sessionVersion;
		bool flag = Singleton<MissionManager>.instance.GetTracingMission() == mission.MissionId;
		int missionId = ((!flag) ? mission.MissionId : 0);
		_traceRequestPending = true;
		UpdateTracingMissionResultType updateTracingMissionResultType = Singleton<MissionManager>.instance.RequestTracingMission(missionId);
		if (sessionVersion == _sessionVersion)
		{
			_traceRequestPending = false;
			if (updateTracingMissionResultType == UpdateTracingMissionResultType.Succeed && _initialized)
			{
				RefreshTracingState();
				RefreshTraceButtons();
				Singleton<GameManager>.instance.audioManager.PlaySound(flag ? "event:/UI/Interface/Mission/UnTrack" : "event:/UI/Interface/Mission/Track");
			}
		}
	}

	private void RefreshTracingState()
	{
		_taskList.RefreshTracingState(Singleton<MissionManager>.instance.GetTracingMission());
		_taskList.RefreshBlockedState();
	}

	private void RefreshBlockedState()
	{
		_blockedRoot.SetActive(Singleton<MissionManager>.instance.IsInBlockedMapArea(_selectedMissionId));
	}

	private void RefreshTraceButtons()
	{
		if (_selectedMissionId <= 0 || !_taskList.TryGetMission(_selectedMissionId, out var _))
		{
			_traceButton.gameObject.SetActive(value: false);
			_untraceButton.gameObject.SetActive(value: false);
			return;
		}
		bool flag = Singleton<MissionManager>.instance.GetTracingMission() == _selectedMissionId;
		_traceButton.gameObject.SetActive(!flag);
		_untraceButton.gameObject.SetActive(flag);
		_traceButton.interactable = !Singleton<MissionManager>.instance.IsInBlockedMapArea(_selectedMissionId);
		_untraceButton.interactable = !Singleton<MissionManager>.instance.IsInBlockedMapArea(_selectedMissionId);
	}

	private void OnMissionActivated(int missionId)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Mission/Click");
		if (!Singleton<MissionManager>.instance.GetMissionRedpointState(missionId))
		{
			return;
		}
		G.localPlayer.redPoints.Missions[missionId] = false;
		RedPoints redPoints = new RedPoints();
		redPoints.Missions.Add(missionId, value: false);
		int version = _sessionVersion;
		G.service.RefreshRedDot(redPoints, (bool _) =>
		{
			Singleton<MissionManager>.instance.RefreshRedDot();
			if (version == _sessionVersion && _initialized)
			{
				_taskList.RefreshAllRedDots();
			}
		});
	}

	private static void SetLocalizedString(LocalizeStringEvent localizeStringEvent, string tableName, int entryId)
	{
		if (entryId <= 0)
		{
			ClearLocalizedString(localizeStringEvent);
			return;
		}
		localizeStringEvent.StringReference.TableReference = tableName;
		localizeStringEvent.StringReference.TableEntryReference = entryId;
		localizeStringEvent.RefreshString();
	}

	private static void ClearLocalizedString(LocalizeStringEvent localizeStringEvent)
	{
		localizeStringEvent.StringReference.TableReference = null;
		localizeStringEvent.StringReference.TableEntryReference = null;
		localizeStringEvent.OnUpdateString.Invoke(string.Empty);
	}
}
