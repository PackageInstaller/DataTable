using System.Collections.Generic;
using ACT.Battle;
using ACT.Game.Data;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupEliteLevelUpView : BaseUIView<PopupEliteLevelUpViewInputController>
{
	private const float LeftStickDeadZone = 0.2f;

	private const int LocalizeSelect = 774;

	private const int LocalizeReturn = 606;

	private PopupEliteLevelUpViewData m_data;

	public LiteItemUIComponent itemCharacterCell;

	public LiteItemUIComponent itemGenericCell;

	public PublicToggle toggleSilence;

	public TextMeshProUGUI TipText;

	[SerializeField]
	private ActButton btn_Cancel;

	[SerializeField]
	private ActButton btn_Confirm;

	[Header("手柄提示(分散显示)")]
	[SerializeField]
	private OperateBtnPrompt promptA_Select;

	[SerializeField]
	private OperateBtnPrompt promptB_Return;

	[SerializeField]
	private OperateBtnPrompt promptX_ToggleSilence;

	[SerializeField]
	private OperateBtnPrompt promptL_ItemDetail;

	[OdinSerialize]
	public Dictionary<PopupEliteLevelUpSubControllerType, ViewControlLayer> ViewControlLayers;

	[SerializeField]
	private Selectable defaultItemSelectable;

	[SerializeField]
	private GameObject cancelHighLight;

	[SerializeField]
	private GameObject confirmHighLight;

	private bool _isItemSelectMode;

	private bool _isConfirmFocused = true;

	public bool IsItemSelectMode => _isItemSelectMode;

	public bool IsInItemSelectContext => IsCurrentlyInItemSelectMode();

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
		m_data = uiViewData as PopupEliteLevelUpViewData;
	}

	protected override void Init()
	{
		base.Init();
		RefreshGenericItem();
		RefreshCharacterItem();
		TipText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2304);
		btn_Cancel.SetBtnClick(CloseView);
		btn_Confirm.SetBtnClick(OnConfirmClick);
		_isItemSelectMode = false;
		SetupOperatePromptContent();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		OnInputModeChanged(MonoECS.instance.InputMode);
	}

	private void OnConfirmClick()
	{
		m_data?.OnConfirm?.Invoke();
		if (m_data.showSilence && toggleSilence.isOn)
		{
			m_data.OnClickSilence?.Invoke(toggleSilence.isOn);
		}
		Close();
	}

	private void CloseView()
	{
		Close();
	}

	private void RefreshGenericItem()
	{
		Item item = new Item();
		item.Id = m_data.item_generic.id;
		item.Count = m_data.changeNumber;
		itemGenericCell.Station = Station;
		itemGenericCell.SetData(item, 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		itemGenericCell.gameObject.SetActive(value: true);
		itemGenericCell.UpdatePerformance();
		itemGenericCell.showDetailPanel = true;
	}

	private void RefreshCharacterItem()
	{
		Item item = new Item();
		item.Id = m_data.item_character.id;
		item.Count = m_data.changeNumber;
		itemCharacterCell.Station = Station;
		itemCharacterCell.SetData(item, 0L, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		itemCharacterCell.gameObject.SetActive(value: true);
		itemCharacterCell.UpdatePerformance();
		itemCharacterCell.showDetailPanel = true;
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
		if (IsCurrentlyInItemSelectMode())
		{
			_isItemSelectMode = false;
			SwitchToSubController(PopupEliteLevelUpSubControllerType.BtnGroup);
			RefreshOperatePrompts(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
		else
		{
			base.Close();
		}
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		if (mode != DeviceInputMode.Gamepad)
		{
			_isItemSelectMode = false;
			UnFocusAllLayers();
			RefreshBtnGroupHighLight(show: false);
			RefreshOperatePrompts(gamepadActive: false);
		}
		else
		{
			SwitchToSubController(PopupEliteLevelUpSubControllerType.BtnGroup);
			RefreshOperatePrompts(gamepadActive: true);
		}
	}

	public void HandleGamepadLeftStickHorizontal(float value)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && !(Mathf.Abs(value) < 0.2f))
		{
			if (IsCurrentlyInItemSelectMode())
			{
				MoveSelection((value > 0f) ? MoveDirection.Right : MoveDirection.Left);
			}
			else
			{
				SelectButtonFocus(value > 0f);
			}
		}
	}

	public void HandleGamepadSubmit()
	{
		TrySubmitCurrentSelection();
	}

	public void HandleGamepadCancel(bool forceExitSelectMode = false)
	{
		bool flag = IsCurrentlyInItemSelectMode();
		bool flag2 = IsEventSelectionOnItemNode();
		if (forceExitSelectMode | flag | flag2)
		{
			_isItemSelectMode = false;
			SwitchToSubController(PopupEliteLevelUpSubControllerType.BtnGroup);
			RefreshOperatePrompts(gamepadActive: true);
		}
		else
		{
			Close();
		}
	}

	public void HandleGamepadLeftStickClick()
	{
		if (!IsCurrentlyInItemSelectMode())
		{
			_isItemSelectMode = true;
			SwitchToSubController(PopupEliteLevelUpSubControllerType.List);
			RefreshOperatePrompts(gamepadActive: true);
		}
	}

	public void HandleGamepadXToggleSilence()
	{
		if (!(toggleSilence == null) && m_data != null && m_data.showSilence)
		{
			toggleSilence.isOn = !toggleSilence.isOn;
		}
	}

	private void SelectButtonFocus(bool focusConfirm)
	{
		_isConfirmFocused = focusConfirm;
		ActButton actButton = (focusConfirm ? btn_Confirm : btn_Cancel);
		if (actButton != null)
		{
			actButton.Select();
		}
		RefreshBtnGroupHighLight(!IsCurrentlyInItemSelectMode() && MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void SelectItemFocus()
	{
		Selectable selectable = ResolveItemSelectable();
		if (!(selectable == null))
		{
			selectable.Select();
			if (EventSystemHelper.Available)
			{
				EventSystemHelper.SetSelectedGameObject(selectable.gameObject);
			}
		}
	}

	private Selectable ResolveItemSelectable()
	{
		if (defaultItemSelectable != null)
		{
			return defaultItemSelectable;
		}
		Selectable selectable = ((itemCharacterCell != null) ? itemCharacterCell.GetComponentInChildren<Selectable>(includeInactive: true) : null);
		if ((object)selectable == null)
		{
			selectable = ((itemGenericCell != null) ? itemGenericCell.GetComponentInChildren<Selectable>(includeInactive: true) : null);
		}
		return selectable;
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

	private static void MoveSelection(MoveDirection moveDirection)
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			AxisEventData eventData = new AxisEventData(EventSystemHelper.Shared)
			{
				moveDir = moveDirection
			};
			ExecuteEvents.Execute(currentSelected, eventData, ExecuteEvents.moveHandler);
		}
	}

	private void RefreshOperatePrompts(bool gamepadActive)
	{
		bool flag = IsCurrentlyInItemSelectMode();
		promptA_Select?.SetVisible(gamepadActive);
		promptB_Return?.SetVisible(gamepadActive);
		bool visible = gamepadActive && !flag && m_data != null && m_data.showSilence && toggleSilence != null;
		promptX_ToggleSilence?.SetVisible(visible);
		promptL_ItemDetail?.SetVisible(gamepadActive && !flag);
	}

	private void SetupOperatePromptContent()
	{
		ConfigurePrompt(promptA_Select, "LargeMapView/Select", 774);
		ConfigurePrompt(promptB_Return, "LargeMapView/Return", 606);
		ConfigurePrompt(promptL_ItemDetail, "UI/ImportCollect", 0);
		ConfigurePrompt(promptX_ToggleSilence, "LargeMapView/MapTemple", 0);
	}

	private static void ConfigurePrompt(OperateBtnPrompt prompt, string bindingAction, int localizeKey)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(bindingAction);
			prompt.SetLocalizeString(localizeKey);
		}
	}

	private void SwitchToSubController(PopupEliteLevelUpSubControllerType target)
	{
		if (ViewControlLayers != null)
		{
			foreach (KeyValuePair<PopupEliteLevelUpSubControllerType, ViewControlLayer> viewControlLayer in ViewControlLayers)
			{
				if (!(viewControlLayer.Value == null))
				{
					if (viewControlLayer.Key == target)
					{
						viewControlLayer.Value.Focus();
						viewControlLayer.Value.ReFocus();
					}
					else
					{
						viewControlLayer.Value.UnFocus();
					}
				}
			}
		}
		if (target == PopupEliteLevelUpSubControllerType.BtnGroup)
		{
			SelectButtonFocus(focusConfirm: true);
			return;
		}
		SelectItemFocus();
		RefreshBtnGroupHighLight(show: false);
	}

	private void UnFocusAllLayers()
	{
		if (ViewControlLayers == null)
		{
			return;
		}
		foreach (KeyValuePair<PopupEliteLevelUpSubControllerType, ViewControlLayer> viewControlLayer in ViewControlLayers)
		{
			viewControlLayer.Value?.UnFocus();
		}
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

	private bool IsCurrentlyInItemSelectMode()
	{
		if (_isItemSelectMode)
		{
			return true;
		}
		if (ViewControlLayers == null || !ViewControlLayers.TryGetValue(PopupEliteLevelUpSubControllerType.List, out var value) || value == null)
		{
			return false;
		}
		if (value.Root != null && value.Root.CurrentFocusLayer == value)
		{
			return true;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			return false;
		}
		Transform parent = ((value.DefaultFindRoot != null) ? value.DefaultFindRoot : value.transform);
		return currentSelected.transform.IsChildOf(parent);
	}

	private bool IsEventSelectionOnItemNode()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			return false;
		}
		if (currentSelected.GetComponentInParent<LiteItemUIComponent>(includeInactive: true) != null)
		{
			return true;
		}
		if (itemCharacterCell != null && currentSelected.transform.IsChildOf(itemCharacterCell.transform))
		{
			return true;
		}
		if (itemGenericCell != null && currentSelected.transform.IsChildOf(itemGenericCell.transform))
		{
			return true;
		}
		return false;
	}
}
