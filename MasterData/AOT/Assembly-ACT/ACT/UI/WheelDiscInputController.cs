using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class WheelDiscInputController : SubUIViewInputController<WheelDiscComponent>
{
	protected override void OnActivate()
	{
		base.OnActivate();
		View.RefreshOpenState();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		View.ResetInputState();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		View.RefreshOpenState();
	}

	[GameInputBindingBool("UI/MenuDisc")]
	private void OnMenuDisc(bool value)
	{
		if (!value)
		{
			View.HandleMenuDiscReleased();
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	private void OnNavigate(Vector2 value)
	{
		if (MonoECS.instance.IsGamePadMode())
		{
			View.HandleRightStickInput(value);
		}
	}

	[GameInputBindingBool("UI/ButtonUp")]
	private void OnExtraOption1(bool value)
	{
		if (!value)
		{
			View.OpenExtraOption(0);
		}
	}

	[GameInputBindingBool("UI/ButtonDown")]
	private void OnExtraOption2(bool value)
	{
		if (!value)
		{
			View.OpenExtraOption(1);
		}
	}

	[GameInputBindingBool("UI/ButtonLeft")]
	private void OnExtraOption3(bool value)
	{
		if (!value)
		{
			View.OpenExtraOption(2);
		}
	}

	[GameInputBindingBool("UI/ButtonRight")]
	private void OnExtraOption4(bool value)
	{
		if (!value)
		{
			View.OpenExtraOption(3);
		}
	}
}
