using ACT.Battle;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI.InputController.JumpToCostDiamondViewInputController;

public class JumpToCostDiamondViewInputController : BaseUIViewInputController<JumpToCostDiamondView>
{
	private ContinuousNavigateData _curNavigateState;

	private ViewControlRoot _viewControlRoot;

	protected override void OnActivate()
	{
		base.OnActivate();
		_viewControlRoot = View.GetComponentInParent<ViewControlRoot>();
		View.btnGroupLayer.Focus();
		UpdateGamepadTips();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		View.btnGroupLayer.UnFocus();
		_curNavigateState?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			View.btnGroupLayer.Focus();
			UpdateGamepadTips();
		}
	}

	[GameInputBindingBool("UI/UISpecial4")]
	private void OnMenuPress(bool isPress)
	{
		if (!isPress)
		{
			View.btnGroupLayer.UnFocus();
			UpdateGamepadTips();
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

	[GameInputBindingBool("UI/Back")]
	private void OnBackPress(bool isPress)
	{
		if (!isPress)
		{
			View.Close();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (!EventSystemHelper.CurrentSelected)
		{
			View.btnGroupLayer.Focus();
		}
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Up:
			_viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			_viewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			_viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			_viewControlRoot?.SelectRight();
			break;
		}
	}

	private void UpdateGamepadTips()
	{
		View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
	}
}
