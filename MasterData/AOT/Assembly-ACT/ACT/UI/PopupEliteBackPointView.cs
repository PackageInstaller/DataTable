using ACT.Battle;
using ACT.Core;
using ACT.Game.Data;
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

public class PopupEliteBackPointView : BaseUIView<PopupEliteBackPointViewInputController>
{
	private const float LeftStickDeadZone = 0.2f;

	private const int LocalizeSelect = 774;

	private const int LocalizeReturn = 606;

	private PopupEliteBackPointViewData m_data;

	[SerializeField]
	private TextMeshProUGUI _activeLevel;

	[SerializeField]
	private TextMeshProUGUI _activeBackLevel;

	[SerializeField]
	private TextMeshProUGUI _currStageName;

	[SerializeField]
	private TextMeshProUGUI _backStageName;

	[SerializeField]
	private Image arrow;

	[SerializeField]
	private Image arrowRight;

	[SerializeField]
	private LiteItemUIComponent _personalEliteResource;

	[SerializeField]
	private ActButton confirmButton;

	[SerializeField]
	private ActButton cancelButton;

	[Header("手柄提示(分散显示)")]
	[SerializeField]
	private OperateBtnPrompt promptA_Select;

	[SerializeField]
	private OperateBtnPrompt promptB_Return;

	[SerializeField]
	private OperateBtnPrompt promptL_ItemDetail;

	[SerializeField]
	private Selectable defaultItemSelectable;

	[SerializeField]
	private ViewControlLayer btnGroupLayer;

	[SerializeField]
	private GameObject cancelHighLight;

	[SerializeField]
	private GameObject confirmHighLight;

	private bool _isConfirmFocused = true;

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
		m_data = uiViewData as PopupEliteBackPointViewData;
	}

	protected override void Init()
	{
		base.Init();
		Refresh();
		confirmButton.SetBtnClick(OnClickConfirmBtn);
		cancelButton.SetBtnClick(Close);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		OnInputModeChanged(MonoECS.instance.InputMode);
	}

	private void OnClickConfirmBtn()
	{
		m_data.OnConfirm?.Invoke();
		Close();
	}

	private void Refresh()
	{
		_activeLevel.SetText("{0:0}", m_data.activeLevel);
		_activeBackLevel.SetText("{0:0}", m_data.backLevel);
		int eliteIconByActiveLevel = Model<EliteModel>.Interface.GetEliteIconByActiveLevel(m_data.activeLevel);
		if (RuntimeConfigs.data.eliteTrainingStages.TryGetValue(eliteIconByActiveLevel, out var value))
		{
			_currStageName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.name);
		}
		_backStageName.gameObject.SetActive(m_data.isTriggerStageDown);
		arrow.gameObject.SetActive(m_data.isTriggerStageDown);
		arrowRight.gameObject.SetActive(m_data.isTriggerStageDown);
		if (RuntimeConfigs.data.eliteTrainingStages.TryGetValue(m_data.backStage + 1, out var value2))
		{
			_backStageName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value2.name);
		}
		RefreshItem();
	}

	private void RefreshItem()
	{
		Item item = new Item();
		item.Id = m_data.characterEliteItemId;
		item.Count = m_data.backCostCount;
		_personalEliteResource.Station = Station;
		_personalEliteResource.SetData(item, 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		_personalEliteResource.gameObject.SetActive(value: true);
		_personalEliteResource.UpdatePerformance();
		_personalEliteResource.showDetailPanel = true;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectCallback();
			}).Play();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		RefreshOperatePrompts(gamepadActive: false);
		RefreshBtnGroupHighLight(show: false);
		RefreshLevelUpNewPromptIfNeeded();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				CloseEffectCallback();
			}).Play();
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
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
			SetupOperatePromptContent();
			FocusBtnGroupLayer();
			SelectButtonFocus(focusConfirm: true);
			RefreshOperatePrompts(gamepadActive: true);
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
		Close();
	}

	public void HandleGamepadLeftStickClick()
	{
		Selectable selectable = ResolveItemSelectable();
		if (!(selectable == null))
		{
			selectable.Select();
			EventSystemHelper.SetSelectedGameObject(selectable.gameObject);
			ExecuteEvents.Execute(selectable.gameObject, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
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

	private void SelectButtonFocus(bool focusConfirm)
	{
		_isConfirmFocused = focusConfirm;
		(focusConfirm ? confirmButton : cancelButton)?.Select();
		RefreshBtnGroupHighLight(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private Selectable ResolveItemSelectable()
	{
		if (defaultItemSelectable != null)
		{
			return defaultItemSelectable;
		}
		if (!(_personalEliteResource != null))
		{
			return null;
		}
		return _personalEliteResource.GetComponentInChildren<Selectable>(includeInactive: true);
	}

	private void RefreshBtnGroupHighLight(bool show)
	{
		if (confirmHighLight != null)
		{
			confirmHighLight.SetActive(show && _isConfirmFocused);
		}
		if (cancelHighLight != null)
		{
			cancelHighLight.SetActive(show && !_isConfirmFocused);
		}
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
		promptA_Select?.SetVisible(gamepadActive);
		promptB_Return?.SetVisible(gamepadActive);
		promptL_ItemDetail?.SetVisible(gamepadActive);
	}

	private void SetupOperatePromptContent()
	{
		ConfigurePrompt(promptA_Select, "LargeMapView/Select", 774);
		ConfigurePrompt(promptB_Return, "LargeMapView/Return", 606);
		ConfigurePrompt(promptL_ItemDetail, "UI/ImportCollect", 0);
	}

	private static void ConfigurePrompt(OperateBtnPrompt prompt, string bindingAction, int localizeKey)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetLocalizeString(localizeKey);
		}
	}

	private static void RefreshLevelUpNewPromptIfNeeded()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW) == UIState.Opened && Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_POPUPELITELEVELUPNEW, out var ui) && ui.GetUIView() is PopupEliteLevelUpNewView popupEliteLevelUpNewView)
		{
			popupEliteLevelUpNewView.ForceRefreshGamepadPromptsAfterChildPopupClose();
		}
	}
}
