namespace System.Diagnostics;

public static class Debug
{
	[Conditional("DEBUG")]
	public static void WriteLine(string message)
	{
		TraceInternal.WriteLine(message);
	}
}
