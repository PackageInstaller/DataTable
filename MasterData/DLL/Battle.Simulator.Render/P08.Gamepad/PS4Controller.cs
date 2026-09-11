namespace P08.Gamepad;

public class PS4Controller : Gamepad
{
	public override void ReloadLayoutFromConfig()
	{
		string pDefaultFileName = "Dualshock4PCLayout";
		LoadLayoutFromConfig("PS4Layout", pDefaultFileName);
	}
}
