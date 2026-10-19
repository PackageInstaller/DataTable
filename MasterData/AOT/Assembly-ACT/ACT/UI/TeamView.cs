using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TeamView : BaseUIView<TeamViewInputController>
{
	[Serializable]
	private class SubControllerOperatePromptHideConfig
	{
		public TeamViewSubControllerType subControllerType;

		public List<OperateBtnPrompt> operateBtnPrompts;
	}

	private TeamViewData m_data;

	private TeamModel _model;

	public TeamSelectSidebarV3 teamSelectSidebar;

	public TextMeshProUGUI teamName;

	[SerializeField]
	private TeamCharacterSelectBar _characterSelectBar;

	[SerializeField]
	private BloodbottleSelectBar bloodBottleBar;

	[SerializeField]
	private GameObject bottleIconRoot;

	[SerializeField]
	private BImage bottleIcon;

	[SerializeField]
	private GameObject bottleAddIcon;

	[SerializeField]
	private CommonNumberComponent bottleUseCunt;

	public List<TeamCharacterInfo> _eachSeatTeamCharacterInfo;

	[SerializeField]
	private Vector3[] seatOffsets = new Vector3[3]
	{
		new Vector3(0f, 0.05f, 0f),
		new Vector3(0f, 0.08f, 0f),
		new Vector3(0f, 0.03f, 0f)
	};

	[SerializeField]
	private StartList _elementRoot;

	[SerializeField]
	private List<TeamCharacterAddBtnV3> _addBtns;

	[SerializeField]
	private ActButton _battleBtn;

	[SerializeField]
	private ActButton _quickFormationBtn;

	[SerializeField]
	private ActButton _closeBtn;

	[SerializeField]
	private ActButton _onLeftBtn;

	[SerializeField]
	private ActButton _onRightBtn;

	[SerializeField]
	private ActButton _teamSelectBtn;

	[SerializeField]
	private ActButton _bloodBtn;

	[SerializeField]
	private LocalizeStringEvent _battleStringEvent;

	[SerializeField]
	private LocalizeStringEvent _closeStringEvent;

	[SerializeField]
	private GameObject[] commonButtons;

	[SerializeField]
	private TextMeshProUGUI _teamIndextext;

	[SerializeField]
	private GameObject _teamInfo;

	[SerializeField]
	private BetterAnimation[] _teamTabs;

	[SerializeField]
	private GameObject _teamLevelLow;

	[SerializeField]
	[Header("主界面输入layer")]
	private ViewControlLayer _mainControlLayer;

	[SerializeField]
	[Header("角色背包输入layer")]
	private ViewControlLayer _characterBagControlLayer;

	[SerializeField]
	[Header("血瓶背包输入layer")]
	private ViewControlLayer _bloodBottleBagControlLayer;

	[SerializeField]
	[Header("队伍背包输入layer")]
	private ViewControlLayer _teamBagControlLayer;

	[SerializeField]
	[Header("手柄提示组件")]
	private GamePadTipsComp _gamePadTipsComp;

	[SerializeField]
	private OperateBtnPrompt _confirmOperateBtnPrompt;

	[SerializeField]
	private OperateBtnPrompt _leftBtnPrompt;

	[SerializeField]
	private OperateBtnPrompt _rightBtnPrompt;

	[SerializeField]
	private List<SubControllerOperatePromptHideConfig> _subControllerOperatePromptHideConfigs = new List<SubControllerOperatePromptHideConfig>();

	private TeamViewSubControllerType _curSubControllerType;

	private readonly List<GamePadTipsAction> _gamePadTipsActions = new List<GamePadTipsAction>();

	private bool _leftRightBtnShouldBeActive;

	private bool m_IsClick;

	private bool _quickFormationClick;

	private bool _havePotion = true;

	private bool m_IsFinish;

	private bool m_isOption;

	private TeamChange evtTrack;

	private List<CanvasGroup> _addBtnCanvasGroups;

	public TeamCharacterSelectBar CharacterSelectBar => _characterSelectBar;

	public BloodbottleSelectBar BloodBottleBar => bloodBottleBar;

	public ViewControlLayer MainControlLayer => _mainControlLayer;

	public ViewControlLayer CharacterBagControlLayer => _characterBagControlLayer;

	public ViewControlLayer BloodBottleBagControlLayer => _bloodBottleBagControlLayer;

	public ViewControlLayer TeamBagControlLayer => _teamBagControlLayer;

	public TeamViewSubControllerType CurSubControllerType => _curSubControllerType;

	public StringBuilder _sb { get; private set; }

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Team_UIRefresh, OnTeamUIRefresh);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_UIBattleCharactersChange, BattleTeamCharChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_ElementallView_Close, OnPlayTabShow);
	}

	private void OnCloseTeamSelectBag()
	{
		Model<TeamModel>.Interface.teamSelectBagInit = false;
		UpdateUIFromBagClose();
		ChangeToGamePadInputState(TeamViewSubControllerType.Main);
		RefreshConfirmOperateBtnPrompts();
		UISceneRender.instance.ChangeToFarCam();
		RefreshUIAfterCameraBlendAsync().Forget();
	}

	private void UpdateUIFromBagClose()
	{
		_closeBtn.gameObject.SetActive(value: true);
		_battleBtn.gameObject.SetActive(value: true);
		_quickFormationBtn.gameObject.SetActive(value: true);
		SetLeftRightBtnActive(m_data.source == TeamProfileSource.World);
		RefreshCharacterBtn();
		UpdateBattleBtn();
		if (_model.source == TeamProfileSource.World || _model.source == TeamProfileSource.Raid)
		{
			teamName.text = _model.CurSelectedTeamProfile.Name;
			_teamInfo.SetActive(value: true);
			UpdateTeamIndexText(init: true);
		}
		BloodBottleData bloodBottleData = ((_model.source != TeamProfileSource.Raid) ? Model<BloodBottleModel>.Interface.GetBloodBottleById(_model.CurSelectedTeamProfile.EquipPotionId) : Model<BloodBottleModel>.Interface.GetTargetSceneBloodBottleById(_model.CurSelectedTeamProfile.EquipPotionId, 0));
		BloodBottleData targetBottle = bloodBottleData;
		OnEquipOrUnloadBottle(targetBottle, _model.CurSelectedTeamProfile.EquipPotionId != 0);
	}

	public void UpdateTeamName()
	{
		teamName.text = _model.CurSelectedTeamProfile.Name;
	}

	private void OnCloseBottleSelectBag()
	{
		UpdateUIFromBagClose();
		ChangeToGamePadInputState(TeamViewSubControllerType.Main);
	}

	private void OnClosePopUpTeamQuickView()
	{
		SetCanvasGroup(active: true);
	}

	private async UniTaskVoid RefreshUIAfterCameraBlendAsync()
	{
		CinemachineBrain brain = UISceneRender.instance.uiSceneCamera.GetComponent<CinemachineBrain>();
		SetSeatInfoAnimation(show: false);
		await UniTask.WaitUntil(() => brain != null && !brain.IsBlending);
		UpdateEachSeatTeamCharacterInfoPositions();
		SetSeatInfoAnimation(show: true);
	}

	private void SetSeatInfoAnimation(bool show)
	{
		for (int i = 0; i < _eachSeatTeamCharacterInfo.Count; i++)
		{
			if (G.localPlayer.GetBagCharacter(_model.CurSelectedTeamCharacters[i]) != null)
			{
				_eachSeatTeamCharacterInfo[i].Active(show);
			}
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		SetGamePadModeActive(type == DeviceInputMode.Gamepad);
	}

	private void SetGamePadModeActive(bool active)
	{
		if (_gamePadTipsComp != null)
		{
			_gamePadTipsComp.gameObject.SetActive(active);
		}
		RefreshLeftRightBtnDisplay();
		if (active)
		{
			ChangeToGamePadInputState(_curSubControllerType);
			return;
		}
		_gamePadTipsComp?.ClearAllPrompts();
		RefreshFocusByInputState();
	}

	public void ChangeToGamePadInputState(TeamViewSubControllerType type)
	{
		_curSubControllerType = type;
		GetController()?.SetTeamViewSubControllerType(type);
		RefreshSubControllerOperateBtnPrompts(type);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad || MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse)
		{
			ViewControlLayer gamePadControlLayer = GetGamePadControlLayer(type);
			RefreshGamePadLayerDefaultSelect(type, gamePadControlLayer);
			gamePadControlLayer?.Focus();
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				RefreshGamePadTipsStatus(type);
			}
		}
	}

	private void RefreshGamePadLayerDefaultSelect(TeamViewSubControllerType type, ViewControlLayer layer)
	{
		if (!(layer == null))
		{
			ACT.ViewControl.SelectableEx defaultSelectBySubController = GetDefaultSelectBySubController(type);
			if (defaultSelectBySubController != null)
			{
				layer.SetDefaultSelect(defaultSelectBySubController);
			}
		}
	}

	private ACT.ViewControl.SelectableEx GetDefaultSelectBySubController(TeamViewSubControllerType type)
	{
		return type switch
		{
			TeamViewSubControllerType.Main => GetCurrentSeatSelectableEx(), 
			TeamViewSubControllerType.CharacterBag => GetCharacterBagSelectableEx(), 
			TeamViewSubControllerType.BloodBottleBag => (bloodBottleBar != null) ? bloodBottleBar.GetDefaultBottleSelectableEx() : null, 
			TeamViewSubControllerType.TeamBag => GetCurrentTeamItemSelectableEx(), 
			_ => null, 
		};
	}

	private ACT.ViewControl.SelectableEx GetCurrentSeatSelectableEx()
	{
		if (_addBtns == null || _addBtns.Count == 0 || _model == null)
		{
			return null;
		}
		int strongGuideAddBtnIndex = Model<TeamModel>.Interface.StrongGuideAddBtnIndex;
		if (strongGuideAddBtnIndex != -1)
		{
			return _addBtns[strongGuideAddBtnIndex].GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
		}
		int index = Mathf.Clamp(_model.curSeatIndex, 0, _addBtns.Count - 1);
		if (!(_addBtns[index] != null))
		{
			return null;
		}
		return _addBtns[index].GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	private ACT.ViewControl.SelectableEx GetCharacterBagSelectableEx()
	{
		if (!(_characterSelectBar != null))
		{
			return null;
		}
		return _characterSelectBar.GetDefaultSelectableEx();
	}

	private ACT.ViewControl.SelectableEx GetCurrentTeamItemSelectableEx()
	{
		if (teamSelectSidebar == null || _model == null)
		{
			return null;
		}
		TeamItemV3 teamItemByTeamIndex = teamSelectSidebar.GetTeamItemByTeamIndex(_model.curSelectedIndex);
		if (!(teamItemByTeamIndex != null))
		{
			return null;
		}
		return teamItemByTeamIndex.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	private void RefreshGamePadTipsStatus(TeamViewSubControllerType type)
	{
		if (!(_gamePadTipsComp == null))
		{
			_gamePadTipsComp.ClearAllPrompts();
			_gamePadTipsActions.Clear();
			_gamePadTipsActions.Add(new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 13,
				localizeTable = "Common"
			});
			_gamePadTipsActions.Add(new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			});
			if (type == TeamViewSubControllerType.BloodBottleBag)
			{
				_gamePadTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "UI/RSUpDownSelect",
					localizeKey = 2165,
					localizeTable = "Common"
				});
			}
			_gamePadTipsComp.RegisterInputActions(_gamePadTipsActions);
		}
	}

	private ViewControlLayer GetGamePadControlLayer(TeamViewSubControllerType type)
	{
		return type switch
		{
			TeamViewSubControllerType.CharacterBag => _characterBagControlLayer, 
			TeamViewSubControllerType.BloodBottleBag => _bloodBottleBagControlLayer, 
			TeamViewSubControllerType.TeamBag => _teamBagControlLayer, 
			_ => _mainControlLayer, 
		};
	}

	private void BindConfirmOperateBtnPrompt()
	{
		if (!(_battleBtn == null))
		{
			_battleBtn.OnStateChanged -= OnConfirmBtnStateChanged;
			_battleBtn.OnStateChanged += OnConfirmBtnStateChanged;
			ActButton actButton = ((teamSelectSidebar != null) ? teamSelectSidebar.BattleBtn : null);
			if (actButton != null)
			{
				actButton.OnStateChanged -= OnConfirmBtnStateChanged;
				actButton.OnStateChanged += OnConfirmBtnStateChanged;
			}
			OnConfirmBtnStateChanged(_battleBtn.CurrentState);
		}
	}

	private void UnBindConfirmOperateBtnPrompt()
	{
		if (_battleBtn != null)
		{
			_battleBtn.OnStateChanged -= OnConfirmBtnStateChanged;
		}
		ActButton actButton = ((teamSelectSidebar != null) ? teamSelectSidebar.BattleBtn : null);
		if (actButton != null)
		{
			actButton.OnStateChanged -= OnConfirmBtnStateChanged;
		}
	}

	private void OnConfirmBtnStateChanged(ActSelectableState state)
	{
		bool flag = teamSelectSidebar != null && _model.teamSelectBagInit;
		ActButton actButton = (flag ? teamSelectSidebar.BattleBtn : _battleBtn);
		bool flag2 = ((actButton != null) ? actButton.CurrentState : state) != ActSelectableState.Disabled && !IsOperateBtnPromptHiddenInSubController(_confirmOperateBtnPrompt, _curSubControllerType);
		_confirmOperateBtnPrompt?.SetVisible(flag2 && !flag);
		((teamSelectSidebar != null) ? teamSelectSidebar.ConfirmOperateBtnPrompt : null)?.SetVisible(flag2 & flag);
	}

	private void RefreshConfirmOperateBtnPrompts()
	{
		ActButton actButton = ((teamSelectSidebar != null && _model.teamSelectBagInit) ? teamSelectSidebar.BattleBtn : _battleBtn);
		ActSelectableState state = ((actButton != null) ? actButton.CurrentState : ActSelectableState.Normal);
		OnConfirmBtnStateChanged(state);
	}

	private void RefreshSubControllerOperateBtnPrompts(TeamViewSubControllerType type)
	{
		if (_subControllerOperatePromptHideConfigs == null || _subControllerOperatePromptHideConfigs.Count == 0)
		{
			OnConfirmBtnStateChanged((_battleBtn != null) ? _battleBtn.CurrentState : ActSelectableState.Normal);
			return;
		}
		HashSet<OperateBtnPrompt> hashSet = new HashSet<OperateBtnPrompt>();
		HashSet<OperateBtnPrompt> hashSet2 = new HashSet<OperateBtnPrompt>();
		foreach (SubControllerOperatePromptHideConfig subControllerOperatePromptHideConfig in _subControllerOperatePromptHideConfigs)
		{
			if (subControllerOperatePromptHideConfig?.operateBtnPrompts == null)
			{
				continue;
			}
			foreach (OperateBtnPrompt operateBtnPrompt in subControllerOperatePromptHideConfig.operateBtnPrompts)
			{
				if (!(operateBtnPrompt == null))
				{
					hashSet.Add(operateBtnPrompt);
					if (subControllerOperatePromptHideConfig.subControllerType == type)
					{
						hashSet2.Add(operateBtnPrompt);
					}
				}
			}
		}
		foreach (OperateBtnPrompt item in hashSet)
		{
			if (!(item == _confirmOperateBtnPrompt) && !(item == _leftBtnPrompt) && !(item == _rightBtnPrompt))
			{
				item.SetVisible(!hashSet2.Contains(item));
			}
		}
		OnConfirmBtnStateChanged((_battleBtn != null) ? _battleBtn.CurrentState : ActSelectableState.Normal);
		RefreshLeftRightBtnDisplay();
	}

	private bool IsOperateBtnPromptHiddenInSubController(OperateBtnPrompt prompt, TeamViewSubControllerType type)
	{
		if (prompt == null || _subControllerOperatePromptHideConfigs == null)
		{
			return false;
		}
		foreach (SubControllerOperatePromptHideConfig subControllerOperatePromptHideConfig in _subControllerOperatePromptHideConfigs)
		{
			if (subControllerOperatePromptHideConfig?.operateBtnPrompts != null && subControllerOperatePromptHideConfig.subControllerType == type && subControllerOperatePromptHideConfig.operateBtnPrompts.Contains(prompt))
			{
				return true;
			}
		}
		return false;
	}

	private void SetLeftRightBtnActive(bool active)
	{
		_leftRightBtnShouldBeActive = active;
		RefreshLeftRightBtnDisplay();
	}

	private void RefreshLeftRightBtnDisplay()
	{
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool leftRightBtnShouldBeActive = _leftRightBtnShouldBeActive;
		_onLeftBtn.gameObject.SetActive(leftRightBtnShouldBeActive && !flag);
		_onRightBtn.gameObject.SetActive(leftRightBtnShouldBeActive && !flag);
		_leftBtnPrompt?.SetVisible((leftRightBtnShouldBeActive & flag) && !IsOperateBtnPromptHiddenInSubController(_leftBtnPrompt, _curSubControllerType));
		_rightBtnPrompt?.SetVisible((leftRightBtnShouldBeActive & flag) && !IsOperateBtnPromptHiddenInSubController(_rightBtnPrompt, _curSubControllerType));
	}

	private void UnFocusAllGamePadLayers()
	{
		_mainControlLayer?.UnFocus();
		_characterBagControlLayer?.UnFocus();
		_bloodBottleBagControlLayer?.UnFocus();
		_teamBagControlLayer?.UnFocus();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Team_UIRefresh, OnTeamUIRefresh);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_UIBattleCharactersChange, BattleTeamCharChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_ElementallView_Close, OnPlayTabShow);
	}

	private void OnTeamUIRefresh(BaseEventContent obj)
	{
		if (_model.source == TeamProfileSource.World)
		{
			teamName.text = _model.CurSelectedTeamProfile.Name;
		}
		for (int i = 0; i < commonButtons.Length; i++)
		{
			commonButtons[i].SetActive(value: true);
		}
		RefreshCharacterBtn();
		UpdateBattleBtn();
	}

	private void OnTeamChange(int teamIndex)
	{
		_model.curSelectedIndex = teamIndex;
		ShowTeam(init: true);
	}

	private void OnPlayTabShow(BaseEventContent obj)
	{
		betterAnimation.GetSequence("TabShow").Play();
	}

	private void BattleTeamCharChange(BaseEventContent obj)
	{
		UITeamCharChange uITeamCharChange = (UITeamCharChange)obj;
		if (_model.source == TeamProfileSource.Temple)
		{
			_model.templeCharactersId = Model<TeamModel>.Interface.DeepCopyArray(uITeamCharChange.charactersId);
			for (int i = 0; i < uITeamCharChange.charactersId.Length; i++)
			{
				_model.templeGroundProfiles.CharacterIds[i] = uITeamCharChange.charactersId[i];
			}
		}
		else if (_model.source == TeamProfileSource.Raid)
		{
			RepeatedField<int> characterIds = _model.raidTeamProfiles[uITeamCharChange.index].CharacterIds;
			characterIds.Clear();
			characterIds.AddRange(uITeamCharChange.charactersId);
		}
		else if (_model.source == TeamProfileSource.Traininground)
		{
			_model.trainingGroudCharactersId = Model<TeamModel>.Interface.DeepCopyArray(uITeamCharChange.charactersId);
		}
		else
		{
			RepeatedField<int> characterIds2 = _model.uiTeamProfiles[uITeamCharChange.index].CharacterIds;
			characterIds2.Clear();
			characterIds2.AddRange(uITeamCharChange.charactersId);
		}
	}

	public async void QuickFormationBtnEvent()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/FastFormation_Click");
		if (!_quickFormationClick && !m_IsClick)
		{
			_quickFormationClick = true;
			if (!teamSelectSidebar.isHidden)
			{
				teamSelectSidebar.UnInit();
			}
			SetCanvasGroup(active: false);
			_model.bagSingleSelect = false;
			Debug.LogWarning($"时间{Time.frameCount}, 点击快速编队按钮");
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPTEAMQUICKSELECT);
			_quickFormationClick = false;
		}
	}

	private void LeftBtnEvent()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/ChangeTeam_Click");
		_model.OnLeft();
		ShowTeam(init: false);
	}

	private void RightBtnEvent()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/ChangeTeam_Click");
		_model.OnRight();
		ShowTeam(init: false);
	}

	public void SelectPreviousTeamByGamePad()
	{
		LeftBtnEvent();
	}

	public void SelectNextTeamByGamePad()
	{
		RightBtnEvent();
	}

	public void SelectPreviousTeamCharacterByGamePad()
	{
		SelectTeamCharacterByGamePad(-1);
	}

	public void SelectNextTeamCharacterByGamePad()
	{
		SelectTeamCharacterByGamePad(1);
	}

	private void SelectTeamCharacterByGamePad(int offset)
	{
		int num = Mathf.Min(_model.CurSelectedTeamCharacters?.Length ?? 0, _addBtns?.Count ?? 0);
		if (num > 0)
		{
			int num2 = Mathf.Clamp(_model.curSeatIndex, 0, num - 1);
			int num3 = (num2 + offset + num) % num;
			if (num3 != num2)
			{
				_addBtns[num2].DeselectByGamePad();
				_model.curSeatIndex = num3;
				_addBtns[num3].SelectByGamePad();
			}
		}
	}

	public void OpenSelectedCharacterTagDetailsByGamePad()
	{
		int[] curSelectedTeamCharacters = _model.CurSelectedTeamCharacters;
		if (curSelectedTeamCharacters != null && curSelectedTeamCharacters.Length != 0)
		{
			int num = Mathf.Clamp(_model.curSeatIndex, 0, curSelectedTeamCharacters.Length - 1);
			Character bagCharacter = G.localPlayer.GetBagCharacter(curSelectedTeamCharacters[num]);
			if (bagCharacter != null)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Open");
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
				{
					characterId = bagCharacter.Id
				});
			}
		}
	}

	public void OpenSelectedCharacterBagByGamePad()
	{
		if (_model != null)
		{
			int[] curSelectedTeamCharacters = _model.CurSelectedTeamCharacters;
			if (curSelectedTeamCharacters != null && curSelectedTeamCharacters.Length != 0)
			{
				int index = Mathf.Clamp(_model.curSeatIndex, 0, Mathf.Min(curSelectedTeamCharacters.Length, _addBtns?.Count ?? 0) - 1);
				_addBtns[index].OnSubmit();
			}
		}
	}

	public void HandleGamePadSpecial1(TeamViewSubControllerType type)
	{
		switch (type)
		{
		case TeamViewSubControllerType.Main:
			BattleBtnEvent();
			break;
		case TeamViewSubControllerType.CharacterBag:
			_characterSelectBar.InvokeOperate();
			break;
		case TeamViewSubControllerType.TeamBag:
			teamSelectSidebar.InvokeTeamSelectBattle();
			break;
		case TeamViewSubControllerType.BloodBottleBag:
			break;
		}
	}

	public void HandleGamePadSpecial2(TeamViewSubControllerType type)
	{
		switch (type)
		{
		case TeamViewSubControllerType.Main:
			QuickFormationBtnEvent();
			break;
		case TeamViewSubControllerType.TeamBag:
			QuickFormationBtnEvent();
			break;
		case TeamViewSubControllerType.BloodBottleBag:
			bloodBottleBar.InvokeJumpToBottleView();
			break;
		case TeamViewSubControllerType.CharacterBag:
			OpenCharacterDetailByGamePad();
			break;
		}
	}

	public void OpenTeamBagByGamePad()
	{
		TeamSelectBtnEvent();
	}

	private void RefreshFocusByInputState()
	{
		ChangeToGamePadInputState(_curSubControllerType);
	}

	private void OpenBloodBottleBag()
	{
		if (_havePotion)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Click");
			if (teamSelectSidebar.isNormal)
			{
				teamSelectSidebar.UnInit();
			}
			_closeBtn.gameObject.SetActive(value: false);
			_battleBtn.gameObject.SetActive(value: false);
			_quickFormationBtn.gameObject.SetActive(value: false);
			_teamInfo.SetActive(value: false);
			bloodBottleBar.Refresh();
			ChangeToGamePadInputState(TeamViewSubControllerType.BloodBottleBag);
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.TeamBloodBottleAddClick);
		}
	}

	public void OpenBloodBottleBagByGamePad()
	{
		OpenBloodBottleBag();
	}

	public void HandleGamePadSpecial5(TeamViewSubControllerType type)
	{
		switch (type)
		{
		case TeamViewSubControllerType.Main:
			OpenSelectedCharacterTagDetailsByGamePad();
			break;
		case TeamViewSubControllerType.CharacterBag:
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Open");
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTAGDETAILS, new CharacterTagDetailsViewData
			{
				characterId = _model.singleSelectCharacter
			});
			break;
		case TeamViewSubControllerType.TeamBag:
			OpenSelectedTeamRenameByGamePad();
			break;
		case TeamViewSubControllerType.BloodBottleBag:
			break;
		}
	}

	private void OpenSelectedTeamRenameByGamePad()
	{
		if (teamSelectSidebar == null || !teamSelectSidebar.isNormal || _model == null)
		{
			return;
		}
		int curSelectTeamIndex = teamSelectSidebar.curSelectTeamIndex;
		PresetTeam presetTeam = _model.source switch
		{
			TeamProfileSource.World => (curSelectTeamIndex >= 0 && curSelectTeamIndex < _model.uiTeamProfiles.Count) ? _model.uiTeamProfiles[curSelectTeamIndex] : null, 
			TeamProfileSource.Raid => (curSelectTeamIndex >= 0 && curSelectTeamIndex < _model.raidTeamProfiles.Count) ? _model.raidTeamProfiles[curSelectTeamIndex] : null, 
			_ => null, 
		};
		if (presetTeam != null)
		{
			TeamItemV3 teamItemByTeamIndex = teamSelectSidebar.GetTeamItemByTeamIndex(curSelectTeamIndex);
			if (!(teamItemByTeamIndex == null))
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Click");
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAMRENAMEWIN, new TeamRenameWin.Param
				{
					teamProfile = presetTeam.Clone(),
					index = curSelectTeamIndex,
					teamItem = teamItemByTeamIndex
				});
			}
		}
	}

	private void OpenCharacterDetailByGamePad()
	{
		int num = _model.singleSelectCharacter;
		if (num == 0)
		{
			int[] curSelectedTeamCharacters = _model.CurSelectedTeamCharacters;
			if (curSelectedTeamCharacters == null || curSelectedTeamCharacters.Length == 0)
			{
				return;
			}
			int num2 = Mathf.Clamp(_model.curSeatIndex, 0, curSelectedTeamCharacters.Length - 1);
			num = curSelectedTeamCharacters[num2];
		}
		if (num != 0)
		{
			_characterSelectBar.InvokeDetail();
		}
	}

	private void TeamSelectBtnEvent()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Click");
		if (teamSelectSidebar.isHidden)
		{
			teamSelectSidebar.OnQuickFormation = QuickFormationBtnEvent;
			teamSelectSidebar.OnClosed = OnCloseTeamSelectBag;
			teamSelectSidebar.OnTeamChanged = OnTeamChange;
			teamSelectSidebar.IsRaidOrBossMode = m_data.isRaidTeam || m_data.bossChallenge;
			teamSelectSidebar.Init();
			Model<TeamModel>.Interface.teamSelectBagInit = true;
			_closeBtn.gameObject.SetActive(value: false);
			_battleBtn.gameObject.SetActive(value: false);
			_quickFormationBtn.gameObject.SetActive(value: false);
			for (int i = 0; i < _addBtns.Count; i++)
			{
				_addBtns[i].DeActive();
			}
			SetLeftRightBtnActive(active: false);
			_teamInfo.SetActive(value: false);
			UISceneRender.instance.ChangeToTeamBagCam();
			ChangeToGamePadInputState(TeamViewSubControllerType.TeamBag);
			RefreshConfirmOperateBtnPrompts();
			RefreshUIAfterCameraBlendAsync().Forget();
		}
	}

	private void UpdateEachSeatTeamCharacterInfoPositions()
	{
		if (_eachSeatTeamCharacterInfo == null || _eachSeatTeamCharacterInfo.Count == 0)
		{
			return;
		}
		Camera uiSceneCamera = UISceneRender.instance.uiSceneCamera;
		if (uiSceneCamera == null)
		{
			return;
		}
		Canvas componentInParent = GetComponentInParent<Canvas>();
		if (componentInParent == null)
		{
			return;
		}
		Transform[] teamModelsPos = UISceneRender.instance.teamModelsPos;
		if (teamModelsPos == null || teamModelsPos.Length == 0)
		{
			return;
		}
		for (int i = 0; i < _eachSeatTeamCharacterInfo.Count && i < teamModelsPos.Length; i++)
		{
			TeamCharacterInfo teamCharacterInfo = _eachSeatTeamCharacterInfo[i];
			if (!(teamCharacterInfo == null))
			{
				Vector3 position = teamModelsPos[i].position + seatOffsets[i];
				Vector3 vector = uiSceneCamera.WorldToScreenPoint(position);
				RectTransformUtility.ScreenPointToLocalPointInRectangle(componentInParent.transform as RectTransform, vector, componentInParent.worldCamera, out var localPoint);
				RectTransform component = teamCharacterInfo.GetComponent<RectTransform>();
				if (component != null)
				{
					component.anchoredPosition = localPoint;
				}
			}
		}
	}

	private void BattleBtnEvent()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Play");
		if (m_IsClick)
		{
			return;
		}
		int[] ids = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		if (!_model.CanBattle(ids) && m_data.source == TeamProfileSource.World)
		{
			GameUtility.OpenToolTip(2303);
			return;
		}
		if (m_data.raidId == 110101)
		{
			RogueCardTableViewData uiData = new RogueCardTableViewData
			{
				raidId = m_data.raidId,
				TeamCharactersIds = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters)
			};
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUECARDTABLE, uiData);
			return;
		}
		_model.UpdateCurBattleIndex(_model.curSelectedIndex);
		UpdateBattleBtn();
		UpdateTeamIndexText(init: true);
		if (m_data.isRaidTeam)
		{
			if (m_isOption)
			{
				return;
			}
			m_isOption = true;
			MonoECS.instance.SyncGameInfos();
			if (m_data.enterId != 0)
			{
				_ = RuntimeConfigs.data.raidEntranceDatas[m_data.enterId];
			}
			TeamUsage teamUsage = new TeamUsage();
			PresetTeam curSelectedTeamProfile = _model.CurSelectedTeamProfile;
			teamUsage.BattleCharacterIdx = 0;
			teamUsage.EquipPotionId = (_havePotion ? curSelectedTeamProfile.EquipPotionId : 0);
			foreach (int characterId in curSelectedTeamProfile.CharacterIds)
			{
				TeamCharacterUsage teamCharacterUsage = new TeamCharacterUsage();
				teamCharacterUsage.CharacterId = characterId;
				teamCharacterUsage.IsTrial = false;
				teamUsage.CharacterUsage.Add(teamCharacterUsage);
			}
			G.service.RaidEnterInfo(m_data.raidId, teamUsage, async (bool r) =>
			{
				if (r)
				{
					MonoECS.instance.PushPause();
					await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
					MonoECS.instance.PopPause();
				}
			});
		}
		if (m_data.bossChallenge)
		{
			if (m_isOption)
			{
				return;
			}
			m_isOption = true;
			G.service.SceneBossChallenge(m_data.index, async (bool success) =>
			{
				if (success)
				{
					BackToBattleMain();
				}
			});
		}
		if (m_data.source == TeamProfileSource.Temple)
		{
			m_data.closeAction?.Invoke();
		}
	}

	private void OpenCharSelectBag(int index)
	{
		_model.curSeatIndex = index;
		int num = _model.CurSelectedTeamCharacters[index];
		int num2 = num;
		_model.bagSingleSelect = true;
		_characterSelectBar.Open(num2, index, num, Station);
		_closeBtn.gameObject.SetActive(value: false);
		_battleBtn.gameObject.SetActive(value: false);
		_quickFormationBtn.gameObject.SetActive(value: false);
		for (int i = 0; i < commonButtons.Length; i++)
		{
			commonButtons[i].SetActive(value: false);
		}
		if (num2 == 0)
		{
			UISceneRender.instance.ChangeToCloseCameraOnEmptySeat(index);
		}
		else
		{
			UISceneRender.instance.ChangeToCloseCamera(index);
		}
		for (int j = 0; j < _addBtns.Count; j++)
		{
			_addBtns[j].DeActive();
		}
		SetLeftRightBtnActive(active: false);
		_teamInfo.SetActive(value: false);
		bottleIconRoot.SetActive(value: false);
		ChangeToGamePadInputState(TeamViewSubControllerType.CharacterBag);
	}

	private void CharacterBtnOnEnter(int index)
	{
		if (_model.CurSelectedTeamCharacters[index] != 0)
		{
			if (_model.curSeatIndex != index)
			{
				CharacterBtnOnExit(_model.curSeatIndex);
				_model.curSeatIndex = index;
			}
			UISceneRender.instance.SetIndexHighlightedActive(index, active: true);
			SetTeamCharacterOperatePromptActive(index, active: true);
		}
	}

	private void CharacterBtnOnExit(int index)
	{
		if (_model.CurSelectedTeamCharacters[index] != 0)
		{
			UISceneRender.instance.SetIndexHighlightedActive(index, active: false);
			SetTeamCharacterOperatePromptActive(index, active: false);
		}
	}

	private void SetTeamCharacterOperatePromptActive(int index, bool active)
	{
		if (_eachSeatTeamCharacterInfo != null && index >= 0 && index < _eachSeatTeamCharacterInfo.Count)
		{
			_eachSeatTeamCharacterInfo[index]?.SetOperateBtnPromptActive(active);
		}
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = (uiViewData as TeamViewData) ?? new TeamViewData();
		_model = Model<TeamModel>.Interface;
		_model.InitRawTeamProfileData(m_data.choseTeamIndex);
		_havePotion = true;
		switch (m_data.source)
		{
		case TeamProfileSource.World:
			_model.InitSeverTeamProfileData();
			break;
		case TeamProfileSource.Temple:
			_model.InitTempleTeamProfileData(m_data.subWorldCharacters, m_data.templeId, m_data.potionId);
			break;
		case TeamProfileSource.Raid:
			_model.InitRaidTeamProfileData(m_data.subWorldCharacters);
			break;
		case TeamProfileSource.Traininground:
		{
			RepeatedField<int> characterIds = G.localPlayer.teamInfo.Teams[4].Teams[0].CharacterIds;
			_model.InitTrainingGroundTeamProfileData(characterIds.ToArray());
			break;
		}
		}
		bloodBottleBar.InitData(this);
		bloodBottleBar.OnEquipStateChange += OnEquipOrUnloadBottle;
		bloodBottleBar.OnClosed = OnCloseBottleSelectBag;
		_model.OnQuickSelectPopClosed += OnClosePopUpTeamQuickView;
		_characterSelectBar.InitData(this);
		_characterSelectBar.OnBagClosed += OnCharacterSelectBagClosed;
		_characterSelectBar.gameObject.SetActive(value: false);
		await Singleton<UISceneManager>.instance.LoadScene<UISceneRender>(GameLoader.meta.uiSceneReferenceAssetID.GUID);
		_sb = new StringBuilder();
		m_isOption = false;
		_battleBtn.SetBtnClick(BattleBtnEvent);
		_quickFormationBtn.SetBtnClick(QuickFormationBtnEvent);
		_closeBtn.SetBtnClick(OpenBlackLoadView);
		_teamSelectBtn.SetBtnClick(TeamSelectBtnEvent);
		_onLeftBtn.SetBtnClick(LeftBtnEvent);
		_onRightBtn.SetBtnClick(RightBtnEvent);
		_bloodBtn.SetBtnClick(OpenBloodBottleBag);
		for (int i = 0; i < _addBtns.Count; i++)
		{
			int index = i;
			_addBtns[index].AddEnterListener(() =>
			{
				CharacterBtnOnEnter(index);
			});
			_addBtns[index].AddExitListener(() =>
			{
				CharacterBtnOnExit(index);
			});
		}
		for (int num = 0; num < _addBtns.Count; num++)
		{
			TeamCharacterAddBtnV3 teamCharacterAddBtnV = _addBtns[num];
			int index2 = num;
			teamCharacterAddBtnV.AddClickListener(() =>
			{
				OpenCharSelectBag(index2);
			}, "event:/UI/Interface/Team/Role_Add");
		}
		Model<TeamModel>.Interface.teamSelectBagInit = false;
		foreach (TeamCharacterInfo item in _eachSeatTeamCharacterInfo)
		{
			item.gameObject.SetActive(value: false);
		}
		_closeStringEvent.SetTable(LocalizeTable.ShortCommon);
		_closeStringEvent.StringReference.TableEntryReference = CoreUtils.GetData(1013, RuntimeConfigs.data.systemOpens).localNameId;
	}

	protected override void Init()
	{
		base.Init();
		Singleton<RedDotManager>.instance.RefreshUnLockSystemRedDot(1013);
		BindConfirmOperateBtnPrompt();
		RefreshCharacterBtn();
		_elementRoot.gameObject.SetActive(m_data.source == TeamProfileSource.Temple);
		if (m_data.source == TeamProfileSource.Temple)
		{
			List<int> limitElements = Model<TempleModel>.Interface.GetLimitElements(m_data.templeId);
			_elementRoot.SetElementActive(limitElements);
		}
		SetLeftRightBtnActive(m_data.source == TeamProfileSource.World || m_data.source == TeamProfileSource.Raid);
		_teamInfo.SetActive(m_data.source == TeamProfileSource.World || m_data.source == TeamProfileSource.Raid);
		TeamViewData data = m_data;
		if (data != null && data.raidId > 0)
		{
			RaidTypeData raidTypeData = GameUtility.GetRaidTypeData(m_data.raidId);
			_havePotion = raidTypeData.raidType != 7;
		}
		bottleIconRoot.SetActive(_havePotion);
		UpdateEachSeatTeamCharacterInfoPositions();
		_model.UpdateCurSelectedIndex(m_data.choseTeamIndex);
		for (int i = 0; i < commonButtons.Length; i++)
		{
			commonButtons[i].SetActive(value: true);
		}
		ShowTeam(init: true);
		if (evtTrack != null)
		{
			Dictionary<Type, ObjectPool> evtsPool = EventTrackSolver.EvtsPool;
			if (evtsPool != null && evtsPool.ContainsKey(typeof(TeamChange)))
			{
				evtTrack.ReleaseEvt();
			}
			evtTrack = null;
		}
		evtTrack = EventTrackSolver.Instance.GetEvt<TeamChange>();
		evtTrack.RecordBeforeChange();
		_curSubControllerType = TeamViewSubControllerType.Main;
		SetGamePadModeActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	protected override void OnPopStack()
	{
		if (_curSubControllerType == TeamViewSubControllerType.CharacterBag)
		{
			_characterSelectBar.ForceUpdatePerformance();
			Character character = CharacterDataHelper.GetCurAllCharacters().Find((Character x) => x.Id == _model.singleSelectCharacter);
			_characterSelectBar.OnChooseCharacter(character);
			UISceneRender.instance.UpdateSkinModel(_model.curSeatIndex, _model.singleSelectCharacter);
		}
	}

	private void ShowTeam(bool init)
	{
		RefreshCharacterBtn();
		if (_model.source == TeamProfileSource.World || _model.source == TeamProfileSource.Raid)
		{
			UpdateTeamIndexText(init);
			teamName.text = _model.CurSelectedTeamProfile.Name;
		}
		BloodBottleData bloodBottleData = ((_model.source != TeamProfileSource.Raid) ? Model<BloodBottleModel>.Interface.GetBloodBottleById(_model.CurSelectedTeamProfile.EquipPotionId) : Model<BloodBottleModel>.Interface.GetTargetSceneBloodBottleById(_model.CurSelectedTeamProfile.EquipPotionId, 0));
		BloodBottleData targetBottle = bloodBottleData;
		OnEquipOrUnloadBottle(targetBottle, _model.CurSelectedTeamProfile.EquipPotionId != 0);
		UpdateBattleBtn();
		UISceneRender.instance.DoShowTeamModels(_model.CurSelectedTeamCharacters);
	}

	private void RefreshCharacterBtn()
	{
		Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		SetAddBtnCanvasGroup();
		RefreshEachSeatTeamCharacterInfo();
		RefreshCurrentTeamCharacterHighlightByGamePad();
	}

	private void RefreshCurrentTeamCharacterHighlightByGamePad()
	{
		if (_model == null || UISceneRender.instance == null)
		{
			return;
		}
		int[] curSelectedTeamCharacters = _model.CurSelectedTeamCharacters;
		if (curSelectedTeamCharacters != null && curSelectedTeamCharacters.Length != 0)
		{
			int num = Mathf.Clamp(_model.curSeatIndex, 0, curSelectedTeamCharacters.Length - 1);
			DeviceInputMode inputMode = MonoECS.instance.InputMode;
			bool flag = (inputMode == DeviceInputMode.Gamepad || inputMode == DeviceInputMode.KeyboardAndMouse) && _curSubControllerType == TeamViewSubControllerType.Main;
			for (int i = 0; i < curSelectedTeamCharacters.Length; i++)
			{
				UISceneRender.instance.SetIndexHighlightedActive(i, flag && i == num && curSelectedTeamCharacters[i] != 0);
			}
		}
	}

	private void RefreshEachSeatTeamCharacterInfo()
	{
		for (int i = 0; i < _eachSeatTeamCharacterInfo.Count; i++)
		{
			int characterId = _model.CurSelectedTeamCharacters[i];
			Character bagCharacter = G.localPlayer.GetBagCharacter(characterId);
			bool flag = bagCharacter != null;
			_eachSeatTeamCharacterInfo[i].Active(flag);
			if (flag)
			{
				_eachSeatTeamCharacterInfo[i].Init(bagCharacter, i, Station, _curSubControllerType);
				_eachSeatTeamCharacterInfo[i].SetOperateBtnPromptActive(i == _model.curSeatIndex);
			}
		}
	}

	private void SetAddBtnCanvasGroup()
	{
		for (int i = 0; i < _model.CurSelectedTeamCharacters.Length; i++)
		{
			_addBtns[i].SetBtnInteractable(!Model<TeamModel>.Interface.teamSelectBagInit);
			if (Model<TeamModel>.Interface.teamSelectBagInit)
			{
				_addBtns[i].SetCanvasGroup(show: false);
			}
			else
			{
				_addBtns[i].SetCanvasGroup(_model.CurSelectedTeamCharacters[i] == 0);
			}
		}
	}

	private void UpdateTeamIndexText(bool init)
	{
		_teamIndextext.text = new StringBuilder().AppendFormat("{0:D2}", _model.curSelectedIndex + 1).ToString();
		if (init)
		{
			for (int i = 0; i < _teamTabs.Length; i++)
			{
				if (i == _model.curSelectedIndex)
				{
					_teamTabs[i].GetSequence("SelectedStatus").Play();
				}
				else
				{
					_teamTabs[i].GetSequence("NormalStatus").Play();
				}
			}
		}
		else
		{
			_teamTabs[_model.lastSelectedIndex].GetSequence("Normal").Play();
			_teamTabs[_model.curSelectedIndex].GetSequence("Selected").Play();
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	private void UpdateBattleBtn()
	{
		int[] array = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		_battleBtn.gameObject.SetActive(value: false);
		if (!_model.teamSelectBagInit)
		{
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] != 0)
				{
					_battleBtn.gameObject.SetActive(value: true);
					break;
				}
			}
		}
		if (_model.source == TeamProfileSource.Temple)
		{
			_battleBtn.Interactable(active: true);
			_battleStringEvent.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Fight;
		}
		else
		{
			if (_model.curSelectedIndex != _model.curBattleIndex || m_data.isRaidTeam || m_data.bossChallenge)
			{
				_battleBtn.Interactable(active: true);
				_battleStringEvent.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Fight;
			}
			else
			{
				_battleBtn.Interactable(active: false);
				_battleStringEvent.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Fighted;
			}
			if (teamSelectSidebar != null && _model.teamSelectBagInit)
			{
				teamSelectSidebar.RefreshBattleBtn();
			}
		}
		if (m_data != null && m_data.RecommendLevel > 0)
		{
			_teamLevelLow.SetActive(_model.IsLowLevel(_model.CurSelectedTeamProfile, m_data.RecommendLevel));
		}
		else
		{
			_teamLevelLow.SetActive(value: false);
		}
	}

	public void CloseByGamePad()
	{
		OpenBlackLoadView();
	}

	internal void OpenBlackLoadView()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		int[] ids = Model<TeamModel>.Interface.DeepCopyArray(_model.BattleTeamCharacters);
		if (!_model.CanBattle(ids))
		{
			GameUtility.OpenToolTip(2303);
		}
		else if (!_quickFormationClick && !m_isOption)
		{
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Team_Close);
			Close();
		}
	}

	protected override void UnInit()
	{
		bloodBottleBar.OnEquipStateChange -= OnEquipOrUnloadBottle;
		_model.OnQuickSelectPopClosed -= OnClosePopUpTeamQuickView;
		UnBindConfirmOperateBtnPrompt();
		for (int i = 0; i < _addBtns.Count; i++)
		{
			_addBtns[i].RemoveClickListener();
			_addBtns[i].RemoveEnterListener();
			_addBtns[i].RemoveExitListener();
		}
		UnFocusAllGamePadLayers();
		base.UnInit();
	}

	protected override async UniTask WaitHideCompleteAsync(CancellationToken token)
	{
		TeamChange pendingEvtTrack = evtTrack;
		evtTrack = null;
		try
		{
			await UniTask.WaitUntil(() => Singleton<NewUIManager>.instance.IsBlackScreenFullyVisible(), PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			bool num = _model.NeedLoad || _model.BattleBottleIsChange;
			if (num)
			{
				_model.EntityLoadCompletion = new UniTaskCompletionSource();
			}
			FireLoadEvent();
			if (num)
			{
				await _model.EntityLoadCompletion.Task.SuppressCancellationThrow();
				_model.EntityLoadCompletion = null;
			}
			if (pendingEvtTrack != null)
			{
				TeamChange trackBaseEvt = pendingEvtTrack;
				pendingEvtTrack = null;
				EventTrackSolver.Instance.Dispatch(trackBaseEvt);
			}
		}
		finally
		{
			if (pendingEvtTrack != null && (EventTrackSolver.EvtsPool?.ContainsKey(typeof(TeamChange)) ?? false))
			{
				pendingEvtTrack.ReleaseEvt();
			}
		}
	}

	public void FireLoadEvent()
	{
		if (_model.source == TeamProfileSource.Traininground)
		{
			if (_model.NeedLoad || _model.BattleBottleIsChange)
			{
				_model.SnapshotTeamChange(_model.RawBattleTeamCharacters, _model.CurSelectedTeamCharacters);
				Singleton<GameManager>.instance.worldManager.ResetTeamPotion(_model.CurSelectedTeamProfile.EquipPotionId);
				Model<TeamModel>.Interface.InitTrainingGroundTeamProfileData(_model.CurSelectedTeamCharacters);
			}
			else
			{
				_model.EntityLoadCompletion?.TrySetResult();
			}
		}
		else if (_model.source == TeamProfileSource.World)
		{
			if (_model.CompareTeamProfile() || _model.rawBattleIndex != _model.curBattleIndex)
			{
				_model.ChangeAllTeamProfile(_model.uiTeamProfiles, _model.curBattleIndex);
			}
			else
			{
				_model.EntityLoadCompletion?.TrySetResult();
			}
		}
		else
		{
			_model.EntityLoadCompletion?.TrySetResult();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseComplete()
	{
		Singleton<UISceneManager>.instance.ReleaseScene<UISceneRender>();
	}

	protected override void OnMoveToShow()
	{
		Singleton<UISceneManager>.instance.OpenScene<UISceneRender>();
	}

	protected override void OnMoveToHide()
	{
		Singleton<UISceneManager>.instance.CloseScene<UISceneRender>();
	}

	private void OnEquipOrUnloadBottle(BloodBottleData targetBottle, bool isEquip)
	{
		UpdateBottleUseCount(targetBottle, isEquip);
		if (!isEquip)
		{
			bottleIcon.icon.transform.localScale = Vector3.zero;
			bottleAddIcon.SetActive(value: true);
		}
		else if (targetBottle != null)
		{
			bottleIcon.icon.transform.localScale = Vector3.one;
			bottleAddIcon.SetActive(value: false);
			ItemData data = CoreUtils.GetData(targetBottle.id, RuntimeConfigs.data.itemDatas);
			Station.LoadItemIconAsync(data.iconAddress, bottleIcon).Forget();
		}
		else
		{
			bottleAddIcon.SetActive(value: true);
			bottleIcon.icon.transform.localScale = Vector3.zero;
		}
	}

	private void UpdateBottleUseCount(BloodBottleData curBottle, bool showCount)
	{
		if ((curBottle != null) & showCount)
		{
			bottleUseCunt.gameObject.SetActive(value: true);
			int num = ((_model.source == TeamProfileSource.World) ? (curBottle.maxUseCount - curBottle.alreadyUseCount) : curBottle.maxUseCount);
			int maxUseCount = curBottle.maxUseCount;
			bottleUseCunt.UpdateNumber(num, maxUseCount);
		}
		else
		{
			bottleUseCunt.gameObject.SetActive(value: false);
		}
	}

	private void OnCharacterSelectBagClosed()
	{
		_closeBtn.gameObject.SetActive(value: true);
		_battleBtn.gameObject.SetActive(value: true);
		_quickFormationBtn.gameObject.SetActive(value: true);
		UpdateBattleBtn();
		for (int i = 0; i < commonButtons.Length; i++)
		{
			commonButtons[i].SetActive(value: true);
		}
		RefreshCharacterBtn();
		UpdateBattleBtn();
		SetLeftRightBtnActive(_model.source == TeamProfileSource.World || _model.source == TeamProfileSource.Raid);
		_teamInfo.SetActive(_model.source == TeamProfileSource.World || _model.source == TeamProfileSource.Raid);
		bottleIconRoot.SetActive(_havePotion);
		ChangeToGamePadInputState(TeamViewSubControllerType.Main);
	}
}
