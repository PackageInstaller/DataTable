using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI.InputController.QuickPowerExchangeItemViewController;

public class QuickPowerExchangeItemViewInputController : BaseUIViewInputController<QuickPowerExchangeItemView>
{
	private ContinuousNavigateData _curNavigateState;

	protected override void OnEnable()
	{
		base.OnEnable();
		UnFocusRewardViewControlLayer();
		View.btnViewControlLayer.Focus();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateState?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type != DeviceInputMode.Gamepad)
		{
			View.btnViewControlLayer.UnFocus();
			UnFocusRewardViewControlLayer();
			UpdateGamepadTips();
		}
		else
		{
			View.btnViewControlLayer.Focus();
			UnFocusRewardViewControlLayer();
			UpdateGamepadTips();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value && !(View == null) && (bool)EventSystemHelper.CurrentSelected)
		{
			EventSystemHelper.Click(EventSystemHelper.CurrentSelected);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (View.rewardViewControlLayer.IsFocused)
			{
				UnFocusRewardViewControlLayer();
				View.btnViewControlLayer.Focus();
			}
			else
			{
				View?.Close();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void ClickPowerBar(bool isPressed)
	{
		if (!isPressed)
		{
			EventSystemHelper.Click(View.powerBar.addPowerBtn);
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OnClickUISpecial5(bool isPressed)
	{
		if (isPressed && !(View == null) && !View.rewardViewControlLayer.IsFocused)
		{
			FocusRewardViewControlLayer();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Up:
			View.viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			View.viewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.viewControlRoot?.SelectRight();
			break;
		}
	}

	private void FocusRewardViewControlLayer()
	{
		View.rewardViewControlLayer?.Focus();
		View.rewardBtnPrompt?.SetVisible(vis: false);
	}

	private void UnFocusRewardViewControlLayer()
	{
		View.rewardViewControlLayer?.UnFocus();
		View.rewardBtnPrompt?.SetVisible(vis: true);
	}

	private void UpdateGamepadTips()
	{
		View.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
	}
}
