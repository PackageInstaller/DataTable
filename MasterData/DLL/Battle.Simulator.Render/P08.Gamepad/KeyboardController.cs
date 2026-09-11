namespace P08.Gamepad;

public class KeyboardController : Gamepad
{
	private bool _useMouse;

	public KeyboardController(bool useMouse)
	{
		_useMouse = useMouse;
	}

	public override void ReloadLayoutFromConfig()
	{
		if (_useMouse)
		{
			string pDefaultFileName = "KeyMousePCLayout";
			LoadLayoutFromConfig("KeyMouseLayout", pDefaultFileName);
		}
		else
		{
			string pDefaultFileName2 = "KeyboardPCLayout";
			LoadLayoutFromConfig("KeyboardLayout", pDefaultFileName2);
		}
	}
}
