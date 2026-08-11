namespace UnityEngine.InputSystem.DualShock;

internal static class DualShockSupport
{
	public static void Initialize()
	{
		InputSystem.RegisterLayout<DualShockGamepad>();
	}
}
