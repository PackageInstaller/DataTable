using ACT.Battle;

namespace ACT.UI;

public class PlayerLevelController : SubUIViewInputController<ActivityPlayerLevel>
{
	[GameInputBindingBool("LargeMapView/Left")]
	public void LeftStickLeft(bool value)
	{
		if (value)
		{
			View.Left();
		}
	}

	[GameInputBindingBool("LargeMapView/Right")]
	public void LeftStickRight(bool value)
	{
		if (value)
		{
			View.Right();
		}
	}

	[GameInputBindingBool("LargeMapView/MapSideInfoLast")]
	public void DpadLeft(bool value)
	{
		if (value)
		{
			View.Left();
		}
	}

	[GameInputBindingBool("LargeMapView/MapSideInfoNext")]
	public void DpadRight(bool value)
	{
		if (value)
		{
			View.Right();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void ButtonSouth(bool value)
	{
		if (value)
		{
			View.ButtonSouth();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.OnOpenActivityDetail();
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.ButtonEast();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value)
		{
			View.LeftStickPress();
		}
	}
}
