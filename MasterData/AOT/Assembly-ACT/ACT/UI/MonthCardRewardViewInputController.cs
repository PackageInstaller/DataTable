using ACT.Battle;

namespace ACT.UI;

public class MonthCardRewardViewInputController : BaseUIViewInputController<MonthCardRewardView>
{
	protected override void OnActivate()
	{
		base.OnActivate();
		UpdateGamepadTips();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			UpdateGamepadTips();
		}
	}

	[GameInputBindingBool("UI/Back")]
	private void OnBackPress(bool isPress)
	{
		if (!isPress)
		{
			View?.Close();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnConfirmPress(bool isPress)
	{
		if (!isPress)
		{
			View?.Close();
		}
	}

	private void UpdateGamepadTips()
	{
		View?.gamePadTipsComp?.RegisterInputActions(GamePadTipHelper.ConfirmAction);
	}
}
