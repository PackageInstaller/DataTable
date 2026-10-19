using ACT.Battle;

namespace ACT.UI;

public class SevendaySignInFixedViewInputController : BaseUIViewInputController<SevenDaySignInFixed>
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

	[GameInputBindingBool("LargeMapView/Up")]
	public void LeftStickUp(bool value)
	{
		if (value)
		{
			View.Up();
		}
	}

	[GameInputBindingBool("LargeMapView/Down")]
	public void LeftStickDown(bool value)
	{
		if (value)
		{
			View.Down();
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

	[GameInputBindingBool("LargeMapView/WorldMapChooseLast")]
	public void DpadUp(bool value)
	{
		if (value)
		{
			View.Up();
		}
	}

	[GameInputBindingBool("LargeMapView/WorldMapChooseNext")]
	public void DpadDown(bool value)
	{
		if (value)
		{
			View.Down();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void ButtonSouth(bool value)
	{
		if (value)
		{
			View.OnClickConfirmButtonHandle();
		}
	}

	[GameInputBindingBool("LargeMapView/BackToTarget")]
	public void ButtonNorth(bool value)
	{
		if (value)
		{
			View.OnClickTryButtonHandle();
		}
	}
}
