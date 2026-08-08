namespace System.Threading;

internal static class _ThreadPoolWaitCallback
{
	internal static bool PerformWaitCallback()
	{
		return ThreadPoolWorkQueue.Dispatch();
	}
}
