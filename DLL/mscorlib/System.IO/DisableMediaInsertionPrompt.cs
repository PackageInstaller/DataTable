namespace System.IO;

internal struct DisableMediaInsertionPrompt : IDisposable
{
	private bool _disableSuccess;

	private uint _oldMode;

	private static bool useUWPFallback;

	public static DisableMediaInsertionPrompt Create()
	{
		DisableMediaInsertionPrompt result = default(DisableMediaInsertionPrompt);
		if (useUWPFallback)
		{
			result._disableSuccess = false;
			return result;
		}
		try
		{
			result._disableSuccess = Interop.Kernel32.SetThreadErrorMode(1u, out result._oldMode);
		}
		catch (DllNotFoundException)
		{
			useUWPFallback = true;
			result._disableSuccess = false;
		}
		return result;
	}

	public void Dispose()
	{
		if (_disableSuccess)
		{
			Interop.Kernel32.SetThreadErrorMode(_oldMode, out var _);
		}
	}
}
