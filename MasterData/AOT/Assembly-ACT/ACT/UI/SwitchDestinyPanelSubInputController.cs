using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class SwitchDestinyPanelSubInputController : SubUIViewInputController<SwitchDestinyPanel>
{
	[GameInputBindingBool("UI/Back")]
	public void Back(bool value)
	{
		if (!value)
		{
			View.Hide();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnSubmit(bool value)
	{
		if (value)
		{
			View.OnConfirm();
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void RightStickNavigate(Vector2 value)
	{
		View.OnRightStickScroll(value);
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.costCell?.onToggleClick?.Invoke();
		}
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		View.OnDeviceChange(type);
	}
}
