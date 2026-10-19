using ACT.Battle;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI.InputController.JumpToFreeDiamondViewInputController;

public class FreeDiamondExchangeViewInputController : BaseUIViewInputController<FreeDiamondExchangeView>
{
	private ContinuousNavigateData _curNavigateState;

	private ViewControlLayer _coinViewLayer;

	protected override void OnInitView(FreeDiamondExchangeView view)
	{
		base.OnInitView(view);
		_coinViewLayer = view.commonCoinGroup?.GetComponent<ViewControlLayer>();
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_coinViewLayer?.OnFocusChanged.RemoveListener(OnCoinFocusChanged);
		_coinViewLayer?.OnFocusChanged.AddListener(OnCoinFocusChanged);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			FocusViewControlLayer();
		}
		UpdateInputActionEnable();
		UpdateGamePadTips();
	}

	protected override void OnDeactivate()
	{
		SetViewActionsDisabled(disabled: false);
		_coinViewLayer?.OnFocusChanged.RemoveListener(OnCoinFocusChanged);
		_curNavigateState?.Reset();
		base.OnDeactivate();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type != DeviceInputMode.Gamepad)
		{
			View.viewControlLayer?.UnFocus();
			SetViewActionsDisabled(disabled: false);
		}
		else
		{
			FocusViewControlLayer();
			UpdateInputActionEnable();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void Reduce(bool isPress)
	{
		if (isPress)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageLeft", View.ClickReduceBtn, 0.01f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void Add(bool isPress)
	{
		if (isPress)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageRight", View.ClickAddBtn, 0.01f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void Reduce100(bool isPress)
	{
		if (!isPress)
		{
			View.ClickReduce100Btn();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void Add100(bool isPress)
	{
		if (!isPress)
		{
			View.ClickAdd100Btn();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void Max(bool isPress)
	{
		if (!isPress)
		{
			View.ClickMaxBtn();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool isPress)
	{
		if (!isPress)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (currentSelected != null)
			{
				EventSystemHelper.Click(currentSelected.GetComponent<ActButton>());
			}
			else
			{
				EventSystemHelper.Click(View.exchangeBtn);
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (EventSystemHelper.CurrentSelected == null)
		{
			FocusViewControlLayer();
		}
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Up:
			View.viewControlLayer?.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewControlLayer?.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.viewControlLayer?.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.viewControlLayer?.Root?.SelectRight();
			break;
		}
	}

	protected override void OnEscPressed(bool isPress)
	{
		base.OnEscPressed(isPress);
		if (!isPress)
		{
			CancelInternal();
		}
	}

	protected override void OnBackPressed(bool isPress)
	{
		base.OnBackPressed(isPress);
		if (!isPress)
		{
			CancelInternal();
		}
	}

	private void CancelInternal()
	{
		EventSystemHelper.Click(View.closeBtn);
	}

	private void FocusViewControlLayer()
	{
		View.viewControlLayer?.Focus();
	}

	private bool CanHandleViewInput()
	{
		if (!(_coinViewLayer == null))
		{
			return !_coinViewLayer.IsFocused;
		}
		return true;
	}

	private void UpdateInputActionEnable()
	{
		SetViewActionsDisabled(!CanHandleViewInput());
	}

	private void OnCoinFocusChanged(bool focused)
	{
		SetViewActionsDisabled(focused);
	}

	private void SetViewActionsDisabled(bool disabled)
	{
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageUp", disabled);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageDown", disabled);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageLeft", disabled);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/SwitchPageRight", disabled);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/UISpecial2", disabled);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Confirm", disabled);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Navigate", disabled);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Esc", disabled);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Back", disabled);
		UpdateGamePadTips(!disabled);
	}

	private void UpdateGamePadTips(bool visible = true)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			if (!visible)
			{
				View.gamePadTipsComp.gameObject.SetActive(value: false);
				return;
			}
			View.gamePadTipsComp.gameObject.SetActive(value: true);
			View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
		}
	}
}
