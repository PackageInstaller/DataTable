namespace P08.Gamepad;

public class XboxController : Gamepad
{
	public override void ReloadLayoutFromConfig()
	{
		string pDefaultFileName = "XboxOnePCLayout";
		LoadLayoutFromConfig("XboxLayout", pDefaultFileName);
	}
}
