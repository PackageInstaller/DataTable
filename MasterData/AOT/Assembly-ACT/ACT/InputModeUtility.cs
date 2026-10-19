using ACT.Battle;

namespace ACT;

public static class InputModeUtility
{
	public static bool ShowPrompt()
	{
		if (MonoECS.instance.ispc)
		{
			return true;
		}
		switch (MonoECS.instance.DeviceScreenType)
		{
		case ScreenSizeMode.LargeScreen:
			if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
			{
				return true;
			}
			break;
		case ScreenSizeMode.SmallScreen:
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				return true;
			}
			break;
		}
		return false;
	}

	public static bool ShowSelection()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			return true;
		}
		return false;
	}
}
