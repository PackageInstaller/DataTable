using ACT.Battle;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI.InputController.BundlePurchaseInputController;

public class BundlePurchaseViewInputController : BaseUIViewInputController<BundlePurchaseView>
{
	private ContinuousNavigateData _curNavigateState;

	private ViewControlRoot _viewControlRoot;

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateState?.Reset();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		_viewControlRoot = View.GetComponentInParent<ViewControlRoot>();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			View.btnGroupLayer.Focus();
			View.rewardLayer.UnFocus();
			UpdateGamepadTips();
		}
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type != DeviceInputMode.Gamepad)
		{
			View.btnGroupLayer.UnFocus();
			View.rewardLayer.UnFocus();
			UpdateGamepadTips();
		}
		else
		{
			View.btnGroupLayer.Focus();
			View.rewardLayer.UnFocus();
			UpdateGamepadTips();
		}
	}

	[GameInputBindingBool("UI/UISpecial4")]
	private void OnMenuPress(bool isPress)
	{
		if (!isPress)
		{
			View.btnGroupLayer.UnFocus();
			View.rewardLayer.Focus();
			UpdateGamepadTips();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirmPress(bool isPress)
	{
		if (isPress || EventSystemHelper.CurrentSelected == null)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		ActToggle component = currentSelected.GetComponent<ActToggle>();
		if ((bool)component)
		{
			EventSystemHelper.Click(component);
			return;
		}
		ActButton component2 = currentSelected.GetComponent<ActButton>();
		if ((bool)component2)
		{
			EventSystemHelper.Click(component2);
		}
	}

	[GameInputBindingBool("UI/Back")]
	private void OnBackPress(bool isPress)
	{
		if (!isPress)
		{
			if (View.rewardLayer.IsFocused)
			{
				View.btnGroupLayer.Focus();
				View.rewardLayer.UnFocus();
			}
			else
			{
				View.Close();
			}
			UpdateGamepadTips();
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
		if (View.btnGroupLayer.IsFocused)
		{
			View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction, GamePadTipHelper.ScrollAction);
		}
		else
		{
			View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
		}
	}
}
