using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopupRaidDoubleInputController : BaseUIViewInputController<PopupRaidDoubleView>
{
	private ContinuousNavigateData m_navigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
		m_navigateData?.Reset();
		View?.FocusDefaultButton();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		m_navigateData?.Reset();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			View?.FocusDefaultButton();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref m_navigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		if (direction == MoveDirection.Left || direction == MoveDirection.Right)
		{
			View?.SelectButton(direction);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirm(bool value)
	{
		if (value)
		{
			StopActionPropagation("UI/Confirm");
			View?.HandleGamepadSubmit();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		StopActionPropagation("UI/Back");
		if (!value)
		{
			View?.HandleGamepadCancel();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.OnRightStickPress();
		}
	}
}
