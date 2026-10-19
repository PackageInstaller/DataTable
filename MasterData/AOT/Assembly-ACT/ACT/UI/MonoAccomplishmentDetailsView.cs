using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Battle;
using ACT.Event;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoAccomplishmentDetailsView : BaseUIView<AccomplishmentDetailsViewInputController>
{
	private MonoAccomplishmentDetailsViewData m_data;

	public ActToggleGroup toggleGroup;

	public List<GameObject> toggles;

	public TMP_InputField inputField;

	public ActButton searchBtn;

	public ActButton clearInputFieldBtn;

	public GameObject noSearchResultRoot;

	public TextMeshProUGUI noSearchResultText;

	public int searchLengthLimit = 10;

	[SerializeField]
	private Dictionary<int, List<RedDotItem>> _toggleRedDotItems;

	public LoopVerticalScrollRect _accomplishmentGroupLoop;

	public TopAchievementGroupCell topAchievementGroupCell;

	public GameObject topAchievementGroupGO;

	[SerializeField]
	private LoopVerticalScrollRect _achievementContentLoop;

	public GameObject achievementContentLoopGO;

	public ViewControlRoot viewPortControlRoot;

	[SerializeField]
	private Dictionary<AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType, ViewControlLayer> _viewPortControlLayer;

	[SerializeField]
	private float scrollSpeed = 2f;

	public OperateBtnPrompt switchPageUpPrompt;

	public OperateBtnPrompt switchPageDownPrompt;

	public OperateBtnPrompt triggerInputFieldPrompt;

	public OperateBtnPrompt inputFieldSubmitPrompt;

	public GameObject prompBoard;

	public OperateBtnPrompt operateBtnPromptA;

	public OperateBtnPrompt operateBtnPromptB;

	private const int LocalizeIDA = 774;

	private const int LocalizeIDB = 606;

	private string searchText;

	private bool _isSearching;

	private string preSearchText;

	private const int SEARCHTEXTISNULL = 2278;

	private int currSelectIndex;

	private bool _inputTriggerInputField;

	private bool _rightCanScroll;

	private float _rightStickInput;

	private AchievementGroupCell _curSelectCell;

	private bool _gamepadPromptInited;

	private AccomplishmentModel _model;

	private int _pendingGroupId;

	private bool _isFillingGroupListAnimations;

	private CancellationTokenSource _groupListFillAnimationsCts;

	private bool _skipCancelGroupListFillAnimationsOnce;

	private bool _isPlayingGroupSelectionSwitchAnimation;

	private int _groupSelectionSwitchFromId;

	private int _groupSelectionSwitchToId;

	private int _lastGroupSwitchFrame = -1;

	private int _lastGroupSwitchTargetId;

	private bool _isFillingContentListAnimations;

	private CancellationTokenSource _contentListFillAnimationsCts;

	private CancellationTokenSource _tabSwitchAnimationsCts;

	private int _lastSelectedAchievementContentIndex = -1;

	private int _achievementContentFocusRequestId;

	private bool _skipNextToggleSwitchAnimation;

	private bool _isRightListTabSwitchAnimating;

	private int _queuedRightListSwitchGroupId;

	private int _requestedSelectedGroupId;

	private AchievementContentCell _openedRewardItemDetailCell;

	private IReadOnlyList<int> _currentAchievementContentIds = Array.Empty<int>();

	public Dictionary<AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType, ViewControlLayer> viewPortControlLayers => _viewPortControlLayer;

	public string SearchText => searchText;

	public bool IsSearching => _isSearching;

	public bool CanUseSearch
	{
		get
		{
			AccomplishmentDetailsViewInputController controller = GetController();
			if (controller == null)
			{
				return false;
			}
			return controller.ControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList;
		}
	}

	public int CurrSelectIndex => currSelectIndex;

	public int CurrentMainId => GetCurrentMainId();

	public int CurrSelectedGroupId { get; private set; }

	public bool inputTriggerInputField => _inputTriggerInputField;

	public bool rightCanScroll => _rightCanScroll;

	public bool IsFillingGroupListAnimations => _isFillingGroupListAnimations;

	public bool TryGetCurrentAchievementContentId(int index, out int contentId)
	{
		if (index >= 0 && index < _currentAchievementContentIds.Count)
		{
			contentId = _currentAchievementContentIds[index];
			return true;
		}
		contentId = 0;
		return false;
	}

	private IReadOnlyList<int> GetVisibleMainIds()
	{
		if (_model == null)
		{
			return null;
		}
		if (_isSearching && !string.IsNullOrEmpty(searchText))
		{
			_model.GetMatchSearchAchievementMainIds(searchText, out var result);
			return result;
		}
		return _model.OrderedMainIds;
	}

	private int GetMainIdByVisibleIndex(int visibleIndex)
	{
		IReadOnlyList<int> visibleMainIds = GetVisibleMainIds();
		if (visibleMainIds == null || visibleIndex < 0 || visibleIndex >= visibleMainIds.Count)
		{
			return 0;
		}
		return visibleMainIds[visibleIndex];
	}

	private int GetVisibleIndexByMainId(int mainId)
	{
		IReadOnlyList<int> visibleMainIds = GetVisibleMainIds();
		if (visibleMainIds == null)
		{
			return 0;
		}
		for (int i = 0; i < visibleMainIds.Count; i++)
		{
			if (visibleMainIds[i] == mainId)
			{
				return i;
			}
		}
		return 0;
	}

	private int GetCurrentMainId()
	{
		return GetMainIdByVisibleIndex(currSelectIndex);
	}

	private GameObject GetToggleByMainId(int mainId)
	{
		int num = mainId - 1;
		if (num < 0 || num >= toggles.Count)
		{
			return null;
		}
		return toggles[num];
	}

	private void ReorderTopTogglesByMainSort()
	{
		IReadOnlyList<int> readOnlyList = _model?.OrderedMainIds;
		if (toggles == null || toggles.Count == 0 || readOnlyList == null || readOnlyList.Count == 0)
		{
			return;
		}
		int num = int.MaxValue;
		for (int i = 0; i < toggles.Count; i++)
		{
			if (!(toggles[i] == null))
			{
				num = Mathf.Min(num, toggles[i].transform.GetSiblingIndex());
			}
		}
		if (num == int.MaxValue)
		{
			return;
		}
		int num2 = num;
		for (int j = 0; j < readOnlyList.Count; j++)
		{
			GameObject toggleByMainId = GetToggleByMainId(readOnlyList[j]);
			if (!(toggleByMainId == null))
			{
				toggleByMainId.transform.SetSiblingIndex(num2++);
			}
		}
	}

	private void SetSelectedTopToggleWithoutNotify(int mainId)
	{
		if (toggles == null)
		{
			return;
		}
		for (int i = 0; i < toggles.Count; i++)
		{
			GameObject gameObject = toggles[i];
			if (!(gameObject == null))
			{
				ActToggle component = gameObject.GetComponent<ActToggle>();
				if (component != null)
				{
					component.SetIsOnWithoutNotify(i + 1 == mainId);
				}
			}
		}
	}

	private static string GetMainTabRedDotPath(int mainId)
	{
		return mainId switch
		{
			1 => RedDotPathDefine.NewAccomplishmentTaskTab, 
			2 => RedDotPathDefine.NewAccomplishmentExploreTab, 
			3 => RedDotPathDefine.NewAccomplishmentBattleTab, 
			4 => RedDotPathDefine.NewAccomplishmentCultivateTab, 
			5 => RedDotPathDefine.NewAccomplishmentOtherTab, 
			_ => string.Empty, 
		};
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as MonoAccomplishmentDetailsViewData;
		_model = Model<AccomplishmentModel>.Interface;
		_skipNextToggleSwitchAnimation = true;
	}

	protected override void Init()
	{
		base.Init();
		InitGamepadPromptBindings();
		InitToggleGroupRedDot();
		ReorderTopTogglesByMainSort();
		_pendingGroupId = m_data?.GroupId ?? 0;
		if (noSearchResultRoot != null)
		{
			noSearchResultRoot.SetActive(value: false);
		}
		SetHasSearchResultUi(hasResult: true);
		if (_accomplishmentGroupLoop != null)
		{
			_accomplishmentGroupLoop.OnItemShow.RemoveListener(OnAccomplishmentGroupItemShow);
			_accomplishmentGroupLoop.OnItemShow.AddListener(OnAccomplishmentGroupItemShow);
		}
		if (_achievementContentLoop != null)
		{
			_achievementContentLoop.OnItemShow.RemoveListener(OnAchievementContentItemShow);
			_achievementContentLoop.OnItemShow.AddListener(OnAchievementContentItemShow);
		}
		if (m_data != null && m_data.TypeId != 0)
		{
			RefreshAccomplishmentGroupList(m_data.TypeId);
		}
		else
		{
			RefreshAccomplishmentGroupList(GetMainIdByVisibleIndex(0));
		}
		_skipNextToggleSwitchAnimation = false;
		RefreshBtnPrompt();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Achive/ChooseEntry");
	}

	private void OnAccomplishmentGroupItemShow(ILoopScrollDataSource src)
	{
		if (_isFillingGroupListAnimations && _groupListFillAnimationsCts != null && src is AchievementGroupCell achievementGroupCell)
		{
			achievementGroupCell.PlayGroupListFillAnimation((float)achievementGroupCell.index * 0.02f, _groupListFillAnimationsCts.Token);
		}
	}

	private void OnAchievementContentItemShow(ILoopScrollDataSource src)
	{
		if (src is AchievementContentCell achievementContentCell)
		{
			if (!_isFillingContentListAnimations || _contentListFillAnimationsCts == null)
			{
				achievementContentCell.SetShowAnimationFinalState();
				return;
			}
			int version = achievementContentCell.ResetShowAnimationState();
			PlayAchievementContentShowAnimationAfterLayoutAsync(achievementContentCell, version, _contentListFillAnimationsCts.Token).Forget();
		}
	}

	private async UniTaskVoid PlayAchievementContentShowAnimationAfterLayoutAsync(AchievementContentCell cell, int version, CancellationToken token)
	{
		try
		{
			await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token);
		}
		catch (OperationCanceledException)
		{
			if (cell != null)
			{
				cell.SetShowAnimationFinalStateIfCurrent(version);
			}
			return;
		}
		if (token.IsCancellationRequested || cell == null)
		{
			if (cell != null)
			{
				cell.SetShowAnimationFinalStateIfCurrent(version);
			}
		}
		else
		{
			cell.PlayShowAnimation((float)cell.index * 0.02f, token);
		}
	}

	public void BeginGroupSelectionSwitchAnimation(int fromGroupId, int toGroupId)
	{
		_isPlayingGroupSelectionSwitchAnimation = true;
		_groupSelectionSwitchFromId = fromGroupId;
		_groupSelectionSwitchToId = toGroupId;
	}

	public void EndGroupSelectionSwitchAnimation()
	{
		_isPlayingGroupSelectionSwitchAnimation = false;
		_groupSelectionSwitchFromId = 0;
		_groupSelectionSwitchToId = 0;
	}

	public bool TryGetGroupSelectionSwitchAnimation(out int fromGroupId, out int toGroupId)
	{
		fromGroupId = _groupSelectionSwitchFromId;
		toGroupId = _groupSelectionSwitchToId;
		return _isPlayingGroupSelectionSwitchAnimation;
	}

	public bool ShouldSkipGroupSwitchRefill(int targetGroupId)
	{
		int frameCount = Time.frameCount;
		if (_lastGroupSwitchFrame == frameCount && _lastGroupSwitchTargetId == targetGroupId)
		{
			return true;
		}
		_lastGroupSwitchFrame = frameCount;
		_lastGroupSwitchTargetId = targetGroupId;
		return false;
	}

	private void OnModelDataChanged(BaseEventContent obj)
	{
		RefreshAccomplishmentGroupListInternal(GetCurrentMainId(), playListFillAnimations: false);
	}

	private void InitToggleGroupRedDot()
	{
		for (int i = 0; i < toggleGroup.ToggleCount; i++)
		{
			int num = i + 1;
			string mainTabRedDotPath = GetMainTabRedDotPath(num);
			RedDotDisplayAction redDotDisplayAction = GetRedDotDisplayAction(num);
			if (!(mainTabRedDotPath != "") || !_toggleRedDotItems.TryGetValue(i, out var value))
			{
				continue;
			}
			foreach (RedDotItem item in value)
			{
				item.redDotType = RedDotType.Dot;
				item.fullPath = mainTabRedDotPath.Split("|").ToList();
				item.displayAction = redDotDisplayAction;
				item.BindTrieNode();
				item.UpdateDisplay();
			}
		}
	}

	private RedDotDisplayAction GetRedDotDisplayAction(int typeId)
	{
		return new AccomplishmentEntranceActive(typeId);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		(betterAnimation?.GetSequence("Show"))?.OnComplete((AnimationBuilder _) =>
		{
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AccomplishmentRefresh, OnModelDataChanged);
		inputField.onValueChanged.RemoveListener(OnInputFieldValueChanged);
		inputField.onValueChanged.AddListener(OnInputFieldValueChanged);
		searchBtn.SetBtnClick(SubmitCurrentSearch);
		clearInputFieldBtn.SetBtnClick(ClearInputFieldEvent);
	}

	private void SubmitCurrentSearch()
	{
		OnSearchSubmit(searchText);
	}

	private void OnInputFieldValueChanged(string arg0)
	{
		searchText = arg0;
	}

	private void ClearInputFieldEvent()
	{
		int currentMainId = GetCurrentMainId();
		ClearInputField();
		for (int i = 0; i < toggles.Count; i++)
		{
			GameObject gameObject = toggles[i];
			if (!gameObject.gameObject.activeInHierarchy)
			{
				gameObject.gameObject.SetActive(value: true);
			}
		}
		SetHasSearchResultUi(hasResult: true);
		RefreshAccomplishmentGroupList(currentMainId);
		RefreshBtnPrompt();
	}

	public void ClearSearchByGamepad()
	{
		if (_isSearching)
		{
			ClearInputFieldEvent();
		}
	}

	private void ClearInputField()
	{
		_isSearching = false;
		inputField.DeactivateInputField();
		inputField.interactable = true;
		inputField.text = string.Empty;
		searchText = string.Empty;
		preSearchText = string.Empty;
		clearInputFieldBtn.gameObject.SetActive(value: false);
		searchBtn.gameObject.SetActive(value: true);
		SetHasSearchResultUi(hasResult: true);
	}

	private void OnSearchSubmit(string result)
	{
		if (!CanUseSearch)
		{
			return;
		}
		if (string.IsNullOrEmpty(result))
		{
			GameUtility.OpenToolTip(2278);
			return;
		}
		_isSearching = true;
		inputField.interactable = false;
		switchPageUpPrompt?.SetVisible(vis: false);
		switchPageDownPrompt?.SetVisible(vis: false);
		triggerInputFieldPrompt?.SetVisible(vis: false);
		inputFieldSubmitPrompt?.SetVisible(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		clearInputFieldBtn.gameObject.SetActive(value: true);
		searchBtn.gameObject.SetActive(value: false);
		if (result != preSearchText)
		{
			preSearchText = result;
			_model.GetMatchSearchAchievementMainIds(result, out var result2);
			if (result2.Count == 0)
			{
				for (int i = 0; i < toggles.Count; i++)
				{
					toggles[i].gameObject.SetActive(value: false);
				}
				SetHasSearchResultUi(hasResult: false);
				UntriggerInputField();
				return;
			}
			SetHasSearchResultUi(hasResult: true);
			for (int j = 0; j < toggles.Count; j++)
			{
				int item = j + 1;
				toggles[j].gameObject.SetActive(result2.Contains(item));
			}
			RefreshAccomplishmentGroupList(result2[0]);
			RefreshBtnPrompt();
		}
		UntriggerInputField();
	}

	private void SetHasSearchResultUi(bool hasResult)
	{
		if (noSearchResultRoot != null)
		{
			noSearchResultRoot.SetActive(!hasResult);
		}
		if (_accomplishmentGroupLoop != null)
		{
			_accomplishmentGroupLoop.gameObject.SetActive(hasResult);
		}
		if (achievementContentLoopGO != null)
		{
			achievementContentLoopGO.SetActive(hasResult);
		}
		if (topAchievementGroupGO != null && !hasResult)
		{
			topAchievementGroupGO.SetActive(value: false);
		}
		if (!hasResult && noSearchResultText != null && !string.IsNullOrEmpty(searchText))
		{
			string text = ((searchText.Length > searchLengthLimit) ? (searchText.Substring(0, searchLengthLimit) + "...") : searchText);
			noSearchResultText.text = text;
		}
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_AccomplishmentRefresh, OnModelDataChanged);
		inputField?.onValueChanged.RemoveListener(OnInputFieldValueChanged);
		base.RemoveEventListener();
	}

	public void OnSelectToggle(int typeId)
	{
		if (_skipNextToggleSwitchAnimation)
		{
			_skipNextToggleSwitchAnimation = false;
			RefreshAccomplishmentGroupList(typeId);
		}
		else
		{
			OnSelectToggleWithTabAnimation(typeId).Forget();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Achive/Left_Click");
		}
	}

	private async UniTaskVoid OnSelectToggleWithTabAnimation(int typeId)
	{
		_ = 1;
		try
		{
			_queuedRightListSwitchGroupId = 0;
			_tabSwitchAnimationsCts?.Cancel();
			_tabSwitchAnimationsCts?.Dispose();
			_tabSwitchAnimationsCts = new CancellationTokenSource();
			CancellationToken token = _tabSwitchAnimationsCts.Token;
			await PlaySequenceAsync("TabHide", token);
			if (!token.IsCancellationRequested)
			{
				RefreshAccomplishmentGroupList(typeId);
				if (!token.IsCancellationRequested)
				{
					await PlaySequenceAsync("TabShow", token);
				}
			}
		}
		catch (OperationCanceledException)
		{
		}
	}

	public void RefreshAccomplishmentGroupList(int typeId)
	{
		RefreshAccomplishmentGroupListInternal(typeId, playListFillAnimations: true);
	}

	private void RefreshAccomplishmentGroupListInternal(int typeId, bool playListFillAnimations)
	{
		if (_model == null)
		{
			return;
		}
		int num = ((typeId != 0) ? typeId : GetMainIdByVisibleIndex(0));
		if (num != 0)
		{
			List<int> list = ((_isSearching && !string.IsNullOrEmpty(searchText)) ? _model.GetSearchFilteredGroupIdsForMain(num, searchText) : _model.GetGroupIdsForMain(num));
			int num2 = ResolveDefaultGroupId(list);
			currSelectIndex = GetVisibleIndexByMainId(num);
			SetSelectedTopToggleWithoutNotify(num);
			AchievementGroupCell.SetSelectedGroupForView(GetInstanceID(), num2);
			_groupListFillAnimationsCts?.Cancel();
			_groupListFillAnimationsCts?.Dispose();
			_groupListFillAnimationsCts = (playListFillAnimations ? new CancellationTokenSource() : null);
			_skipCancelGroupListFillAnimationsOnce = playListFillAnimations;
			_isFillingGroupListAnimations = playListFillAnimations;
			_accomplishmentGroupLoop.ClearCells();
			_accomplishmentGroupLoop.totalCount = list?.Count ?? 0;
			_accomplishmentGroupLoop.RefillCells();
			_isFillingGroupListAnimations = false;
			if (num2 != 0)
			{
				RefreshRightAchievementListInternal(num2, playListFillAnimations, playListFillAnimations);
			}
			else if (topAchievementGroupGO != null)
			{
				topAchievementGroupGO.SetActive(value: false);
			}
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad || MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse)
			{
				RefreshScrollViewSelection();
				RefreshBtnPrompt();
			}
		}
	}

	private int ResolveDefaultGroupId(List<int> groupIds)
	{
		if (groupIds == null || groupIds.Count == 0)
		{
			return 0;
		}
		if (_pendingGroupId != 0 && groupIds.Contains(_pendingGroupId))
		{
			int pendingGroupId = _pendingGroupId;
			_pendingGroupId = 0;
			return pendingGroupId;
		}
		if (CurrSelectedGroupId != 0 && groupIds.Contains(CurrSelectedGroupId))
		{
			return CurrSelectedGroupId;
		}
		_pendingGroupId = 0;
		return groupIds[0];
	}

	public void RefreshRightAchievementList(int groupId)
	{
		RefreshRightAchievementListInternal(groupId, playContentListAnimation: true, resetContentScroll: true);
	}

	private void RefreshRightAchievementListInternal(int groupId, bool playContentListAnimation, bool resetContentScroll)
	{
		if (_skipCancelGroupListFillAnimationsOnce)
		{
			_skipCancelGroupListFillAnimationsOnce = false;
		}
		else
		{
			_groupListFillAnimationsCts?.Cancel();
		}
		CurrSelectedGroupId = groupId;
		_requestedSelectedGroupId = groupId;
		RefreshTopAchievementGroup(groupId);
		ForceRebuildRightAchievementLayout();
		RefreshAccomplishmentList(groupId, playContentListAnimation, resetContentScroll);
		ForceRebuildRightAchievementLayout();
		if (resetContentScroll)
		{
			ResetAchievementContentScrollToTop();
		}
		RefreshAchievementContentScrollState();
		AccomplishmentDetailsViewInputController controller = GetController();
		if (controller == null || controller.ControllerType != AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList)
		{
			ChangeControllerType(AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList);
		}
	}

	public void RefreshRightAchievementListWithTabAnimation(int groupId)
	{
		if (groupId != 0)
		{
			_requestedSelectedGroupId = groupId;
			_queuedRightListSwitchGroupId = groupId;
			if (_isRightListTabSwitchAnimating)
			{
				_tabSwitchAnimationsCts?.Cancel();
			}
			else
			{
				RefreshRightAchievementListWithTabAnimationAsync().Forget();
			}
		}
	}

	private async UniTaskVoid RefreshRightAchievementListWithTabAnimationAsync()
	{
		_isRightListTabSwitchAnimating = true;
		try
		{
			while (_queuedRightListSwitchGroupId != 0)
			{
				int targetGroupId = _queuedRightListSwitchGroupId;
				_queuedRightListSwitchGroupId = 0;
				_tabSwitchAnimationsCts?.Cancel();
				_tabSwitchAnimationsCts?.Dispose();
				_tabSwitchAnimationsCts = new CancellationTokenSource();
				CancellationToken token = _tabSwitchAnimationsCts.Token;
				try
				{
					await PlaySequenceAsync("TabHide", token);
					if (token.IsCancellationRequested)
					{
						continue;
					}
					RefreshRightAchievementList(targetGroupId);
					if (!token.IsCancellationRequested)
					{
						await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token);
						if (!token.IsCancellationRequested)
						{
							RefreshAchievementContentScrollState();
							await PlaySequenceAsync("TabShow", token);
						}
					}
				}
				catch (OperationCanceledException)
				{
				}
			}
		}
		catch (OperationCanceledException)
		{
		}
		finally
		{
			_isRightListTabSwitchAnimating = false;
			_queuedRightListSwitchGroupId = 0;
		}
	}

	private UniTask PlaySequenceAsync(string sequenceName, CancellationToken token)
	{
		if (betterAnimation == null || string.IsNullOrEmpty(sequenceName))
		{
			return UniTask.CompletedTask;
		}
		if (token.IsCancellationRequested)
		{
			return UniTask.FromCanceled(token);
		}
		AnimationBuilder sequence = betterAnimation.GetSequence(sequenceName);
		if (sequence == null)
		{
			return UniTask.CompletedTask;
		}
		UniTaskCompletionSource tcs = new UniTaskCompletionSource();
		sequence.OnComplete((AnimationBuilder _) =>
		{
			tcs.TrySetResult();
		}).Play();
		if (token.CanBeCanceled)
		{
			token.Register(() =>
			{
				tcs.TrySetCanceled(token);
			});
		}
		return tcs.Task;
	}

	private void RefreshAccomplishmentList(int groupId, bool playShowAnimation = true, bool resetScroll = true)
	{
		List<int> list = ((_isSearching && !string.IsNullOrEmpty(searchText)) ? _model.GetSearchFilteredSortedContentIdsForGroup(groupId, searchText) : _model.GetSortedContentIdsForGroup(groupId));
		if (!resetScroll && TryRefreshAchievementContentInPlace(list))
		{
			return;
		}
		int startIndex = 0;
		float contentOffset = 0f;
		if (!resetScroll)
		{
			CaptureAchievementContentScroll(list, out startIndex, out contentOffset);
		}
		IReadOnlyList<int> currentAchievementContentIds;
		if (list == null)
		{
			IReadOnlyList<int> readOnlyList = Array.Empty<int>();
			currentAchievementContentIds = readOnlyList;
		}
		else
		{
			IReadOnlyList<int> readOnlyList = list;
			currentAchievementContentIds = readOnlyList;
		}
		_currentAchievementContentIds = currentAchievementContentIds;
		if (list == null || list.Count == 0)
		{
			_contentListFillAnimationsCts?.Cancel();
			_isFillingContentListAnimations = false;
			achievementContentLoopGO.SetActive(value: false);
			return;
		}
		achievementContentLoopGO.SetActive(value: true);
		_contentListFillAnimationsCts?.Cancel();
		_contentListFillAnimationsCts?.Dispose();
		_contentListFillAnimationsCts = (playShowAnimation ? new CancellationTokenSource() : null);
		_isFillingContentListAnimations = playShowAnimation;
		SetAchievementContentVerticalScrollEnabled(enabled: true);
		if (resetScroll)
		{
			ResetAchievementContentScrollToTop();
		}
		else
		{
			_achievementContentLoop.StopMovement();
		}
		_achievementContentLoop.ClearCells();
		_achievementContentLoop.totalCount = list.Count;
		if (resetScroll)
		{
			_achievementContentLoop.RefillCells();
		}
		else
		{
			_achievementContentLoop.RefillCells(startIndex, fillViewRect: false, contentOffset);
		}
		_isFillingContentListAnimations = false;
	}

	private bool TryRefreshAchievementContentInPlace(List<int> sortedIds)
	{
		if (sortedIds == null || sortedIds.Count == 0)
		{
			return false;
		}
		if (_achievementContentLoop == null || achievementContentLoopGO == null || !achievementContentLoopGO.activeInHierarchy)
		{
			return false;
		}
		if (_achievementContentLoop.totalCount != sortedIds.Count)
		{
			return false;
		}
		if (_achievementContentLoop.ItemIndexEnd <= _achievementContentLoop.ItemIndexStart)
		{
			return false;
		}
		if (!IsSameContentIdSequence(_currentAchievementContentIds, sortedIds))
		{
			return false;
		}
		_currentAchievementContentIds = sortedIds;
		_achievementContentLoop.RefreshCells();
		return true;
	}

	private void CaptureAchievementContentScroll(List<int> sortedIds, out int startIndex, out float contentOffset)
	{
		startIndex = 0;
		contentOffset = 0f;
		if (_achievementContentLoop == null || sortedIds == null || sortedIds.Count == 0 || _achievementContentLoop.totalCount <= 0)
		{
			return;
		}
		_achievementContentLoop.UpdateBounds();
		int firstItem = _achievementContentLoop.GetFirstItem(out contentOffset);
		int value = firstItem;
		if (TryGetCurrentAchievementContentId(firstItem, out var contentId))
		{
			for (int i = 0; i < sortedIds.Count; i++)
			{
				if (sortedIds[i] == contentId)
				{
					value = i;
					break;
				}
			}
		}
		startIndex = Mathf.Clamp(value, 0, sortedIds.Count - 1);
	}

	private static bool IsSameContentIdSequence(IReadOnlyList<int> current, List<int> next)
	{
		if (current == null || next == null || current.Count != next.Count)
		{
			return false;
		}
		for (int i = 0; i < next.Count; i++)
		{
			if (current[i] != next[i])
			{
				return false;
			}
		}
		return true;
	}

	private void RefreshTopAchievementGroup(int groupId)
	{
		if (!_model.TryGetGroupMilestoneCollectionId(groupId, out var collectionId) || collectionId.Length == 0)
		{
			topAchievementGroupGO.SetActive(value: false);
			return;
		}
		topAchievementGroupGO.SetActive(value: true);
		topAchievementGroupCell.Init(groupId, Station);
	}

	private void ForceRebuildRightAchievementLayout()
	{
		Canvas.ForceUpdateCanvases();
		RectTransform rectTransform = ((achievementContentLoopGO != null) ? (achievementContentLoopGO.transform.parent as RectTransform) : null);
		if (rectTransform != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
		}
		if (_achievementContentLoop != null && _achievementContentLoop.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(_achievementContentLoop.content);
		}
		Canvas.ForceUpdateCanvases();
	}

	private void ResetAchievementContentScrollToTop()
	{
		if (!(_achievementContentLoop == null) && !(_achievementContentLoop.content == null))
		{
			_achievementContentLoop.StopMovement();
			Vector2 anchoredPosition = _achievementContentLoop.content.anchoredPosition;
			anchoredPosition.y = 0f;
			_achievementContentLoop.content.anchoredPosition = anchoredPosition;
		}
	}

	private void RefreshAchievementContentScrollState()
	{
		if (_achievementContentLoop == null || _achievementContentLoop.content == null || _achievementContentLoop.viewport == null)
		{
			return;
		}
		bool flag = _achievementContentLoop.content.rect.height > _achievementContentLoop.viewport.rect.height + 0.01f;
		SetAchievementContentVerticalScrollEnabled(flag);
		if (!flag)
		{
			if (HasAchievementContentOutsideViewport())
			{
				SetAchievementContentVerticalScrollEnabled(enabled: true);
				return;
			}
			_rightStickInput = 0f;
			ResetAchievementContentScrollToTop();
		}
	}

	private bool HasAchievementContentOutsideViewport()
	{
		if (_achievementContentLoop == null || _achievementContentLoop.totalCount <= 0)
		{
			return false;
		}
		if (_achievementContentLoop.ItemIndexStart <= 0)
		{
			return _achievementContentLoop.ItemIndexEnd < _achievementContentLoop.totalCount;
		}
		return true;
	}

	private void SetAchievementContentVerticalScrollEnabled(bool enabled)
	{
		if (!(_achievementContentLoop == null) && _achievementContentLoop.vertical != enabled)
		{
			_achievementContentLoop.vertical = enabled;
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		AchievementGroupCell.ClearSelectedGroupForView(GetInstanceID());
		toggleGroup.SetAllToggleOff();
		if (_accomplishmentGroupLoop != null)
		{
			_accomplishmentGroupLoop.OnItemShow.RemoveListener(OnAccomplishmentGroupItemShow);
		}
		if (_achievementContentLoop != null)
		{
			_achievementContentLoop.OnItemShow.RemoveListener(OnAchievementContentItemShow);
		}
		_groupListFillAnimationsCts?.Cancel();
		_groupListFillAnimationsCts?.Dispose();
		_groupListFillAnimationsCts = null;
		_contentListFillAnimationsCts?.Cancel();
		_contentListFillAnimationsCts?.Dispose();
		_contentListFillAnimationsCts = null;
		_tabSwitchAnimationsCts?.Cancel();
		_tabSwitchAnimationsCts?.Dispose();
		_tabSwitchAnimationsCts = null;
		_isFillingGroupListAnimations = false;
		_isFillingContentListAnimations = false;
		_skipCancelGroupListFillAnimationsOnce = false;
		_skipNextToggleSwitchAnimation = false;
		if (toggles != null)
		{
			for (int i = 0; i < toggles.Count; i++)
			{
				if (toggles[i] != null)
				{
					toggles[i].gameObject.SetActive(value: true);
				}
			}
		}
		ClearInputField();
		if (noSearchResultRoot != null)
		{
			noSearchResultRoot.SetActive(value: false);
		}
		_isRightListTabSwitchAnimating = false;
		_queuedRightListSwitchGroupId = 0;
		_requestedSelectedGroupId = 0;
		_achievementContentFocusRequestId++;
		_openedRewardItemDetailCell = null;
		_currentAchievementContentIds = Array.Empty<int>();
		_gamepadPromptInited = false;
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		_tabSwitchAnimationsCts?.Cancel();
		_tabSwitchAnimationsCts?.Dispose();
		_tabSwitchAnimationsCts = null;
		(betterAnimation?.GetSequence("Hide"))?.OnComplete((AnimationBuilder _) =>
		{
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (UIController.State == UIState.Opened)
		{
			if (type == DeviceInputMode.Gamepad && _inputTriggerInputField)
			{
				inputField?.ActivateInputField();
			}
			if (!_inputTriggerInputField)
			{
				RefreshScrollViewSelection();
			}
			RefreshBtnPrompt();
		}
	}

	public void OnControllerActivate()
	{
		RestoreCurrentControllerSelection();
		ClearOpenedRewardItemDetailSelection();
		RefreshBtnPrompt();
	}

	private void ClearOpenedRewardItemDetailSelection()
	{
		_openedRewardItemDetailCell?.ClearRewardItemGamepadSelection();
		_openedRewardItemDetailCell = null;
	}

	public void SelectTab(int index)
	{
		int mainIdByVisibleIndex = GetMainIdByVisibleIndex(index);
		if (mainIdByVisibleIndex == 0 || currSelectIndex == index)
		{
			return;
		}
		ActToggle actToggle = GetToggleByMainId(mainIdByVisibleIndex)?.GetComponent<ActToggle>();
		if (actToggle != null)
		{
			if (!actToggle.IsOn)
			{
				actToggle.SetIsOn(val: true);
			}
			else
			{
				OnSelectToggle(mainIdByVisibleIndex);
			}
		}
		else
		{
			OnSelectToggle(mainIdByVisibleIndex);
		}
	}

	public void InputTriggerInputField()
	{
		if (CanUseSearch && !_isSearching && !_inputTriggerInputField && !inputField.isFocused)
		{
			switchPageUpPrompt?.SetVisible(vis: false);
			switchPageDownPrompt?.SetVisible(vis: false);
			triggerInputFieldPrompt?.SetVisible(vis: false);
			inputFieldSubmitPrompt?.SetVisible(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
			operateBtnPromptA?.SetVisible(vis: false);
			((IOperatePromptIconCollectionProvider)this).UnInitCollection();
			_inputTriggerInputField = true;
			_rightCanScroll = false;
			HideGroupCellGamepadStates();
			inputField.ActivateInputField();
			inputField.Select();
			inputField.MoveTextEnd(shift: false);
		}
	}

	public void UntriggerInputField()
	{
		if (!_inputTriggerInputField)
		{
			inputField.DeactivateInputField();
			return;
		}
		_inputTriggerInputField = false;
		inputField.DeactivateInputField();
		RefreshScrollViewSelection();
		((IOperatePromptIconCollectionProvider)this).InitCollection();
		RefreshBtnPrompt();
	}

	public void OnButtonNorthClick()
	{
		if (CanUseSearch && (_inputTriggerInputField || _isSearching))
		{
			if (_isSearching)
			{
				ClearInputFieldEvent();
			}
			else
			{
				OnSearchSubmit(searchText);
			}
		}
	}

	public bool NavigateSelectedGroup(MoveDirection direction)
	{
		if (direction != MoveDirection.Up && direction != MoveDirection.Down)
		{
			return false;
		}
		if (_model == null || _accomplishmentGroupLoop == null)
		{
			return false;
		}
		int currentMainId = GetCurrentMainId();
		if (currentMainId == 0)
		{
			return false;
		}
		List<int> list = ((_isSearching && !string.IsNullOrEmpty(searchText)) ? _model.GetSearchFilteredGroupIdsForMain(currentMainId, searchText) : _model.GetGroupIdsForMain(currentMainId));
		if (list == null || list.Count == 0)
		{
			return false;
		}
		int num = ((_requestedSelectedGroupId != 0) ? _requestedSelectedGroupId : CurrSelectedGroupId);
		int num2 = list.IndexOf(num);
		if (num2 < 0)
		{
			num2 = 0;
		}
		int num3 = ((direction == MoveDirection.Up) ? Mathf.Max(0, num2 - 1) : Mathf.Min(list.Count - 1, num2 + 1));
		if (num3 == num2)
		{
			return true;
		}
		int num4 = num;
		int num5 = (_requestedSelectedGroupId = list[num3]);
		AchievementGroupCell.SetSelectedGroupForView(GetInstanceID(), num5);
		BeginGroupSelectionSwitchAnimation(num4, num5);
		RefreshRightAchievementListWithTabAnimation(num5);
		RefreshGroupSelectionCellStates(num4, num5);
		EndGroupSelectionSwitchAnimation();
		SyncGroupListButtonSelection(num3);
		return true;
	}

	public bool MoveAchievementContentSelection(MoveDirection direction)
	{
		if (direction != MoveDirection.Up && direction != MoveDirection.Down)
		{
			return false;
		}
		if (_achievementContentLoop == null || _achievementContentLoop.totalCount <= 0)
		{
			return false;
		}
		int num = GetSelectedAchievementContentCell()?.index ?? _lastSelectedAchievementContentIndex;
		if (num < 0)
		{
			num = 0;
		}
		int index = ((direction == MoveDirection.Up) ? Mathf.Max(0, num - 1) : Mathf.Min(_achievementContentLoop.totalCount - 1, num + 1));
		SelectAchievementContentAtIndex(index);
		return true;
	}

	public void OnSelectItemCell()
	{
		AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType? accomplishmentDetailsViewControllerType = GetController()?.ControllerType;
		if (accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroup || accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroupItem)
		{
			if (topAchievementGroupCell != null && topAchievementGroupCell.OpenRewardItemDetail() && accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroup)
			{
				ChangeControllerType(AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroupItem);
			}
		}
		else if (accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.AchieveContentList)
		{
			AchievementContentCell selectedAchievementContentCell = GetSelectedAchievementContentCell();
			RememberSelectedAchievementContentCell(selectedAchievementContentCell);
			if (selectedAchievementContentCell != null && selectedAchievementContentCell.OpenRewardItemDetail())
			{
				_openedRewardItemDetailCell = selectedAchievementContentCell;
			}
		}
	}

	public bool TryClaimSelectedAchievementContentReward()
	{
		AchievementContentCell selectedAchievementContentCell = GetSelectedAchievementContentCell();
		int num;
		if ((object)selectedAchievementContentCell == null)
		{
			num = 0;
		}
		else
		{
			num = (selectedAchievementContentCell.TryClaimReward() ? 1 : 0);
			if (num != 0)
			{
				RefreshGamepadCellStates();
				RefreshBtnPrompt();
			}
		}
		return (byte)num != 0;
	}

	public void RefreshGamepadCellStates()
	{
		RefreshGroupCellGamepadStates();
		topAchievementGroupCell?.RefreshGamepadInputState(this);
		if (_achievementContentLoop == null)
		{
			return;
		}
		for (int i = _achievementContentLoop.ItemIndexStart; i < _achievementContentLoop.ItemIndexEnd; i++)
		{
			if (_achievementContentLoop.GetItem(i) is AchievementContentCell achievementContentCell)
			{
				achievementContentCell.RefreshGamepadInputState(this);
			}
		}
	}

	private AchievementContentCell GetSelectedAchievementContentCell()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected != null))
		{
			return null;
		}
		return currentSelected.GetComponentInParent<AchievementContentCell>(includeInactive: true);
	}

	private void RememberSelectedAchievementContentCell(AchievementContentCell cell)
	{
		if (!(cell == null))
		{
			_lastSelectedAchievementContentIndex = cell.index;
		}
	}

	private void SelectAchievementContentAtIndex(int index)
	{
		if (!(_achievementContentLoop == null) && _achievementContentLoop.totalCount > 0)
		{
			index = Mathf.Clamp(index, 0, _achievementContentLoop.totalCount - 1);
			_lastSelectedAchievementContentIndex = index;
			int focusRequestId = ++_achievementContentFocusRequestId;
			if (!IsAchievementContentIndexInVisibleWindow(index) || GetAchievementContentSelectable(index) == null)
			{
				_achievementContentLoop.ScrollToCell(index, 0f);
			}
			if (!TrySelectVisibleAchievementContent(index, clearSelectionWhenInvisible: false))
			{
				SelectAchievementContentAfterScrollAsync(index, focusRequestId).Forget();
			}
		}
	}

	private bool IsAchievementContentIndexInVisibleWindow(int index)
	{
		if (_achievementContentLoop == null || _achievementContentLoop.totalCount <= 0)
		{
			return true;
		}
		if (index >= _achievementContentLoop.ItemIndexStart)
		{
			return index < _achievementContentLoop.ItemIndexEnd;
		}
		return false;
	}

	private async UniTaskVoid SelectAchievementContentAfterScrollAsync(int index, int focusRequestId)
	{
		for (int i = 0; i < 30; i++)
		{
			await UniTask.Yield();
			if (_achievementContentLoop == null || focusRequestId != _achievementContentFocusRequestId || TrySelectVisibleAchievementContent(index, clearSelectionWhenInvisible: false))
			{
				break;
			}
		}
	}

	private bool TrySelectVisibleAchievementContent(int index, bool clearSelectionWhenInvisible)
	{
		ACT.ViewControl.SelectableEx achievementContentSelectable = GetAchievementContentSelectable(index);
		if (achievementContentSelectable == null)
		{
			if (clearSelectionWhenInvisible)
			{
				EventSystemHelper.SetSelectedGameObject(null);
				RefreshGamepadCellStates();
				RefreshBtnPrompt();
			}
			return false;
		}
		EventSystemHelper.SetSelectedGameObject(achievementContentSelectable.gameObject);
		ViewControlLayer viewControlLayer = GetViewControlLayer(AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.AchieveContentList);
		if (viewControlLayer != null)
		{
			viewControlLayer.DefaultSelect = achievementContentSelectable;
		}
		RefreshGamepadCellStates();
		RefreshBtnPrompt();
		return true;
	}

	public void OnRightStickScroll(Vector2 value)
	{
		_rightStickInput = (_rightCanScroll ? value.y : 0f);
	}

	private void Update()
	{
		ExecuteRightStickScroll();
	}

	private void ExecuteRightStickScroll()
	{
		if (_rightCanScroll && !(_achievementContentLoop == null) && !Mathf.Approximately(_rightStickInput, 0f))
		{
			float verticalNormalizedPosition = _achievementContentLoop.verticalNormalizedPosition;
			verticalNormalizedPosition += _rightStickInput * scrollSpeed * Time.unscaledDeltaTime;
			_achievementContentLoop.verticalNormalizedPosition = Mathf.Clamp01(verticalNormalizedPosition);
		}
	}

	public void RefreshBtnPrompt()
	{
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		int activeToggleCount = toggleGroup.GetActiveToggleCount();
		bool canUseSearch = CanUseSearch;
		prompBoard?.SetActive(flag);
		switchPageUpPrompt?.SetVisible(flag && !_inputTriggerInputField && activeToggleCount > 1);
		switchPageDownPrompt?.SetVisible(flag && !_inputTriggerInputField && activeToggleCount > 1);
		triggerInputFieldPrompt?.SetVisible((flag & canUseSearch) && !_inputTriggerInputField && !_isSearching);
		inputFieldSubmitPrompt?.SetVisible((flag & canUseSearch) && (_inputTriggerInputField || _isSearching));
		bool flag2 = flag;
		RefreshOperateBtnPromptA(flag2);
		operateBtnPromptB?.SetVisible(flag2);
		if (flag2)
		{
			operateBtnPromptB?.RefreshIcon();
		}
		RefreshGamepadCellStates();
	}

	public void RefreshScrollViewSelection()
	{
		AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType? accomplishmentDetailsViewControllerType = GetController()?.ControllerType;
		if (accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroup)
		{
			if (topAchievementGroupCell == null || !topAchievementGroupCell.IsRewardItemHighlighted)
			{
				FocusTopGroupWithoutSelectingItem();
			}
			return;
		}
		if (accomplishmentDetailsViewControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroupItem)
		{
			if (topAchievementGroupCell == null || !topAchievementGroupCell.IsRewardItemHighlighted)
			{
				topAchievementGroupCell?.SelectRewardItem();
			}
			return;
		}
		GetCurSelectCell(CurrSelectedGroupId);
		ViewControlLayer currentViewControlLayer = GetCurrentViewControlLayer();
		if (currentViewControlLayer != null)
		{
			AccomplishmentDetailsViewInputController controller = GetController();
			if (controller != null && controller.ControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList)
			{
				currentViewControlLayer.DefaultSelect = _curSelectCell?.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
				currentViewControlLayer.UnFocus();
			}
		}
		ViewControlRoot viewControlRoot = viewPortControlRoot;
		if ((object)viewControlRoot != null && !viewControlRoot.ReFocus())
		{
			currentViewControlLayer?.Focus();
		}
	}

	private AchievementGroupCell GetCurSelectCell(int groupId)
	{
		if (groupId == 0 || _model == null)
		{
			SetCurSelectCell(null);
			return null;
		}
		int currentMainId = GetCurrentMainId();
		if (currentMainId == 0)
		{
			SetCurSelectCell(null);
			return null;
		}
		int num = ((_isSearching && !string.IsNullOrEmpty(searchText)) ? _model.GetSearchFilteredGroupIdsForMain(currentMainId, searchText) : _model.GetGroupIdsForMain(currentMainId))?.IndexOf(groupId) ?? (-1);
		AchievementGroupCell achievementGroupCell = ((num >= 0) ? (_accomplishmentGroupLoop.GetItem(num) as AchievementGroupCell) : null);
		SetCurSelectCell(achievementGroupCell);
		return achievementGroupCell;
	}

	public void RefreshGroupSelectionCellStates(int previousGroupId, int selectedGroupId)
	{
		RefreshGroupSelectionCellState(previousGroupId);
		if (previousGroupId != selectedGroupId)
		{
			RefreshGroupSelectionCellState(selectedGroupId);
		}
	}

	private void RefreshGroupSelectionCellState(int groupId)
	{
		if (groupId == 0 || _model == null || _accomplishmentGroupLoop == null)
		{
			return;
		}
		int currentMainId = GetCurrentMainId();
		if (currentMainId != 0)
		{
			int num = ((_isSearching && !string.IsNullOrEmpty(searchText)) ? _model.GetSearchFilteredGroupIdsForMain(currentMainId, searchText) : _model.GetGroupIdsForMain(currentMainId))?.IndexOf(groupId) ?? (-1);
			if (num >= 0 && _accomplishmentGroupLoop.GetItem(num) is AchievementGroupCell achievementGroupCell)
			{
				achievementGroupCell.RefreshSelectStateForGroupSwitch();
			}
		}
	}

	public void SetCurSelectCell(AchievementGroupCell cell)
	{
		_curSelectCell = cell;
	}

	private void SyncGroupListButtonSelection(int groupIndex)
	{
		if (groupIndex < 0 || _accomplishmentGroupLoop == null || !EventSystemHelper.Available)
		{
			return;
		}
		AccomplishmentDetailsViewInputController controller = GetController();
		if (controller == null || controller.ControllerType != AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList)
		{
			return;
		}
		AchievementGroupCell achievementGroupCell = _accomplishmentGroupLoop.GetItem(groupIndex) as AchievementGroupCell;
		if (achievementGroupCell == null)
		{
			_accomplishmentGroupLoop.ScrollToCell(groupIndex, 0f);
			achievementGroupCell = _accomplishmentGroupLoop.GetItem(groupIndex) as AchievementGroupCell;
		}
		if (achievementGroupCell == null)
		{
			return;
		}
		ACT.ViewControl.SelectableEx componentInChildren = achievementGroupCell.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
		if (!(componentInChildren == null))
		{
			ViewControlLayer viewControlLayer = GetViewControlLayer(AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList);
			if (viewControlLayer != null)
			{
				viewControlLayer.DefaultSelect = componentInChildren;
			}
			if (EventSystemHelper.CurrentSelected != componentInChildren.gameObject)
			{
				EventSystemHelper.SetSelectedGameObject(componentInChildren.gameObject);
			}
		}
	}

	public void ChangeControllerType(AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType controllerType)
	{
		if ((controllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroup || controllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroupItem) && !HasCurrentTopGroupReward())
		{
			controllerType = AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList;
		}
		if (GetController()?.ControllerType != AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.AchieveContentList && controllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.AchieveContentList)
		{
			_lastSelectedAchievementContentIndex = -1;
		}
		if (controllerType != AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList && _inputTriggerInputField)
		{
			_inputTriggerInputField = false;
			inputField?.DeactivateInputField();
		}
		GetController()?.ChangeControllerType(controllerType);
		ViewControlLayer viewControlLayer = GetViewControlLayer(controllerType);
		switch (controllerType)
		{
		case AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroup:
			FocusTopGroupWithoutSelectingItem();
			break;
		case AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroupItem:
			FocusTopGroupItem();
			break;
		default:
			if (viewControlLayer != null)
			{
				PrepareDefaultSelect(controllerType, viewControlLayer);
				viewControlLayer.Focus();
			}
			break;
		}
		RefreshBtnPrompt();
	}

	private void RestoreCurrentControllerSelection()
	{
		AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType accomplishmentDetailsViewControllerType = GetController()?.ControllerType ?? AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList;
		switch (accomplishmentDetailsViewControllerType)
		{
		case AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroup:
			FocusTopGroupWithoutSelectingItem();
			return;
		case AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroupItem:
			FocusTopGroupItem();
			return;
		}
		ViewControlLayer viewControlLayer = GetViewControlLayer(accomplishmentDetailsViewControllerType);
		if (!(viewControlLayer == null))
		{
			PrepareDefaultSelect(accomplishmentDetailsViewControllerType, viewControlLayer);
			viewControlLayer.Focus();
		}
	}

	private void FocusTopGroupWithoutSelectingItem()
	{
		ViewControlLayer viewControlLayer = GetViewControlLayer(AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.TopAchieveGroup);
		if (viewControlLayer != null)
		{
			viewControlLayer.DefaultSelect = null;
			viewControlLayer.UnFocus();
			viewControlLayer.Focus(autoFindSelectable: false);
		}
		topAchievementGroupCell?.ClearRewardItemSelection();
	}

	private void FocusTopGroupItem()
	{
		topAchievementGroupCell?.SelectRewardItem();
	}

	private void PrepareDefaultSelect(AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType controllerType, ViewControlLayer layer)
	{
		if (!(layer == null) && controllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.AchieveContentList)
		{
			layer.DefaultSelect = GetAchievementContentSelectable(_lastSelectedAchievementContentIndex) ?? GetFirstAchievementContentSelectable();
		}
	}

	private void RefreshGroupCellGamepadStates()
	{
		if (_accomplishmentGroupLoop == null)
		{
			return;
		}
		for (int i = _accomplishmentGroupLoop.ItemIndexStart; i < _accomplishmentGroupLoop.ItemIndexEnd; i++)
		{
			if (_accomplishmentGroupLoop.GetItem(i) is AchievementGroupCell achievementGroupCell)
			{
				achievementGroupCell.RefreshGamepadInputState(this);
			}
		}
	}

	private void HideGroupCellGamepadStates()
	{
		if (_accomplishmentGroupLoop == null)
		{
			return;
		}
		for (int i = _accomplishmentGroupLoop.ItemIndexStart; i < _accomplishmentGroupLoop.ItemIndexEnd; i++)
		{
			if (_accomplishmentGroupLoop.GetItem(i) is AchievementGroupCell achievementGroupCell)
			{
				achievementGroupCell.HideGamepadSelectState();
			}
		}
	}

	private ACT.ViewControl.SelectableEx GetFirstAchievementContentSelectable()
	{
		return GetAchievementContentSelectable(0);
	}

	private ACT.ViewControl.SelectableEx GetAchievementContentSelectable(int index)
	{
		if (_achievementContentLoop == null || _achievementContentLoop.totalCount <= 0)
		{
			return null;
		}
		if (index < 0 || index >= _achievementContentLoop.totalCount)
		{
			return null;
		}
		AchievementContentCell achievementContentCell = _achievementContentLoop.GetItem(index) as AchievementContentCell;
		if (!(achievementContentCell != null))
		{
			return null;
		}
		return achievementContentCell.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	public bool HasCurrentTopGroupReward()
	{
		if (topAchievementGroupGO != null)
		{
			return topAchievementGroupGO.activeSelf;
		}
		return false;
	}

	private ViewControlLayer GetCurrentViewControlLayer()
	{
		AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType controllerType = GetController()?.ControllerType ?? AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList;
		return GetViewControlLayer(controllerType);
	}

	private ViewControlLayer GetViewControlLayer(AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType controllerType)
	{
		if (viewPortControlLayers != null && viewPortControlLayers.TryGetValue(controllerType, out var value))
		{
			return value;
		}
		return null;
	}

	private void InitGamepadPromptBindings()
	{
		if (!_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			operateBtnPromptA?.SetBindingAction("UI/Confirm");
			operateBtnPromptA?.SetLocalizeString(774);
			operateBtnPromptB?.SetBindingAction("UI/Back");
			operateBtnPromptB?.SetLocalizeString(606);
		}
	}

	private void RefreshOperateBtnPromptA(bool showCommonPrompts)
	{
		int num;
		if (showCommonPrompts && !_inputTriggerInputField)
		{
			AccomplishmentDetailsViewInputController controller = GetController();
			num = ((controller != null && controller.ControllerType == AccomplishmentDetailsViewInputController.AccomplishmentDetailsViewControllerType.SecondAchieveGroupList) ? 1 : 0);
		}
		else
		{
			num = 0;
		}
		bool flag = (byte)num != 0;
		operateBtnPromptA?.SetVisible(flag);
		if (flag)
		{
			operateBtnPromptA?.RefreshIcon();
		}
	}
}
