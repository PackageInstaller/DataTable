namespace Microsoft.Win32;

internal static class Win32Native
{
	public static string GetMessage(int hr)
	{
		return "Error " + hr;
	}

	public static int MakeHRFromErrorCode(int errorCode)
	{
		return -2147024896 | errorCode;
	}
}
