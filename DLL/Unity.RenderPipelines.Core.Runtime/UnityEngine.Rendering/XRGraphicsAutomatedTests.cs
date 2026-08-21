namespace UnityEngine.Rendering;

public static class XRGraphicsAutomatedTests
{
	public static bool running = false;

	private static bool activatedFromCommandLine => false;

	public static bool enabled { get; } = activatedFromCommandLine;
}
