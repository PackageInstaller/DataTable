using ACT.Battle;
using UnityEngine;

namespace ACT.UI.InputController.EliteOverview;

public class EliteOverviewViewInputController : BaseUIViewInputController<EliteOverviewView>
{
	[GameInputBindingVector2("UI/Navigate")]
	private void OnNavigate(Vector2 value)
	{
		View?.HandleLeftStickHorizontalInput(value.x);
	}

	[GameInputBindingBool("LargeMapView/Return")]
	private void OnGamePadReturn(bool value)
	{
		if (value)
		{
			StopActionPropagation("LargeMapView/Return");
			StopActionPropagation("UI/Back");
			View?.Close();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		StopActionPropagation("UI/Back");
		StopActionPropagation("LargeMapView/Return");
		if (!value)
		{
			View?.Close();
		}
	}
}
