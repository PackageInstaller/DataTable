using ACT.Battle;

namespace ACT.UI;

public class PopupEliteBreakViewInputController : BaseUIViewInputController<PopupEliteBreakView>
{
	[GameInputBindingBool("LargeMapView/Select")]
	private void OnGamePadSelect(bool value)
	{
		if (value)
		{
			StopActionPropagation("LargeMapView/Select");
			StopActionPropagation("LargeMapView/Return");
			StopActionPropagation("UI/Back");
			View?.HandleGamepadSubmit();
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
