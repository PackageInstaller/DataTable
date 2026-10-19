using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Core;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class UI_InviteCharacterConfirmView : BaseUIView<InviteCharacterConfirmViewInputController>
{
	private const float LeftStickDeadZone = 0.2f;

	private const int LocalizeSelect = 774;

	private const int LocalizeReturn = 606;

	private UI_InviteCharacterConfirmViewData m_data;

	[SerializeField]
	private TextMeshProUGUI topTipsTxt;

	[SerializeField]
	private RectTransform redTipsRoot;

	[SerializeField]
	private TextMeshProUGUI redTipsTxt;

	[SerializeField]
	private LocalizeStringEvent bottomTipsTxt;

	[SerializeField]
	private LoopHorizontalScrollRect _playerList;

	[SerializeField]
	private ActButton btn_Cancel;

	[SerializeField]
	private ActButton btn_Confirm;

	[SerializeField]
	private OperateBtnPrompt promptASelect;

	[SerializeField]
	private OperateBtnPrompt promptBReturn;

	[SerializeField]
	private ViewControlLayer btnGroupLayer;

	[SerializeField]
	private GameObject cancelHighLight;

	[SerializeField]
	private GameObject confirmHighLight;

	private bool _isConfirmFocused = true;

	private bool _gamepadPromptInited;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as UI_InviteCharacterConfirmViewData;
		Model<InviteCharacterModel>.Interface.InviteCharacterList = m_data.characterList;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected override void Init()
	{
		base.Init();
		btn_Cancel.SetBtnClick(CloseView);
		btn_Confirm.SetBtnClick(OnConfirmClick);
		InitGamePadPromptBindings();
		RefreshView();
		RefreshCharacterList();
		OnInputModeChanged(MonoECS.instance.InputMode);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
	}

	private void RefreshCharacterList()
	{
		_playerList.ClearCells();
		_playerList.totalCount = m_data.characterList.Count;
		_playerList.RefillCells();
	}

	private void RefreshView()
	{
		int todayInvitationCount = Model<LoungeModel>.Interface.TodayInvitationCount;
		int loungereInviteNumberMax = RuntimeConfigs.data.game.loungereInviteNumberMax;
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, m_data.topTipsCommonId));
		stringBuilder.Append(todayInvitationCount);
		stringBuilder.Append("/");
		stringBuilder.Append(loungereInviteNumberMax);
		topTipsTxt.text = stringBuilder.ToString();
		bottomTipsTxt.StringReference.TableEntryReference = m_data.bottomCommonId;
		redTipsRoot.gameObject.SetActive(value: false);
		redTipsTxt.gameObject.SetActive(value: false);
		List<string> list = new List<string>();
		foreach (InviteCharacterConfirmPanelData character in m_data.characterList)
		{
			if (RuntimeConfigs.data.entityDatas.TryGetValue(character.characterId, out var value) && value != null)
			{
				string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.nameLocal);
				if (character.hasPlot && !character.canTrrigerStory)
				{
					list.Add(localizeString);
				}
			}
		}
		if (list.Count > 0)
		{
			redTipsRoot.gameObject.SetActive(value: true);
			redTipsTxt.gameObject.SetActive(value: true);
			string text = FormatCharacterNames(list);
			redTipsTxt.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2367, new object[1] { text });
		}
	}

	private string FormatCharacterNames(List<string> characterNames)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < characterNames.Count; i++)
		{
			stringBuilder.Append(characterNames[i]);
			if (i < characterNames.Count - 1)
			{
				stringBuilder.Append("、");
			}
		}
		return stringBuilder.ToString();
	}

	private void OnConfirmClick()
	{
		m_data?.confirmClick?.Invoke();
		Close();
	}

	private void CloseView()
	{
		Close();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			FocusBtnGroupLayer();
			SelectButtonFocus(focusConfirm: true);
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		RefreshOperatePrompts(gamepadActive: false);
		RefreshBtnGroupHighLight(show: false);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Close");
	}

	private void InitGamePadPromptBindings()
	{
		if (!_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			ConfigurePrompt(promptASelect, "UI/Confirm", 774);
			ConfigurePrompt(promptBReturn, "UI/Back", 606);
		}
	}

	private static void ConfigurePrompt(OperateBtnPrompt prompt, string bindingAction, int localizeKey)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetLocalizeString(localizeKey);
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		if (mode != DeviceInputMode.Gamepad)
		{
			btnGroupLayer?.UnFocus();
			RefreshOperatePrompts(gamepadActive: false);
			RefreshBtnGroupHighLight(show: false);
		}
		else
		{
			FocusBtnGroupLayer();
			SelectButtonFocus(focusConfirm: true);
			RefreshOperatePrompts(gamepadActive: true);
		}
	}

	private void FocusBtnGroupLayer()
	{
		if (!(btnGroupLayer == null))
		{
			btnGroupLayer.Focus();
			btnGroupLayer.ReFocus();
		}
	}

	public void HandleGamepadLeftStickHorizontal(float value)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && !(Mathf.Abs(value) < 0.2f))
		{
			SelectButtonFocus(value > 0f);
		}
	}

	public void HandleGamepadSubmit()
	{
		TrySubmitCurrentSelection();
	}

	public void HandleGamepadCancel()
	{
		CloseView();
	}

	private void SelectButtonFocus(bool focusConfirm)
	{
		_isConfirmFocused = focusConfirm;
		(focusConfirm ? btn_Confirm : btn_Cancel)?.Select();
		RefreshBtnGroupHighLight(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void RefreshBtnGroupHighLight(bool show)
	{
		confirmHighLight?.SetActive(show && _isConfirmFocused);
		cancelHighLight?.SetActive(show && !_isConfirmFocused);
	}

	private static void TrySubmitCurrentSelection()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	private void RefreshOperatePrompts(bool gamepadActive)
	{
		promptASelect?.SetVisible(gamepadActive);
		if (gamepadActive)
		{
			promptASelect?.RefreshIcon();
		}
		promptBReturn?.SetVisible(gamepadActive);
		if (gamepadActive)
		{
			promptBReturn?.RefreshIcon();
		}
	}
}
