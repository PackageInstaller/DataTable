using ACT.Battle;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI.InputController.JumpToFreeDiamondViewInputController;

public class JumpToFreeDiamondViewInputController : BaseUIViewInputController<JumpToFreeDiamondView>
{
	private enum FocusLayerType
	{
		BtnGroup,
		CoinGroup
	}

	private ContinuousNavigateData _curNavigateState;

	private ViewControlRoot _viewControlRoot;

	private CommonCoinGroup _coinGroup;

	private FocusLayerType _focusLayerType;

	protected override void OnInitView(JumpToFreeDiamondView view)
	{
		base.OnInitView(view);
		_focusLayerType = FocusLayerType.BtnGroup;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_viewControlRoot = View.GetComponentInParent<ViewControlRoot>();
		_coinGroup = View.coinGroupLayer.GetComponent<CommonCoinGroup>();
		View.coinGroupLayer?.OnFocusChanged.AddListener(OnCoinFocusChanged);
		ReFocusCurrentLayer();
		UpdateGamepadTips();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		View.coinGroupLayer?.OnFocusChanged.RemoveListener(OnCoinFocusChanged);
		_curNavigateState?.Reset();
	}

	private void OnCoinFocusChanged(bool focused)
	{
		if (focused)
		{
			_focusLayerType = FocusLayerType.CoinGroup;
		}
		else
		{
			FocusButtonGroup(resetToConfirm: true);
		}
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			ReFocusCurrentLayer();
			UpdateGamepadTips();
		}
	}

	[GameInputBindingBool("UI/Back")]
	private void OnBackPress(bool isPress)
	{
		if (!isPress && _focusLayerType == FocusLayerType.BtnGroup)
		{
			View.OnCloseAction();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirmPress(bool isPress)
	{
		if (!isPress && !(EventSystemHelper.CurrentSelected == null))
		{
			ActButton component = EventSystemHelper.CurrentSelected.GetComponent<ActButton>();
			if ((bool)component)
			{
				EventSystemHelper.Click(component);
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (EventSystemHelper.CurrentSelected == null)
		{
			ReFocusCurrentLayer();
		}
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Left:
			_viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			_viewControlRoot?.SelectRight();
			break;
		}
	}

	private void ReFocusCurrentLayer()
	{
		if (_focusLayerType == FocusLayerType.CoinGroup)
		{
			View.coinGroupLayer.ReFocus();
		}
		else
		{
			FocusButtonGroup(resetToConfirm: true);
		}
	}

	private void FocusButtonGroup(bool resetToConfirm)
	{
		_focusLayerType = FocusLayerType.BtnGroup;
		if (resetToConfirm)
		{
			ACT.ViewControl.SelectableEx component = View.confirmButton.GetComponent<ACT.ViewControl.SelectableEx>();
			if ((bool)component)
			{
				View.btnGroupLayer.SetDefaultSelect(component);
			}
			View.btnGroupLayer.Focus();
		}
		else
		{
			View.btnGroupLayer.ReFocus();
		}
	}

	private void UpdateGamepadTips()
	{
		View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
	}
}
