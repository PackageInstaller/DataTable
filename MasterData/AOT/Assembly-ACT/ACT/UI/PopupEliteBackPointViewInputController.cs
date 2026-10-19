using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class PopupEliteBackPointViewInputController : BaseUIViewInputController<PopupEliteBackPointView>
{
	[GameInputBindingBool("LargeMapView/Select")]
	private void OnGamePadSelect(bool value)
	{
		if (value)
		{
			StopActionPropagation("LargeMapView/Select");
			View?.HandleGamepadSubmit();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnGamePadNavigate(Vector2 value)
	{
		View?.HandleGamepadLeftStickHorizontal(value.x);
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	private void OnGamePadLeftStickClick(bool value)
	{
		if (value)
		{
			View?.HandleGamepadLeftStickClick();
		}
	}

	[GameInputBindingBool("LargeMapView/Return")]
	private void OnGamePadReturn(bool value)
	{
		if (value)
		{
			StopActionPropagation("LargeMapView/Return");
			StopActionPropagation("UI/Back");
			View?.HandleGamepadCancel();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		StopActionPropagation("UI/Back");
		StopActionPropagation("LargeMapView/Return");
		if (!value)
		{
			View?.HandleGamepadCancel();
		}
	}
}
