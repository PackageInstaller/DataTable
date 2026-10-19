using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.UI.Interface;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class TeamTeachingView : BaseUIView<TeamTeachingViewInputController>
{
	private enum TeamChallengeSortGroup
	{
		NotCleared,
		PartialCleared,
		FullyCleared,
		Locked
	}

	[Header("First-level tabs")]
	[SerializeField]
	private CommonTabListComponent _mainTabList;

	[SerializeField]
	private TeamTeachingTab _mainTabTemplate;

	[SerializeField]
	private RectTransform _mainTabRoot;

	[SerializeField]
	private RectTransform _previousMainTabPrompt;

	[SerializeField]
	private RectTransform _nextMainTabPrompt;

	[Header("Content groups")]
	[SerializeField]
	private GameObject _singleTrainingGroup;

	[SerializeField]
	private GameObject _teamTrainingGroup;

	[SerializeField]
	private LoopScrollRect _singleTrainingScrollRect;

	[SerializeField]
	private LoopScrollRect _teamTrainingScrollRect;

	[Header("Right-side presentation")]
	[SerializeField]
	private SingleTrainingContentView _singleTrainingContentView;

	[SerializeField]
	private TeamTrainingContentView _teamTrainingContentView;

	[SerializeField]
	private ActButton _closeBtn;

	[SerializeField]
	private GamePadTipsComp _gamePadTipsComp;

	public Dictionary<TeamTeachingSubControllerType, ViewControlLayer> ViewControlLayers;

	[OdinSerialize]
	public Dictionary<TeamTeachingSubControllerType, List<GameObject>> ViewControlPrompt;

	[SerializeField]
	private GameObject _singleTrainingSelectRewardPrompt;

	[SerializeField]
	private GameObject _teamTrainingSelectRewardPrompt;

	private readonly List<SimulateTraining> _mainConfigs = new List<SimulateTraining>();

	private readonly List<TeamTeachingTab> _runtimeTabs = new List<TeamTeachingTab>();

	private readonly List<CharacterTutorialRaidInfo> _characterTutorials = new List<CharacterTutorialRaidInfo>();

	private readonly List<TrainingContents> _teamChallenges = new List<TrainingContents>();

	private readonly List<int> _teamTargetIdsBuffer = new List<int>();

	private readonly UnityAction<ILoopScrollDataSource> _singleItemShowAction;

	private readonly UnityAction<ILoopScrollDataSource> _teamItemShowAction;

	private readonly Action<TrainingItem> _trainingItemSelectedAction;

	private readonly Action<int> _teamItemSelectedAction;

	private SimulateTraining _activeMainConfig;

	private TrainingContents _selectedChallenge;

	private CharacterTutorialRaidInfo _selectedTutorial;

	private bool _isFreeTrainingSelected = true;

	private int _challengeTime = -1;

	private int _challengeTimeContentId;

	private TeamTeachingSubControllerType _subControllerType = TeamTeachingSubControllerType.SingleTrainingList;

	private readonly Dictionary<TeamTeachingSubControllerType, UnityAction<bool>> _focusChangedActions = new Dictionary<TeamTeachingSubControllerType, UnityAction<bool>>();

	private readonly List<GamePadTipsAction> _gamePadTipsActions = new List<GamePadTipsAction>();

	public bool IsGamePadListState => IsListState(_subControllerType);

	public event Action<TrainingContents> OnTeamDetailRequested;

	public TeamTeachingView()
	{
		_singleItemShowAction = OnSingleItemShow;
		_teamItemShowAction = OnTeamItemShow;
		_trainingItemSelectedAction = OnTrainingItemSelected;
		_teamItemSelectedAction = OnTeamItemSelected;
	}

	protected override void Init()
	{
		base.Init();
		BindGamePadControlLayers();
		TeamTeachingViewData teamTeachingViewData = uiViewData as TeamTeachingViewData;
		_challengeTime = teamTeachingViewData?.ChallengeTime ?? (-1);
		_challengeTimeContentId = teamTeachingViewData?.TrainingContentId ?? 0;
		BuildMainTabs();
		BindButtons();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/CharacterTraining/Open");
	}

	protected override void UnInit()
	{
		if (_mainTabList != null)
		{
			CommonTabListComponent mainTabList = _mainTabList;
			mainTabList.OnTabActive = (Action<ITabItem>)Delegate.Remove(mainTabList.OnTabActive, new Action<ITabItem>(OnMainTabActive));
		}
		if (_singleTrainingScrollRect != null)
		{
			_singleTrainingScrollRect.OnItemShow.RemoveListener(_singleItemShowAction);
		}
		if (_teamTrainingScrollRect != null)
		{
			_teamTrainingScrollRect.OnItemShow.RemoveListener(_teamItemShowAction);
		}
		UnbindGamePadControlLayers();
		HideAllViewControlPrompts();
		_gamePadTipsComp?.ClearAllPrompts();
		base.UnInit();
	}

	private void BuildMainTabs()
	{
		if (_mainTabList == null || _mainTabTemplate == null || _mainTabRoot == null || _mainTabList.Group == null)
		{
			Debug.LogError("[TeamTeaching] Assign TabList, its ActToggleGroup, TeamTeachingTab template, and TabList/Viewport/Content as Main Tab Root.", this);
			return;
		}
		_mainTabList.Initialize(_mainTabRoot, null, _mainTabList.Group);
		CommonTabListComponent mainTabList = _mainTabList;
		mainTabList.OnTabActive = (Action<ITabItem>)Delegate.Remove(mainTabList.OnTabActive, new Action<ITabItem>(OnMainTabActive));
		CommonTabListComponent mainTabList2 = _mainTabList;
		mainTabList2.OnTabActive = (Action<ITabItem>)Delegate.Combine(mainTabList2.OnTabActive, new Action<ITabItem>(OnMainTabActive));
		_mainTabList.TabItems.Clear();
		foreach (TeamTeachingTab runtimeTab in _runtimeTabs)
		{
			if (runtimeTab != null)
			{
				UnityEngine.Object.Destroy(runtimeTab.gameObject);
			}
		}
		_runtimeTabs.Clear();
		_mainConfigs.Clear();
		Dictionary<int, SimulateTraining> dictionary = RuntimeConfigs.data?.simulateTrainings;
		if (dictionary == null)
		{
			Debug.LogError("[TeamTeaching] simulateTraining configuration is not loaded.", this);
			if (_singleTrainingGroup != null)
			{
				_singleTrainingGroup.SetActive(value: false);
			}
			if (_teamTrainingGroup != null)
			{
				_teamTrainingGroup.SetActive(value: false);
			}
			return;
		}
		_mainConfigs.AddRange(dictionary.Values);
		_mainConfigs.Sort((SimulateTraining l, SimulateTraining r) => CompareSort(l.sort, l.id, r.sort, r.id));
		_mainTabTemplate.gameObject.SetActive(value: false);
		foreach (SimulateTraining config in _mainConfigs)
		{
			TeamTeachingTab teamTeachingTab = UnityEngine.Object.Instantiate(_mainTabTemplate, _mainTabRoot);
			teamTeachingTab.name = $"TeamTeachingTab_{config.id}";
			teamTeachingTab.Bind(config, () => IsMainTabUnlocked(config));
			teamTeachingTab.gameObject.SetActive(value: true);
			_runtimeTabs.Add(teamTeachingTab);
			_mainTabList.TabItems.Add(teamTeachingTab);
		}
		RefreshMainTabSiblingOrder();
		TeamTeachingTab defaultMainTab = GetDefaultMainTab((uiViewData as TeamTeachingViewData)?.MainTabId ?? 0);
		if (defaultMainTab != null)
		{
			_mainTabList.ActiveTab = defaultMainTab;
		}
	}

	private TeamTeachingTab GetDefaultMainTab(int requestedTabId)
	{
		TeamTeachingTab teamTeachingTab = null;
		for (int i = 0; i < _runtimeTabs.Count; i++)
		{
			TeamTeachingTab teamTeachingTab2 = _runtimeTabs[i];
			if (teamTeachingTab2?.Data != null && IsMainTabUnlocked(teamTeachingTab2.Data))
			{
				if ((object)teamTeachingTab == null)
				{
					teamTeachingTab = teamTeachingTab2;
				}
				if (teamTeachingTab2.Data.id == requestedTabId)
				{
					return teamTeachingTab2;
				}
			}
		}
		return teamTeachingTab;
	}

	private void RefreshMainTabSiblingOrder()
	{
		if (_previousMainTabPrompt != null && _previousMainTabPrompt.parent == _mainTabRoot)
		{
			_previousMainTabPrompt.SetAsFirstSibling();
		}
		if (_nextMainTabPrompt != null && _nextMainTabPrompt.parent == _mainTabRoot)
		{
			_nextMainTabPrompt.SetAsLastSibling();
		}
	}

	private void OnMainTabActive(ITabItem tab)
	{
		TeamTeachingTab mainTab = tab as TeamTeachingTab;
		if ((object)mainTab == null)
		{
			return;
		}
		if (_activeMainConfig == null)
		{
			RefreshMainTabContent(mainTab);
			return;
		}
		AnimationBuilder animationBuilder = betterAnimation?.GetSequence("SwithHide");
		if (animationBuilder == null)
		{
			RefreshMainTabContent(mainTab);
			PlayMainTabShowAnimation();
			return;
		}
		animationBuilder.OnComplete((AnimationBuilder _) =>
		{
			RefreshMainTabContent(mainTab);
			PlayMainTabShowAnimation();
		}).Play();
	}

	private void RefreshMainTabContent(TeamTeachingTab mainTab)
	{
		_activeMainConfig = mainTab.Data;
		bool flag = _mainConfigs.Count > 0 && _activeMainConfig.id == _mainConfigs[0].id;
		if (_singleTrainingGroup != null)
		{
			_singleTrainingGroup.SetActive(flag);
		}
		if (_teamTrainingGroup != null)
		{
			_teamTrainingGroup.SetActive(!flag);
		}
		if (flag)
		{
			RefreshSingleTraining();
			ChangeToGamePadInputState(TeamTeachingSubControllerType.SingleTrainingList);
		}
		else
		{
			RefreshTeamTraining(_activeMainConfig);
			ChangeToGamePadInputState(TeamTeachingSubControllerType.TeamTrainingList);
		}
	}

	private void PlayMainTabShowAnimation()
	{
		PlayTrainingItemAnimation(show: true);
		PlayTeamTrainingItemSwitchShowAnimation();
		betterAnimation?.GetSequence("SwithShow")?.Play();
	}

	private void RefreshSingleTraining()
	{
		if (_singleTrainingScrollRect == null)
		{
			return;
		}
		_isFreeTrainingSelected = true;
		_selectedTutorial = null;
		_characterTutorials.Clear();
		foreach (Character bagCharacter in CharacterDataHelper.GetBagCharacters())
		{
			CharacterTutorialRaidInfo characterTutorialRaidInfoByCharacterId = Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(bagCharacter.Id);
			if (characterTutorialRaidInfoByCharacterId != null)
			{
				_characterTutorials.Add(characterTutorialRaidInfoByCharacterId);
			}
		}
		_characterTutorials.Sort((CharacterTutorialRaidInfo l, CharacterTutorialRaidInfo r) =>
		{
			bool flag = IsRaidCompleted(l.RaidId);
			bool flag2 = IsRaidCompleted(r.RaidId);
			return (flag != flag2) ? (flag ? 1 : (-1)) : l.RaidEnterId.CompareTo(r.RaidEnterId);
		});
		_singleTrainingScrollRect.ClearCellsPool();
		_singleTrainingScrollRect.OnItemShow.RemoveListener(_singleItemShowAction);
		_singleTrainingScrollRect.OnItemShow.AddListener(_singleItemShowAction);
		_singleTrainingScrollRect.totalCount = _characterTutorials.Count + 1;
		_singleTrainingScrollRect.RefillCells();
		RefreshSingleTrainingDetail();
	}

	private void RefreshTeamTraining(SimulateTraining mainConfig)
	{
		if (_teamTrainingScrollRect == null)
		{
			return;
		}
		TeamTeachingViewData viewData = uiViewData as TeamTeachingViewData;
		_teamChallenges.Clear();
		foreach (TrainingContents value in RuntimeConfigs.data.trainingContentss.Values)
		{
			if (value.IdBelong == mainConfig.id)
			{
				_teamChallenges.Add(value);
			}
		}
		_teamChallenges.Sort((TrainingContents l, TrainingContents r) =>
		{
			int num = GetChallengeSortGroup(l, viewData).CompareTo(GetChallengeSortGroup(r, viewData));
			return (num != 0) ? num : CompareSort(l.sort, l.id, r.sort, r.id);
		});
		_selectedChallenge = GetDefaultTeamChallenge(viewData?.TrainingContentId ?? 0);
		_teamTrainingScrollRect.ClearCellsPool();
		_teamTrainingScrollRect.OnItemShow.RemoveListener(_teamItemShowAction);
		_teamTrainingScrollRect.OnItemShow.AddListener(_teamItemShowAction);
		_teamTrainingScrollRect.totalCount = _teamChallenges.Count;
		_teamTrainingScrollRect.RefillCells();
		RefreshTeamDetail();
	}

	private static TeamChallengeSortGroup GetChallengeSortGroup(TrainingContents data, TeamTeachingViewData viewData)
	{
		if (data == null || !IsChallengeUnlocked(data))
		{
			return TeamChallengeSortGroup.Locked;
		}
		if (ShouldSortAsCompleted(data, viewData))
		{
			return TeamChallengeSortGroup.FullyCleared;
		}
		if (!IsRaidCompleted(data.raidID))
		{
			return TeamChallengeSortGroup.NotCleared;
		}
		return TeamChallengeSortGroup.PartialCleared;
	}

	private static bool ShouldSortAsCompleted(TrainingContents data, TeamTeachingViewData viewData)
	{
		if (viewData != null && viewData.DeferCompletedChallengeSort && data.id == viewData.TrainingContentId)
		{
			return false;
		}
		return HasMaxStars(data);
	}

	private TrainingContents GetDefaultTeamChallenge(int requestedContentId)
	{
		TrainingContents trainingContents = null;
		for (int i = 0; i < _teamChallenges.Count; i++)
		{
			TrainingContents trainingContents2 = _teamChallenges[i];
			if (IsChallengeUnlocked(trainingContents2))
			{
				if (trainingContents == null)
				{
					trainingContents = trainingContents2;
				}
				if (trainingContents2.id == requestedContentId)
				{
					return trainingContents2;
				}
			}
		}
		TrainingContents trainingContents3 = trainingContents;
		if (trainingContents3 == null)
		{
			if (_teamChallenges.Count <= 0)
			{
				return null;
			}
			trainingContents3 = _teamChallenges[0];
		}
		return trainingContents3;
	}

	private void OnSingleItemShow(ILoopScrollDataSource source)
	{
		if (!(source is TrainingItem trainingItem))
		{
			return;
		}
		if (trainingItem.index == 0)
		{
			string localizeString = LocalizationUtility.GetLocalizeString("Common", 1215);
			trainingItem.BindFreeTraining(localizeString, _isFreeTrainingSelected, _trainingItemSelectedAction);
			return;
		}
		int num = trainingItem.index - 1;
		if (num >= 0 && num < _characterTutorials.Count)
		{
			CharacterTutorialRaidInfo characterTutorialRaidInfo = _characterTutorials[num];
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(characterTutorialRaidInfo.RaidId);
			trainingItem.BindCharacterTutorial(characterTutorialRaidInfo, IsRaidCompleted(characterTutorialRaidInfo.RaidId), raidInfo?.Target?.IsPerfect == true, Station, !_isFreeTrainingSelected && _selectedTutorial == characterTutorialRaidInfo, _trainingItemSelectedAction);
		}
	}

	private void OnTeamItemShow(ILoopScrollDataSource source)
	{
		if (!(source is CommonSubWorldEntranceItem { index: >=0 } commonSubWorldEntranceItem) || commonSubWorldEntranceItem.index >= _teamChallenges.Count)
		{
			return;
		}
		TrainingContents trainingContents = _teamChallenges[commonSubWorldEntranceItem.index];
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(trainingContents.raidID);
		RuntimeConfigs.data.raids.TryGetValue(trainingContents.raidID, out var value);
		_teamTargetIdsBuffer.Clear();
		if (value?.firstReward != null)
		{
			foreach (ItemKv item in value.firstReward)
			{
				if (item != null && item.id > 0)
				{
					_teamTargetIdsBuffer.Add(item.id);
				}
			}
		}
		bool value2 = HasMaxStars(trainingContents) && raidInfo?.Target?.IsPerfect == true;
		commonSubWorldEntranceItem.SyncFocusOnSelect = true;
		commonSubWorldEntranceItem.RefreshUI(commonSubWorldEntranceItem.index, trainingContents.contentLv1name, _teamTargetIdsBuffer, raidInfo?.Target, IsChallengeUnlocked(trainingContents), _teamItemSelectedAction, value2);
		commonSubWorldEntranceItem.SetSelect(trainingContents == _selectedChallenge);
	}

	private void OnTrainingItemSelected(TrainingItem item)
	{
		if (item == null)
		{
			return;
		}
		int currentSingleTrainingIndex = GetCurrentSingleTrainingIndex();
		if (item.index != currentSingleTrainingIndex)
		{
			if (currentSingleTrainingIndex >= 0 && _singleTrainingScrollRect != null && _singleTrainingScrollRect.GetItem(currentSingleTrainingIndex) is TrainingItem trainingItem && trainingItem != item)
			{
				trainingItem.SetSelect(value: false);
			}
			_isFreeTrainingSelected = item.IsFreeTraining;
			_selectedTutorial = item.RaidInfo;
			RefreshSingleTrainingDetail();
			RefreshGamePadPrompts();
			PlaySelectItemShowAnimation();
		}
		item.SetSelect(value: true);
		item.SyncGamePadFocus();
	}

	private void OnTeamItemSelected(int index)
	{
		if (index < 0 || index >= _teamChallenges.Count)
		{
			return;
		}
		int num = _teamChallenges.IndexOf(_selectedChallenge);
		if (num != index)
		{
			if (num >= 0 && _teamTrainingScrollRect.GetItem(num) is CommonSubWorldEntranceItem commonSubWorldEntranceItem)
			{
				commonSubWorldEntranceItem.SetSelect(value: false);
			}
			_selectedChallenge = _teamChallenges[index];
			if (_teamTrainingScrollRect.GetItem(index) is CommonSubWorldEntranceItem commonSubWorldEntranceItem2)
			{
				commonSubWorldEntranceItem2.SetSelect(value: true);
				commonSubWorldEntranceItem2.SyncGamePadFocus();
			}
			RefreshTeamDetail();
			RefreshGamePadPrompts();
			PlaySelectItemShowAnimation();
		}
	}

	private void PlaySelectItemShowAnimation()
	{
		betterAnimation?.GetSequence("selectItemShow")?.Play();
	}

	private void RefreshTeamDetail()
	{
		if (_teamTrainingContentView != null)
		{
			int challengeTime = ((_selectedChallenge != null && _selectedChallenge.id == _challengeTimeContentId) ? _challengeTime : (-1));
			_teamTrainingContentView.Refresh(_selectedChallenge, Station, IsChallengeUnlocked(_selectedChallenge), challengeTime);
		}
	}

	private void BindButtons()
	{
		if (_singleTrainingContentView != null)
		{
			_singleTrainingContentView.Initialize(EnterSelectedTraining);
		}
		if (_teamTrainingContentView != null)
		{
			_teamTrainingContentView.Initialize(EnterSelectedChallenge, OpenTeamCharacterDetail);
		}
		_closeBtn.SetBtnClick(OnClose, "event:/UI/Common/Return_Click");
	}

	public void OnClose()
	{
		if (uiViewData is TeamTeachingViewData { OnClose: { } action })
		{
			action();
		}
		Close();
	}

	private void OpenTeamCharacterDetail(TrainingContents data, int characterIndex = -1)
	{
		int[] array = data?.teamCharacter;
		if (array != null && array.Length > 0)
		{
			OnTeamDetailRequested?.Invoke(data);
			List<Character> characters = CharacterDataHelper.CreateTrialCharacterTeamByProbationIds(data.teamCharacter);
			CharacterUID? defaultCharacterUID = null;
			if (characterIndex >= 0 && characterIndex < data.teamCharacter.Length && RuntimeConfigs.data?.entityCharacterProbations != null && RuntimeConfigs.data.entityCharacterProbations.ContainsKey(data.teamCharacter[characterIndex]))
			{
				defaultCharacterUID = new CharacterUID(data.teamCharacter[characterIndex], isTrialCharacter: true);
			}
			Model<CharacterModel>.Interface.OpenCharacterTeam(characters, defaultCharacterUID);
		}
	}

	private void BindGamePadControlLayers()
	{
		foreach (TeamTeachingSubControllerType type in Enum.GetValues(typeof(TeamTeachingSubControllerType)))
		{
			if (TryGetGamePadControlLayer(type, out var layer) && !(layer == null) && !_focusChangedActions.ContainsKey(type))
			{
				UnityAction<bool> unityAction = (bool isFocused) =>
				{
					OnGamePadControlLayerFocusChanged(type, isFocused);
				};
				layer.OnFocusChanged.AddListener(unityAction);
				_focusChangedActions.Add(type, unityAction);
			}
		}
	}

	private void UnbindGamePadControlLayers()
	{
		foreach (KeyValuePair<TeamTeachingSubControllerType, UnityAction<bool>> focusChangedAction in _focusChangedActions)
		{
			if (TryGetGamePadControlLayer(focusChangedAction.Key, out var layer) && layer != null)
			{
				layer.OnFocusChanged.RemoveListener(focusChangedAction.Value);
			}
		}
		_focusChangedActions.Clear();
	}

	private void OnGamePadControlLayerFocusChanged(TeamTeachingSubControllerType type, bool isFocused)
	{
		if (isFocused)
		{
			_subControllerType = type;
			RefreshGamePadPrompts();
		}
	}

	public void ChangeToGamePadInputState(TeamTeachingSubControllerType type, bool reFocus = false)
	{
		_subControllerType = type;
		if (TryGetGamePadControlLayer(type, out var layer) && layer != null)
		{
			if (reFocus)
			{
				layer.ReFocus();
			}
			else
			{
				layer.Focus();
			}
		}
		RefreshGamePadPrompts();
	}

	public void RestoreGamePadInputState()
	{
		ChangeToGamePadInputState(_subControllerType, reFocus: true);
	}

	public void SwitchMainTab(int direction)
	{
		if (_mainTabList == null || _runtimeTabs.Count == 0 || direction == 0)
		{
			return;
		}
		int num = _runtimeTabs.IndexOf(_mainTabList.ActiveTab as TeamTeachingTab);
		if (num < 0)
		{
			num = 0;
		}
		int num2 = ((direction > 0) ? 1 : (-1));
		for (int i = 1; i <= _runtimeTabs.Count; i++)
		{
			int index = (num + num2 * i + _runtimeTabs.Count) % _runtimeTabs.Count;
			TeamTeachingTab teamTeachingTab = _runtimeTabs[index];
			if (teamTeachingTab != null)
			{
				Func<bool> canActive = teamTeachingTab.CanActive;
				if (canActive == null || canActive())
				{
					_mainTabList.ActiveTab = teamTeachingTab;
					break;
				}
			}
		}
	}

	public void OpenSelectedTeamCharacterDetail()
	{
		if (_subControllerType == TeamTeachingSubControllerType.TeamTrainingList && _selectedChallenge != null)
		{
			OpenTeamCharacterDetail(_selectedChallenge);
		}
	}

	public void FocusRewardItems()
	{
		TeamTeachingSubControllerType teamTeachingSubControllerType = _subControllerType switch
		{
			TeamTeachingSubControllerType.SingleTrainingList => TeamTeachingSubControllerType.SingleTrainingReward, 
			TeamTeachingSubControllerType.TeamTrainingList => TeamTeachingSubControllerType.TeamTrainingReward, 
			_ => _subControllerType, 
		};
		if (teamTeachingSubControllerType != _subControllerType && HasRewardsForCurrentListState() && TryGetGamePadControlLayer(teamTeachingSubControllerType, out var layer) && layer?.GetDefault() != null)
		{
			ChangeToGamePadInputState(teamTeachingSubControllerType);
		}
	}

	public bool ReturnFromGamePadSubState()
	{
		if (IsGamePadControlLayerFocused(TeamTeachingSubControllerType.SingleTrainingReward))
		{
			ChangeToGamePadInputState(TeamTeachingSubControllerType.SingleTrainingList, reFocus: true);
			return true;
		}
		if (IsGamePadControlLayerFocused(TeamTeachingSubControllerType.TeamTrainingReward))
		{
			ChangeToGamePadInputState(TeamTeachingSubControllerType.TeamTrainingList, reFocus: true);
			return true;
		}
		switch (_subControllerType)
		{
		case TeamTeachingSubControllerType.SingleTrainingReward:
			ChangeToGamePadInputState(TeamTeachingSubControllerType.SingleTrainingList, reFocus: true);
			return true;
		case TeamTeachingSubControllerType.TeamTrainingReward:
			ChangeToGamePadInputState(TeamTeachingSubControllerType.TeamTrainingList, reFocus: true);
			return true;
		default:
			return false;
		}
	}

	private bool IsGamePadControlLayerFocused(TeamTeachingSubControllerType type)
	{
		if (TryGetGamePadControlLayer(type, out var layer) && layer != null)
		{
			return layer.IsFocused;
		}
		return false;
	}

	public void ConfirmGamePadSelection()
	{
		switch (_subControllerType)
		{
		case TeamTeachingSubControllerType.SingleTrainingList:
			EnterSelectedTraining();
			break;
		case TeamTeachingSubControllerType.TeamTrainingList:
			EnterSelectedChallenge();
			break;
		default:
			SubmitCurrentSelection();
			break;
		}
	}

	private static void SubmitCurrentSelection()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void NavigateGamePad(MoveDirection direction)
	{
		if (TryGetGamePadControlLayer(_subControllerType, out var layer) && !(layer?.Root == null))
		{
			switch (direction)
			{
			case MoveDirection.Up:
				layer.Root.SelectUp();
				break;
			case MoveDirection.Down:
				layer.Root.SelectDown();
				break;
			case MoveDirection.Left:
				layer.Root.SelectLeft();
				break;
			case MoveDirection.Right:
				layer.Root.SelectRight();
				break;
			}
			SyncGamePadListSelection();
		}
	}

	private void SyncGamePadListSelection()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			return;
		}
		switch (_subControllerType)
		{
		case TeamTeachingSubControllerType.SingleTrainingList:
		{
			TrainingItem componentInParent2 = currentSelected.GetComponentInParent<TrainingItem>();
			if (!(componentInParent2 == null) && componentInParent2.index != GetCurrentSingleTrainingIndex())
			{
				componentInParent2.SelectFromGamePad();
			}
			break;
		}
		case TeamTeachingSubControllerType.TeamTrainingList:
		{
			CommonSubWorldEntranceItem componentInParent = currentSelected.GetComponentInParent<CommonSubWorldEntranceItem>();
			if (!(componentInParent == null) && componentInParent.index != GetCurrentTeamTrainingIndex())
			{
				componentInParent.SelectFromGamePad();
			}
			break;
		}
		}
	}

	private bool TryGetGamePadControlLayer(TeamTeachingSubControllerType type, out ViewControlLayer layer)
	{
		if (ViewControlLayers != null && ViewControlLayers.TryGetValue(type, out layer) && layer != null)
		{
			return true;
		}
		layer = null;
		return false;
	}

	private void RefreshGamePadPrompts()
	{
		RefreshStateOperatePrompts();
		if (!(_gamePadTipsComp == null))
		{
			_gamePadTipsActions.Clear();
			TeamTeachingSubControllerType subControllerType = _subControllerType;
			if (subControllerType == TeamTeachingSubControllerType.SingleTrainingReward || subControllerType == TeamTeachingSubControllerType.TeamTrainingReward)
			{
				_gamePadTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "UI/Confirm",
					localizeKey = 774,
					localizeTable = "Common"
				});
			}
			_gamePadTipsActions.Add(new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			});
			bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
			if (_gamePadTipsComp.gameObject.activeSelf != flag)
			{
				_gamePadTipsComp.gameObject.SetActive(flag);
			}
			_gamePadTipsComp.ClearAllPrompts();
			_gamePadTipsComp.RegisterInputActions(_gamePadTipsActions);
		}
	}

	private void RefreshStateOperatePrompts()
	{
		RefreshViewControlPrompts(_subControllerType);
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		SetActiveIfChanged(_singleTrainingSelectRewardPrompt, flag && _subControllerType == TeamTeachingSubControllerType.SingleTrainingList && _singleTrainingContentView != null && _singleTrainingContentView.HasRewards);
		SetActiveIfChanged(_teamTrainingSelectRewardPrompt, flag && _subControllerType == TeamTeachingSubControllerType.TeamTrainingList && _teamTrainingContentView != null && _teamTrainingContentView.HasRewards);
	}

	private void RefreshViewControlPrompts(TeamTeachingSubControllerType type)
	{
		HideAllViewControlPrompts();
		if (ViewControlPrompt == null || MonoECS.instance.InputMode != DeviceInputMode.Gamepad || !ViewControlPrompt.TryGetValue(type, out var value) || value == null)
		{
			return;
		}
		foreach (GameObject item in value)
		{
			SetActiveIfChanged(item, active: true);
		}
	}

	private void HideAllViewControlPrompts()
	{
		SetActiveIfChanged(_singleTrainingSelectRewardPrompt, active: false);
		SetActiveIfChanged(_teamTrainingSelectRewardPrompt, active: false);
		if (ViewControlPrompt == null)
		{
			return;
		}
		foreach (KeyValuePair<TeamTeachingSubControllerType, List<GameObject>> item in ViewControlPrompt)
		{
			if (item.Value == null)
			{
				continue;
			}
			foreach (GameObject item2 in item.Value)
			{
				SetActiveIfChanged(item2, active: false);
			}
		}
	}

	private static void SetActiveIfChanged(GameObject target, bool active)
	{
		if (target != null && target.activeSelf != active)
		{
			target.SetActive(active);
		}
	}

	private static bool IsListState(TeamTeachingSubControllerType type)
	{
		if (type != TeamTeachingSubControllerType.SingleTrainingList)
		{
			return type == TeamTeachingSubControllerType.TeamTrainingList;
		}
		return true;
	}

	private bool HasRewardsForCurrentListState()
	{
		return _subControllerType switch
		{
			TeamTeachingSubControllerType.SingleTrainingList => _singleTrainingContentView != null && _singleTrainingContentView.HasRewards, 
			TeamTeachingSubControllerType.TeamTrainingList => _teamTrainingContentView != null && _teamTrainingContentView.HasRewards, 
			_ => false, 
		};
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			FocusCurrentListSelection();
			RestoreGamePadInputState();
		}
		else
		{
			HideAllViewControlPrompts();
		}
	}

	private void FocusCurrentListSelection()
	{
		switch (_subControllerType)
		{
		case TeamTeachingSubControllerType.SingleTrainingList:
			if (_singleTrainingScrollRect?.GetItem(GetCurrentSingleTrainingIndex()) is TrainingItem trainingItem)
			{
				trainingItem.SyncGamePadFocus();
			}
			break;
		case TeamTeachingSubControllerType.TeamTrainingList:
			if (_teamTrainingScrollRect?.GetItem(GetCurrentTeamTrainingIndex()) is CommonSubWorldEntranceItem commonSubWorldEntranceItem)
			{
				commonSubWorldEntranceItem.SyncGamePadFocus();
			}
			break;
		}
	}

	private int GetCurrentSingleTrainingIndex()
	{
		if (_isFreeTrainingSelected)
		{
			return 0;
		}
		if (_selectedTutorial == null)
		{
			return -1;
		}
		int num = _characterTutorials.IndexOf(_selectedTutorial);
		if (num >= 0)
		{
			return num + 1;
		}
		return -1;
	}

	private int GetCurrentTeamTrainingIndex()
	{
		if (_selectedChallenge != null)
		{
			return _teamChallenges.IndexOf(_selectedChallenge);
		}
		return -1;
	}

	private void RefreshSingleTrainingDetail()
	{
		if (_singleTrainingContentView != null)
		{
			_singleTrainingContentView.Refresh(_isFreeTrainingSelected, _selectedTutorial, Station);
		}
	}

	public void EnterSelectedTraining()
	{
		if (_isFreeTrainingSelected)
		{
			EnterTrainingGround();
			return;
		}
		CharacterTutorialRaidInfo selectedTutorial = _selectedTutorial;
		if (selectedTutorial != null)
		{
			EnterRaid(selectedTutorial.RaidId);
		}
	}

	public void EnterSelectedChallenge()
	{
		if (_selectedChallenge != null && IsChallengeUnlocked(_selectedChallenge))
		{
			EnterRaid(_selectedChallenge.raidID, _selectedChallenge);
		}
	}

	private void EnterTrainingGround()
	{
		if (MonoECS.instance.playState != PlayState.UnBattle && MonoECS.instance.sceneStatus == SceneStatus.Main)
		{
			GameUtility.OpenToolTip(1184);
			return;
		}
		MonoECS.instance.SyncGameInfos();
		Model<TrainingGroundModel>.Interface.MainWorldBattleCharaPostion = MonoECS.instance.localPlayer.battleEntity.GetCompPhysics().SyncPosition;
		G.service.EnterTrainingGround((bool success) =>
		{
			if (success)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Trainingground).Forget();
			}
		});
	}

	private static void EnterRaid(int raidId, TrainingContents teamTeachingContent = null)
	{
		if (raidId <= 0)
		{
			return;
		}
		MonoECS.instance.SyncGameInfos();
		TeamUsage teamUsage = ((teamTeachingContent == null) ? Model<RaidModel>.Interface.GetRaidTrialTeamUsage(raidId) : Model<RaidModel>.Interface.GetTrialTeamUsage(teamTeachingContent.teamCharacter));
		if (teamUsage == null)
		{
			Debug.LogError($"[TeamTeaching] Raid {raidId} has no valid trial team configuration.");
			return;
		}
		G.service.RaidEnterInfo(raidId, teamUsage, async (bool success) =>
		{
			if (success)
			{
				if (teamTeachingContent != null)
				{
					Model<TeamTeachingModel>.Interface.SetCurrentTrainingContent(teamTeachingContent);
				}
				else
				{
					Model<TeamTeachingModel>.Interface.ClearCurrentTrainingContent();
				}
				await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
				TriggerTeamChallengeEncyclopedia(teamTeachingContent);
			}
		});
	}

	private static void TriggerTeamChallengeEncyclopedia(TrainingContents trainingContent)
	{
		int[] array = trainingContent?.BKID;
		if (array == null || array.Length <= 0)
		{
			return;
		}
		HashSet<int> hashSet = new HashSet<int>();
		array = trainingContent.BKID;
		foreach (int num in array)
		{
			if (num > 0 && hashSet.Add(num))
			{
				UIUtility.TriggerGuideTimerComponent(num);
			}
		}
	}

	private static bool IsMainTabUnlocked(SimulateTraining data)
	{
		if (data == null || data.preconditionID <= 0)
		{
			return true;
		}
		Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(data.preconditionID, out var value);
		if (value != null)
		{
			int status = value.status;
			if ((uint)(status - 1) <= 1u)
			{
				return true;
			}
		}
		return false;
	}

	private static bool IsChallengeUnlocked(TrainingContents data)
	{
		if (data == null || !RuntimeConfigs.data.raids.TryGetValue(data.raidID, out var value))
		{
			return false;
		}
		return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value.unlockCondition);
	}

	private static bool IsRaidCompleted(int raidId)
	{
		if (raidId > 0)
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidId);
			if (raidInfo != null)
			{
				return raidInfo.CleanNum > 0;
			}
			return false;
		}
		return false;
	}

	private static bool HasMaxStars(TrainingContents data)
	{
		return GetRaidTargetCompletedCount(data) >= 3;
	}

	private static int GetRaidTargetCompletedCount(TrainingContents data)
	{
		if (data == null || !RuntimeConfigs.data.raids.TryGetValue(data.raidID, out var value))
		{
			return 0;
		}
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(data.raidID);
		if (raidInfo == null || raidInfo.CleanNum <= 0 || raidInfo.Target?.TargetReward == null || value.firstReward == null)
		{
			return 0;
		}
		int num = 0;
		bool value2 = default;
		foreach (ItemKv item in value.firstReward)
		{
			if ((item != null && item.id > 0 && raidInfo.Target.TargetReward.TryGetValue(item.id, out value2)) & value2)
			{
				num++;
			}
		}
		return num;
	}

	private static int CompareSort(int lSort, int lId, int rSort, int rId)
	{
		int num = ((lSort <= 0) ? int.MaxValue : lSort).CompareTo((rSort <= 0) ? int.MaxValue : rSort);
		if (num == 0)
		{
			return lId.CompareTo(rId);
		}
		return num;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		PlayTrainingItemAnimation(show: true);
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		PlayTrainingItemAnimation(show: false);
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}

	private void PlayTrainingItemAnimation(bool show)
	{
		IReadOnlyList<RectTransform> readOnlyList = _singleTrainingScrollRect?.Children;
		if (readOnlyList == null)
		{
			return;
		}
		for (int i = 0; i < readOnlyList.Count; i++)
		{
			RectTransform rectTransform = readOnlyList[i];
			if (rectTransform == null || !rectTransform.gameObject.activeInHierarchy)
			{
				continue;
			}
			TrainingItem component = rectTransform.GetComponent<TrainingItem>();
			if (!(component == null))
			{
				if (show)
				{
					component.PlayShowAnimation();
				}
				else
				{
					component.PlayHideAnimation();
				}
			}
		}
	}

	private void PlayTeamTrainingItemSwitchShowAnimation()
	{
		IReadOnlyList<RectTransform> readOnlyList = _teamTrainingScrollRect?.Children;
		if (readOnlyList == null)
		{
			return;
		}
		for (int i = 0; i < readOnlyList.Count; i++)
		{
			RectTransform rectTransform = readOnlyList[i];
			if (!(rectTransform == null) && rectTransform.gameObject.activeInHierarchy)
			{
				rectTransform.GetComponent<CommonSubWorldEntranceItem>()?.PlaySwitchShowAnimation();
			}
		}
	}
}
