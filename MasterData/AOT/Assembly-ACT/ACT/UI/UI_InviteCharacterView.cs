using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Sound.Management;
using ACT.UI.InputController;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Lumin.LoungeSystem;
using Lumin.LoungeSystem.UI;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class UI_InviteCharacterView : BaseUIView<InviteCharacterViewInputController>
{
	private UI_InviteCharacterViewData m_data;

	[SerializeField]
	private ActButton btn_Invite;

	[SerializeField]
	private ActButton btn_Close;

	[SerializeField]
	private LoopVerticalScrollRect _characterListSR;

	[SerializeField]
	private TextMeshProUGUI _inviteTxt;

	[SerializeField]
	private TextMeshProUGUI _inviteBtnTxt;

	[SerializeField]
	public PublicToggleGroup toggleGroup;

	[SerializeField]
	public GameObject prompBoard;

	[Tooltip("B键")]
	public OperateBtnPrompt operateBtnPromptB;

	[Tooltip("Y键")]
	public OperateBtnPrompt operateBtnPromptY;

	private const int LocalizeIDB = 606;

	private List<Character> characters;

	private int currSelectCharacterId;

	private int currSelectIndex = -1;

	private int inviteCharacterCount;

	private int tempModelCharacterId;

	private LoungeInteractPointUseType type;

	private bool _gamepadPromptInited;

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
		m_data = uiViewData as UI_InviteCharacterViewData;
		Model<InviteCharacterModel>.Interface.SingleInviteCharacterPointId = m_data.pointId;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected override void Init()
	{
		base.Init();
		inviteCharacterCount = 0;
		tempModelCharacterId = 0;
		btn_Invite.SetBtnClick(InviteCharacter);
		btn_Close.SetBtnClick(Close);
		InitGamePadPromptBindings();
		RefreshCharacterList();
		RefreshInviteText();
		InitModel();
		SetGamePadTipsActive(IsGamepadMode);
	}

	private void InitModel()
	{
		if (characters.Count != 0)
		{
			Character character = characters[0];
			currSelectCharacterId = character.Id;
			int pointId = m_data.pointId;
			if (Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(currSelectCharacterId) == LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
			{
				LoungeUIScene.instance.ShowTempDimModel(pointId, currSelectCharacterId);
				tempModelCharacterId = currSelectCharacterId;
			}
		}
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

	private void RefreshInviteText()
	{
		int todayInvitationCount = Model<LoungeModel>.Interface.TodayInvitationCount;
		int loungereInviteNumberMax = RuntimeConfigs.data.game.loungereInviteNumberMax;
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2363));
		stringBuilder.Append($"{todayInvitationCount}/{loungereInviteNumberMax}");
		_inviteTxt.text = stringBuilder.ToString();
		type = Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(currSelectCharacterId);
		if (todayInvitationCount == loungereInviteNumberMax)
		{
			_inviteBtnTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2370);
			SetBtnState(active: false);
		}
		else if (type == LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
		{
			_inviteBtnTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2364);
			SetBtnState(active: true);
		}
		else if (type == LoungeInteractPointUseType.LoungeInteractPointUseInvite || type == LoungeInteractPointUseType.LoungeInteractPointUseRand)
		{
			_inviteBtnTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2369);
			SetBtnState(active: false);
		}
		else
		{
			_inviteBtnTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2368);
			SetBtnState(active: false);
		}
	}

	private void SetBtnState(bool active)
	{
		btn_Invite.Interactable(active);
		RefreshGamepadInvitePrompt();
	}

	private void InitGamePadPromptBindings()
	{
		if (!_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			operateBtnPromptB?.SetBindingAction("UI/Back");
			operateBtnPromptB?.SetLocalizeString(606);
			operateBtnPromptY?.SetBindingAction("UI/UISpecial1");
			operateBtnPromptY?.SetLocalizeString(0);
		}
	}

	public void SetGamePadTipsActive(bool active)
	{
		bool flag = active && IsGamepadMode;
		prompBoard?.SetActive(flag);
		operateBtnPromptB?.SetVisible(flag);
		operateBtnPromptY?.SetVisible(flag);
		if (flag)
		{
			operateBtnPromptB?.RefreshIcon();
			operateBtnPromptY?.RefreshIcon();
		}
		RefreshGamepadInvitePrompt();
		RefreshGamepadSelectionVisual();
	}

	private void RefreshGamepadInvitePrompt()
	{
		if (!IsGamepadMode)
		{
			operateBtnPromptY?.SetVisible(vis: false);
			return;
		}
		bool visible = btn_Invite != null && btn_Invite.IsInteractable();
		operateBtnPromptY?.SetVisible(visible);
	}

	public void MoveGamepadSelection(int direction)
	{
		if (characters == null || characters.Count == 0 || direction == 0)
		{
			return;
		}
		int num = Model<InviteCharacterModel>.Interface.CurrSelectIndex;
		if (num < 0)
		{
			num = 0;
		}
		else
		{
			num += ((direction > 0) ? 1 : (-1));
			if (num >= characters.Count)
			{
				num = characters.Count - 1;
			}
			else if (num < 0)
			{
				num = 0;
			}
		}
		SelectCharacterAtIndex(num);
	}

	public void SelectCharacterAtIndex(int index)
	{
		if (characters == null || characters.Count == 0 || _characterListSR == null)
		{
			return;
		}
		index = Mathf.Clamp(index, 0, characters.Count - 1);
		if (Model<InviteCharacterModel>.Interface.CurrSelectIndex == index)
		{
			RefreshGamepadSelectionVisual();
			return;
		}
		Model<InviteCharacterModel>.Interface.CurrSelectIndex = index;
		currSelectIndex = index;
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

	public void RefreshGamepadSelectionVisual()
	{
		if (_characterListSR == null || _characterListSR.content == null)
		{
			return;
		}
		bool isGamepadMode = IsGamepadMode;
		int num = Model<InviteCharacterModel>.Interface.CurrSelectIndex;
		for (int i = 0; i < _characterListSR.content.childCount; i++)
		{
			InviteCharacterCell component = _characterListSR.content.GetChild(i).GetComponent<InviteCharacterCell>();
			if (!(component == null))
			{
				component.SetGamepadHandleVisible(isGamepadMode && component.index == num);
			}
		}
	}

	public void TryInviteCharacterByGamepad()
	{
		if (!(btn_Invite == null) && btn_Invite.IsInteractable())
		{
			SubmitInviteButton();
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	private void RefreshCharacterList()
	{
		characters = Model<InviteCharacterModel>.Interface.SortCharactersList(m_data.pointId);
		_characterListSR.ClearCells();
		_characterListSR.totalCount = characters.Count;
		_characterListSR.RefillCells();
		Model<InviteCharacterModel>.Interface.CurrSelectIndex = 0;
		PublicToggle component = (_characterListSR.GetItem(Model<InviteCharacterModel>.Interface.CurrSelectIndex) as InviteCharacterCell).GetComponent<PublicToggle>();
		if (component != null)
		{
			component.isOn = true;
		}
		RefreshGamepadSelectionVisual();
	}

	private void InviteCharacter()
	{
		Action confirmClick = () =>
		{
			int characterId = currSelectCharacterId;
			int pointId = m_data.pointId;
			Action callback = () =>
			{
				inviteCharacterCount++;
				Close();
			};
			Singleton<LoungeSystemManager>.instance.InviteCharacter(characterId, pointId, callback);
		};
		bool canTrrigerStory = Model<InviteCharacterModel>.Interface.HasPlotAtPoint(currSelectCharacterId, m_data.pointId);
		bool hasPlot = Model<InviteCharacterModel>.Interface.CharacterHasActivePlot(currSelectCharacterId);
		List<InviteCharacterConfirmPanelData> list = new List<InviteCharacterConfirmPanelData>();
		list.Add(new InviteCharacterConfirmPanelData
		{
			characterId = currSelectCharacterId,
			pointId = m_data.pointId,
			canTrrigerStory = canTrrigerStory,
			hasPlot = hasPlot
		});
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_INVITECHARACTERCONFIRM, new UI_InviteCharacterConfirmViewData
		{
			topTipsCommonId = 2365,
			redTipsCommonId = 2367,
			bottomCommonId = 2366,
			characterList = list,
			confirmClick = confirmClick
		});
	}

	private void SubmitInviteButton()
	{
		if (!(btn_Invite == null))
		{
			ExecuteEvents.Execute(btn_Invite.gameObject, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	private void OnRefreshView(BaseEventContent obj)
	{
		if (characters.Count == 0 || Model<InviteCharacterModel>.Interface.CurrSelectIndex < 0)
		{
			return;
		}
		Character character = characters[Model<InviteCharacterModel>.Interface.CurrSelectIndex];
		if (currSelectCharacterId != character.Id)
		{
			currSelectCharacterId = character.Id;
			int pointId = m_data.pointId;
			if (Model<InviteCharacterModel>.Interface.GetCharacterStateInLounge(currSelectCharacterId) == LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
			{
				LoungeUIScene.instance.ShowTempDimModel(pointId, currSelectCharacterId);
				tempModelCharacterId = currSelectCharacterId;
				Singleton<CharacterVoiceManager>.instance.PlayCharacterVoice(currSelectCharacterId);
			}
			RefreshInviteText();
			RefreshGamepadSelectionVisual();
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		Model<InviteCharacterModel>.Interface.CurrSelectIndex = -1;
		SetGamePadTipsActive(active: false);
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
		if (inviteCharacterCount == 0)
		{
			int pointId = m_data.pointId;
			if (tempModelCharacterId != 0)
			{
				LoungeUIScene.instance.RemoveTempDimModel(pointId, tempModelCharacterId);
			}
			LoungeUIScene.instance.ResetToEmptyState();
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
	}
}
