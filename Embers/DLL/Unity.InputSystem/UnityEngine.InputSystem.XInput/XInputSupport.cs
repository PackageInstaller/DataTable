namespace UnityEngine.InputSystem.XInput;

internal static class XInputSupport
{
	public static void Initialize()
	{
		InputSystem.RegisterLayout<XInputController>();
	}
}
