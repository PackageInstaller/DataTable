namespace System.Globalization;

internal static class GlobalizationMode
{
	internal static bool Invariant { get; } = GetGlobalizationInvariantMode();

	private static bool GetGlobalizationInvariantMode()
	{
		return false;
	}
}
