using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.UI.InputController.EliteViewController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopupEliteLevelUpNewView : BaseUIView<PopupEliteLevelUpNewViewInputController>
{
	private PopupEliteLevelUpNewViewData m_data;

	private PopupEliteLevelUpViewSubControllerType _currentSubControllerType;

	private bool _xLongPressTriggered;

	private bool _xPressActive;

	private float _xPressStartTimeUnscaled;

	private const float XLongPressSeconds = 1f;

	private const float XShortTapMaxSeconds = 0.25f;

	public EliteLevelUpPanelNew eliteLevelUpPanelNew;

	[SerializeField]
	private EliteDiscComponent eliteDiscComponent;

	[OdinSerialize]
	public Dictionary<PopupEliteLevelUpViewSubControllerType, ViewControlLayer> ViewControlLayers;

	[Header("空白点击")]
	public ActButton emptyClickAreaBtn;

	[SerializeField]
	private CommonCoinComponent commonEliteResource;

	[SerializeField]
	private CommonCoinComponent personalEliteResource;

	[SerializeField]
	private OperateBtnPrompt eliteCurrencyPrompt;

	public EliteDiscComponent EliteDisc => eliteDiscComponent;

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
		m_data = uiViewData as PopupEliteLevelUpNewViewData;
	}

	protected override void Init()
	{
		base.Init();
		eliteLevelUpPanelNew.BindEliteDiscComponent(eliteDiscComponent);
		eliteLevelUpPanelNew.InitPointIndex(Model<EliteModel>.Interface.GetElitePointIndex(m_data.character, m_data.elitePointId));
		eliteLevelUpPanelNew.InitPanel(m_data, Station);
		eliteLevelUpPanelNew.PlayShowAnimation();
		InitEliteTokenInfo(m_data.character);
		RefreshTrialCharacterResourceVisibility(m_data.character);
		if (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CHARACTER) is CharacterView characterView)
		{
			characterView.RefreshEliteMainGamepadTips();
		}
		eliteDiscComponent.SetDiscParam(isPopupDisplayDisc: true);
		eliteDiscComponent.Init(m_data.character, Station, m_data.elitePointId, m_data.indexOfThreeProgress);
		eliteDiscComponent.RefreshCurrentSelectionVisual();
		_currentSubControllerType = PopupEliteLevelUpViewSubControllerType.ElitePoints;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		OnInputModeChanged(MonoECS.instance.InputMode);
		emptyClickAreaBtn.SetBtnClick(OnEmptyClickAreaBtn);
	}

	private void OnEmptyClickAreaBtn()
	{
		eliteLevelUpPanelNew.SetRightRootVisible(b: false);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		UnFocusAllLayers();
		eliteDiscComponent?.gamePadTipsComp?.GetPrompt("UI/LongPressX")?.OnBindingPressed(isPressed: false);
		_xPressActive = false;
		_xLongPressTriggered = false;
		base.UnInit();
		eliteLevelUpPanelNew.PlayHideAnimation();
		eliteDiscComponent.SetParticleSystemInVisible();
		if (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CHARACTER) is CharacterView characterView)
		{
			RefreshMainEliteDiscAfterClose();
			characterView.RefreshEliteMainGamepadTips(eliteLevelUpNewPopupJustClosed: true);
		}
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
		SetCharacterViewCanvasGroup();
		base.Close();
	}

	private void SetCharacterViewCanvasGroup()
	{
		CharacterViewCanvasGroupRefreshEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterViewCanvasGroupRefreshEvt>();
		evt.alphaValue = 1f;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SetCharacterViewCanvasGroup, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void InitEliteTokenInfo(Character character)
	{
		if (character != null)
		{
			EntityCharacterData data = CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas);
			RefreshEliteResource(commonEliteResource, data.eliteElementItem);
			RefreshEliteResource(personalEliteResource, data.eliteCharacterItem);
		}
	}

	private static void RefreshEliteResource(CommonCoinComponent resource, int itemId)
	{
		if (!(resource == null))
		{
			EliteResourceIconRefresher.Refresh(resource, itemId);
		}
	}

	private void RefreshTrialCharacterResourceVisibility(Character character)
	{
		bool active = character != null && !character.IsTrailCharacter;
		if (commonEliteResource != null)
		{
			commonEliteResource.gameObject.SetActive(active);
		}
		if (personalEliteResource != null)
		{
			personalEliteResource.gameObject.SetActive(active);
		}
	}

	private void RefreshMainEliteDiscAfterClose()
	{
		ElitePointLevelChange evt = Singleton<EventManager>.instance.GetEvt<ElitePointLevelChange>();
		evt.isLevelUp = false;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.EliteRefreshDisc, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		if (mode != DeviceInputMode.Gamepad)
		{
			_currentSubControllerType = PopupEliteLevelUpViewSubControllerType.ElitePoints;
			UnFocusAllLayers();
			RefreshEliteCurrencyPrompt();
			return;
		}
		if (_currentSubControllerType == PopupEliteLevelUpViewSubControllerType.SelectConsumeItem)
		{
			SwitchToSubController(PopupEliteLevelUpViewSubControllerType.SelectConsumeItem);
			eliteLevelUpPanelNew?.TryFocusMaterialSelectable();
		}
		else if (_currentSubControllerType == PopupEliteLevelUpViewSubControllerType.SelectEliteCurrency)
		{
			SwitchToSubController(PopupEliteLevelUpViewSubControllerType.SelectEliteCurrency);
			FocusFirstEliteCurrency();
		}
		else
		{
			SwitchToSubController(PopupEliteLevelUpViewSubControllerType.ElitePoints);
		}
		RefreshEliteCurrencyPrompt();
	}

	public EliteViewSubControllerType HandleGamepadLeftStickClick(EliteViewSubControllerType current)
	{
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return current;
		}
		if (!(eliteLevelUpPanelNew != null) || !eliteLevelUpPanelNew.HasReinforcedMaterialSlotsVisible())
		{
			return current;
		}
		switch (current)
		{
		case EliteViewSubControllerType.SelectReinforcedMaterial:
			if (_currentSubControllerType != PopupEliteLevelUpViewSubControllerType.SelectConsumeItem)
			{
				_currentSubControllerType = PopupEliteLevelUpViewSubControllerType.SelectConsumeItem;
				SwitchToSubController(PopupEliteLevelUpViewSubControllerType.SelectConsumeItem);
				eliteLevelUpPanelNew?.TryFocusMaterialSelectable();
				eliteDiscComponent?.GetControllerType(EliteViewSubControllerType.SelectReinforcedMaterial);
				RefreshEliteCurrencyPrompt();
			}
			return current;
		default:
			return current;
		case EliteViewSubControllerType.ElitePointUpGarde:
			_currentSubControllerType = PopupEliteLevelUpViewSubControllerType.SelectConsumeItem;
			SwitchToSubController(PopupEliteLevelUpViewSubControllerType.SelectConsumeItem);
			eliteLevelUpPanelNew?.TryFocusMaterialSelectable();
			eliteDiscComponent?.GetControllerType(EliteViewSubControllerType.SelectReinforcedMaterial);
			RefreshEliteCurrencyPrompt();
			return EliteViewSubControllerType.SelectReinforcedMaterial;
		}
	}

	public bool HandleGamepadSubmitInSelectMaterial()
	{
		if (_currentSubControllerType != PopupEliteLevelUpViewSubControllerType.SelectConsumeItem)
		{
			return false;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			return false;
		}
		ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
		{
			handler?.OnSubmit(data);
		});
		return true;
	}

	public EliteViewSubControllerType HandleGamepadCancelInSelectMaterial()
	{
		_currentSubControllerType = PopupEliteLevelUpViewSubControllerType.ElitePoints;
		SwitchToSubController(PopupEliteLevelUpViewSubControllerType.ElitePoints);
		eliteDiscComponent?.GetControllerType(EliteViewSubControllerType.ElitePointUpGarde);
		RefreshEliteCurrencyPrompt();
		return EliteViewSubControllerType.ElitePointUpGarde;
	}

	public bool IsSelectConsumeItemMode()
	{
		return _currentSubControllerType == PopupEliteLevelUpViewSubControllerType.SelectConsumeItem;
	}

	public bool IsSelectEliteCurrencyMode()
	{
		return _currentSubControllerType == PopupEliteLevelUpViewSubControllerType.SelectEliteCurrency;
	}

	public EliteViewSubControllerType GetCurrentPromptControllerType()
	{
		return _currentSubControllerType switch
		{
			PopupEliteLevelUpViewSubControllerType.SelectConsumeItem => EliteViewSubControllerType.SelectReinforcedMaterial, 
			PopupEliteLevelUpViewSubControllerType.SelectEliteCurrency => EliteViewSubControllerType.SelectEliteCurrency, 
			_ => EliteViewSubControllerType.ElitePointUpGarde, 
		};
	}

	public bool EnterEliteCurrencyMode()
	{
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad || !HasVisibleEliteCurrency())
		{
			return false;
		}
		_currentSubControllerType = PopupEliteLevelUpViewSubControllerType.SelectEliteCurrency;
		SwitchToSubController(PopupEliteLevelUpViewSubControllerType.SelectEliteCurrency);
		FocusFirstEliteCurrency();
		RefreshGamepadPrompts();
		return true;
	}

	public void ExitEliteCurrencyMode()
	{
		if (IsSelectEliteCurrencyMode())
		{
			_currentSubControllerType = PopupEliteLevelUpViewSubControllerType.ElitePoints;
			SwitchToSubController(PopupEliteLevelUpViewSubControllerType.ElitePoints);
			RefreshGamepadPrompts();
		}
	}

	public void HandleGamepadEliteCurrencyNavigate(float value)
	{
		if (IsSelectEliteCurrencyMode() && !(Mathf.Abs(value) <= 0f))
		{
			CommonCoinComponent selectedEliteCurrency = GetSelectedEliteCurrency();
			CommonCoinComponent currency = ((selectedEliteCurrency == commonEliteResource) ? personalEliteResource : commonEliteResource);
			if (!IsVisibleEliteCurrency(currency))
			{
				currency = selectedEliteCurrency;
			}
			SelectEliteCurrency(currency);
		}
	}

	public bool HandleGamepadSubmitEliteCurrency()
	{
		if (!IsSelectEliteCurrencyMode())
		{
			return false;
		}
		CommonCoinComponent commonCoinComponent = GetSelectedEliteCurrency();
		if (!IsVisibleEliteCurrency(commonCoinComponent))
		{
			commonCoinComponent = GetFirstVisibleEliteCurrency();
		}
		commonCoinComponent?.InputClick();
		return commonCoinComponent != null;
	}

	private void FocusFirstEliteCurrency()
	{
		SelectEliteCurrency(GetFirstVisibleEliteCurrency());
	}

	private CommonCoinComponent GetSelectedEliteCurrency()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			return null;
		}
		if (commonEliteResource != null && (currentSelected == commonEliteResource.gameObject || currentSelected.transform.IsChildOf(commonEliteResource.transform)))
		{
			return commonEliteResource;
		}
		if (personalEliteResource != null && (currentSelected == personalEliteResource.gameObject || currentSelected.transform.IsChildOf(personalEliteResource.transform)))
		{
			return personalEliteResource;
		}
		return null;
	}

	private CommonCoinComponent GetFirstVisibleEliteCurrency()
	{
		if (IsVisibleEliteCurrency(personalEliteResource))
		{
			return personalEliteResource;
		}
		if (!IsVisibleEliteCurrency(commonEliteResource))
		{
			return null;
		}
		return commonEliteResource;
	}

	public bool HasVisibleEliteCurrency()
	{
		return GetFirstVisibleEliteCurrency() != null;
	}

	private static bool IsVisibleEliteCurrency(CommonCoinComponent currency)
	{
		if (currency != null && currency.gameObject.activeInHierarchy)
		{
			return currency.interactable;
		}
		return false;
	}

	private static void SelectEliteCurrency(CommonCoinComponent currency)
	{
		if (IsVisibleEliteCurrency(currency))
		{
			currency.Select();
			EventSystemHelper.SetSelectedGameObject(currency.gameObject);
		}
	}

	private void RefreshGamepadPrompts()
	{
		eliteDiscComponent?.GetControllerType(GetCurrentPromptControllerType());
		eliteLevelUpPanelNew?.ForceRefreshOperatePrompts();
		RefreshEliteCurrencyPrompt();
	}

	private void RefreshEliteCurrencyPrompt()
	{
		eliteCurrencyPrompt?.SetVisible(MonoECS.instance.InputMode == DeviceInputMode.Gamepad && _currentSubControllerType == PopupEliteLevelUpViewSubControllerType.ElitePoints && HasVisibleEliteCurrency());
	}

	public void ForceRefreshGamepadPromptsAfterChildPopupClose()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			eliteDiscComponent?.GetControllerType(GetCurrentPromptControllerType());
			eliteLevelUpPanelNew?.ForceRefreshOperatePrompts();
		}
	}

	public bool HandleGamepadXPressed(bool isPressed, EliteViewSubControllerType controllerType)
	{
		if (eliteDiscComponent != null && eliteDiscComponent.IsSelectedTrialCharacter)
		{
			return false;
		}
		eliteDiscComponent?.gamePadTipsComp?.GetPrompt("UI/LongPressX")?.OnBindingPressed(isPressed);
		if (controllerType != EliteViewSubControllerType.ElitePointUpGarde)
		{
			return false;
		}
		if (eliteLevelUpPanelNew == null)
		{
			return true;
		}
		if (isPressed)
		{
			if (_xPressActive)
			{
				return true;
			}
			_xPressActive = true;
			_xLongPressTriggered = false;
			_xPressStartTimeUnscaled = Time.unscaledTime;
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/LongPressX", () =>
			{
				_xLongPressTriggered = true;
				eliteLevelUpPanelNew.HandleGamepadResetShortcut();
			}, 1f, 1, 0.02f, null, () =>
			{
				eliteDiscComponent?.gamePadTipsComp?.GetPrompt("UI/LongPressX")?.OnBindingPressed(isPressed: false);
				float num = Time.unscaledTime - _xPressStartTimeUnscaled;
				if (!_xLongPressTriggered && num <= 0.25f)
				{
					eliteLevelUpPanelNew.HandleGamepadBacktrackShortcut();
				}
				_xLongPressTriggered = false;
				_xPressActive = false;
			});
			return true;
		}
		eliteDiscComponent?.gamePadTipsComp?.GetPrompt("UI/LongPressX")?.OnBindingPressed(isPressed: false);
		return true;
	}

	public void HandleGamepadLeftStickHorizontalInSelectMaterial(float value)
	{
		if (IsSelectConsumeItemMode() && !(Mathf.Abs(value) <= 0f))
		{
			MoveSelection((value > 0f) ? MoveDirection.Right : MoveDirection.Left);
		}
	}

	public void HandleGamepadLeftStickVerticalInSelectMaterial(float value)
	{
		if (IsSelectConsumeItemMode() && !(Mathf.Abs(value) <= 0f))
		{
			MoveSelection((value > 0f) ? MoveDirection.Up : MoveDirection.Down);
		}
	}

	private void SwitchToSubController(PopupEliteLevelUpViewSubControllerType target)
	{
		if (ViewControlLayers == null)
		{
			return;
		}
		foreach (KeyValuePair<PopupEliteLevelUpViewSubControllerType, ViewControlLayer> viewControlLayer in ViewControlLayers)
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

	private void UnFocusAllLayers()
	{
		if (ViewControlLayers == null)
		{
			return;
		}
		foreach (KeyValuePair<PopupEliteLevelUpViewSubControllerType, ViewControlLayer> viewControlLayer in ViewControlLayers)
		{
			viewControlLayer.Value?.UnFocus();
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
}
