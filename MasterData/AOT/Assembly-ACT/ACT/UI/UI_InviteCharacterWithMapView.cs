using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound.Management;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Lumin.LoungeSystem;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class UI_InviteCharacterWithMapView : BaseUIView<InviteCharacterWithMapViewInputController>
{
	private UI_InviteCharacterWithMapViewData m_data;

	[SerializeField]
	private ActButton btn_Invite;

	[SerializeField]
	private LoopVerticalScrollRect _characterListSR;

	[SerializeField]
	private TextMeshProUGUI _inviteTxt;

	[SerializeField]
	private TextMeshProUGUI _inviteBtnTxt;

	[SerializeField]
	private TextMeshProUGUI _leftBottomTxt;

	[SerializeField]
	private RectTransform _roomListRoot;

	[SerializeField]
	private GamePadTipsComp gamePadTipsComp;

	[SerializeField]
	private OperateBtnPrompt operateBtnPromptY;

	[SerializeField]
	private Dictionary<InviteCharacterControllerType, ViewControlLayer> ViewControlLayers;

	private List<Character> characters;

	public int currSelectCharacterId;

	private int currSelectIndex = -1;

	private List<RoomData> roomList;

	private bool isRoomListInited;

	private int _selectedRoomCharacterPointId;

	private int _selectedRoomCharacterId;

	private InviteCharacterControllerType _controllerType;

	private int _selectedRoomGroupIndex = -1;

	private int _selectedRoomCellIndex = -1;

	private bool _gamepadPromptInited;

	private readonly List<CharacterRoomListGroup> _roomGroups = new List<CharacterRoomListGroup>();

	private readonly StringBuilder _inviteCountTextBuilder = new StringBuilder(32);

	private const int LocalizeIDConfirmCharacterList = 774;

	private const int LocalizeIDConfirmRoomList = 14;

	private const int LocalizeIDConfirmReplace = 51;

	private const int LocalizeIDBack = 606;

	public bool IsGamepadMode => MonoECS.instance.InputMode == DeviceInputMode.Gamepad;

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_InviteCharacterRefresh, OnRefreshView);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_InviteCharacterRefresh, OnRefreshView);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected override void Init()
	{
		base.Init();
		btn_Invite.SetBtnClick(InviteCharacter);
		Model<InviteCharacterModel>.Interface.CurrSelectIndex = 0;
		Model<InviteCharacterModel>.Interface.SingleInviteCharacterPointId = 0;
		ClearSelectedRoomCharacter();
		_controllerType = InviteCharacterControllerType.CharacterList;
		_selectedRoomGroupIndex = -1;
		_selectedRoomCellIndex = -1;
		CacheRoomGroups();
		InitGamePadPromptBindings();
		RefreshCharacterList();
		RefreshRoomList();
		RefreshInviteText();
		RefreshInviteBtnState();
		RefreshLeftBottomTxt();
		SetGamePadTipsActive(IsGamepadMode);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show")?.Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	private void RefreshCharacterList()
	{
		characters = Model<InviteCharacterModel>.Interface.SortCharactersList();
		if (characters == null || characters.Count == 0)
		{
			currSelectCharacterId = 0;
			return;
		}
		int characterSelectionIndex = GetCharacterSelectionIndex();
		Model<InviteCharacterModel>.Interface.CurrSelectIndex = characterSelectionIndex;
		currSelectIndex = characterSelectionIndex;
		currSelectCharacterId = characters[characterSelectionIndex].Id;
		SyncSelectedRoomCharacterForCurrentCharacter();
		_characterListSR.ClearCells();
		_characterListSR.totalCount = characters.Count;
		_characterListSR.RefillCells();
		PublicToggle publicToggle = (_characterListSR.GetItem(characterSelectionIndex) as InviteCharacterCell)?.GetComponent<PublicToggle>();
		if (publicToggle != null)
		{
			publicToggle.isOn = true;
		}
		RefreshGamepadSelectionVisual();
	}

	private int GetCharacterSelectionIndex()
	{
		if (characters == null || characters.Count == 0)
		{
			return 0;
		}
		if (currSelectCharacterId > 0)
		{
			int num = characters.FindIndex((Character character) => character != null && character.Id == currSelectCharacterId);
			if (num >= 0)
			{
				return num;
			}
		}
		return Mathf.Clamp(Model<InviteCharacterModel>.Interface.CurrSelectIndex, 0, characters.Count - 1);
	}

	private void InviteCharacter()
	{
		Action confirmClick = () =>
		{
			Action callback = () =>
			{
				Model<InviteCharacterModel>.Interface.ClearTempInviteCharacterList();
				RefreshCharacterList();
				RefreshRoomList();
				RefreshInviteText();
				RefreshInviteBtnState();
				RefreshLeftBottomTxt();
			};
			foreach (TempInviteCharacter tempInviteCharacter in Model<InviteCharacterModel>.Interface.TempInviteCharacterList)
			{
				int characterId = tempInviteCharacter.characterId;
				int pointId = tempInviteCharacter.pointId;
				Singleton<LoungeSystemManager>.instance.InviteCharacter(characterId, pointId, callback);
			}
		};
		if (Model<InviteCharacterModel>.Interface.TempInviteCharacterList.Count == 0)
		{
			return;
		}
		List<InviteCharacterConfirmPanelData> list = new List<InviteCharacterConfirmPanelData>();
		foreach (TempInviteCharacter tempInviteCharacter2 in Model<InviteCharacterModel>.Interface.TempInviteCharacterList)
		{
			bool canTrrigerStory = Model<InviteCharacterModel>.Interface.HasPlotAtPoint(tempInviteCharacter2.characterId, tempInviteCharacter2.pointId);
			bool hasPlot = Model<InviteCharacterModel>.Interface.CharacterHasActivePlot(tempInviteCharacter2.characterId);
			list.Add(new InviteCharacterConfirmPanelData
			{
				characterId = tempInviteCharacter2.characterId,
				pointId = tempInviteCharacter2.pointId,
				canTrrigerStory = canTrrigerStory,
				hasPlot = hasPlot
			});
		}
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_INVITECHARACTERCONFIRM, new UI_InviteCharacterConfirmViewData
		{
			topTipsCommonId = 2365,
			bottomCommonId = 2366,
			redTipsCommonId = 2367,
			characterList = list,
			confirmClick = confirmClick
		});
	}

	private void OnRefreshView(BaseEventContent obj)
	{
		currSelectCharacterId = characters[Model<InviteCharacterModel>.Interface.CurrSelectIndex].Id;
		SyncSelectedRoomCharacterForCurrentCharacter();
		RefreshLeftBottomTxt();
		RefreshRoomList();
		RefreshInviteText();
		RefreshInviteBtnState();
		RefreshGamepadSelectionVisual();
	}

	private void RefreshRoomList()
	{
		roomList = Singleton<LoungeSystemManager>.instance.RoomManager.GetUnlockedRooms();
		CacheRoomGroups();
		for (int i = 0; i < _roomGroups.Count; i++)
		{
			CharacterRoomListGroup characterRoomListGroup = _roomGroups[i];
			if (!(characterRoomListGroup == null))
			{
				bool flag = i < roomList.Count;
				characterRoomListGroup.gameObject.SetActive(flag);
				if (flag)
				{
					characterRoomListGroup.Init(i, roomList[i], Station, isRoomListInited);
				}
			}
		}
		isRoomListInited = true;
		RefreshGamepadRoomSelectionVisual();
	}

	private void CacheRoomGroups()
	{
		if (!(_roomListRoot == null) && _roomGroups.Count != _roomListRoot.childCount)
		{
			_roomGroups.Clear();
			for (int i = 0; i < _roomListRoot.childCount; i++)
			{
				_roomGroups.Add(_roomListRoot.GetChild(i).GetComponent<CharacterRoomListGroup>());
			}
		}
	}

	private void RefreshLeftBottomTxt()
	{
		bool flag = Model<InviteCharacterModel>.Interface.CurrSelectCharacterIsInTempInviteCharacterList(currSelectCharacterId);
		_leftBottomTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2659);
		if (Model<LoungeModel>.Interface.CharacterToIndex.TryGetValue(currSelectCharacterId, out var value) && Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(value, out var value2))
		{
			LoungeInteractPointUseType useType = value2.useType;
			if (useType == LoungeInteractPointUseType.LoungeInteractPointUseEmpty && !flag)
			{
				_leftBottomTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2659);
			}
			else if ((useType == LoungeInteractPointUseType.LoungeInteractPointUseEmpty) & flag)
			{
				_leftBottomTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, value2.name);
			}
			else if (useType == LoungeInteractPointUseType.LoungeInteractPointUseInvite || useType == LoungeInteractPointUseType.LoungeInteractPointUseRand)
			{
				_leftBottomTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, value2.name);
			}
		}
		int num = 0;
		foreach (KeyValuePair<int, LoungePoint> item in Model<LoungeModel>.Interface.IndexToCharacter)
		{
			if (item.Value.waitStory != 0)
			{
				num = item.Value.waitStory;
				break;
			}
		}
		if (num != 0)
		{
			LoungeStory data = CoreUtils.GetData(num, RuntimeConfigs.data.loungeStorys);
			if (data != null && data.characterId.Contains(currSelectCharacterId))
			{
				_leftBottomTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2368);
			}
		}
	}

	private void RefreshInviteText()
	{
		int todayInvitationCount = Model<LoungeModel>.Interface.TodayInvitationCount;
		int loungereInviteNumberMax = RuntimeConfigs.data.game.loungereInviteNumberMax;
		_inviteCountTextBuilder.Clear();
		_inviteCountTextBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2363));
		_inviteCountTextBuilder.Append(todayInvitationCount);
		_inviteCountTextBuilder.Append('/');
		_inviteCountTextBuilder.Append(loungereInviteNumberMax);
		_inviteTxt.text = _inviteCountTextBuilder.ToString();
		_inviteBtnTxt.text = ((todayInvitationCount == loungereInviteNumberMax) ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2370) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2364));
	}

	private void RefreshInviteBtnState()
	{
		LoungeInteractPointUseType characterStateInLounge = Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(currSelectCharacterId);
		btn_Invite.interactable = characterStateInLounge == LoungeInteractPointUseType.LoungeInteractPointUseEmpty && Model<InviteCharacterModel>.Interface.TempInviteCharacterList.Count != 0;
		RefreshGamepadInvitePrompt();
	}

	private bool CheckInvite(int currSelectCharacterId, int pointId)
	{
		if (!CanTempInviteCharacter(currSelectCharacterId, pointId))
		{
			return false;
		}
		SetCurrentCharacterSelection(currSelectCharacterId);
		List<TempInviteCharacter> tempInviteCharacterList = Model<InviteCharacterModel>.Interface.TempInviteCharacterList;
		int num = GetTempInviteIndexByPoint(pointId);
		int tempInviteIndexByCharacter = GetTempInviteIndexByCharacter(currSelectCharacterId);
		if (num >= 0)
		{
			if (tempInviteIndexByCharacter >= 0 && tempInviteIndexByCharacter != num)
			{
				tempInviteCharacterList.RemoveAt(tempInviteIndexByCharacter);
				if (tempInviteIndexByCharacter < num)
				{
					num--;
				}
			}
			tempInviteCharacterList[num].characterId = currSelectCharacterId;
			tempInviteCharacterList[num].pointId = pointId;
			return true;
		}
		if (tempInviteIndexByCharacter >= 0)
		{
			tempInviteCharacterList[tempInviteIndexByCharacter].pointId = pointId;
			return true;
		}
		if (RuntimeConfigs.data.game.loungereInviteNumberMax - Model<LoungeModel>.Interface.TodayInvitationCount - tempInviteCharacterList.Count <= 0)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.InviteCharacterCountMax);
			return false;
		}
		tempInviteCharacterList.Add(new TempInviteCharacter
		{
			characterId = currSelectCharacterId,
			pointId = pointId
		});
		return true;
	}

	private void SetCurrentCharacterSelection(int characterId)
	{
		if (characterId > 0)
		{
			currSelectCharacterId = characterId;
			if (characters == null)
			{
				characters = Model<InviteCharacterModel>.Interface.SortCharactersList();
			}
			int num = characters.FindIndex((Character character) => character != null && character.Id == characterId);
			if (num >= 0)
			{
				Model<InviteCharacterModel>.Interface.CurrSelectIndex = num;
				currSelectIndex = num;
			}
		}
	}

	private bool CanTempInviteCharacter(int characterId, int pointId)
	{
		if (characterId <= 0)
		{
			return false;
		}
		if (Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(characterId) != LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
		{
			return false;
		}
		return Model<InviteCharacterModel>.Interface.GetCharacterCanEnterPoint(pointId).Contains(characterId);
	}

	private int GetTempInviteIndexByPoint(int pointId)
	{
		List<TempInviteCharacter> tempInviteCharacterList = Model<InviteCharacterModel>.Interface.TempInviteCharacterList;
		for (int i = 0; i < tempInviteCharacterList.Count; i++)
		{
			if (tempInviteCharacterList[i].pointId == pointId)
			{
				return i;
			}
		}
		return -1;
	}

	private int GetTempInviteIndexByCharacter(int characterId)
	{
		List<TempInviteCharacter> tempInviteCharacterList = Model<InviteCharacterModel>.Interface.TempInviteCharacterList;
		for (int i = 0; i < tempInviteCharacterList.Count; i++)
		{
			if (tempInviteCharacterList[i].characterId == characterId)
			{
				return i;
			}
		}
		return -1;
	}

	private void RefreshAfterTempInviteChanged()
	{
		RefreshCharacterList();
		RefreshRoomList();
		RefreshLeftBottomTxt();
		RefreshInviteText();
		RefreshInviteBtnState();
		RefreshGamepadTipsStatus();
		RefreshGamepadRoomSelectionVisual();
	}

	public void OnInviteButtonClick(int roomListIndex, int cellIndex, int pointId, int currSelectCharacterId)
	{
		if (!TryShowCurrentCharacterOccupiedTip(pointId))
		{
			ClearSelectedRoomCharacter();
			if (CheckInvite(currSelectCharacterId, pointId))
			{
				RefreshAfterTempInviteChanged();
				Singleton<CharacterVoiceManager>.instance.PlayCharacterVoice(currSelectCharacterId);
			}
		}
	}

	public void OnPlotButtonClick(int roomListIndex, int cellIndex, int pointId, int currSelectCharacterId)
	{
		if (!TryShowCurrentCharacterOccupiedTip(pointId))
		{
			ClearSelectedRoomCharacter();
			if (CheckInvite(currSelectCharacterId, pointId))
			{
				RefreshAfterTempInviteChanged();
				Singleton<CharacterVoiceManager>.instance.PlayCharacterVoice(currSelectCharacterId);
			}
		}
	}

	public void OnForbidButtonClick(int roomListIndex, int cellIndex, int pointId, int currSelectCharacterId)
	{
		if (!TryShowCurrentCharacterOccupiedTip(pointId))
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.ForbidTips);
		}
	}

	public void OnCharacterButtonClick(int roomListIndex, int cellIndex, int pointId, int currSelectCharacterId = 0)
	{
		if (TryShowCurrentCharacterOccupiedTip(pointId))
		{
			return;
		}
		if (ShouldForbidClickCheckedInCharacter(pointId, currSelectCharacterId))
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.ForbidTips);
			return;
		}
		List<TempInviteCharacter> tempInviteCharacterList = Model<InviteCharacterModel>.Interface.TempInviteCharacterList;
		int tempInviteIndexByPoint = GetTempInviteIndexByPoint(pointId);
		if (tempInviteIndexByPoint >= 0)
		{
			if (tempInviteCharacterList[tempInviteIndexByPoint].characterId == this.currSelectCharacterId)
			{
				ClearSelectedRoomCharacter();
				tempInviteCharacterList.RemoveAt(tempInviteIndexByPoint);
				RefreshAfterTempInviteChanged();
				ChangeToGamePadInputState(InviteCharacterControllerType.CharacterList);
				return;
			}
			if (CheckInvite(this.currSelectCharacterId, pointId))
			{
				ClearSelectedRoomCharacter();
				RefreshAfterTempInviteChanged();
				return;
			}
		}
		SelectRoomCharacter(pointId, currSelectCharacterId, refreshCharacterList: true);
	}

	private bool TryShowCurrentCharacterOccupiedTip(int pointId)
	{
		switch (Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(currSelectCharacterId))
		{
		case LoungeInteractPointUseType.LoungeInteractPointUseGlobal:
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CharacterTakenPlot);
			return true;
		default:
			return false;
		case LoungeInteractPointUseType.LoungeInteractPointUseInvite:
		case LoungeInteractPointUseType.LoungeInteractPointUseRand:
			if (Model<InviteCharacterModel>.Interface.GetCharacterLoungePointId(currSelectCharacterId) == pointId)
			{
				return false;
			}
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CharacterCheckedIn);
			return true;
		}
	}

	private bool ShouldForbidClickCheckedInCharacter(int pointId, int clickedCharacterId)
	{
		if (pointId <= 0 || clickedCharacterId <= 0)
		{
			return false;
		}
		if (Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(currSelectCharacterId) != LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
		{
			return false;
		}
		if (!Model<LoungeModel>.Interface.IndexToCharacter.TryGetValue(pointId, out var value) || value.character.Count == 0)
		{
			return false;
		}
		return value.character.Contains(clickedCharacterId);
	}

	public bool IsSelectedRoomCharacter(int pointId, int characterId)
	{
		if (_selectedRoomCharacterPointId == pointId && _selectedRoomCharacterId == characterId)
		{
			return currSelectCharacterId == characterId;
		}
		return false;
	}

	private void SelectRoomCharacter(int pointId, int characterId, bool refreshCharacterList)
	{
		if (characterId <= 0)
		{
			return;
		}
		if (characters == null)
		{
			characters = Model<InviteCharacterModel>.Interface.SortCharactersList();
		}
		int num = characters.FindIndex((Character character) => character != null && character.Id == characterId);
		if (num >= 0)
		{
			currSelectCharacterId = characterId;
			Model<InviteCharacterModel>.Interface.CurrSelectIndex = num;
			_selectedRoomCharacterPointId = pointId;
			_selectedRoomCharacterId = characterId;
			if (refreshCharacterList)
			{
				RefreshCharacterList();
				_selectedRoomCharacterPointId = pointId;
				_selectedRoomCharacterId = characterId;
			}
			RefreshRoomList();
			RefreshLeftBottomTxt();
			RefreshInviteText();
			RefreshInviteBtnState();
		}
	}

	private void ClearSelectedRoomCharacter()
	{
		_selectedRoomCharacterPointId = 0;
		_selectedRoomCharacterId = 0;
	}

	private void SyncSelectedRoomCharacterForCurrentCharacter()
	{
		ClearSelectedRoomCharacter();
		if (currSelectCharacterId <= 0)
		{
			return;
		}
		if (Model<InviteCharacterModel>.Interface.TryGetTempInvitePointId(currSelectCharacterId, out var pointId))
		{
			_selectedRoomCharacterPointId = pointId;
			_selectedRoomCharacterId = currSelectCharacterId;
			return;
		}
		LoungeInteractPointUseType characterStateInLounge = Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(currSelectCharacterId);
		if (characterStateInLounge == LoungeInteractPointUseType.LoungeInteractPointUseInvite || characterStateInLounge == LoungeInteractPointUseType.LoungeInteractPointUseRand)
		{
			int characterLoungePointId = Model<InviteCharacterModel>.Interface.GetCharacterLoungePointId(currSelectCharacterId);
			if (characterLoungePointId > 0)
			{
				_selectedRoomCharacterPointId = characterLoungePointId;
				_selectedRoomCharacterId = currSelectCharacterId;
			}
		}
	}

	public void RefreshOnePoint(int characterId, int roomListIndex, int index, int pointId, ImageAssetStation station, bool isInviteRefresh)
	{
		CharacterRoomListGroup roomGroup = GetRoomGroup(roomListIndex);
		if (roomGroup != null)
		{
			roomGroup.gameObject.SetActive(value: true);
			roomGroup.RefreshOnePoint(characterId, index, pointId, station, isInviteRefresh, roomListIndex);
		}
		RefreshCharacterList();
		RefreshInviteBtnState();
		RefreshGamepadRoomSelectionVisual();
	}

	private void InitGamePadPromptBindings()
	{
		if (!_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			operateBtnPromptY?.SetBindingAction("UI/UISpecial1");
			operateBtnPromptY?.SetLocalizeString(0);
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	public void SetGamePadTipsActive(bool active)
	{
		bool flag = active && IsGamepadMode;
		gamePadTipsComp?.gameObject.SetActive(flag);
		operateBtnPromptY?.SetVisible(flag);
		if (flag)
		{
			RefreshGamepadTipsStatus();
			gamePadTipsComp?.RefreshAllPrompts();
			operateBtnPromptY?.RefreshIcon();
		}
		else
		{
			gamePadTipsComp?.ClearAllPrompts();
		}
		RefreshGamepadInvitePrompt();
		RefreshGamepadSelectionVisual();
	}

	private void RefreshGamepadTipsStatus()
	{
		if (IsGamepadMode && !(gamePadTipsComp == null))
		{
			int localizeKey = ResolveGamepadConfirmLocalizeId();
			gamePadTipsComp.RegisterInputActions(new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = localizeKey,
				localizeTable = LocalizationUtility.localizeTableName_Common
			}, new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = LocalizationUtility.localizeTableName_Common
			});
		}
	}

	private int ResolveGamepadConfirmLocalizeId()
	{
		if (_controllerType == InviteCharacterControllerType.CharacterList)
		{
			return 774;
		}
		CharacterCell selectedRoomCell = GetSelectedRoomCell();
		if (selectedRoomCell == null)
		{
			return 774;
		}
		int pointId = selectedRoomCell.PointId;
		if (IsTempInvitePoint(pointId, currSelectCharacterId))
		{
			return 14;
		}
		if (GetTempInviteIndexByPoint(pointId) < 0)
		{
			return 774;
		}
		return 51;
	}

	private void RefreshGamepadInvitePrompt()
	{
		if (!IsGamepadMode)
		{
			operateBtnPromptY?.SetVisible(vis: false);
		}
		else
		{
			operateBtnPromptY?.SetVisible(btn_Invite != null && btn_Invite.IsInteractable());
		}
	}

	public void HandleGamepadConfirm()
	{
		if (_controllerType == InviteCharacterControllerType.CharacterList)
		{
			TryEnterRoomListByGamepad();
		}
		else
		{
			ConfirmSelectedRoomCellByGamepad();
		}
	}

	private void TryEnterRoomListByGamepad()
	{
		if (characters == null || characters.Count == 0)
		{
			return;
		}
		int index = Mathf.Clamp(Model<InviteCharacterModel>.Interface.CurrSelectIndex, 0, characters.Count - 1);
		Character character = characters[index];
		if (character == null)
		{
			return;
		}
		currSelectCharacterId = character.Id;
		switch (Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(currSelectCharacterId))
		{
		case LoungeInteractPointUseType.LoungeInteractPointUseInvite:
		case LoungeInteractPointUseType.LoungeInteractPointUseRand:
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CharacterCheckedIn);
			return;
		case LoungeInteractPointUseType.LoungeInteractPointUseGlobal:
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CharacterTakenPlot);
			return;
		}
		if (!TrySelectTempInviteRoomCell(currSelectCharacterId))
		{
			TrySelectDefaultRoomCell();
		}
		ChangeToGamePadInputState(InviteCharacterControllerType.RoomList);
	}

	private void ConfirmSelectedRoomCellByGamepad()
	{
		CharacterCell selectedRoomCell = GetSelectedRoomCell();
		if (selectedRoomCell == null)
		{
			TrySelectDefaultRoomCell();
			RefreshGamepadRoomSelectionVisual();
			return;
		}
		int pointId = selectedRoomCell.PointId;
		bool flag = IsTempInvitePoint(pointId, currSelectCharacterId);
		if (selectedRoomCell.TriggerGamepadConfirm())
		{
			bool flag2 = IsTempInvitePoint(pointId, currSelectCharacterId);
			if (flag && !flag2)
			{
				ChangeToGamePadInputState(InviteCharacterControllerType.CharacterList);
				return;
			}
			RefreshGamepadTipsStatus();
			RefreshGamepadRoomSelectionVisual();
		}
	}

	public bool TryHandleGamepadBack()
	{
		if (_controllerType != InviteCharacterControllerType.RoomList)
		{
			return false;
		}
		ChangeToGamePadInputState(InviteCharacterControllerType.CharacterList);
		return true;
	}

	public void TryInviteCharacterByGamepad()
	{
		if (!(btn_Invite == null) && btn_Invite.IsInteractable())
		{
			btn_Invite.OnSubmit(null);
		}
	}

	public void MoveGamepadSelection(MoveDirection direction)
	{
		if (_controllerType == InviteCharacterControllerType.RoomList)
		{
			MoveRoomSelection(direction);
			return;
		}
		switch (direction)
		{
		case MoveDirection.Up:
			MoveCharacterSelection(-1);
			break;
		case MoveDirection.Down:
			MoveCharacterSelection(1);
			break;
		}
	}

	private void MoveCharacterSelection(int direction)
	{
		if (characters != null && characters.Count != 0 && direction != 0)
		{
			int num = Model<InviteCharacterModel>.Interface.CurrSelectIndex;
			num = ((num >= 0) ? Mathf.Clamp(num + ((direction > 0) ? 1 : (-1)), 0, characters.Count - 1) : 0);
			SelectCharacterAtIndex(num);
		}
	}

	private void SelectCharacterAtIndex(int index)
	{
		if (characters == null || characters.Count == 0 || _characterListSR == null)
		{
			return;
		}
		index = Mathf.Clamp(index, 0, characters.Count - 1);
		if (Model<InviteCharacterModel>.Interface.CurrSelectIndex == index)
		{
			currSelectCharacterId = characters[index].Id;
			SyncSelectedRoomCharacterForCurrentCharacter();
			RefreshGamepadSelectionVisual();
			return;
		}
		Model<InviteCharacterModel>.Interface.CurrSelectIndex = index;
		currSelectIndex = index;
		currSelectCharacterId = characters[index].Id;
		SyncSelectedRoomCharacterForCurrentCharacter();
		InviteCharacterCell.RevealForGamepad(_characterListSR, index);
		PublicToggle publicToggle = (_characterListSR.GetItem(index) as InviteCharacterCell)?.GetComponent<PublicToggle>();
		if (publicToggle != null)
		{
			publicToggle.isOn = true;
		}
		RefreshGamepadSelectionVisual();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_InviteCharacterRefresh, null);
	}

	public void RefreshGamepadScrollSelection()
	{
		if (characters != null && characters.Count != 0)
		{
			if (Model<InviteCharacterModel>.Interface.CurrSelectIndex < 0)
			{
				SelectCharacterAtIndex(0);
			}
			else
			{
				RefreshGamepadSelectionVisual();
			}
		}
	}

	private void MoveRoomSelection(MoveDirection direction)
	{
		if (GetSelectedRoomCell() == null && TrySelectDefaultRoomCell())
		{
			RefreshGamepadRoomSelectionVisual();
			return;
		}
		switch (direction)
		{
		case MoveDirection.Up:
			TrySelectRoomGroupByOffset(1);
			break;
		case MoveDirection.Down:
			TrySelectRoomGroupByOffset(-1);
			break;
		case MoveDirection.Left:
			TrySelectRoomCellByOffset(-1);
			break;
		case MoveDirection.Right:
			TrySelectRoomCellByOffset(1);
			break;
		}
		RefreshGamepadTipsStatus();
		RefreshGamepadRoomSelectionVisual();
	}

	private bool TrySelectDefaultRoomCell()
	{
		if (_roomListRoot == null)
		{
			return false;
		}
		for (int i = 0; i < _roomListRoot.childCount; i++)
		{
			CharacterRoomListGroup roomGroup = GetRoomGroup(i);
			if (roomGroup == null || roomGroup.groupRoot == null || !roomGroup.gameObject.activeInHierarchy)
			{
				continue;
			}
			for (int j = 0; j < roomGroup.groupRoot.childCount; j++)
			{
				CharacterCell roomCell = GetRoomCell(i, j);
				if (!(roomCell == null) && roomCell.gameObject.activeInHierarchy)
				{
					_selectedRoomGroupIndex = i;
					_selectedRoomCellIndex = j;
					return true;
				}
			}
		}
		return false;
	}

	private bool TrySelectTempInviteRoomCell(int characterId)
	{
		foreach (TempInviteCharacter tempInviteCharacter in Model<InviteCharacterModel>.Interface.TempInviteCharacterList)
		{
			if (tempInviteCharacter.characterId == characterId && TrySelectRoomCellByPointId(tempInviteCharacter.pointId))
			{
				return true;
			}
		}
		return false;
	}

	private bool TrySelectRoomCellByPointId(int pointId)
	{
		if (_roomListRoot == null)
		{
			return false;
		}
		for (int i = 0; i < _roomListRoot.childCount; i++)
		{
			CharacterRoomListGroup roomGroup = GetRoomGroup(i);
			if (roomGroup == null || roomGroup.groupRoot == null || !roomGroup.gameObject.activeInHierarchy)
			{
				continue;
			}
			for (int j = 0; j < roomGroup.groupRoot.childCount; j++)
			{
				CharacterCell roomCell = GetRoomCell(i, j);
				if (!(roomCell == null) && roomCell.PointId == pointId)
				{
					_selectedRoomGroupIndex = i;
					_selectedRoomCellIndex = j;
					return true;
				}
			}
		}
		return false;
	}

	private bool TrySelectRoomGroupByOffset(int offset)
	{
		if (_roomListRoot == null || offset == 0)
		{
			return false;
		}
		for (int i = Mathf.Clamp(_selectedRoomGroupIndex + offset, 0, _roomListRoot.childCount - 1); i >= 0 && i < _roomListRoot.childCount; i += ((offset > 0) ? 1 : (-1)))
		{
			CharacterRoomListGroup roomGroup = GetRoomGroup(i);
			if (roomGroup != null && roomGroup.groupRoot != null && roomGroup.gameObject.activeInHierarchy && roomGroup.groupRoot.childCount > 0)
			{
				_selectedRoomGroupIndex = i;
				_selectedRoomCellIndex = 0;
				return true;
			}
		}
		return false;
	}

	private bool TrySelectRoomCellByOffset(int offset)
	{
		CharacterRoomListGroup roomGroup = GetRoomGroup(_selectedRoomGroupIndex);
		if (roomGroup == null || roomGroup.groupRoot == null || offset == 0)
		{
			return false;
		}
		int num = Mathf.Clamp(_selectedRoomCellIndex + offset, 0, roomGroup.groupRoot.childCount - 1);
		CharacterCell roomCell = GetRoomCell(_selectedRoomGroupIndex, num);
		if (roomCell == null || !roomCell.gameObject.activeInHierarchy)
		{
			return false;
		}
		_selectedRoomCellIndex = num;
		return true;
	}

	private CharacterRoomListGroup GetRoomGroup(int groupIndex)
	{
		CacheRoomGroups();
		if (groupIndex < 0 || groupIndex >= _roomGroups.Count)
		{
			return null;
		}
		return _roomGroups[groupIndex];
	}

	private CharacterCell GetSelectedRoomCell()
	{
		return GetRoomCell(_selectedRoomGroupIndex, _selectedRoomCellIndex);
	}

	private CharacterCell GetRoomCell(int groupIndex, int cellIndex)
	{
		CharacterRoomListGroup roomGroup = GetRoomGroup(groupIndex);
		if (roomGroup == null || roomGroup.groupRoot == null || cellIndex < 0 || cellIndex >= roomGroup.groupRoot.childCount)
		{
			return null;
		}
		return roomGroup.groupRoot.GetChild(cellIndex).GetComponent<CharacterCell>();
	}

	private bool IsTempInvitePoint(int pointId, int characterId)
	{
		foreach (TempInviteCharacter tempInviteCharacter in Model<InviteCharacterModel>.Interface.TempInviteCharacterList)
		{
			if (tempInviteCharacter.pointId == pointId && tempInviteCharacter.characterId == characterId)
			{
				return true;
			}
		}
		return false;
	}

	private void ChangeToGamePadInputState(InviteCharacterControllerType type, bool needFocusLayer = true)
	{
		_controllerType = type;
		if (type == InviteCharacterControllerType.CharacterList)
		{
			_selectedRoomGroupIndex = -1;
			_selectedRoomCellIndex = -1;
		}
		else if (GetSelectedRoomCell() == null)
		{
			TrySelectDefaultRoomCell();
		}
		if (needFocusLayer && ViewControlLayers != null && ViewControlLayers.TryGetValue(type, out var value))
		{
			value.ReFocus();
		}
		RefreshGamepadTipsStatus();
		RefreshGamepadSelectionVisual();
	}

	private void RefreshGamepadSelectionVisual()
	{
		RefreshGamepadCharacterSelectionVisual();
		RefreshGamepadRoomSelectionVisual();
	}

	private void RefreshGamepadCharacterSelectionVisual()
	{
		if (_characterListSR == null || _characterListSR.content == null)
		{
			return;
		}
		int num = Model<InviteCharacterModel>.Interface.CurrSelectIndex;
		bool flag = IsGamepadMode && _controllerType == InviteCharacterControllerType.CharacterList;
		for (int i = 0; i < _characterListSR.content.childCount; i++)
		{
			InviteCharacterCell component = _characterListSR.content.GetChild(i).GetComponent<InviteCharacterCell>();
			if (!(component == null))
			{
				component.SetGamepadHandleVisible(flag && component.index == num);
			}
		}
	}

	private void RefreshGamepadRoomSelectionVisual()
	{
		if (_roomListRoot == null)
		{
			return;
		}
		bool flag = IsGamepadMode && _controllerType == InviteCharacterControllerType.RoomList;
		for (int i = 0; i < _roomListRoot.childCount; i++)
		{
			CharacterRoomListGroup roomGroup = GetRoomGroup(i);
			if (roomGroup == null || roomGroup.groupRoot == null)
			{
				continue;
			}
			for (int j = 0; j < roomGroup.groupRoot.childCount; j++)
			{
				CharacterCell roomCell = GetRoomCell(i, j);
				if (!(roomCell == null))
				{
					bool flag2 = IsGamepadMode && _controllerType == InviteCharacterControllerType.CharacterList && IsSelectedRoomCharacter(roomCell.PointId, currSelectCharacterId);
					roomCell.SetGamepadSelectVisible((flag && i == _selectedRoomGroupIndex && j == _selectedRoomCellIndex) | flag2);
				}
			}
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		gamePadTipsComp?.ClearAllPrompts();
		operateBtnPromptY?.SetVisible(vis: false);
		Model<InviteCharacterModel>.Interface.CurrSelectIndex = -1;
		Model<InviteCharacterModel>.Interface.ClearTempInviteCharacterList();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
