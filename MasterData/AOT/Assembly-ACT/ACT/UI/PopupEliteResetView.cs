using ACT.Battle;
using ACT.Game.Data;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupEliteResetView : BaseUIView<PopupEliteResetViewInputController>
{
	private const float LeftStickDeadZone = 0.2f;

	private const int LocalizeSelect = 774;

	private const int LocalizeReturn = 606;

	private PopupEliteResetViewData m_data;

	public LiteItemUIComponent itemCell;

	[SerializeField]
	private ActButton btn_Cancel;

	[SerializeField]
	private ActButton btn_Confirm;

	[Header("手柄提示(分散显示) ")]
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
		m_data = uiViewData as PopupEliteResetViewData;
	}

	protected override void Init()
	{
		base.Init();
		RefreshItem();
		btn_Cancel.SetBtnClick(CloseView);
		btn_Confirm.SetBtnClick(OnConfirmClick);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		OnInputModeChanged(MonoECS.instance.InputMode);
	}

	private void OnConfirmClick()
	{
		m_data?.OnConfirm?.Invoke();
		Close();
	}

	private void CloseView()
	{
		Close();
	}

	private void RefreshItem()
	{
		Item item = new Item();
		item.Id = m_data.itemData.id;
		item.Count = m_data.allCost;
		itemCell.Station = Station;
		itemCell.SetData(item, 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		itemCell.gameObject.SetActive(value: true);
		itemCell.UpdatePerformance();
		itemCell.showDetailPanel = true;
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

	private void SelectButtonFocus(bool focusConfirm)
	{
		_isConfirmFocused = focusConfirm;
		(focusConfirm ? btn_Confirm : btn_Cancel)?.Select();
		RefreshBtnGroupHighLight(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private Selectable ResolveItemSelectable()
	{
		if (defaultItemSelectable != null)
		{
			return defaultItemSelectable;
		}
		if (!(itemCell != null))
		{
			return null;
		}
		return itemCell.GetComponentInChildren<Selectable>(includeInactive: true);
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
